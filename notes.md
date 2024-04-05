## Download multiple files from google drive
* The format of direct download link is `https://drive.usercontent.google.com/download?id=[ID]&export=download`
* The format of share link of a file is `https://drive.google.com/file/d/[ID]/view?usp=drive_link`
* Create a file with all the links separated by a newline `links.txt` and format all the links like the direct link using neovim
* Now download the files using the following command
```
aria2c -x 16 -j 16 -i links.txt
```

## Convert PDF to Image
```
gs -dNOPAUSE -sDEVICE=jpeg -r300 -sOutputFile=output-%03d.jpeg input.pdf -c quit
```
Let’s break down the command and understand it:
* `gs`: This is the command to invoke Ghostscript.
* `-dNOPAUSE`: This option tells Ghostscript not to pause between pages during processing.
* `-sDEVICE=jpeg`: This sets the output device to JPEG format. We can replace jpeg with pngalpha if we desire image format in PNG.
* `-r300`: Sets the resolution to 300 DPI (dots per inch). We can adjust this value to change the output image’s quality and size.
* `-sOutputFile=output-%03d.jpeg`: This specifies the output file pattern. %03d indicates that the page number will be zero-padded to three digits. So, the output files will be named output-001.jpeg, output-002.jpeg, etc.
* `input.pdf`: The name of the input PDF file to convert.
* `-c quit`: This flag tells Ghostscript to quit after processing the PDF.

## Extract text from pdf images
```
ls output*.jpg > images.txt
tesseract images.txt output.txt
```

## Download youtube videos using yt-dlp
Download a single video in 720p resolution and mp4 format
```
yt-dlp [link_to_video] -f mp4 -S "res:720"
```
Download all videos from a playlist in 720p resolution and mp4 format
```
yt-dlp --yes-playlist [link_to_playlist] -f mp4 -S "res:720"
```
