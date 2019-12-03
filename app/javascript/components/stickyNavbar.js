jQuery(document).ready(function( $ ) {
    jQuery(window).scroll(function() {
      if ( $ (window).width() > 1024) {
        if ( $ (window).scrollTop() >= 500) {
            $ ('#site_header').fadeIn();
          } else {
            $ ('#site_header').fadeOut();
             }
      }
    });
});
