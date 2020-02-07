package;

import openfl.display.Sprite;
import openfl.display.Shape;


class Main extends Sprite {

	public function new() {
		super();

		function drawGrid(offsetX, offsetY, gap, size) {
			var drawer = new Shape ();
			drawer.graphics.beginFill(0x000000, 0.25);
	
			for(ii in 1...6) {
				var x = offsetX + (gap * ii);
				for(jj in 1...6) {
					var y = offsetY + (gap * jj);
					drawer.graphics.drawRect(
						x, y, size, size
					);
				}
			}

			this.addChild(drawer);
		}

		function drawFullTriangle(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + gap + (size / 2), offsetY + (gap * 5) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY +  gap + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 5) + (size / 2), offsetY +  (gap * 5) + (size / 2));
			triangle.graphics.lineTo(offsetX + gap + (size / 2), offsetY +  (gap * 5) + (size / 2));
			
			this.addChild(triangle);
		}

		function drawOpenTriangle(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + gap + (size / 2), offsetY + (gap * 5) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + gap + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 5) + (size / 2), offsetY + (gap * 5) + (size / 2));
			
			this.addChild(triangle);
		}

		function drawCeilingLine(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + gap + (size / 2), offsetY + gap + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 5) + (size / 2), offsetY + gap + (size / 2));
			
			this.addChild(triangle);
		}

		function drawBeltLine(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 3) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 3) + (size / 2));
			
			this.addChild(triangle);
		}

		function drawLanceLine(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + (gap * 5) + (size / 2), offsetY + (gap * 3) + (size / 2));
			triangle.graphics.lineTo(offsetX + gap + (size / 2), offsetY + (gap * 3) + (size / 2));
			
			this.addChild(triangle);
		}

		function drawLegLine(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 3) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 5) + (size / 2));
			
			this.addChild(triangle);
		}

		function drawSadLine(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 5) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 4) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 5) + (size / 2));
			
			this.addChild(triangle);
		}

		function drawHappyLine(offsetX, offsetY, gap, size, color = 0x00AAAA, alpha = 0.75) {
			var triangle = new Shape ();
			triangle.graphics.lineStyle (size, color, alpha);
			
			triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 4) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 5) + (size / 2));
			triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 4) + (size / 2));
			
			this.addChild(triangle);
		}

		var size = 5;
		var gap = 10;
		var offsetX = 10;
		var offsetY = 10;

		drawGrid(offsetX, offsetY, gap, size);
		drawFullTriangle(offsetX, offsetY, gap, size);

		offsetX = 110;
		
		drawGrid(offsetX, offsetY, gap, size);
		drawOpenTriangle(offsetX, offsetY, gap, size);

		offsetX = 210;
		
		drawGrid(offsetX, offsetY, gap, size);
		drawCeilingLine(offsetX, offsetY, gap, size);

		offsetX = 310;
		
		drawGrid(offsetX, offsetY, gap, size);
		drawBeltLine(offsetX, offsetY, gap, size);

		offsetX = 410;
		
		drawGrid(offsetX, offsetY, gap, size);
		drawLanceLine(offsetX, offsetY, gap, size);

		offsetX = 510;
		
		drawGrid(offsetX, offsetY, gap, size);
		drawLegLine(offsetX, offsetY, gap, size);

		offsetX = 610;
		
		drawGrid(offsetX, offsetY, gap, size);
		drawSadLine(offsetX, offsetY, gap, size);

		offsetX = 710;
		
		drawGrid(offsetX, offsetY, gap, size);
		drawHappyLine(offsetX, offsetY, gap, size);

		offsetX = 10;
		offsetY = 110;
		var baseX = offsetX;
		var baseY = offsetY;

		for(ii in 0...4) {

			offsetY = baseY + (100 * ii);

			for(jj in 0...8)  {

				offsetX = baseX + (100 * jj);

				var outsideShape = Math.random();
				trace("outsideShape", outsideShape);
				drawGrid(offsetX, offsetY, gap, size);
				if(outsideShape <= 0.875) {
					drawFullTriangle(offsetX, offsetY, gap, size);
				} else {
					drawOpenTriangle(offsetX, offsetY, gap, size);
				}
				
				var fillShape = Math.random();
				trace("fillShape (Y/N)", fillShape);
				if(fillShape >= 0.25) {
					fillShape = Std.random(6);
					trace("fillShape (Y/N)", fillShape);
					switch (fillShape) {
						case 0:
							drawLegLine(offsetX, offsetY, gap, size);
							drawBeltLine(offsetX, offsetY, gap, size);
						case 1:
							drawBeltLine(offsetX, offsetY, gap, size);
						case 2:
							drawLanceLine(offsetX, offsetY, gap, size);
						case 3:
							drawCeilingLine(offsetX, offsetY, gap, size);
						case 4:
							drawSadLine(offsetX, offsetY, gap, size);
						case 5:
							drawHappyLine(offsetX, offsetY, gap, size);
					}
				}
			}
		}


	}
}
