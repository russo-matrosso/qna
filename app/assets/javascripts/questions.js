var ready = function() {
    $('#delete_question').click(function() {
        $('#delete_confirmation').show();
    });

    $('#hide_confirmation').click(function() {
        $('#delete_confirmation').hide();
    });

    $.getJSON(window.location.pathname, function(data) {
        $.each(data, function(key) {
            console.log(data[key]);
            $('.answers').append(HandlebarsTemplates['answer'](data[key]));
        });
    });

    $('form#new_answer').bind('ajax:success', function (e, data, status, xhr) {
        response = $.parseJSON(xhr.responseText);
        $('.answers').after(HandlebarsTemplates['answer'](response));
    });


    data = $.getJSON(window.location.pathname);
};

$(document).ready(ready);
$(document).on('page:load', ready);

