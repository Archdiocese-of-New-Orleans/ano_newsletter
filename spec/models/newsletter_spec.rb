require 'spec_helper'

describe Newsletter do
  it { should validate_presence_of(:released_at) }
  it { should have_attached_file(:asset) }
  it { should validate_attachment_presence(:asset) }

  it '#archive' do
    archived = []
    3.times do
      archived << FactoryGirl.create(:newsletter, released_at: DateTime.now)
    end

    newsletter = archived.first
    newsletter.update(released_at: DateTime.now + 1.day)
    expect(Newsletter.archive.length).to eq(2)
  end
end
