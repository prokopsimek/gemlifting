$(document).on('turbolinks:load', function() {

    // open all categories list on homepage
    $('#categories-list .btn-all-categories').click(function(e){
        e.preventDefault();
        $('#categories-list .category.hidden').removeClass('hidden');
        $(this).addClass('hidden');
        var target = $("#categories-list").offset().top;
        $('html, body').animate({scrollTop:target}, 'slow');
    });

});
