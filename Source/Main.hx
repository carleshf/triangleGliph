package;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Assets;



class TriangleGliph	{
	var _content:Array<Int>;
	var _shapes:Array<Shape>;
	var _color:Int;
	var _alpha:Float;
	var _grid:Bool;
	var _nelm:Int;

	public function new(color = 0x00AAAA, alpha = 0.75, grid = false) {
		_content = [];
		_shapes = [];
		_color = color;
		_alpha = alpha;
		_grid = grid;
		_nelm = 1;
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
			_content.push(1);
		} else {
			_content.push(0);
		}

		// 2. Select number of elements to add
		var pelm = Math.random();
		if (pelm <= 0.1) {
			_nelm = 3;
		} else if(pelm <= 0.3) {
			_nelm = 2;
		}

		// 3. Fill the glyph
		var elmsToAdd = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
		for(ii in 0..._nelm) {
			var val = Std.random(elmsToAdd.length - 1);
			_content.push(elmsToAdd[val]);
			elmsToAdd = updateToAddArray(elmsToAdd[val], elmsToAdd);
		}
	}

	public function clean(canvas:Sprite) {
		for(part in _shapes) {
			canvas.removeChild(part);
		}
		_shapes = [];
	}

	public function draw(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int) {
		if(_grid) {
			drawGrid(canvas, oX, oY, gap, stroke);
		}
		for(elm in _content) {
			var part:Shape = null;
			switch (elm) {
				case 0:
					part = drawCloseTriangle(canvas, oX, oY, gap, stroke);
				case 1:
					part = drawOpenTriangle(canvas, oX, oY, gap, stroke);
				case 2:
					part = drawCeilingLine(canvas, oX, oY, gap, stroke);
				case 3:
					part = drawBeltLine(canvas, oX, oY, gap, stroke);
				case 4:
					part = drawLanceLine(canvas, oX, oY, gap, stroke);
				case 5:
					part = drawSadLine(canvas, oX, oY, gap, stroke);
				case 6:
					part = drawHappyLine(canvas, oX, oY, gap, stroke);
				case 7:
					part = drawSadLargeLine(canvas, oX, oY, gap, stroke);
				case 8:
					part = drawHappyLargeLine(canvas, oX, oY, gap, stroke);
				case 9:
					part = drawLegLine(canvas, oX, oY, gap, stroke);
				case 10:
					part = drawDiagonalDownLine(canvas, oX, oY, gap, stroke);
				case 11:
					part = drawDiagonalUpLine(canvas, oX, oY, gap, stroke);
			}
			_shapes.push(part);
		}
	}

	private function drawCloseTriangle(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + gap + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY +  gap + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 5) + (stroke / 2), oY +  (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + gap + (stroke / 2), oY +  (gap * 5) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawOpenTriangle(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + gap + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY + gap + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 5) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawCeilingLine(canvas, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + gap + (stroke / 2), oY + gap + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 5) + (stroke / 2), oY + gap + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawBeltLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 2) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 4) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawLanceLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 5) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		triangle.graphics.lineTo(oX + gap + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawLegLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawSadLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 2) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 4) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 4) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawHappyLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 2) + (stroke / 2), oY + (gap * 4) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 4) + (stroke / 2), oY + (gap * 4) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawSadLargeLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 2) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 4) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawHappyLargeLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 2) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 4) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawDiagonalDownLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 2) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
	}

	private function drawDiagonalUpLine(canvas:Sprite, oX:Int, oY:Int, gap:Int, stroke:Int):Shape {
		var triangle = new Shape ();
		triangle.graphics.lineStyle (stroke, _color, _alpha);
		triangle.graphics.moveTo(oX + (gap * 3) + (stroke / 2), oY + (gap * 5) + (stroke / 2));
		triangle.graphics.lineTo(oX + (gap * 4) + (stroke / 2), oY + (gap * 3) + (stroke / 2));
		canvas.addChild(triangle);
		return triangle;
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
		_shapes.push(drawer);
	}

	public function addPieceByNum(num:Int) {
		if(num >= 0 && num <= 11) {
			_content.push(num);
		}
	}

	public function setGrid(status) {
		_grid = status;
	}

	public function setColor(color) {
		_color = color;
	}

	public function setAlpha(alpha) {
		_alpha = alpha;
	}

	public function length():Int {
		return _content.length;
	}

	public function content():Array<Int> {
		return _content.map(function(x) return x);
	}
	
	public function isEquals(b:TriangleGliph):Bool {
		if(_content.length != b.length()) {
			return false;
		}
		var len:Int = _content.length;
		var acc:Int = 0;
		var b_content:Array<Int> = b.content();
		trace("len", len);
		trace("acc", acc);
		trace("b_content", b_content);
		for(elm in _content) {
			if(b_content.indexOf(elm) >= 0) {
				acc = acc + 1;
			}
		}
		return acc == len;
	}
}


class Button extends Sprite {
	private var _text:TextField;

