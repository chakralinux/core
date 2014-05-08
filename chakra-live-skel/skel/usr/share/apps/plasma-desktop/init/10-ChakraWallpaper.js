/* Copyright 2014 Chakra Developer Team */

var activity = activities()[0]
activity.name = i18n("Chakra")
activity.currentConfigGroup = new Array("Wallpaper", "image");
activity.writeConfig("wallpaper", "/usr/share/wallpapers/descartes/");
activity.writeConfig("userswallpaper", "/usr/share/wallpapers/descartes");

// Set Descartes wallpaper for a fresh user
for (var i = 0; i < activities().length; i++) {
    var activity = activities()[i]
    activity.currentConfigGroup = new Array("Wallpaper", "image")
    activity.writeConfig("wallpaper", "/usr/share/wallpapers/descartes/")
    activity.writeConfig("userswallpaper", "/usr/share/wallpapers/descartes")
}