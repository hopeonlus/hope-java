
  function TOOLTIP() {
    this.width = 200;                     
    this.bgColor = '#e6e6e6';             
    this.textColor = '#000066';           
    this.borderColor = '#000066';         
    this.opacity = 90;                    
    this.cursorDistance = 5;

    // don't change
    this.text = '';
    this.obj = 0;
    this.sobj = 0;
    this.active = false;

    this.create = function() {
      if(!this.sobj) this.init();

      var t = '<table border=0 cellspacing=0 cellpadding=4 bgcolor=' + this.bgColor + '><tr>' +
              '<td align=left><font color=' + this.textColor + ' face=tahoma size=-2>' + this.text + '</font></td></tr></table>';

      if(document.layers) {
        t = '<table border=0 cellspacing=0 cellpadding=1><tr><td bgcolor=' + this.borderColor + '>' + t + '</td></tr></table>';
        this.sobj.document.write(t);
        this.sobj.document.close();
      }
      else {
        this.sobj.border = '1px solid ' + this.borderColor;
        this.setOpacity();
        if(document.getElementById) document.getElementById('ToolTip').innerHTML = t;
        else document.all.ToolTip.innerHTML = t;
      }
      this.show();
    }

    this.init = function() {
      if(document.getElementById) {
        this.obj = document.getElementById('ToolTip');
        this.sobj = this.obj.style;
      }
      else if(document.all) {
        this.obj = document.all.ToolTip;
        this.sobj = this.obj.style;
      }
      else if(document.layers) {
        this.obj = document.ToolTip;
        this.sobj = this.obj;
      }
    }

    this.show = function() {
      var ext = (document.layers ? '' : 'px');
      var left = mouseX;

      if(left + this.width + this.cursorDistance > winX) left -= this.width + this.cursorDistance;
      else left += this.cursorDistance;

      this.sobj.left = left + ext;
      this.sobj.top = mouseY + this.cursorDistance + ext;

      if(!this.active) {
        this.sobj.visibility = 'visible';
        this.active = true;
      }
    }

    this.hide = function() {
      if(this.sobj) this.sobj.visibility = 'hidden';
      this.active = false;
    }

    this.setOpacity = function() {
      this.sobj.filter = 'alpha(opacity=' + this.opacity + ')';
      this.sobj.mozOpacity = '.1';
      if(this.obj.filters) this.obj.filters.alpha.opacity = this.opacity;
      if(!document.all && this.sobj.setProperty) this.sobj.setProperty('-moz-opacity', this.opacity / 100, '');
    }
  }

  var tooltip = mouseX = mouseY = winX = 0;

  if(document.layers) {
    document.write('<layer id="ToolTip"></layer>');
    document.captureEvents(Event.MOUSEMOVE);
  }
  else document.write('<div id="ToolTip" style="position:absolute; z-index:99"></div>');
  document.onmousemove = getMouseXY;

  function getMouseXY(e) {
    if(document.all) {
      mouseX = event.clientX + document.body.scrollLeft;
      mouseY = event.clientY + document.body.scrollTop;
    }
    else {
      mouseX = e.pageX;
      mouseY = e.pageY;
    }
    if(mouseX < 0) mouseX = 0;
    if(mouseY < 0) mouseY = 0;

    if(document.body && document.body.offsetWidth) winX = document.body.offsetWidth - 25;
    else if(window.innerWidth) winX = window.innerWidth - 25;
    else winX = screen.width - 25;

    if(tooltip && tooltip.active) tooltip.show();
  }

  function toolTip(text, width, opacity) {
    if(text) {
      tooltip = new TOOLTIP();
      tooltip.text = text;
      if(width) tooltip.width = width;
      if(opacity) tooltip.opacity = opacity;
      tooltip.create();
    }
    else if(tooltip) tooltip.hide();
  }

