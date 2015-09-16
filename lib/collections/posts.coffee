@Posts = new Mongo.Collection 'posts'

@Posts.allow
  update: (userId, post) -> ownsDocument(userId, post),
  remove: (userId, post) -> ownsDocument(userId, post)

@Posts.deny
  update: (userId, post, fieldNames) ->
    _.without(fieldNames, 'url', 'title').length > 0
  update: (userId, post, fieldNames, modifier) ->
    errors = validatePost modifier.$set
    errors.title or errors.url

@Meteor.methods
  postInsert: (postAttributes) ->
    check Meteor.userId(), String
    check postAttributes,
      title: String,
      url: String

    errors = validatePost postAttributes
    throw new Meteor.Error 'invalid-post', 'You must set a title and URL for your post' if errors.title or errors.url

    postWithSameLink = Posts.findOne url: postAttributes.url
    if postWithSameLink
      return postExists: true, _id: postWithSameLink._id

    user = Meteor.user()
    post = _.extend postAttributes,
      userId: user._id
      author: user.username
      submitted: new Date()
      commentsCount: 0
      upvoters: []
      votes: 0

    postId = Posts.insert post

    return _id: postId

  upvote: (postId) ->
    check @userId, String
    check postId, String

    affected = Posts.update
      _id: postId
      upvoters: {$ne: @userId}
    ,
      $addToSet: {upvoters: @userId}
      $inc: {votes: 1}

    if not affected
      throw new Meteor.Error 'invalid', 'You were not able to upvote this post'

@validatePost = (post) ->
  errors = {}

  errors.title = "Please fill in a headline" if not post.title
  errors.url = "Please fill in a URL" if not post.url

  errors