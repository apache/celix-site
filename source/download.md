---
title: Download
---

# Download a Release of Apache Celix

Apache Celix only releases source distributions, information about building and running van be found inside the release tarball.

## Mirrors

The currently selected mirror is **[preferred]**. If you encounter a problem with this mirror, please select another mirror. If all mirrors are failing, there are *backup* 
mirrors (at the end of the mirrors list) that should be available. 
<form action="[location]" method="get" id="SelectMirror">
    Other mirrors:
    <select name="Preferred">
        [if-any https]
        [for https]
        <option value="[https]">[https]</option>
        [end]
        [end]
        [if-any http]
        [for http]
        <option value="[http]">[http]</option>
        [end]
        [end]
        [if-any ftp]
        [for ftp]<option value="[ftp]">[ftp]</option>
        [end]
        [end]
        [if-any backup]
        [for backup]<option value="[backup]">\[backup\] \(backup\)</option>
        [end]
        [end]
    </select>
    <input type="submit" value="Change" />
</form>

You may also consult the [complete list of mirrors](https://www.apache.org/mirrors/).

## Downloads

- Source: <a href="[preferred]celix/celix-{{< param "latestVersion" >}}/celix-{{< param "latestVersion" >}}.tar.gz">celix-{{< param "latestVersion" >}}.tar.gz</a> 
[ [PGP](https://downloads.apache.org/celix/celix-{{< param "latestVersion" >}}/celix-{{< param "latestVersion" >}}.tar.gz.asc) ]
[ [SHA512](https://downloads.apache.org/celix/celix-{{< param "latestVersion" >}}/celix-{{< param "latestVersion" >}}.tar.gz.sha512) ]

