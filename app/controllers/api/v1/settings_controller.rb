class API::V1::SettingsController < Faalis::APIController
  before_filter :build_resource, :only => :create
  load_and_authorize_resource :except => [:destory]

  # GET /api/v1/settings
  def index
    respond_with(@settings)
  end

  def create
    
    if @setting.save
      respond_with(@setting)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @setting.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with(@setting)
  end

  def update
    

    if @setting.update(resource_params)
      respond_with(@setting)
    else
      respond_to do |format|
        format.json { render :json => {:fields => @setting.errors}, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    ids = params[:id].split(",")
    @settings = ::Setting.where(:id => ids)
    authorize! :destroy, @settings
    @settings.destroy_all
  end

  def build_resource
    @setting = ::Setting.new(resource_params)
  end

  def resource_params
    params.require(:setting).permit(:id, :theme)
  end

end
