# application.coffee


# slideRight = ( $elm ) ->

#   pageWidth = $(window).width

#   $elm.animate {
#       "margin-left": "-#{pageWidth}"
#     }, 1000


window.addEventListener "popstate", (e) ->
  switchPage location.pathname.split( "/" )[1]

projects = [ "ryuichisakamoto", "yoshitakaamano", "ericclapton", "lostintranslation", "marcjacobs" ]






switchPage = ( newSection, currentSection ) ->

  pageToShow = projects[ newSection ]
  pageToHide = projects[ currentSection ]

  if pageToHide != pageToShow 
    $("##{pageToHide}").fadeOut 200, ->
      $("##{pageToShow}").fadeIn 200, ->
        $("##{pageToShow}").addClass 'selected'
      $("##{pageToHide}").removeClass 'selected'

  $(".center-content").attr( "project_page", pageToShow )

  window.history.pushState null, null, "/#{pageToShow}"

arrowListeners = () ->
  $(".left-button").on 'click', (e) ->
    e.preventDefault()

    proj = $(".center-content").attr( "project_page" )
    currentSection = projects.indexOf proj

    console.log currentSection
    console.log projects.length
    newSection = ( currentSection - 1 ) %% projects.length
    console.log newSection

    switchPage newSection, currentSection
    

  $(".right-button").on 'click', (e) ->
    e.preventDefault()

    proj = $(".center-content").attr( "project_page" )
    currentSection = projects.indexOf proj

    console.log currentSection
    console.log projects.length
    newSection = ( currentSection + 1 ) %% projects.length
    console.log newSection

    switchPage newSection, currentSection

$(document).ready ->
  if $("body").hasClass "project-page"
    arrowListeners()


  $('.menu-button').on 'click', (e) ->
    e.preventDefault()

    $("#navigation-modal").fadeIn 100

  $(".x-button").on 'click', (e) ->
    e.preventDefault()
    
    $("#navigation-modal").fadeOut 100



  # $('.nav-button').on 'click', (e) ->
  #   e.preventDefault()

  #   pageToShow = $(this).attr 'page'
  #   pageToHide = $('.nav-button.selected').attr 'page'

  #   if pageToHide != pageToShow then switchPage( pageToShow )

  #   window.history.pushState null, null, "/#{pageToShow}"


    