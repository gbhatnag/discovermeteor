Package.describe({
  name: 'gbhatnag:errors',
  version: '1.0.0',
  // Brief, one-line summary of the package.
  summary: 'A pattern to display application errors to the user'
});

Package.onUse(function (api) {
  api.versionsFrom('1.1.0.3');

  api.use(['minimongo', 'mongo-livedata', 'templating'], 'client');

  api.addFiles(['errors.js', 'errors_list.html', 'errors_list.js'], 'client');
});

Package.onTest(function (api) {
  api.use('gbhatnag:errors', 'client');
  api.use(['tinytest', 'test-helpers'], 'client');

  api.addFiles('errors_tests.js', 'client');
})