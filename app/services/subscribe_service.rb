class SubscribeService

  def initializers(email)
    @email = email
    @mailinglist =  ENV['NEWSLETTER']
    @mailgun_api_key = ENV['MAILGUN_API_KEY']
  end

  def add_list_member email
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
