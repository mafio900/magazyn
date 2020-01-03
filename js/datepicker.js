(function($) {
    $.fn.loadDatePicker = function() {
        $('.date').datetimepicker({
            dateFormat: "yy-mm-dd",
            minDate: new Date(),
            setDate: (new Date()),
            changeMonth: true,
            changeYear: true,
            monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj', 'Czerwiec','Lipiec', 'Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
            monthNamesShort: ['Styczeń','Luty','Marzec','Kwiecień','Maj', 'Czerwiec','Lipiec', 'Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
            dayNamesMin: ['Pn','Wt','Śr','Cz','Pt','So','Nd'],
            timeText: 'Czas',
            hourText: 'Godzina',
	        minuteText: 'Minuta',
            closeText: 'Wybierz',
            currentText: 'Teraz'
        });
        $('.date').datetimepicker('setDate', (new Date()) );
    }
})(jQuery);
