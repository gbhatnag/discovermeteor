Template.header.helpers
  activeRouteClass: () ->
    args = Array.prototype.slice.call arguments, 0
    args.pop()

    active = _.any args, (name) ->
      Router.current() and Router.current().route.getName() is name

    active and 'active'