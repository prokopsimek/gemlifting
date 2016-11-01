$(document).on('turbolinks:load', function() {
    window.setTimeout(function () {
        $(".alert").fadeTo(1000, 0).slideUp(500, function () {
            $(this).remove();
        });
    }, 1500);
});
