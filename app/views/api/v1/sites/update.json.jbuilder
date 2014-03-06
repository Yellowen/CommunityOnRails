json.extract! @site, :id, :title, :description

json.partial! 'faalis/relations/belongs_to', object: @site.category, :name => :category, :fields => [:id, :name]

