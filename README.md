# terminal-banner
[![GitHub license](https://img.shields.io/github/license/cawaltrip/terminal-banner.svg)](https://github.com/cawaltrip/terminal-banner)
[![GitHub issues](https://img.shields.io/github/issues/cawaltrip/terminal-banner.svg)](https://github.com/cawaltrip/terminal-banner/issues)

Terminal Banner is a bash script that will display a banner at the top row of a terminal window.  This script can be used by anyone but is designed primarly for use by the DoD/IC to display a colored classification banner.  This script is regularly tested using `PuTTY` on Windows 10 and `gnome-terminal` on RHEL 7.

# Installation
This currently relies on setting the `${PS1}` prompt variable.  To use it, just prepend your variable like so:
```sh
export PS1="\["$(banner_text "${1}" "{2}")"\]<rest-of-prompt-here>"
```

# Configuration & Examples
The script is has some example banners built in that are configured based on the last public defined color guidelines for the DoD/IC.

## Classification Colors
The United States [General Services Administration](https://www.gsa.gov) (GSA) is responsible for managing and maintaining a lot of the basic necessities of the U.S. Government.  One of the things it used to publish was the color codes used for printing the Standard Forms (SF) for the various classification labels.  In Feb 2017, the Federal Standard color system, FED-STD-595C, was canceled and replaced with SAE AMS-STD-595 (see https://www.gsa.gov/colorstd for more information) and since then, the official colors are no longer published.

In order to determine what the official colors are defined as, archived copies of previous documents can be used.  One example document that lists all of the PANTONE colors is a [contract award](https://www.gpo.gov/docs/default-source/contract-pricing/dallas/ab1724s.pdf) (see section 2 on page 5 for the specifications).  That document specifies the following values:
```
SF706 (TOP SECRET)      PMS 165C    RGB(255,103,31)    HEX(FF671F)    CMYK(0,70,100,0)
SF707 (SECRET)          PMS 186C    RGB(200,16,46)     HEX(C8102E)    CMYK(2,100,85,6)
SF708 (CONFIDENTIAL)    PMS 286C    RGB(0,51,160)      HEX(0033A0)    CMYK(100,75,0,0)
SF709 (CLASSIFIED)      PMS 264C    RGB(193,167,226)   HEX(C1A7E2)    CMYK(26,37,0,0)
SF710 (UNCLASSIFIED)    PMS 356C    RGB(0,122,51)      HEX(007A33)    CMYK(91,4,100,25)
SF712 (CLASSIFIED SCI)  PMS 101C    RGB(247,234,72)    HEX(F7EA48)    CMYK(0,0,68,0)
```
Standard Forms 706, 707, 708, and 710 have white text; 709, and 712 have black text.

These values are defined in the script and can be called with their sample functions:
```sh
u_banner
fouo_banner
c_banner
s_banner
ts_banner
sci_banner
class_banner
```

# Additional Work
This currently only works with `PuTTY` and `gnome-terminal`.  I'd also like to make this modular enough that it can support different terminal emulators easily.

Need to trap WINCH and redraw banner on screen resize.

# Known Bugs
Clearing the screen (via `Ctrl+L` or `clear`) results in the prompt appearing on the same line as the banner.  Is there a way to trap these calls and bump the prompt down a line?

# Licensing
This software is licensed under the MIT License (SPDX: MIT).  See [the LICENSE file](LICENSE) for the full text of the license.  A copy of the license text can also be found at [the SPDX page](https://spdx.org/licenses/MIT.html) or the [OSI page](https://opensource.org/licenses/MIT).

# Contributing [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](https://github.com/cawaltrip/terminal-banner/issues)
Feel free to make pull requests!  I can always use the help!

# Acknowledgements
I decided to make this after looking at the [classification banner](https://github.com/fcaviggia/classification-banner) made by @fcaviggia.