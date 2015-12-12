$ ->
  $(".user-description").css("display", "none")
  $(".add-action-list").css("display", "none")
  $(".left-side-menu").css("display", "none")

  channels = $(".user-description").length
  $(".user-description").height(channels*30 + 50)
  $(".user-menu").on "click", ->
    $(".user-description").toggle()

  $(".add-play-list").on "click", ->
    $(".add-action-list").toggle()

  $(".add-button-action-container").on "click", ->
    $(this).toggle()

  $(".toggle-side-menu").on "click", ->
    $(".left-side-menu").toggle()
    if $(".left-side-menu").css("display") == 'none'
      $(".left-side-menu").removeClass("col-md-2")
      $(".contents").removeClass("col-md-10")
      $(".contents").addClass("col-md-12")
    else
      $(".left-side-menu").addClass("col-md-2")
      $(".contents").addClass("col-md-10")
      $(".contents").removeClass("col-md-12")
      # $(".contents").css("padding-left", "0")
      # $(".contents").css("padding-right", "0")

  $(".add").on "click", ->
    $(".floating-playlist-add").toggle()
