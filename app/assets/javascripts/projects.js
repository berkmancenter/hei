$( '#filtering' ).on( 'click', 'h2', function( e ) {
  e.preventDefault();
  $('#filtering #filter_container').toggle();
  $('#filtering').height($('body').data('filter_container_height'));
} );

$( '.pagination' ).on( 'click', 'a', function( e ) {
  paginationTarget = $(this).closest('.pagination_target');
  e.preventDefault();;
  $.ajax( {
    type: 'GET',
    url: $(this).attr('href'),
    dataType: 'html',
    success: function( html ) {
      $(paginationTarget).html( html );
    }
  } );
} );

$( function ( ) {
  $('body').data('filter_container_height', $('#filtering').height());
  $('#filtering #filter_container').hide();
  $('#filtering').height($('body').data('filter_container_height'));
} );

