# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.more_toggle').click (e)->
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
