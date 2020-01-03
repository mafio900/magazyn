(function($) {
    $.fn.loadSelect2 = function() {
        $('.js-select2').select2({
            language: "pl",
            dropdownParent: $('#modal')
        });
    }
})(jQuery);
