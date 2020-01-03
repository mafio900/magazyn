(function($) {
    $.fn.loadValidationTowar = function() {
        $.validator.addMethod("valueNotEquals", function(value, element, arg){
            return arg !== value;
        }, "Value must not equal arg.");
        $.validator.addMethod("literyispacje", function(value, element) {
            return this.optional(element) || /^[a-zA-ZąĄęĘóśŚÓłŁżŻźŹćĆńŃ\s]*$/.test(value);
        }, "To pole musi posiadać tylko litery!");
        $('input[name="Nazwa"]').rules('remove', "nowhitespace");
        $('input[name="Nazwa"]').rules( "add", {
            maxlength: '100'
        });

        $('select[name="IdJednostkaMiary"]').rules( "add", {
            valueNotEquals: "def",
            messages: {
                valueNotEquals: "Proszę wybrać jednostkę!"
            }
        });

        $('.js-select2').on('change', function() {
            $(this).valid();
        });
    }
})(jQuery);
