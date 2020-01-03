$(document).ready(function() {
    if(typeof jQuery().loadModal !== "undefined") {
        $('.add-button').loadModal({klasa : 'loadValidationTowar'});
        $('.edit-button').loadModal({klasa : 'loadValidationTowar'});
    }
});
