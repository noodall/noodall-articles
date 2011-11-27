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
    options = remove_invalid_filters(options)
    options[:order] = ['published_at DESC','created_at DESC']
    children.published.limit(3).all(options)
  end

  def list
    self
  end

  def all_categories
    super(children.published.criteria.to_hash)
  end

  def archive(options = {})
    options = remove_invalid_filters(options)

    criteria = Plucky::CriteriaHash.new(
      :path => self._id,
      :_type => 'Article',
      :published_at => { :$lte => Time.zone.now },
      :published_to => { :$gte => Time.zone.now }
    ).to_hash.merge(options)

    result = self.collection.map_reduce(archive_map('published_at'), archive_reduce, {:query => criteria, :finalize => archive_finalize, :out => "tmp_articles"})
    years = result.find.to_a.map{ |hash| Year.new(hash['_id'],hash['value']) }.sort{ |a,b| b.year <=> a.year }

    years
  end

  private

  def remove_invalid_filters(query)
    query.reject {|key, value| value == "All" || value.blank? }
  end
end
