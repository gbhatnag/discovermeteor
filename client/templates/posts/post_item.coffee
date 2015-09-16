Template.postItem.helpers
  domain: () ->
    a = document.createElement 'a'
    a.href = @url
    a.hostname
  ownPost: () -> @userId is Meteor.userId()
  upvotedClass: () ->
    userId = Meteor.userId()
    if userId and not _.include(@upvoters, userId)
      return 'btn-primary upvotable'
    else
      return 'disabled'

Template.postItem.events
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id