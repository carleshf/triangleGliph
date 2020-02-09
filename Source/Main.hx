package;

import haxe.Constraints.Function;
import haxe.macro.Compiler.IncludePosition;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;


class TriangleGliph	{
	var content:Array<Int>;
	var color:Int;
	var alpha:Float;
	var grid:Bool;
	var nelm:Int;

	public function new(color = 0x00AAAA, alpha = 0.75, grid = false) {
		this.content = [];
		this.color = color;
		this.alpha = alpha;
		this.grid = grid;
		this.nelm = 1;
	}

	public function setGrid(status) {
		this.grid = status;
	}

	public function setColor(color) {
		this.color = color;
	}

	public function setAlpha(alpha) {
		this.alpha = alpha;
	}

	private function drawGrid(canvas, offsetX, offsetY, gap, size) {
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

		canvas.addChild(drawer);
	}
	
	private function drawCloseTriangle(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + gap + (size / 2), offsetY + (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY +  gap + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 5) + (size / 2), offsetY +  (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + gap + (size / 2), offsetY +  (gap * 5) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawOpenTriangle(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + gap + (size / 2), offsetY + (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + gap + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 5) + (size / 2), offsetY + (gap * 5) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawCeilingLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + gap + (size / 2), offsetY + gap + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 5) + (size / 2), offsetY + gap + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawBeltLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 3) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 3) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawLanceLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 5) + (size / 2), offsetY + (gap * 3) + (size / 2));
		triangle.graphics.lineTo(offsetX + gap + (size / 2), offsetY + (gap * 3) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawLegLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 3) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 5) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawSadLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 4) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 5) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawHappyLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 4) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 4) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawSadLargeLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 3) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 5) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawHappyLargeLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 3) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 3) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawDiagonalDownLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 2) + (size / 2), offsetY + (gap * 3) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 5) + (size / 2));
		
		canvas.addChild(triangle);
	}

	private function drawDiagonalUpLine(canvas, offsetX, offsetY, gap, size) {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (size, color, alpha);
		
		triangle.graphics.moveTo(offsetX + (gap * 3) + (size / 2), offsetY + (gap * 5) + (size / 2));
		triangle.graphics.lineTo(offsetX + (gap * 4) + (size / 2), offsetY + (gap * 3) + (size / 2));
		
		canvas.addChild(triangle);
	}

	public function draw(canvas, offsetX, offsetY, gap, size) {
		if(grid) {
			drawGrid(canvas, offsetX, offsetY, gap, size);
		}
		for(elm in content) {
			switch (elm) {
				case 0:
					drawCloseTriangle(canvas, offsetX, offsetY, gap, size);
				case 1:
					drawOpenTriangle(canvas, offsetX, offsetY, gap, size);
				case 2:
					drawCeilingLine(canvas, offsetX, offsetY, gap, size);
				case 3:
					drawBeltLine(canvas, offsetX, offsetY, gap, size);
				case 4:
					drawLanceLine(canvas, offsetX, offsetY, gap, size);
				case 5:
					drawSadLine(canvas, offsetX, offsetY, gap, size);
				case 6:
					drawHappyLine(canvas, offsetX, offsetY, gap, size);
				case 7:
					drawSadLargeLine(canvas, offsetX, offsetY, gap, size);
				case 8:
					drawHappyLargeLine(canvas, offsetX, offsetY, gap, size);
				case 9:
					drawLegLine(canvas, offsetX, offsetY, gap, size);
				case 10:
					drawDiagonalDownLine(canvas, offsetX, offsetY, gap, size);
				case 11:
					drawDiagonalUpLine(canvas, offsetX, offsetY, gap, size);
			}
		}
	}

	public function print() {
		trace(content);
	}

	public function add(elm:Int){
		content.push(elm);
	}

	public function generate() {
		/*	Creation of a Triangular Glyph
			------------------------------
			1. First decide typo of border: 
				* 0.9 for closed ....... 0
				* 0.1 for opened ....... 1
			2. Decide filling elements:
				* 0.6 for one element 
				* 0.3 for two elements
				* 0.1 for three elements
			Using as elements (all equi-probables):
				* for ceiling .........  2
				* for belt ............  3
				* lance ...............  4
				* for sad .............  5
				* for happy ...........  6
				* for large sad .......  7
				* for large happy .....  8
				* for leg .............  9
				* for down diag ....... 10
				* for up diag ......... 11
		*/
		function updateToAddArray(addedValue:Int, elmsToAdd:Array<Int>) {
			function remove(fullArray:Array<Int>, elmsRemove:Array<Int>) {
				for(elm in elmsRemove) {
					fullArray = fullArray.filter(function(item) return item != elm);
				}
				return fullArray;
			}
			// Filter addValue
			var newElmsToAdd = remove(elmsToAdd, [addedValue]);
			
			// Added diagonals --> remove happy/sad , leg , large sad , diagonals
			if(addedValue == 10 || addedValue == 11) {
				newElmsToAdd = remove(elmsToAdd, [5, 6, 9, 10, 11]);
			}
			// Added leg --> remove diagonals
			if(addedValue == 9) {
				newElmsToAdd = remove(elmsToAdd, [10, 11]);
			}
			// Added large sad --> remove diagonals
			if(addedValue == 7) {
				newElmsToAdd = remove(elmsToAdd, [10, 11]);
			}
			// Added happy --> remove diagonals and large happy
			if(addedValue == 6 || addedValue == 8) {
				newElmsToAdd = remove(elmsToAdd, [6, 8, 10, 11]);
			}
			// Added sad --> remove diagonals and large sad
			if(addedValue == 5 || addedValue == 7) {
				newElmsToAdd = remove(elmsToAdd, [5, 7, 10, 11]);
			}
			// Added belt/lance --> remove lance/belt
			if(addedValue == 3 || addedValue == 4) {
				newElmsToAdd = remove(elmsToAdd, [3, 4]);
			}
			// Added ceeling/lance --> remove lance/ceeling
			if(addedValue == 2 || addedValue == 4) {
				newElmsToAdd = remove(elmsToAdd, [2, 4]);
			}

			return newElmsToAdd;
		}

		// 1. Select border
		if(Math.random() <= 0.1) {
			add(1);
		} else {
			add(0);
		}

		// 2. Select number of elements to add
		var pelm = Math.random();
		if (pelm <= 0.1) {
			nelm = 3;
		} else if(pelm <= 0.3) {
			nelm = 2;
		}

		// 3. Fill the glyph
		var elmsToAdd = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
		for(ii in 0...nelm) {
			var val = Std.random(elmsToAdd.length - 1);
			add(elmsToAdd[val]);
			elmsToAdd = updateToAddArray(elmsToAdd[val], elmsToAdd);
		}
	}
}

