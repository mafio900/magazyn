(function($) {
    $.fn.loadValidationPZTowar = function() {
        $.validator.addMethod("valueNotEquals", function(value, element, arg){
            return arg !== value;
        }, "Value must not equal arg.");

        $('select[name="IdTowar"]').rules( "add", {
            valueNotEquals: "def",
            messages: {
                valueNotEquals: "Proszę wybrać towar!"
            }
        });

        $('.js-select2').on('change', function() {
            $(this).valid();
        });
    }
})(jQuery);
