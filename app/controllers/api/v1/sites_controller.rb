class API::V1::SitesController < APIController
  before_filter :build_resource, :only => :create
  load_and_authorize_resource :except => [:destory]

  # GET /api/v1/sites
  def index
    respond_with(@sites)
  end

  def create
    
    if @site.save
      respond_with(@site)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @site.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with(@site)
  end

  def update
    

    if @site.update(resource_params)
      respond_with(@site)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @site.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    ids = params[:id].split(",")
    @sites = ::Site.where(:id => ids)
    authorize! :destroy, @sites
    @sites.destroy_all
  end

  def build_resource
    @site = ::Site.new(resource_params)
  end

  def resource_params
    params.require(:site).permit(:id, :title, :category_id, :description)
  end

end
