json.array! @sites do |site|
  json.extract! site, :id, :title, :description
  json.site_category do
    if site.site_category
      json.id site.site_category.id
      json.name site.site_category.name
    end
  end

  json.namespace do
    if site.namespace
      json.id site.namespace.id
      json.name site.namespace.name
    end
  end

end
