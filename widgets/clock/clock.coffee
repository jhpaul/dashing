class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)
    if h > 12 then a = " PM" else a = " AM"
    if h >12 then h=h-12

    @set('time', h + ":" + m + a)
    @set('date', today.toDateString())

  formatTime: (i) ->
    if i < 10 then "0" + i else i