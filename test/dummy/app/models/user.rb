class User
  include MongoMapper::Document
  include Canable::Cans

  key :email, String
  key :full_name, String
  key :groups, Array
  key :permalink, String

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
