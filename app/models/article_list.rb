require 'noodall/articles/archive'
require 'noodall/articles/categories'

class ArticleList < Noodall::Node
  include Noodall::Articles::Archive
  include Noodall::Articles::Categories

  sub_templates Article

  def articles
    children.published
  end

  def recent_articles(options = {})
    options.reject! {|key, value| value == "All" || value.blank? }
    options[:order] = ['published_at DESC','created_at DESC']
    children.published.limit(3).all(options)
  end

  def list
    self
  end

  def all_categories
    super(children.published.criteria.to_hash)
  end

end
