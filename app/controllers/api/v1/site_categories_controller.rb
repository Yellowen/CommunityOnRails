class API::V1::SiteCategoriesController < APIController
  before_filter :build_resource, :only => :create
  
  load_and_authorize_resource :except => [:destory]
  
  # GET /api/v1/site_categories
  def index
    respond_with(@site_categories)
  end

  def create
    
    if @site_category.save
      respond_with(@site_category)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @site_category.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with(@site_category)
  end

  def update
    

    if @site_category.update(resource_params)
      respond_with(@site_category)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @site_category.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    ids = params[:id].split(",")
    @site_categories = ::SiteCategory.where(:id => ids)
    authorize! :destroy, @site_categories
    @site_categories.destroy_all
  end

  def build_resource
    @site_category = ::SiteCategory.new(resource_params)
    
  end

  def resource_params
    params.require(:site_category).permit(:id, :name, :description)
  end

end
