Product = Struct.new("Product", :handle, :title, :price, :branded, :colors, :size, :sale, :featuring_product, :limited_stock_message, keyword_init: true) do
  DATA = YAML.load_file(Rails.root.join("config", "products.yml")).freeze
  self::IMAGE_EXTNAMES = %w[.jpg .webp .png].to_set.freeze

  def self.all
    @all ||= DATA.map { |handle, product| new(handle:, **product) }
  end

  def self.find(handle)
    new(handle:, **DATA.fetch(handle))
  end

  def to_param
    handle
  end

  def to_partial_path
    "products/product"
  end

  def first_image_src
    filename = Dir.foreach(Rails.root.join("public", "img", "products", handle, "main")).detect { |filename| File.extname(filename).in?(IMAGE_EXTNAMES) }
    return unless filename
    "/img/products/#{handle}/main/#{filename}"
  end

  def outdated_price(currency = "GBP")
    ((price[currency] * 2).to_f / 100).ceil - 0.01
  end
end