	public function new(parent:Sprite, px:Int, py:Int, w:Int, text:String) {
		super();
		this.mouseChildren = false;
		this.buttonMode = true;

		var textFieldFormat:TextFormat = new TextFormat(Assets.getFont("fonts/DANUBE__.TTF").fontName, 13, 0x000000);

		_text = new TextField();
		_text.defaultTextFormat = textFieldFormat;
		_text.x = px;
		_text.y = py;
		_text.width = w;
		_text.height = 15;
		_text.text = text;
		//_text.background = true;
		//_text.backgroundColor = 0xbc8f8f;
		this.addChild(_text);
	}
}


class Main extends Sprite {
	private var _btnWall:Button;
	private var _btnPices:Button;
	private var _btnAlph:Button;
	private var _content:Array<TriangleGliph>;

	private var _offset_x = 10;
	private var _offset_y = 10;
	
	public function new () {
		super ();
		init();
		drawRandom(_offset_x + 15, _offset_y, 50, 6, 2, 5, 6);
	}
	
	public function init() {
		fillBackGround(0xfff8db, 340, 310);
		_content = [];
		_btnWall = new Button(this, 90, 275, 130, "Random Wall");
		_btnPices = new Button(this, 20, 275, 60, "Pieces");
		_btnAlph = new Button(this, 230, 275, 90, "Alphabet");
		_btnWall.addEventListener(MouseEvent.CLICK, clickWall);
		_btnPices.addEventListener(MouseEvent.CLICK, clickPieces);
		_btnAlph.addEventListener(MouseEvent.CLICK, clickAlphabet);
		addChild(_btnWall);
		addChild(_btnPices);
		addChild(_btnAlph);
	}

	public function fillBackGround(color:Int, w:Int, h:Int) {
		this.graphics.beginFill(color);
		this.graphics.drawRect(0, 0, w, h);
		this.graphics.endFill();
	}

	public function clearCollection() {
		for(glyph in _content) {
			glyph.clean(this);
		}
		_content = [];
	}

	public function drawPieces(oX:Int, oY:Int, glyphGap:Int, gridGap:Int, strokeSize:Int, nCols:Int) {
		for(elm in 0...12) {
			var glyph = new TriangleGliph();
			glyph.setGrid(true);
			glyph.setAlpha(0.75);
			glyph.setColor(0xf78bc1);
			/*if(elm == 0 || elm == 1) {
				glyph.setColor(0xf78bc1);
			} else {
				glyph.setColor(0xc5dfcf);
			}*/
			glyph.addPieceByNum(elm);
			_content.push(glyph);
		}

		var ii = 0;
		var jj = 0;
		for(glyph in _content) {
			var px = oX + ii * glyphGap;
			var py = oY + jj * glyphGap;
			glyph.draw(this, px, py, gridGap, strokeSize);
			ii = ii + 1;
			if(ii > nCols) {
				ii = 0;
				jj = jj + 1;
			}
		}
	}

	public function drawRandom(oX:Int, oY:Int, glyphGap:Int, gridGap:Int, strokeSize:Int, nRows:Int, nCols:Int) {
		for(ii in 0...nRows) {
			var py = oY + ii * glyphGap;
			for(jj in 0...nCols) {
				var px = oX + jj * glyphGap;
				var glyph = new TriangleGliph();
				glyph.setGrid(false);
				glyph.setColor(0x000F55);
				glyph.setAlpha(1);
				glyph.generate();
				glyph.draw(this, px, py, gridGap, strokeSize);
				_content.push(glyph);
			}
		}
	}

	public function drawAlphabet(oX:Int, oY:Int, glyphGap:Int, gridGap:Int, strokeSize:Int, nChars:Int, nCols:Int) {
		function isIn (array:Array<TriangleGliph>, item:TriangleGliph) {
			for(glyph in array) {
				if(glyph.isEquals(item)) {
					return true;
				}
			}
			return false;
		}

		while(_content.length < nChars) {
			var glyph = new TriangleGliph();
			glyph.generate();
			if(!isIn(_content, glyph)) {
				glyph.setGrid(false);
				glyph.setColor(0xAFD8DF);
				glyph.setAlpha(1);
				_content.push(glyph);
			}
		}

		var ii = 0;
		var jj = 0;
		for(elm in _content) {
			var px = oX + ii * glyphGap;
			var py = oY + jj * glyphGap;
			elm.draw(this, px, py, gridGap, strokeSize);
			ii = ii + 1;
			if(ii >= nCols) {
				ii = 0;
				jj = jj + 1;
			}
		}
	}
	
	public function clickWall(e:MouseEvent) {
		trace("click random wall");
		clearCollection();
		drawRandom(_offset_x + 15, _offset_y, 50, 6, 2, 5, 6);
	}

	public function clickPieces(e:MouseEvent) {
		trace("click pieces");
		clearCollection();
		drawPieces(_offset_x, _offset_y, 85, 10, 5, 3);
	}

	public function clickAlphabet(e:MouseEvent) {
		trace("test alphabet");
		clearCollection();
		drawAlphabet(_offset_x + 35, _offset_y, 50, 6, 2, 25, 5);
	}
}