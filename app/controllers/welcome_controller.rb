class WelcomeController < ApplicationController

  def index
    if ENV['coming_soon'] == 'true'
      redirect_to :coming_soon
      return
    end
  end

  def coming_soon
    render layout: 'simple'
  end

  def subscribe
    email = params[:email].downcase

    respond_to do |f|
      if email ~= /[0-9a-z\._]+\@[0-9a-z\._]+\.[0-9a-z\._]#{2,3,4}/i
        if SubscribeService.new(email).call
          f.html { render 'subscribed' }
        else
          flash[:error] = _('Subscription failed. Please try again later.')
          f.html { redirect_to request.referer  }
        end
      else
          flash[:error] = _('Please enter a valid email address.')
          f.html { redirect_to request.referer  }
      end
    end
  end

end
