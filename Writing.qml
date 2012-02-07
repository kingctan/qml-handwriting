import QtQuick 2.0

import "js/shortstraw.js" as Straw
import "js/script.js" as Script

Canvas {
    id:canvas

    property int paintX
    property int paintY
    property int count: 0
    property int lineWidth: 5
    property variant drawColor: "black"

    property int strokes: 0

    MouseArea {
        id:mousearea
        hoverEnabled:true
        anchors.fill: parent
        onClicked: drawPoint();
        onPositionChanged:  {
            if (mousearea.pressed) {
                drawLineSegment();
                Script.addItem(mouseX, mouseY);
            }
            paintX = mouseX;
            paintY = mouseY;

        }

        onReleased: {
        var ctx = canvas.getContext('2d');
            var array = Straw.shortStraw(Script.getList());

            ctx.beginPath();
            ctx.strokeStyle = 'red';
            ctx.moveTo(array[0].x, array[0].y);
            ctx.lineWidth = 2;
            for (var i = 0; i < array.length; i++) {
                console.log("strokes "+strokes+": " + array[i].x + ", "+ array[i].y );
                text.text = Zinnia.query(strokes, array[i].x, array[i].y);

                if (i>0) ctx.lineTo(array[i].x, array[i].y);
            }

            ctx.stroke();
            ctx.closePath();

            Script.clear();
            strokes++;
        }
    }

    function drawLineSegment() {
        var ctx = canvas.getContext('2d');
        ctx.beginPath();
        ctx.strokeStyle = drawColor
        ctx.lineWidth = lineWidth
        ctx.moveTo(paintX, paintY);
        ctx.lineTo(mousearea.mouseX, mousearea.mouseY);
        ctx.stroke();
        ctx.closePath();
    }

    function drawPoint() {
        var ctx = canvas.getContext('2d');
        ctx.lineWidth = lineWidth
        ctx.fillStyle = drawColor
        ctx.fillRect(mousearea.mouseX, mousearea.mouseY, 2, 2);
    }

    function clear() {
        var ctx = canvas.getContext('2d');
        strokes=0;
        text.text = "";
        Zinnia.clear();
        ctx.clearRect(0, 0, width, height);
    }
}