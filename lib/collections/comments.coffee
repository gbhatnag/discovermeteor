@Comments = new Mongo.Collection 'comments'

@Meteor.methods
  commentInsert: (commentAttributes) ->
    check @userId, String
    check commentAttributes,
      postId: String
      body: String

    user = Meteor.user()
    post = Posts.findOne commentAttributes.postId

    if not post
      throw new Meteor.Error 'invalid-comment', 'Your comment is not attached to a post'

    comment = _.extend commentAttributes,
      userId: user._id
      author: user.username
      submitted: new Date()

    Comments.insert comment
