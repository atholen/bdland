# application.coffee

window.addEventListener "popstate", (e) ->
  switchPage location.pathname.split( "/" )[1]

projects = [ "ryuichisakamoto", "yoshitakaamano", "ericclapton", "lostintranslation", "marcjacobs" ]

###### Handle video embed size

$allVideos = $("iframe")

$allVideos.each ->
  $(this).data('aspectRatio', @height / @width).removeAttr('height').removeAttr 'width'

$(window).resize( ->
  newWidth = $(".measuring-stick").width()

  $allVideos.each ->
    $el = $(this)
    $el.width(newWidth).height newWidth * $el.data('aspectRatio')
    return
  return
).resize()


################## METHODS ####################


checkPageHeight = () ->
  paneH     = $(".project-pane").height()
  navH      = $("#navigation-bar").height()
  footerH   = 40 + $("#footer").height() + 13       # include margins
  windowH   = $(window).height()

  if ( windowH - navH - footerH ) < paneH
    $("#footer").addClass "not-fixed-to-bottom"
  else
    $("#footer").removeClass "not-fixed-to-bottom"

switchPage = ( newSection, currentSection ) ->
  pageToShow = projects[ newSection ]
  pageToHide = projects[ currentSection ]

  if pageToHide != pageToShow 
    $("##{pageToHide}").fadeOut 200, ->
      $("##{pageToShow}").fadeIn 200, ->
        $("##{pageToShow}").addClass 'selected'
        checkPageHeight()
      $("##{pageToHide}").removeClass 'selected'

  $(".center-content").attr( "project_page", pageToShow )

  window.history.pushState null, null, "/#{pageToShow}"

arrowListeners = () ->
  $(".left-button").on 'click', (e) ->
    e.preventDefault()

    proj = $(".center-content").attr( "project_page" )
    currentSection = projects.indexOf proj

    newSection = ( currentSection - 1 ) %% projects.length

    switchPage newSection, currentSection
    

  $(".right-button").on 'click', (e) ->
    e.preventDefault()

    proj = $(".center-content").attr( "project_page" )
    currentSection = projects.indexOf proj

    newSection = ( currentSection + 1 ) %% projects.length

    switchPage newSection, currentSection


################## MAIN ####################


$(document).ready ->
  checkPageHeight()

  if $("body").hasClass "project-page"
    arrowListeners()

  if ! $("body").hasClass "project-page"
    $(document).on 'scroll', () ->
      scrollH = $(document).scrollTop()
      videoH  = $("#video").height()
      $("#navigation-bar").css "background-color", "rgba( 33, 33, 33, #{ scrollH / videoH } )" # 33's for dark grey ("almost black")


  $('.menu-button').on 'click', (e) ->
    e.preventDefault()

    $("#navigation-modal").fadeIn 100, () ->
      $("body").addClass "no-scroll"

  $(".x-button").on 'click', (e) ->
    e.preventDefault()
    
    $("#navigation-modal").fadeOut 100, () ->
      $("body").removeClass "no-scroll"

    