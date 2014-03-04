json.extract! @site, :id, :title, :description
json.category do
  json.id @site.category_id
  json.name @site.category.name
end
