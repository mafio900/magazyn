$(document).ready(function() {
    if(typeof jQuery().loadModal !== "undefined") {
        $('.add-button').loadModal({klasa : 'loadValidationZamowienie'});
        $('.edit-button').loadModal({klasa : 'loadValidationZamowienie'});
    }
});
