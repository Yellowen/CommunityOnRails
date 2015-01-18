Faalis::Engine.load_seed

SiteCategory.create(name: 'Arts and Entertainment')
SiteCategory.create(name: 'Automotive')
SiteCategory.create(name: 'Beauty and Fitness')
SiteCategory.create(name: 'Books and Literature')
SiteCategory.create(name: 'Business and Industrial Markets')
SiteCategory.create(name: 'Computers and Electronics')
SiteCategory.create(name: 'Finance')
SiteCategory.create(name: 'Food and Drink')
SiteCategory.create(name: 'Games')
SiteCategory.create(name: 'Healthcare')
SiteCategory.create(name: 'Hobbies and Leisure')
SiteCategory.create(name: 'Home and Garden')
SiteCategory.create(name: 'Internet and Telecom')
SiteCategory.create(name: 'Jobs and Education')
SiteCategory.create(name: 'Law and Government')
SiteCategory.create(name: 'News')
SiteCategory.create(name: 'Online Communities')
SiteCategory.create(name: 'People and Society')
SiteCategory.create(name: 'Pets and Animals')
SiteCategory.create(name: 'Real Estate')
SiteCategory.create(name: 'Reference')
SiteCategory.create(name: 'Science')
SiteCategory.create(name: 'Shopping')
SiteCategory.create(name: 'Sports')
SiteCategory.create(name: 'Travel')
SiteCategory.create(name: 'Other')

unless Rails.env.production?
  if Faalis::ORM.active_record?
    Namespace.create(name: 'ex', user_id: 1)

    SiteFramework::Site.create(title: 'example site',
                               description: 'some example',
                               site_category_id: 1)

    SiteFramework::Domain.create!(name: 'ex.localhost.com', site_id: 1,
                                  namespace_id: 1)

    Faalis::User.create({ email: 'user@user.com',
                          groupid: 1,
                          password: '123123123',
                          password_confirmation: '123123123'})

    Namespace.create(name: 'ex2', user_id: 3)

    SiteFramework::Site.create(title: 'example 2 site',
                               description: 'some 2  example',
                               site_category_id: 3)

    SiteFramework::Domain.create!(name: 'ex2.localhost.com', site_id: 2,
                                  namespace_id: 2)

  elsif Faalis::ORM.mongoid?

    user1 = Faalis::User.create(email: 'user1@user.com',
                                password: '123123123',
                                password_confirmation: '123123123')

    user2 = Faalis::User.create(email: 'user2@user.com',
                               password: '123123123',
                               password_confirmation: '123123123')

    user1.namespaces = [Namespace.new(name: 'ex')]

    user1.namespaces[0].sites = [SiteFramework::Site.new(title: 'example site',
                                                         description: 'some example',
                                                         site_category: ['Healthcare'])]

    user1.namespaces[0].sites[0].domains = [SiteFramework::Domain.new(name: 'ex.localhost.com')]


    user2.namespaces = [Namespace.new(name: 'ex2')]

    user2.namespaces[0].sites = [SiteFramework::Site.new(title: 'example 2 site',
                                                         description: 'some 2  example',
                                                         site_category: ['Healthcare'])]

    user2.namespaces[0].sites[0].domains = [SiteFramework::Domain.new(name: 'ex2.localhost.com')]

  end

end
