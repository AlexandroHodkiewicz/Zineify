# Zineify
Tools for DIY publishing.

I wanted to publish a booklet as a zine with 8-up imposition. I had created a pdf with all my content, all I needed was to shrink, shift, and rotate the pages onto a single sheet. I didn't find anything that met my needs, so I created a script that would do it for me.

## Features

### 8-up 

Start with a pdf that has eight 2.75" x 4.25" pages. Run `impose8up.sh` to produce a pdf that can be printed on a single letter-sized page, then cut and folded into a self-contained zine.

## Requirements

Currently this project is Mac-centric. It can most likely be easily adapted to any linux type system that has good tools for the postscript ecosystem.

### Getting started

The scripts in this repository depend on some software packages that you'll need to install. By far the easiest way to manage them is through [Homebrew](https://brew.sh). If you haven't installed Homebrew yet, do so before using this package.

To install all required packages, run `./pkg_brew_install.sh`. This may take a while depending on whether you've already downloaded some of the dependencies and your internet connection.

### Usage

The main script is `formats/impose8up.sh`. Simply specify your input file and it will take care of the rest.

### Customization

If you want change the overlay, you can edit the file `overlay.ps` directly. You can change the line patterns, move the scissors icon, or anything else that fits on a single page.

## Feature Requests

To request a new feature, please open an issue.
