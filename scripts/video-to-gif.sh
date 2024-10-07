#! /bin/sh
# require ffmpeg and imagemagick installed

function video-to-gif () {
    set -e
    videoFilename=$1
    filename="${videoFilename%.*}"
    tmpFilename="$filename.tmp.gif"
    gifFilename="$filename.gif"

    filters="fps=10,scale=1000:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=128[p];[s1][p]paletteuse=dither=bayer"

    ffmpeg -i "$videoFilename" -vf "$filters" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers optimize "$gifFilename"

    osascript -e "display notification \"GIF $gifFilename generated \""

    echo $gifFilename
}
