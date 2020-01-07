$(document).ready(function() {
    if(typeof jQuery().loadModal !== "undefined") {
        $('.add-button').loadModal({klasa : 'loadValidationPZTowar'});
        $('.edit-button').loadModal({klasa : 'loadValidationPZTowar'});
    }
});
