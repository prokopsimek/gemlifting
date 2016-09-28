$(document).on('page:change', function() {
    console.log('GA logging');
    ga('send', 'pageview', window.location.pathname);
});
