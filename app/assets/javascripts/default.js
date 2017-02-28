$(document).on('turbolinks:load', function() {

    // Tooltip
    $('button').tooltip({
        trigger: 'click',
        placement: 'top'
    });
    function setTooltip(btn, message) {
        $(btn).tooltip('hide')
            .attr('data-original-title', message)
            .tooltip('show');
    };
    function hideTooltip(btn) {
        setTimeout(function() {
            $(btn).tooltip('hide');
        }, 1000);
    };

    // copy to clipboard
    var clipboard = new Clipboard('.btn-clip');
    clipboard.on('success', function(e) {
        setTooltip(e.trigger, 'Copied!');
        hideTooltip(e.trigger);
    });
    clipboard.on('error', function(e) {
        setTooltip(e.trigger, 'Failed!');
        hideTooltip(e.trigger);
    });

    // select onclick
    $('input.select-onclick').click(function () {
        this.select();
    });

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
