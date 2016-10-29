$(document).on('turbolinks:load', function() {

    // open all categories list on homepage
    $('#categories-list .btn-all-categories').click(function(e){
        e.preventDefault();
        $('#categories-list .category.hidden').removeClass('hidden');
        $(this).addClass('hidden');
        var target = $("#categories-list").offset().top;
        $('html, body').animate({scrollTop:target}, 'fast');
    });

    // open other subcategories on homepage by clicking on 'more'
    $('#categories-list .category .more').click(function(e){
        e.preventDefault();
        var category_id = $(this).data('category');
        $('#categories-list #category-' + category_id + ' span.hidden').removeClass('hidden');
        $('#categories-list #category-' + category_id + ' .more-wrapper').remove();
    });

});
