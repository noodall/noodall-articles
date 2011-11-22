class LatestArticles < Noodall::Component

  key :title, String, :default => "Latest Articles"

  # Keys for filtering articles
  key :category, String
  key :article_list_id, ObjectId
  belongs_to :article_list

  # Returns a filtered list of latest articles
  def articles
    return [] if article_list.nil?
    query = {
      categories: category,
      order: ['published_at DESC','created_at DESC']
    }

    # Remove any filters that are set to "All"
    query.reject! {|key, value| value == "All" || value.blank? }

    article_list.children.published.limit(3).all(query)
  end

  def categories
    Article.all_categories
  end

end
