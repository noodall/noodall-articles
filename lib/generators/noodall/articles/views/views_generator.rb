class Noodall::Articles::ViewsGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../../../app', __FILE__)

  def copy_views
    directory "views", "app/views"
  end
end
