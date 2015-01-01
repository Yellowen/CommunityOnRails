class SubscribeService

  def initialize(email)
    @email = email
    @mailinglist =  Rails.application.secrets[:mailgun_mailinglist]
    @mailgun_api_key = Rails.application.secrets[:mailgun_api]
  end

  def add_list_member
    begin
      RestClient.post("https://api:#{@mailgun_api_key}" \
                      "@api.mailgun.net/v2/lists/#{@mailinglist}/members",
                      subscribed: true,
                      name: @email,
                      description: @email,
                      address: @email)
      true
    rescue RestClient::BadRequest => e
      return false
    end
  end

  def call
    add_list_member
  end
end
