class User
  include MongoMapper::Document
  include Canable::Cans
  plugin Noodall::Tagging

  key :name, String
  key :permalink, String, :index => true
  key :email, String

  alias_method :groups=, :tags=
  alias_method :groups, :tags
  alias_method :group_list=, :tag_list=
  alias_method :group_list, :tag_list

  cattr_accessor :editor_groups

  def admin?
    groups.include?('website administrator')
  end

  def editor?
    return true if self.class.editor_groups.blank?
    admin? or (self.class.editor_groups & groups).size > 0
  end

  before_save :set_permalink
  def set_permalink
    self.permalink = full_name.parameterize
  end

end
