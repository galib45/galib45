## Download multiple files from google drive
* The format of direct download link is `https://drive.usercontent.google.com/download?id=[ID]&export=download`
* The format of share link of a file is `https://drive.google.com/file/d/[ID]/view?usp=drive_link`
* Create a file with all the links separated by a newline `links.txt` and format all the links like the direct link using neovim
* Now download the files using the following command
```
aria2c -x 16 -j 16 -i links.txt
```
