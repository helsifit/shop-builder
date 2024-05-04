module Site
  YAML.load_file(Rails.root.join("config", "site.yml")).each do |k, v|
    define_singleton_method(k) { v }
  end
end
