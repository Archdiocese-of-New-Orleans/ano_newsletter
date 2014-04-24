require 'rubygems'
require 'jquery-rails'
require 'bootstrap-sass'
require 'paperclip'
require 'momentjs-rails'
require 'bootstrap3-datetimepicker-rails'

module AnoNewsletter

  module Hooks
    autoload :CanCanAuthorization, 'ano_newsletter/hooks/cancan'
  end

  DEFAULT_AUTHORIZE = Proc.new {}
  AUTHORIZATION_ADAPTERS = {}
  DEFAULT_CURRENT_USER = Proc.new do
    request.env["warden"].try(:user) || respond_to?(:current_user) && current_user
  end

  def self.authorize_with(*args, &block)
    extension = args.shift

    if extension
      @authorize = Proc.new {
        @authorization_adapter = AnoNewsletter::AUTHORIZATION_ADAPTERS[extension].new(*([self] + args).compact)
      }
    else
      @authorize = block if block
    end

    @authorize || DEFAULT_AUTHORIZE
  end

  def self.current_user_method(&block)
    @current_user = block if block
    @current_user || DEFAULT_CURRENT_USER
  end

  class Engine < ::Rails::Engine

    config.generators do |g|
      g.test_framework :rspec, :views => false, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    initializer "ano_newsletter.assets.precompile" do |app|
      app.config.assets.precompile += %w(ano_newsletter.css ano_newsletter.js)
    end

    initializer "ano_newsletter.hooks" do
      if Object.const_defined?("CanCan")
        require "ano_newsletter/hooks/cancan"
      end
    end

    initializer "ano_newsletter.finisher_hook" do
      AnoNewsletter.authorize_with :cancan
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

  end

end