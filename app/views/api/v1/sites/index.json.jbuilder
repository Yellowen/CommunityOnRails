json.array! @sites do |site|
  json.extract! site, :id, :title, :description
  json.category do if site.category
    json.id site.category.id
    json.name site.category.name
  end
end

end
