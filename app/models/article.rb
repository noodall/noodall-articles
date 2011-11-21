class Article < Noodall::Node

  delegate :list, :all_categories, :recent_articles, :archive, :to => :parent

  key :categories, Array, :index => true

  key :asset_id, ObjectId
  belongs_to :asset

  def category_list=(string)
    self.categories = string.to_s.split(',').map{ |t| t.strip.titlecase }.reject(&:blank?).compact.uniq
  end

  def category_list
    categories.join(',')
  end

  # Parses body to find first image asset
  def set_asset

    # get all image assets
    asset_ids = body.to_s.scan(%r|<img.*id="asset-([^"]*)".*/>|i)
    if asset_ids.empty?
      self.asset = nil
    else
      # remove prefix and file extension
      self.asset = Asset.find_by_id(asset_ids.first.first.to_s)
    end
  end
  before_save :set_asset
end
