json.array! @site_categories do |site_category|
  json.extract! site_category, :id, :name, :description
end
