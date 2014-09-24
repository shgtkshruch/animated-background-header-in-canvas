(function() {
  var drow_canvas;

  window.onload = function() {
    drow_canvas();
    return window.addEventListener('resize', drow_canvas);
  };

  drow_canvas = function() {
    var Circle, canvas, ch, circles, ctx, cw, draw, i, num, _i;
    canvas = document.getElementById('c');
    ctx = canvas.getContext('2d');
    cw = canvas.width = window.innerWidth;
    ch = canvas.height = window.innerHeight;
    circles = [];
    num = cw / 3;
    Circle = (function() {
      function Circle() {
        this.x = Math.random() * cw;
        this.y = ch + Math.random() * 100;
        this.r = 1 + Math.random() * 5;
        this.alpha = 0.1 + Math.random() * 0.3;
        this.velocity = Math.random();
      }

      Circle.prototype.draw = function() {
        this.alpha -= 0.0003;
        if (this.alpha < 0) {
          this.constructor();
        }
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.r, 0, Math.PI * 2, false);
        ctx.fillStyle = 'rgba(255,255,255,' + this.alpha + ')';
        ctx.fill();
        return this.y -= this.velocity;
      };

      return Circle;

    })();
    for (i = _i = 0; 0 <= num ? _i < num : _i > num; i = 0 <= num ? ++_i : --_i) {
      circles.push(new Circle());
    }
    return (draw = function() {
      ctx.clearRect(0, 0, cw, ch);
      circles.forEach(function(c) {
        return c.draw();
      });
      return requestAnimationFrame(draw);
    })();
  };

}).call(this);
