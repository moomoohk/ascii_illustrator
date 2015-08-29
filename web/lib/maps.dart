// Copyright (c) 2015, Meshulam Silk (moomoohk@ymail.com). All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of ascii_illustrator;

PixelMap slash = new PixelMap.variations([[
	false, false, false, false, true,
	false, false, false, true,  false,
	false, false, true,  false, false,
	false, true,  false, false, false,
	true,  false, false, false, false
], [
	false, false, false, true,  true,
	false, false, true,  true,  false,
	false, true,  true,  false, false,
	true,  true,  false, false, false,
	true,  false, false, false, false
], [
	false, false, false, false, true,
	false, false, false, true,  true,
	false, false, true,  true,  false,
	false, true,  true,  false, false,
	true,  true,  false, false, false
]], "/");
PixelMap pipe = new PixelMap([
	false, false, true,  false, false,
	false, false, true,  false, false,
	false, false, true,  false, false,
	false, false, true,  false, false,
	false, false, true,  false, false
], "|");
PixelMap dash = new PixelMap([
	false, false, false, false, false,
	false, false, false, false, false,
	true,  true,  true,  true,  true,
	false, false, false, false, false,
	false, false, false, false, false
], "–");
PixelMap topBar = new PixelMap([
	true,  true,  true,  true,  true,
	false, false, false, false, false,
	false, false, false, false, false,
	false, false, false, false, false,
	false, false, false, false, false
], "¯");
PixelMap underscore = new PixelMap([
	false, false, false, false, false,
	false, false, false, false, false,
	false, false, false, false, false,
	false, false, false, false, false,
	true,  true,  true,  true,  true
], "_");
PixelMap l = new PixelMap([
	true,  false, false, false, false,
	true,  false, false, false, false,
	true,  false, false, false, false,
	true,  false, false, false, false,
	true,  true,  true,  true,  true
], "L");
PixelMap equals = new PixelMap([
	false, false, false, false, false,
	true,  true,  true,  true,  true,
	false, false, false, false, false,
	true,  true,  true,  true,  true,
	false, false, false, false, false
], "=");
PixelMap swastika = new PixelMap([
	true,  false, true,  true,  true,
	true,  false, true,  false, false,
	true,  true,  true,  true,  true,
	false, false, true,  false, true,
	true,  true,  true,  false, true
], "卐");
PixelMap O = new PixelMap.variations([[
	false, true,  true,  true,  false,
	true,  true,  false, true,  true,
	true,  false, false, false, true,
	true,  true,  false, true,  true,
	false, true,  true,  true,  false
], [
	false, true,  true,  true,  false,
	true,  false, false, false, true,
	true,  false, false, false, true,
	true,  false, false, false, true,
	false, true,  true,  true,  false
]], "O");
PixelMap plus = pipe.combine(dash, "+");
PixelMap plusMinus = plus.combine(underscore, "±");
PixelMap notEquals = equals.combine(slash, "≠");
PixelMap backSlash = slash.flip("\\");
PixelMap x = slash.combine(backSlash, "X");
PixelMap T = topBar.combine(pipe, "T");

List<PixelMap> maps = [
	slash,
	dash,
	equals,
	underscore,
	pipe,
	topBar,
	plus,
	plusMinus,
	l,
	x,
	T,
	swastika,
	notEquals,
	backSlash,
	new PixelMap([
		true,  true,  true,  true,  true,
		true,  false, false, false, true,
		true,  false, false, false, true,
		true,  false, false, false, true,
		true,  true,  true,  true,  true
	], "□")
];