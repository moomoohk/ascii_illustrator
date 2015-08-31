// Copyright (c) 2015, Meshulam Silk (moomoohk@ymail.com). All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ascii_illustrator;

import "dart:html";
import "dart:math";

part "lib/map.dart";
part "lib/maps.dart";

int mainDimension = 6;
List<PixelMap> markedMaps = new List<PixelMap>(mainDimension * mainDimension);

TextAreaElement output = new TextAreaElement()
  ..id = "output"
  ..readOnly = true
  ..onMouseDown.listen((MouseEvent e) {
    e.preventDefault();
    output.select();
  })
  ..onCopy.listen((_) {
    if (output.text.length > 0) {
      // Copied
    } else {
      // Not copied
    }
  });

void main() {
  generateGrid();
  querySelector("span#loading").remove();
}

void generateGrid() {
  List<String> colors = [
    "red",
    "blue",
    "yellow",
    "aqua",
    "green",
    "black",
    "grey",
    "orange",
    "brown",
    "coral",
    "crimson"
  ];
  int resolution = 5;

  TableElement mainGrid = new TableElement()..id = "mainGrid";
  TableSectionElement mainGridBody = mainGrid.createTBody();
  for (int i = 1; i <= mainDimension; i++) {
    TableRowElement mainGridRow = mainGridBody.insertRow(0);

    for (int j = 1; j <= mainDimension; j++) {
      TableCellElement mainGridCell = mainGridRow.insertCell(0);
      DivElement mainGridCellContainer = new DivElement()
        ..className = "mainGridCell"
        ..attributes["color"] = colors[new Random().nextInt(colors.length)];
      SpanElement mainGridCellText = new SpanElement()
        ..className = "mainGridCellText";
      mainGridCell.children.add(mainGridCellContainer);
      mainGridCellContainer.children.add(mainGridCellText);

      TableElement subGrid = new TableElement()..className = "subGrid";
      TableSectionElement subGridBody = subGrid.createTBody();
      for (int k = 1; k <= resolution; k++) {
        TableRowElement subGridRow = subGridBody.insertRow(0);

        for (int l = 1; l <= resolution; l++) {
          TableCellElement subGridCell = subGridRow.insertCell(0);
          subGridCell.children.add(new DivElement()..className = "pixel");
        }
      }

      mainGridCellContainer.children.add(subGrid);
    }
  }
  querySelector("body").children
    ..add(mainGrid)
    ..add(output);

  querySelectorAll("div.pixel")
    ..onMouseEnter.listen((MouseEvent me) {
      DivElement target = me.target as DivElement;
      target
        ..style.backgroundColor =
        target.parent.parent.parent.parent.parent.attributes["color"]
        ..classes.add("marked");
    })
    ..onMouseLeave.listen((MouseEvent me) {
      DivElement target = me.target as DivElement;
      resolveChar(target.parent.parent.parent.parent.parent);
    })
    ..onClick.listen((MouseEvent me) {
      DivElement target = me.target as DivElement;
      target
        ..classes.remove("set")
        ..classes.remove("marked")
        ..style.backgroundColor = "initial";
      resolveChar(target.parent.parent.parent.parent.parent);
    })
    ..onDragEnter.listen((MouseEvent me) {
      print("drag enter");
    })
    ..onDrag.listen((MouseEvent me) {
      print("drag");
    });

  querySelectorAll("div.mainGridCell").onMouseLeave.listen((MouseEvent me) {
    DivElement target = me.target as DivElement;
    clearGrid(target);
    resolveChar(target);
  });
}

void resolveChar(DivElement container) {
  List<bool> map = new List<bool>();
  TableSectionElement tableBody = container.querySelector("table > tbody");
  List rows = tableBody.children;
  bool hasSet = false;
  for (TableRowElement row in rows) {
    List cells = row.children;

    for (TableCellElement cell in cells) {
      DivElement pixel = cell.querySelector("div.pixel");
      map.add(
          pixel.classes.contains("marked") || pixel.classes.contains("set"));
      if (pixel.classes.contains("set")) {
        hasSet = true;
      }
    }
  }
  SpanElement text =
      container.querySelector("span.mainGridCellText") as SpanElement;
  int x = container.parent.parent.children.indexOf(container.parent);
  int y =
      container.parent.parent.parent.children.indexOf(container.parent.parent);
  bool found = false;
  for (PixelMap m in maps) {
    if (m.check(map)) {
      found = true;
      text.text = m.char;
      container.querySelectorAll("div.marked").classes..add("set");
      hasSet = true;
      markedMaps[x + y * mainDimension] = m;
    }
  }
  if (!hasSet || hasSet && !found) {
    markedMaps[x + y * mainDimension] = null;
    text.text = "";
    if (hasSet) {
      container.querySelectorAll("div.set").classes.remove("set");
      resolveChar(container);
    }
  }

  generateAscii();
}

void clearGrid(DivElement container) {
  container.querySelectorAll("div.marked:not(.set)")
    ..classes.remove("marked")
    ..style.backgroundColor = "initial";
}

void generateAscii() {
  output.text = "";
  for (int i = 0; i < markedMaps.length; i++) {
    PixelMap m = markedMaps[i];
    if (m != null) {
      output.text += m.char;
    } else {
      output.text += " ";
    }
    if ((i + 1) % mainDimension == 0) {
      output.text += "\n";
    }
  }
}
