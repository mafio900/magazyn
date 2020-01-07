(function($) {
    $.fn.loadValidationPZ = function() {
        $.validator.addMethod("valueNotEquals", function(value, element, arg){
            return arg !== value;
        }, "Value must not equal arg.");
        $('input[name="NumerPZ"]').rules('remove', "nowhitespace");
        $('input[name="DataDostawy"]').rules('remove', "nowhitespace");

        $('select[name="IdDostawca"]').rules( "add", {
            valueNotEquals: "def",
            messages: {
                valueNotEquals: "Proszę wybrać dostawcę!"
            }
        });

        $('.js-select2').on('change', function() {
            $(this).valid();
        });
    }
})(jQuery);
