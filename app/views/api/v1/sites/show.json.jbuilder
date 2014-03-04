json.extract! @site, :id, :title, :description

json.category do
  json.id @site.category.id
  json.name @site.category.name
end


