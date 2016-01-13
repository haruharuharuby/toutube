$ ->
  $(".user-description").css("display", "none")
  $(".playlist-action-container").css("display", "none")
  $(".left-side-menu").css("display", "none")
  $("#new_playlist_submit").css("display", "none")
  $("#new_playlist_submit").prop("disabled", true)

  $(".comment-action").css("display", "none")

  $(".user-icon").on "click", ->
    $(".user-description").toggle()

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

  $(".playlist-add-toggle").on "click", ->
    $(".playlist-action-container").toggle()

  $(".playlist-action-item").on "click", ->
    $(this).submit()

  $("#new_playlist_name").on "focus", ->
    $("#new_playlist_submit").css("display", "block")

  $("#new_playlist_name").on "input", ->
    if $(this).val().length == 0
      $("#new_playlist_submit").prop("disabled", true)
    else
      $("#new_playlist_submit").prop("disabled", false)


  $("#comment_body").on "focus", ->
    $(".comment-action").css("display", "block")

  $("#comment_cancel").on "click", ->
    $(".comment-action").css("display", "none")
    $("textarea#comment_body").val("")
