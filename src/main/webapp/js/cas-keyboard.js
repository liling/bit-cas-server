// Software Keyboard
$(document).ready(function(){
    $('.qwerty').each(function() {
        $(this).keyboard({
            openOn   : null,
            stayOpen : true,
            layout   : 'qwerty',
            position : {
                of : $(this),
                my : 'left top',
                at : 'left top'
            }
        });
    });
    $('#username-keyboard').click(function(){
        $('#username').getkeyboard().reveal();
    });
    $('#password-keyboard').click(function(){
        $('#password').getkeyboard().reveal();
    });
    // since IE adds an overlay behind the input to prevent clicking in other inputs (the keyboard may not automatically open on focus... silly IE bug)
    // We can remove the overlay (transparent) if desired using this code:
    $('.qwerty').bind('visible.keyboard', function(e, keyboard, el){
     $('.ui-keyboard-overlay').remove(); // remove overlay because clicking on it will close the keyboard... we set "openOn" to null to prevent closing.
    });
});
