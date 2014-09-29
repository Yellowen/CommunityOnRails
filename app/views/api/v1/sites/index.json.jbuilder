json.array! @sites do |site|
  json.id site.id.to_s
  json.extract! site, :title, :description
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
