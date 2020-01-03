(function($) {
    $.fn.loadValidation = function(form) {
    $(form).validate({
        errorClass: 'error',
        validClass: 'success',
        errorElement: 'span',
        errorPlacement: function(error, element) {
            if (element.hasClass('js-select2')) {
                error.appendTo(element.next('span').next('div'));
            }
            error.appendTo( element.next("div") );
        },
        highlight: function(element, errorClass, validClass) {
            $(element).parents("div.form-control-*").addClass(errorClass).removeClass(validClass);
            $(element).addClass(errorClass).removeClass(validClass);
            $(element).next('span').addClass(errorClass).removeClass(validClass);
        },
        unhighlight: function(element, errorClass, validClass) {
            $(element).parents(".error").removeClass(errorClass).addClass(validClass);
            $(element).removeClass(errorClass).addClass(validClass);
            $(element).next('span').removeClass(errorClass).addClass(validClass);
        }
    });

    $('input[type="text"]').each(function() {
        $(this).rules('add', {
            required: true,
            nowhitespace: true,
            messages: {
                required: "To pole jest wymagane!",
                nowhitespace: "To pole nie może posiadać spacji!"
            }
        });
    });
    }
})(jQuery);
