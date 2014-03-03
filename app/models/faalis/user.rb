# Require Faalis user class first
# if we don't do this, User class will define here for the first time
# which will break our application
require Faalis::Engine.root.join('app', 'models', 'faalis', 'user')

# Re-opened class of `Faalis::User` to extend it based on our needs
class Faalis::User

end
