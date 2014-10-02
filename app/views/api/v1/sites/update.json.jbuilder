json.id @site.id.to_s
json.extract! @site, :title, :description

json.partial! 'faalis/relations/belongs_to', object: @site.site_category, :name => :site_category, :fields => [:id, :name]

json.partial! 'faalis/relations/belongs_to', object: @site.namespace, :name => :namespace, :fields => [:id, :name]

