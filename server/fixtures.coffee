if Posts.find().count() is 0
  Posts.insert
    title: 'Introducing Telescope',
    url: 'http://sachagreif.com/introducing-telescope/',
    userId: "adminId",
    author: "Admin",
    submitted: new Date()
  
  Posts.insert
    title: 'Meteor',
    url: 'http://meteor.com',
    userId: "adminId",
    author: "Admin",
    submitted: new Date()

  Posts.insert
    title: 'The Meteor Book',
    url: 'http://themeteorbook.com',
    userId: "adminId",
    author: "Admin",
    submitted: new Date()
