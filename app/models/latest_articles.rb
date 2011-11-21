class LatestArticles < Noodall::Component

  key :title, String, :default => "Latest Articles"

  # Keys for filtering articles
  key :sector, String
  key :region, String
  key :category, String

  # Returns a filtered list of latest articles
  def articles
    news_page = ArticleList.find_by_permalink("news")

    query = {
      categories: category,
      sectors: sector,
      regions: region,
      order: ['published_at DESC','created_at DESC']
    }

    # Remove any filters that are set to "All"
    query.reject! {|key, value| value == "All" || value.blank? }

    news_page.children.published.limit(3).all(query)
  end

  def categories
    ArticleList.new.all_categories
  end

  def regions
    ArticleList.new.all_regions
  end

  def sectors
    ArticleList.new.all_sectors
  end
end
