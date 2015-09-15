if Posts.find().count() is 0
  now = new Date().getTime()

  # create two users
  tomId = Meteor.users.insert
    profile: {name: 'Tom Coleman'}
  tom = Meteor.users.findOne tomId

  sachaId = Meteor.users.insert
    profile: {name: 'Sacha Greif'}
  sacha = Meteor.users.findOne sachaId

  telescopeId = Posts.insert
    title: 'Introducing Telescope',
    url: 'http://sachagreif.com/introducing-telescope/',
    userId: sacha._id,
    author: sacha.profile.name,
    submitted: new Date(now - 7 * 3600 * 1000)

  Comments.insert
    postId: telescopeId,
    userId: tom._id,
    author: tom.profile.name,
    submitted: new Date(now - 5 * 3600 * 1000),
    body: 'Interesting project Sacha, can I get involved?'

  Comments.insert
    postId: telescopeId,
    userId: sacha._id,
    author: sacha.profile.name,
    submitted: new Date(now - 3 * 3600 * 1000),
    body: 'You sure can Tom!'

  Posts.insert
    title: 'Meteor',
    url: 'http://meteor.com',
    userId: tom._id,
    author: tom.profile.name,
    submitted: new Date()

  Posts.insert
    title: 'The Meteor Book',
    url: 'http://themeteorbook.com',
    userId: tom._id,
    author: tom.profile.name,
    submitted: new Date()
