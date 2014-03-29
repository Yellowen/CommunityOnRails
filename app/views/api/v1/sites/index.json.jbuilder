json.array! @sites do |site|
  json.extract! site, :id, :title, :description
  json.category do
    if site.category
      json.id site.category.id
      json.name site.category.name
    end
  end

  json.namespace do
    if site.namespace
      json.id site.namespace.id
      json.name site.namespace.name
    end
  end

end
