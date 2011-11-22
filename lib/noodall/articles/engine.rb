module Noodall
  module Articles
    class Engine < Rails::Engine
      initializer "Add assets to precomiler" do |app|
        app.config.assets.precompile += %w( noodall-articles/categories.js )
      end
    end
  end
end
