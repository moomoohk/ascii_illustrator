// Copyright (c) 2015, Meshulam Silk (moomoohk@ymail.com). All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ascii_illustrator;

import "dart:html";
import "dart:math";

part "lib/map.dart";
part "lib/maps.dart";

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
  for (int i = 1; i <= resolution; i++) {
    TableRowElement mainGridRow = mainGridBody.insertRow(0);

    for (int j = 1; j <= resolution; j++) {
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
  querySelector("body").children.add(mainGrid);

  querySelectorAll("div.pixel")
    ..onMouseEnter.listen((MouseEvent me) {
      DivElement target = me.target as DivElement;
      target
        ..style.backgroundColor =
        target.parent.parent.parent.parent.parent.attributes["color"]
        ..classes.add("marked");
    })
    ..onClick.listen((MouseEvent me) {
      DivElement target = me.target as DivElement;
      target
        ..classes.remove("marked")
        ..style.backgroundColor = "initial";
    })
    ..onDragEnter.listen((MouseEvent me) {
      print("drag enter");
    })
    ..onDrag.listen((MouseEvent me) {
      print("drag");
    });
  querySelectorAll("div.mainGridCell").onMouseLeave.listen((MouseEvent me) {
    DivElement target = me.target as DivElement;

    List<bool> map = new List<bool>();

    TableSectionElement tableBody = target.querySelector("table > tbody");
    List rows = tableBody.children;
    for (TableRowElement row in rows) {
      List cells = row.children;

      for (TableCellElement cell in cells) {
        DivElement pixel = cell.querySelector("div.pixel");
        map.add(pixel.classes.contains("marked"));
      }
    }

    for (PixelMap m in maps) {
      if (m.check(map)) {
        target.querySelector("span.mainGridCellText").text = m.char;
        target.querySelectorAll("div.marked").classes.add("set");
      }
    }

    target.querySelectorAll("div.marked:not(.set)")
      ..classes.remove("marked")
      ..style.backgroundColor = "initial";
  });
}
