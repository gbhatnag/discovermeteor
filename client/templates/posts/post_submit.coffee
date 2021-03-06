@Template.postSubmit.onCreated () -> Session.set 'postSubmitErrors', {}

@Template.postSubmit.helpers
  errorMessage: (field) ->
    Session.get('postSubmitErrors')[field]

  errorClass: (field) ->
    if Session.get('postSubmitErrors')[field] then 'has-error' else ''

@Template.postSubmit.events
  'submit form': (e) ->
    e.preventDefault()
    post = 
      url: $(e.target).find('[name=url]').val(),
      title: $(e.target).find('[name=title]').val()

    errors = validatePost post
    return Session.set 'postSubmitErrors', errors if errors.title or errors.url

    Meteor.call 'postInsert', post, (error, result) ->
      Errors.throw error.reason if error
      Errors.throw 'This link has already been posted' if result.postExists
      Router.go 'postPage', _id: result._id
