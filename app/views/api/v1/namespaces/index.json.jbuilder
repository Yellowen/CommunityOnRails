json.array! @namespaces do |namespace|
  json.id namespace.id.to_s
  json.extract! namespace, :name
end
