window.onload = ->
  drow_canvas()

drow_canvas = ->
  canvas = document.getElementById 'c'
  ctx = canvas.getContext '2d'
  cw = canvas.width = window.innerWidth
  ch = canvas.height = window.innerHeight
  circles = []
  num = cw / 2

  class Circle
    constructor: ->
      @x = Math.random() * cw
      @y = ch + Math.random() * 100
      @r = 1 + Math.random() * 5
      @alpha = 0.2 + Math.random() * 0.3
      @velocity = Math.random()

    draw: ->
      @alpha -= 0.0005

      @constructor() if @alpha < 0

      ctx.beginPath()
      ctx.arc @x, @y, @r, 0, Math.PI * 2, false
      ctx.fillStyle = 'rgba(255,255,255,' + @alpha + ')'
      ctx.fill()
      @y -= @velocity

  for i in [0...num]
    circles.push new Circle()

  (draw = ->
    ctx.clearRect 0, 0, cw, ch

    circles.forEach (c) ->
      c.draw()

    requestAnimationFrame draw
  )()
