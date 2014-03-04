json.array! @namespaces do |namespace|
  json.extract! namespace, :id, :name
end
