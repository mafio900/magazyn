(function($) {
    $.fn.loadValidationZamowienie = function() {
        $.validator.addMethod("valueNotEquals", function(value, element, arg){
            return arg !== value;
        }, "Value must not equal arg.");
        $.validator.addMethod("literyispacje", function(value, element) {
            return this.optional(element) || /^[a-zA-ZąĄęĘóśŚÓłŁżŻźŹćĆńŃ\s]*$/.test(value);
        }, "To pole musi posiadać tylko litery!");

        $('#DataZamowienia').rules('remove', "required nowhitespace");
        $('input[name="DataWydania"]').rules('remove', "nowhitespace");

        $('input[name="DataWydania"]').rules( "add", {
            dateValidator: {
                format: 'YYYY-MM-DD HH:mm',
                separator: '-'
            }
        });

        $('.js-select2').on('change', function() {
            $(this).valid();
        });
    }
})(jQuery);
