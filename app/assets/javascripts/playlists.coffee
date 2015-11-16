$ ->
  $videos = $(".playlist-video")
  $videos.each ->
    if $(this).attr("id") == "0"
      $(this).show()
    else
      $(this).hide()

  $videos.each ->
    $(this).on "ended", ->
      if $(this).attr("id") == $videos.last().attr("id")
        $(this).hide()
        $videos.first().show()
      else
        $next = $(this).next()
        $(this).fadeOut().delay(800)
        $next.fadeIn(1000).get(0).play()
