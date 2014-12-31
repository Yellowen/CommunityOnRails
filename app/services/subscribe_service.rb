class SubscribeService

  def initializers(email)
    @email = email
  end

  def call
    true
  end
end
