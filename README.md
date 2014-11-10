## AOSP fürs Nexus4 (mako) selbst bauen ##

### Repo ###

[Repo](http://source.android.com/source/developing.html) ist ein Werkzeug, welches Google zur Verfügung 
gestellt hat, es vereinfacht [Git](http://git-scm.com/book) im Zusammenhang mit dem Android Source Code

### Repo installieren  

```bash
# Zuerst ein Verzeichnis erstellen in welchem repo gespeichert wird und zu $PATH hinzufügen
$ mkdir ~/bin
$ PATH=~/bin:$PATH

# Download von repo selbst
$ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

# repo ausführbar machen
$ chmod a+x ~/bin/repo
```

### Repo initalisieren ###

```bash
# Ein Verzeichnis für die Quelldateien erstellen
# Dies ist nur ein Beispielpfad, es kann selbsverständlich jedes Verzeichnis gewählt werden
# (aber das Dateisystem muss Groß-/Kleinschreibung unterstützen)
$ mkdir -p ~/android/Projekt
$ cd ~/android/Projekt

# Repo im erstellen Verzeichnis installieren
$ repo init -u https://android.googlesource.com/platform/manifest -b android-5.0.0_r2
```

### "Source tree" runterladen ###

Runterladen starten (das 1. mal dauert, je nach Internetgeschwindigkeit, sehr lange, kann ebenso 
bei Änderungen der quelle ausgeführt werden (bzw. nach ändern des "revision tags" in .repo/manifests/default.xml)

```bash
$ repo sync
```

### local_manifests ###

Hier können lokal Änderungen der Projekte welche "gesynct" werden sollen, vorgenommen werden
(siehe local_manifests.xml), dazu im .repo Ordner, falls noch nicht vorhanden, einen Ordner local_manifests 
erstellen, und entsprechende Datei einfügen

### Propriertäre Dateien ###

[Hier](https://developers.google.com/android/nexus/drivers?hl=de) zu finden (bzw. preview binaries [hier](https://developers.google.com/android/nexus/blobs-preview), entpacken und mit repo sync einfügen 
(siehe local_manifest.xml) oder einfach im Projekt "root" Ordner entpacken 
(nach dem entpacken/sync muss z.b. das Verzeichnis ~/android/Projekt/vendor/qcom/mako existieren)

(Wichtig: nicht vergessen sie in device/lge/mako einzubinden [Commit](https://github.com/vetzki/device_lge_mako/commit/35df836faea27b66ec79d0c8ca7e745abd97dfc1)

### Building ###

Oracle-Java 7 benutzen [(Howto](http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html))

```bash
# In den Hauptordner der gesyncten Projekte wechseln
$ cd ~/android/Projekt
$ . build/envsetup.sh
$ lunch
(mako auswählen)
$ make otapackage
```

Es kann auch die buildspec.mk verwendet werden
wget https://raw.githubusercontent.com/vetzki/local_manifests/master/buildspec.mk -O ~/android/Projekt/buildspec.mk