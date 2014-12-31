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

    if email ~= /[0-9a-z\._]+\@[0-9a-z\._]+\.[0-9a-z\._]#{2,3,4}/i

    end
  end

end
