json.extract! @site, :id, :title, :description


json.partial! 'faalis/relations/belongs_to', object: @site.site_category, :name => :site_category, :fields => [:id, :name]


json.partial! 'faalis/relations/belongs_to', object: @site.namespace, :name => :namespace, :fields => [:id, :name]


