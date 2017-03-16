/*
  ImagicalPlugCreator for Ubuntu
  (C) Ad5001 <mail@ad5001.eu> 2017
 */

.pragma library
.import Ubuntu.Components 1.3 as UC
.import QtQuick 2.4 as Qt
.import Ubuntu.DownloadManager 1.2 as UDM

// .import ImagicalPlugCreator 1.0 as qprocess

function refreshName(name, author, i18n, main, pageHeader) {
    main.title = i18n.tr("ImagicalPlugCreator - " + (name !== "" ? name : "Name") + " by " + (author !== "" ? author : "Author"));
    pageHeader.title = i18n.tr("ImagicalPlugCreator - " + (name !== "" ? name : "Name") + " by " + (author !== "" ? author : "Author"));
}

function buildPlugin(name, author, config, events, tasks, dummies, download) {
    delete(dummies[0]);
    delete(tasks[0]);
    console.log("Building plugin base " + name + " by " + author +". Config? " + config + ". Events? " + events + ". Tasks: " + tasks.join(", ") + ". Dummies: " + dummies.join(", "))
    var url = "https://download.ad5001.eu/en/web/ImagicalPlugCreator/buildOnline.php?name=" + name + "&author=" + author + "&config=" + config + "&events=" + events + "&tasks=" + encodeURIComponent(tasks.join(",")).substr(3) + "&dummies=" + encodeURIComponent(dummies.join(",")).substr(3);

    var doc = new XMLHttpRequest(); // Debug
    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.DONE) {
            // otput response of request
            console.log(doc.responseText);
        }
    }
    doc.open("GET", url);
    doc.send();

    download.download(url); // Only method possible to write a file...
    console.log(url);
}
