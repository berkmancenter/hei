$( '.container' ).on( 'click', '.more_toggle', function( e ) {
  e.preventDefault();
  var $this = $(this);
  var project = $this.closest('.project');
  if ( project.hasClass('span4') ) {
    // expand it
    $this.find('.state').html('less');
    project.find('.more').show();
    project.find('.less').hide();
    project.removeClass('span4').addClass('span8');
    $this.closest('.thumbnail').addClass('tall');
  } else {
    // contract it
    $this.find('.state').html('more');
    project.find('.more').hide();
    project.find('.less').show();
    project.removeClass('span8').addClass('span4');
    $this.closest('.thumbnail').removeClass('tall');
  }
} );

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

