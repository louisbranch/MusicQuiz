trim = (str) ->
  trimmed = str.replace(/^\s+|\s+$/g,"")
  escape(trimmed)
    
$ inputListener = ->
  if $('#challenge_tracks').length
    track_inputs = $('.song_item > input')
    for i in track_inputs
      i.onkeydown = ->
        valueCheck this

valueCheck = (e) ->
  e.className = ""
  if e.value.length > 0
    clearTimeout t
    e.className = "thinking"
    t = setTimeout((=> requestValue(e)), 2000)

requestValue = (e) ->
  url = e.getAttribute('data-url')
  text = trim(e.value)
  $.ajax url+"?name="+text,
    type: 'GET'
    error: ->
        e.className = "wrong"
    success: ->
        e.className = "right"

stopMusic = ->
  audio_tags = $('audio')
  for i in audio_tags
    i.pause()
    i.currentTime = 0;

playNextMusic = ->
  $('#track_active > .track_player > audio')[0].play()

hideControllers = ->
  if $('#track_controllers').length
    track_items = $('.track_item')
    final = track_items.length
    if $(track_items[0]).attr('id') == "track_active"
      $('#prev_track').hide()
    else
      $('#prev_track').show()
    if $(track_items[final-1]).attr('id') == "track_active"
      $('#next_track').hide()
    else
      $('#next_track').show()

$ trackControllers = ->
  if $('#track_controllers').length
    next = $('#next_track')
    prev = $('#prev_track')
    end = $('#end_challenge')
    track_items = $('.track_item')
    $(track_items[0]).show().attr('id','track_active')
    hideControllers()
    $(next).click ->
      item = $("#track_active")
      $(item).hide()
      $(item).attr('id','')
      $(item).next().fadeIn()
      $(item).next().attr('id','track_active')
      hideControllers()
      stopMusic()
      playNextMusic()  
      false
    $(prev).click ->
      item = $("#track_active")
      $(item).attr('id','')
      $(item).hide()
      $(item).prev().attr('id','track_active')
      $(item).prev().fadeIn()
      hideControllers()
      stopMusic()
      playNextMusic()
      false
