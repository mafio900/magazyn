$(document).ready(function() {
    if(typeof jQuery().loadModal !== "undefined") {
        $('.add-button').loadModal({klasa : 'loadValidationPZ'});
        $('.edit-button').loadModal({klasa : 'loadValidationPZ'});
    }
});
