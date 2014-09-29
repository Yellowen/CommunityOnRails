class API::V1::NamespacesController < APIController
  
  before_filter :build_resource, :only => :create
  
  load_and_authorize_resource :except => [:destory]
  
  # GET /api/v1/namespaces
  def index
    respond_with(@namespaces)
  end

  def create
    
    if @namespace.save
      respond_with(@namespace)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @namespace.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with(@namespace)
  end

  def update
    

    if @namespace.update(resource_params)
      respond_with(@namespace)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @namespace.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    ids = params[:id].split(",")
    @namespaces = ::Namespace.where(:id => ids)
    authorize! :destroy, @namespaces
    @namespaces.destroy_all
  end

  def build_resource
    @namespace = ::Namespace.new(resource_params)
    
  end

  def resource_params
    params.require(:namespace).permit(:id, :name)
  end

end
