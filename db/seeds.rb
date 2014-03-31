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

Namespace.create(name: 'exnamespace', user_id: 1)

SiteFramework::Site.create(title: 'example site',
                           description: 'some example',
                           site_category_id: 1)

SiteFramework::Domain.create!(name: 'ex.localhost.com', site_id: 1,
                             namespace_id: 1)
