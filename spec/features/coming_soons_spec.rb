require 'rails_helper'

feature 'ComingSoons', type: :feature do

  before :all do
    @coming_soon = ENV['coming_soon']
    ENV['coming_soon'] = 'true'
  end

  after :all do
    ENV['coming_soon'] = @coming_soon
  end

  scenario 'User Coming to the home page' do
    visit root_url
    expect(current_path).to eq(coming_soon_path)
  end
end
