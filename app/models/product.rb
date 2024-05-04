Product = Struct.new("Product", :handle, :title, :price, :branded, :colors, :sizes, :sale, :featuring_product, :limited_stock_message, keyword_init: true) do
  self::DATA = YAML.load_file(Rails.root.join("config", "products.yml")).freeze
  self::IMAGE_EXTNAMES = %w[.jpg .webp .png].to_set.freeze

  def self.all
    @all ||= Product::DATA.map { |handle, product| new(handle:, **product) }
  end

  def self.find(handle)
    new(handle:, **Product::DATA.fetch(handle))
  end

  def to_param
    handle
  end

  def to_partial_path
    "products/product"
  end

  def image_srcs
    Dir.foreach(Rails.root.join("public", "img", "products", handle, "main")).filter_map do |filename|
      "/img/products/#{handle}/main/#{filename}" if File.extname(filename).in?(Product::IMAGE_EXTNAMES)
    end
  end

  def first_image_src
    image_srcs.first
  end

  def outdated_price(currency = "GBP")
    ((price[currency] * 2).to_f / 100).ceil - 0.01
  end
end
