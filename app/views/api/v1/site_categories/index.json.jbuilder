json.array! @site_categories do |site_category|
  json.id site_category.id.to_s
  json.extract! site_category, :name, :description
end
