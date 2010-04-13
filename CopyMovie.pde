/**
 * $Id: CopyMovie.pde 30 2008-12-15 08:26:58Z btgiles $
 *
 * Copyright (C) 2008 Ben Giles
 * btgiles@gmail.com
 * bencode.googlecode.com
 *
 * Released under the GPL, Version 3
 * License available here: http://www.gnu.org/licenses/gpl.txt
 */

import processing.video.*;

Movie inMovie;
MovieMaker outMovie;

int frameNumber = 0;
int framesPerSecond = 25;

void setup() {
  size(640, 480);
  frameRate(framesPerSecond);
  inMovie = new Movie(this, "/Users/ben/Movies/Random/Random.m4v");
  outMovie = new MovieMaker(this, width, height, "output42.mov", framesPerSecond);
}

void draw() {
  progress();
  analyze();
  render();
  store();
  advance();
}

void progress() {
  if ((frameNumber%100) == 0) {
    println("Working on frame number " + frameNumber);
  }
}

void analyze() {
  if (inMovie.time() >= inMovie.duration()) {
    outMovie.finish();
    exit();
  }
}

void render() {
  inMovie.jump((float) frameNumber/framesPerSecond);
  inMovie.read();
}

void store() {
  image(inMovie, 0, 0);
  outMovie.addFrame();
}

void advance() {
  frameNumber++;
}
