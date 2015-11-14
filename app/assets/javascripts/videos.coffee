$ ->
  $(".user-information").css("display", "none")
  $(".add-action-list").css("display", "none")

  channels = $(".user-channel").length
  $(".user-information").height(channels*30 + 50)
  $(".user-icon").on "click", ->
    $(".user-information").toggle()

  $(".add-play-list").on "click", ->
    $(".add-action-list").toggle()

  $(".add-button-action-container").on "click", ->
    $(this).toggle()
