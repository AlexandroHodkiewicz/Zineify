<img width="1440" height="1440" alt="A3A4AAF1-9BFB-44F7-842F-CB504D269E2B" src="https://github.com/user-attachments/assets/93c0f835-731e-4c5f-8a27-ad4941052081" />

# Zineify
Tools for DIY publishing.

I wanted to publish a booklet as a zine with 8-up imposition. I had created a pdf with all my content, all I needed was to shrink, shift, and rotate the pages onto a single sheet. I didn't find anything that met my needs, so I created a script that would do it for me.

## Features

### 8-up 

Start with a pdf that has eight 2.75" x 4.25" pages. Run `formats/impose8up.sh` to produce a pdf that can be printed on a single letter-sized page, then cut and folded into a self-contained zine. By default, instructional markings are overlayed to serve as a visual aid in construction.

#### Assembly

To go from a printed page to a booklet, fold and cut the page according to the line styles. Any order is fine, but to get you started, here's one way to do it step by step.

1. Fold the paper in half length-wise along the solid line and the dotted lines extending to the edges: on one side you will see pages one, six, seven and eight; on the other you will see pages two, three, four, and five.
2. Unfold the paper, leaving the crease in the center.
3. Fold the paper in half width-wise along the dotted line: on one side you will see pages one, two, three and eight; on the other you will see pages four, five, six, and seven.
4. Using the crease you made in step 1 as a guide, cut along the solid line: on one side the cut separates pages three and eight; on the other it separates pages four and seven.
5. Fold along the dashed line separating pages four and seven from pages five and six: these pages should end up facing each other.
6. Unfold the paper completely.
7. Fold along the crease you made in step 1. Using the creases from steps 3 and 5, bring pages five and six into the center of the construction. This results in the inner page pairs (three/four and seven/eight) being brought back-to-back.
8. Fold along the dashed line so that pages two and three are facing each other.

Your zine should now look something like the photo above!

## Requirements

Currently this project is Mac-centric. It can most likely be easily adapted to any linux type system that has good tools for the postscript ecosystem.

I only have a letter-sized printer, so I don't currently support A4. It would just be a matter of some math (or rather _maths_) to accomodate other page sizes.

### Getting started

The scripts in this repository depend on some software packages that you'll need to install. By far the easiest way to manage them is through [Homebrew](https://brew.sh). If you haven't installed Homebrew yet, do so before using this package.

To install all required packages, run 

```./pkg_brew_install.sh```

This may take a while depending on whether you've already downloaded some of the dependencies and your internet connection.

### Usage

The main script is 

```formats/impose8up.sh```

Simply specify your input file and it will take care of the rest.

### Customization

If you want change the overlay, you can edit the file `overlay.ps` directly. You can change the line patterns, move the scissors icon, or anything else that fits on a single page.

## Feature Requests

To request a new feature, please open an issue.