class Button extends Sprite {
	private var _text:TextField;

	public function new(parent:Sprite, px:Int, py:Int, text:String) {
		super();

		_text = new TextField();
		_text.defaultTextFormat = new TextFormat("Katamotz Ikasi", 30, 0x202020);
		_text.x = 50;
		_text.y = 50;
		_text.width = 350;
		_text.text = "Hello, Haxe and OpenFL!";
		//addChild (_text);

		parent.addChild(_text);
	}

	public function addCallback(paren:Sprite, handler) {
		paren.addEventListener(MouseEvent.CLICK, handler);
	}
}

class Main extends Sprite {
	static public function drawPieces(canvas, offsetX, offsetY, glyphGap, gridGap, strokeSize) {
		var pieces:Array<TriangleGliph> = [];
		for(elm in 0...12) {
			var glyph = new TriangleGliph();
			glyph.setGrid(true);
			glyph.setAlpha(1);
			if(elm == 0 || elm == 1) {
				glyph.setColor(0xDD8888);
			} else {
				glyph.setColor(0x00AAAA);
			}
			glyph.add(elm);
			pieces.push(glyph);
		}

		var ii = 0;
		var jj = 0;
		for(glyph in pieces) {
			var px = offsetX + ii * glyphGap;
			var py = offsetY + jj * glyphGap;
			glyph.draw(canvas, px, py, gridGap, strokeSize);
			ii = ii + 1;
			if(ii > 3) {
				ii = 0;
				jj = jj + 1;
			}
		}
	}

	static public function drawRandom(canvas, offsetX, offsetY, glyphGap, gridGap, strokeSize, nRows, nCols) {
		for(ii in 0...nRows) {
			var py = offsetY + ii * glyphGap;
			for(jj in 0...nCols) {
				var px = offsetX + jj * glyphGap;
				var glyph = new TriangleGliph();
				glyph.setGrid(false);
				glyph.setColor(0x222222);
				glyph.setAlpha(1);
				glyph.generate();
				glyph.draw(canvas, px, py, gridGap, strokeSize);
				glyph.print();
			}
		}
	}



	public function new() {
		super();

		//this.mouseChildren = false;
		//this.buttonMode = true;

		init();
	}

	public function init() {

		//drawPieces(this, 10, 10, 50, 6, 2);

		drawRandom(this, 10, 160, 50, 6, 2, 5, 10);
		function onButtonClick(e:MouseEvent) {
			trace('you clicked me!');
			drawRandom(this, 10, 160, 50, 6, 2, 5, 10);
		}

		var x = new Button(this, 10, 250, "hello");
		x.addCallback(this, onButtonClick);

	}
}
