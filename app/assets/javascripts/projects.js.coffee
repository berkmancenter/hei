# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.more_toggle').on
  click: (e)-> 
    e.preventDefault()
    project = $(this).closest('.project')
    if $(project).hasClass('span4')
      #Expand it
      $(this).find('.state').html('less')
      $(project).find('.more').show()
      $(project).find('.less').hide()
      $(project).removeClass('span4').addClass('span8')
      $(this).closest('.thumbnail').addClass('tall')
    else 
      #Contract it
      $(this).find('.state').html('more')
      $(project).find('.more').hide()
      $(project).find('.less').show()
      $(project).removeClass('span8').addClass('span4')
      $(this).closest('.thumbnail').removeClass('tall')

$(document).ready ()->
  $('body').data('filter_container_height', $('#filtering').height())
  $('#filtering #filter_container').hide()
  $('#filtering').height($('body').data('filter_container_height'))

$('#filtering h2').on
  click: (e)->
    e.preventDefault()
    $('#filtering #filter_container').toggle()
    $('#filtering').height($('body').data('filter_container_height'))

$('.pagination a').on
  click: (e)->
    paginationTarget = $(this).closest('.pagination_target')
    e.preventDefault();
    $.ajax
      type: 'GET',
      url: $(this).attr('href')
      dataType: 'html'
      success: (html)->
        $(paginationTarget).html(html);

