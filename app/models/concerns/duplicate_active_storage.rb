module DuplicateActiveStorage
  extend ActiveSupport::Concern

  included do
    after_commit do
      duplicate_active_storage unless @is_migration
    end
    after_destroy :duplicate_active_storage

    def duplicate_active_storage
      picture_types = ["asset"]
      transfer_to_active_storage(picture_types)
    end

    private

    def transfer_to_active_storage(picture_types)
      picture_types.each do |picture_type|
        next unless send("saved_change_to_#{picture_type}_updated_at?") ^ @is_migration
        next unless send(picture_type.to_s).exists?

        if try(:deleted?) || destroyed?
          remove_active_storage
          next
        end

        ActiveRecord::Base.transaction do
          blob = ActiveStorage::Blob.create_after_upload!(
            io: open(send(picture_type.to_sym).path),
            filename: send("#{picture_type}_file_name"),
            content_type: send("#{picture_type}_content_type")
          )

          blob.attachments.create(
            name: picture_type.to_s,
            record_type: self.class.name,
            record_id: id
          )
        end
        clear_attribute_changes(["#{picture_type}_updated_at"])
      end
    end

    def remove_active_storage
      ActiveStorage::Attachment.find_by(record_type: self.class.name, record_id: id)&.destroy
    end

  end
end