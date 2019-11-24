<h1 align="center">Share My Host</h1>
<p align="center">
    <img src="https://img.shields.io/github/issues/antony-jr/ShareMyHost.svg?style=flat-square" alt="issues" / >
    <img src="https://img.shields.io/github/forks/antony-jr/ShareMyHost.svg?style=flat-square" alt="stars" / >
    <img src="https://img.shields.io/github/stars/antony-jr/ShareMyHost.svg?style=flat-square" alt="stars" / >
    <img src="https://img.shields.io/github/license/antony-jr/ShareMyHost.svg?style=flat-square" alt="license" />
    <a class="badge-align" href="https://travis-ci.org/antony-jr/ShareMyHost"><img src="https://img.shields.io/travis/antony-jr/ShareMyHost.svg?style=flat-square" / > </a>
</p>

<p align="center">
<table>
  <tr>
    <th >Download<br></th>
    <th >Execute</th>
  </tr>
  <tr>
    <td >
    <a href="https://github.com/antony-jr/ShareMyHost/releases/tag/continuous">
    <img src="https://img.shields.io/badge/Get%20the%20Latest%20AppImage-x86__64-brightgreen.svg?style=for-the-badge" alt="Download" / >
    </a>
    </td>
    <td ><b>chmod</b> +x ShareMyHost*-x86_64.AppImage &amp;&amp; ./ShareMyHost*-x86_64.AppImage<br></td>
  </tr>
</table>
</p>


<p align="center">
  <img src=".img/poster.png" height="570px" width=auto alt="Share My Host">  <br>
</p>


**ShareMyHost** is a simple and powerful program written in C++/QML using Google's material 
design guidelines. It gives a *very simple http server for sharing file(s) within your
local network*. It uses **mount points** which are sort of like http endpoints with directory
listing to specific directories in your file system.

For example, You create a **Mount Point**(say /Animes to /home/user/Anime) then you can access
the directory listing and all its files at ```http://ip:port/Animes``` (Ex: http://192.168.1.3:8080/Animes).

## Features

* *Easy to Use* - This program is specifically built for ease of use.

* *Support for Kodi HTTP Client* - The best of my knowledge, this is the only application which supports listing of files in kodi 
  from the mount points.

* *Directory Listing by Default* - No need to fight with permissions in linux.

* *Automatic Permission Managemnt* - No need to worry about who owns what.

* *Mongoose Server as Backend* - Uses a trusted Web Server.

* *Material Design* - Built using QML with Material Style.


See down below for the usage.

# Usage

### Starting the server

<p align="center">
  <img src=".img/start_server.gif" height="570px" width=auto alt="Starting the Server">  
  <br>
</p>

### Adding Mount Point


<p align="center">
  <img src=".img/add_mount_point.gif" height="570px" width=auto alt="Add Mount Point">  
  <br>
</p>

### Removing Mount Point

<p align="center">
  <img src=".img/remove_mount_point.gif" height="570px" width=auto alt="Remove Mount Point">  
  <br>
</p>



# Support 

If you think that this project is **cool** then you can give it a :star: or :fork_and_knife: it if you want to improve it with me. I really :heart: stars though!   

You can also tweet about me on twitter , get connected with me [@antonyjr0](https://twitter.com/antonyjr0)

Thank You! :smiley_cat:

# Icons

All icons used in this program has been made by [Icons8](https://icons8.com). 

# Mongoose Server Usage

This program uses the mongoose server for serving contents, Since it's in GPLV2 this program is also under 
GPLV2 to comply with the license. 

The source of mongoose server has been heavily modified to our specific use case, such as the usage with
mount points. Therefore for updating the mongoose server code, we must be careful not to remove the 
modified code. *All modification to the code is mentioned in the top of source files.*


# License

The GNU General Public License V2.

Copyright (C) Antony Jr.
