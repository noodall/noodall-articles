require 'noodall/articles/categories'

class Article < Noodall::Node
  extend Noodall::Articles::Categories

  delegate :list, :articles, :all_categories, :recent_articles, :archive, :to => :parent

  key :categories, Array, :index => true

  key :asset_id, ObjectId
  belongs_to :asset

  def category_list=(string)
    self.categories = string.to_s.split(',').map{ |t| t.strip.titlecase }.reject(&:blank?).compact.uniq
  end

  def category_list
    categories.join(',')
  end

  protected

  # A slug for creating the permalink with date
  def slug
    (published_at || current_time).strftime('%Y/%m/%d/') + super
  end

  private

  # Always put a new article at the top of a list
  def set_position
    write_attribute :position, 0 if self.position.blank?
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
