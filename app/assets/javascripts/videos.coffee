$ ->
  $(".user-description").css("display", "none")
  $(".add-action-list").css("display", "none")

  channels = $(".user-description").length
  $(".user-description").height(channels*30 + 50)
  $(".user-menu").on "click", ->
    $(".user-description").toggle()

  $(".add-play-list").on "click", ->
    $(".add-action-list").toggle()

  $(".add-button-action-container").on "click", ->
    $(this).toggle()
