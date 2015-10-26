require 'rails/generators/base'

module Cesri
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_clearance_initializer
        copy_file 'cesri.rb', 'config/initializers/cesri.rb'
      end

    end
  end
end