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
end
