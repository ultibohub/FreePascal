{%MainUnit classes.pp}
{
    This file is part of the Free Component Library (FCL)
    Copyright (c) 1999-2000 by the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

const
  SAssignError = '%s kann nicht zu  %s zugewiesen werden';
  SFCreateError = 'Datei %s kann nicht erstellt werden';
  SFOpenError = 'Datei %s kann nicht ge�ffnet werden';
  SReadError = 'Stream-Read-Fehler';
  SWriteError = 'Stream-Write-Fehler';
  SMemoryStreamError = 'Expandieren des Speicher-Stream wegen Speichermangel nicht m�glich';
  SCantWriteResourceStreamError = 'In einen zum Lesen ge�ffneten Ressourcen-Stream kann nicht geschrieben werden';
  SDuplicateReference = 'Zweimaliger Aufruf von WriteObject f�r die gleiche Instanz';
  SClassNotFound = 'Klasse %s nicht gefunden';
  SInvalidImage = 'Ung�ltiges Stream-Format';
  SResNotFound = 'Ressource %s nicht gefunden';
  SClassMismatch = 'Ressource %s hat die falsche Klasse';
  SListIndexError = 'Der Index der Liste �berschreitet das Maximum (%d)';
  SListCapacityError = 'Die Kapazit�t der Liste ist ersch�pft (%d)';
  SListCountError = 'Zu viele Eintr�ge in der Liste (%d)';
  SSortedListError = 'Operation bei sortierten Stringlisten nicht erlaubt';
  SDuplicateString = 'In der Stringliste sind Duplikate nicht erlaubt';
  SInvalidTabIndex = 'Registerindex au�erhalb des zul�ssigen Bereichs';
  SDuplicateName = 'Eine Komponente mit der Bezeichnung %s existiert bereits';
  SInvalidName = '''''%s'''' ist kein g�ltiger Komponentenname';
  SDuplicateClass = 'Eine Klasse mit der Bezeichnung %s existiert bereits';
  SNoComSupport = '%s wurde nicht als COM-Klasse registriert';
  SInvalidInteger = '''''%s'''' ist kein g�ltiger Integerwert';
  SLineTooLong = 'Zeile zu lang';

  SInvalidPropertyValue = 'Ung�ltiger Wert der Eigenschaft';
  SInvalidPropertyPath = 'Ung�ltiger Pfad f�r Eigenschaft';
  SUnknownProperty = 'Eigenschaft existiert nicht';
  SReadOnlyProperty = 'Eigenschaft kann nur gelesen werden';
  SUnknownPropertyType = 'Unbekannter Eigenschaftstyp %d';
  SPropertyException = 'Fehler beim Lesen von %s%s: %s';
  SAncestorNotFound = 'Vorfahr f�r ''%s'' nicht gefunden';
  SInvalidBitmap = 'Bitmap ist ung�ltig';
  SInvalidIcon = 'Ung�ltiges Symbol';
  SInvalidMetafile = 'Metadatei ist ung�ltig';
  SInvalidPixelFormat = 'Ung�ltiges Pixelformat';
  SBitmapEmpty = 'Bitmap ist leer';
  SScanLine = 'Bereichs�berschreitung bei Zeilenindex';
  SChangeIconSize = 'Die Gr��e eines Symbols kann nicht ge�ndert werden';
  SOleGraphic = 'Ung�ltige Operation f�r TOleGraphic';
  SUnknownExtension = 'Unbekannte Bilddateierweiterung (.%s)';
  SUnknownClipboardFormat = 'Format der Zwischenablage wird nicht unterst�tzt';
  SOutOfResources = 'Systemressourcen ersch�pft.';
  SNoCanvasHandle = 'Leinwand/Bild erlaubt kein Zeichnen';
  SInvalidImageSize = 'Ung�ltige Bildgr��e';
  STooManyImages = 'Zu viele Bilder';
  SDimsDoNotMatch = 'Bildgr��e und Bildlistengr��e stimmen nicht �berein';
  SInvalidImageList = 'Ung�ltige ImageList';
  SReplaceImage = 'Bild kann nicht ersetzt werden';
  SImageIndexError = 'Ung�ltiger ImageList-Index';
  SImageReadFail = 'Die ImageList-Daten konnten nicht aus dem Stream gelesen werden';
  SImageWriteFail = 'Die ImageList-Daten konnten nicht in den Stream geschrieben werden';
  SWindowDCError = 'Fehler beim Erstellen des Fenster-Ger�tekontexts';
  SClientNotSet = 'Client von TDrag wurde nicht initialisiert';
  SWindowClass = 'Fehler beim Erzeugen einer Fensterklasse';
  SWindowCreate = 'Fehler beim Erzeugen eines Fensters';
  SCannotFocus = 'Ein deaktiviertes oder unsichtbares Fenster kann nicht den Fokus erhalten';
  SParentRequired = 'Element ''%s'' hat kein �bergeordnetes Fenster';
  SMDIChildNotVisible = 'Ein MDI-Kindformular kann nicht verborgen werden';
  SVisibleChanged = 'Eigenschaft Visible kann in OnShow oder OnHide nicht ver�ndert werden';
  SCannotShowModal = 'Aus einem sichtbaren Fenster kann kein modales gemacht werden';
  SScrollBarRange = 'Eigenschaft Scrollbar au�erhalb des zul�ssigen Bereichs';
  SPropertyOutOfRange = 'Eigenschaft %s au�erhalb des g�ltigen Bereichs';
  SMenuIndexError = 'Men�index au�erhalb des zul�ssigen Bereichs';
  SMenuReinserted = 'Men� zweimal eingef�gt';
  SMenuNotFound = 'Untermen� ist nicht im Men�';
  SNoTimers = 'Nicht gen�gend Timer verf�gbar';
  SNotPrinting = 'Der Drucker ist nicht am Drucken';
  SPrinting = 'Das Drucken ist im Gang';
  SPrinterIndexError = 'Druckerindex au�erhalb des zul�ssigen Bereichs';
  SInvalidPrinter = 'Ausgew�hlter Drucker ist ung�ltig';
  SDeviceOnPort = '%s an %s';
  SGroupIndexTooLow = 'GroupIndex kann nicht kleiner sein als der GroupIndex eines vorhergehenden Men�elementes';
  STwoMDIForms = 'Es ist nur ein MDI-Formular pro Anwendung m�glich';
  SNoMDIForm = 'Formular kann nicht erstellt werden. Zur Zeit sind keine MDI-Formulare aktiv';
  SRegisterError = 'Ung�ltige Komponentenregistrierung';
  SImageCanvasNeedsBitmap = 'Ein Bild kann nur ge�ndert werden, wenn es ein Bitmap enth�lt';
  SControlParentSetToSelf = 'Ein Steuerelement kann nicht sich selbst als Vorfahr haben';
  SOKButton = 'OK';
  SCancelButton = 'Abbrechen';
  SYesButton = '&Ja';
  SNoButton = '&Nein';
  SHelpButton = '&Hilfe';
  SCloseButton = '&Schlie�en';
  SIgnoreButton = '&Ignorieren';
  SRetryButton = '&Wiederholen';
  SAbortButton = 'Abbruch';
  SAllButton = '&Alles';

  SFB = 'VH';
  SFG = 'VG';
  SBG = 'HG';
  SOldTShape = 'Kann �ltere Version von TShape nicht laden';
  SVMetafiles = 'Metadateien';
  SVEnhMetafiles = 'Erweiterte Metadateien';
  SVIcons = 'Symbole';
  SVBitmaps = 'Bitmaps';
  SGridTooLarge = 'Gitter zu gro� f�r Operation';
  STooManyDeleted = 'Zu viele Zeilen oder Spalten gel�scht';
  SIndexOutOfRange = 'Gitterindex au�erhalb des zul�ssigen Bereichs';
  SFixedColTooBig = 'Die Anzahl fester Spalten mu� kleiner sein als die Spaltenanzahl';
  SFixedRowTooBig = 'Die Anzahl fester Zeilen mu� kleiner sein als die Zeilenanzahl';
  SInvalidStringGridOp = 'Es k�nnen keine Zeilen des ''Grids'' gel�scht oder eingef�gt werden';
  SParseError = '%s in Zeile %d';

  SIdentifierExpected = 'Bezeichner erwartet';
  SStringExpected = 'String erwartet';
  SNumberExpected = 'Zahl erwartet';

  SCharExpected = '%s erwartet';

  SSymbolExpected = '%s erwartet';

  SInvalidNumber = 'Ung�ltiger numerischer Wert';
  SInvalidString = 'Ung�ltige Stringkonstante';
  SInvalidProperty = 'Ung�ltiger Wert der Eigenschaft';
  SInvalidBinary = 'Ung�ltiger Bin�rwert';
  SOutlineIndexError = 'Gliederungsindex nicht gefunden';
  SOutlineExpandError = 'Elternknoten mu� expandiert sein';
  SInvalidCurrentItem = 'Ung�ltiger Wert';
  SMaskErr = 'Ung�ltiger Eingabewert';
  SMaskEditErr = 'Ung�ltiger Eingabewert. Benutzen Sie die ESC-Taste, um die �nderungen r�ckg�ngig zu machen.';
  SOutlineError = 'Ung�ltiger Gliederungsindex';
  SOutlineBadLevel = 'Ung�ltige Zuweisung von Ebenen';
  SOutlineSelection = 'Ung�ltige Auswahl';
  SOutlineFileLoad = 'Fehler beim Dateiladen';
  SOutlineLongLine = 'Zeile zu lang';
  SOutlineMaxLevels = 'Maximale Gliederungstiefe �berschritten';

  SMsgDlgWarning = 'Warnung';
  SMsgDlgError = 'Fehler';
  SMsgDlgInformation = 'Information';
  SMsgDlgConfirm = 'Best�tigen';
  SMsgDlgYes = '&Ja';
  SMsgDlgNo = '&Nein';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Abbrechen';
  SMsgDlgHelp = '&Hilfe';
  SMsgDlgHelpNone = 'Keine Hilfe verf�gbar';
  SMsgDlgHelpHelp = 'Hilfe';
  SMsgDlgAbort = '&Abbrechen';
  SMsgDlgRetry = '&Wiederholen';
  SMsgDlgIgnore = '&Ignorieren';
  SMsgDlgAll = '&Alles';
  SMsgDlgNoToAll = '&Alle Nein';
  SMsgDlgYesToAll = 'A&lle Ja';

  SmkcBkSp = 'R�ck';
  SmkcTab = 'Tab';
  SmkcEsc = 'Esc';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Leertaste';
  SmkcPgUp = 'BildAuf';
  SmkcPgDn = 'BildAb';
  SmkcEnd = 'Ende';
  SmkcHome = 'Pos1';
  SmkcLeft = 'Linksb�ndig';
  SmkcUp = 'Nach oben';
  SmkcRight = 'Rechts';
  SmkcDown = 'Nach unten';
  SmkcIns = 'Einfg';
  SmkcDel = 'Entf';
  SmkcShift = 'Umsch+';
  SmkcCtrl = 'Strg+';
  SmkcAlt = 'Alt+';

  srUnknown = '(Unbekannt)';
  srNone = '(Leer)';
  SOutOfRange = 'Wert mu� zwischen %d und %d liegen';
  SCannotCreateName = 'F�r eine unbenannte Komponente kann kein Standard-Methodennamen erstellt werden';

  SDateEncodeError = 'Ung�ltiges Argument f�r Datumskodierung';
  STimeEncodeError = 'Ung�ltiges Argument f�r Zeitkodierung';
  SInvalidDate = '''''%s'''' ist kein g�ltiges Datum';
  SInvalidTime = '''''%s'''' ist keine g�ltige Zeit';
  SInvalidDateTime = '''''%s'''' ist kein g�ltiges Datum und Zeit';
  SInsertLineError = 'Zeile kann nicht eingef�gt werden';

  SCannotDragForm = 'Formulare k�nnen nicht gezogen werden';
  SPutObjectError = 'PutObject auf undefiniertes Element';
  SCardDLLNotLoaded = 'CARDS.DLL kann nicht geladen werden';
  SDuplicateCardId = 'Doppelte CardId gefunden';

  SDdeErr = 'Ein Fehler wurde von der DDE zur�ckgeliefert  ($0%x)';
  SDdeConvErr = 'DDE Fehler - Konversation wurde nicht hergestellt ($0%x)';
  SDdeMemErr = 'Fehler trat auf, da unzureichender Speicher f�r DDE ($0%x)';
  SDdeNoConnect = 'DDE-Konversation kann nicht eingerichtet werden';


  SDefaultFilter = 'Alle Dateien (*.*)|*.*';
  sAllFilter = 'Alle Dateien';
  SNoVolumeLabel = ': [ - Ohne Namen - ]';

  SConfirmCreateDir = 'Das angegebene Verzeichnis existiert nicht. Soll es angelegt werden?';
  SSelectDirCap = 'Verzeichnis ausw�hlen';
  SCannotCreateDir = 'Das Verzeichnis kann nicht erstellt werden';
  SDirNameCap = 'Verzeichnis&name:';
  SDrivesCap = '&Laufwerke:';
  SDirsCap = '&Verzeichnisse:';
  SFilesCap = '&Dateien: (*.*)';
  SNetworkCap = 'Ne&tzwerk...';

  SColorPrefix = 'Farbe';
  SColorTags = 'ABCDEFGHIJKLMNOP';

  SInvalidClipFmt = 'Ung�ltiges Format der Zwischenablage';
  SIconToClipboard = 'Zwischenablage unterst�tzt keine Symbole';

  SDefault = 'Vorgabe';

  SInvalidMemoSize = 'Text �berschreitet Memo-Kapazit�t';
  SCustomColors = 'Selbstdefinierte Farben';
  SInvalidPrinterOp = 'Operation auf ausgew�hltem Drucker nicht verf�gbar';
  SNoDefaultPrinter = 'Zur Zeit ist kein Standard-Drucker gew�hlt';

  SIniFileWriteError = 'nach %s kann nicht geschrieben werden';

  SBitsIndexError = 'Bits-Index au�erhalb des zul�ssigen Bereichs';

  SUntitled = '(Unbenannt)';

  SInvalidRegType = 'Ung�ltiger Datentyp f�r ''%s''';
  SRegCreateFailed = 'Erzeugung von Schl�ssel %s misslungen';
  SRegSetDataFailed = 'Konnte Daten f�r ''%s'' nicht setzen';
  SRegGetDataFailed = 'Konnte Daten f�r ''%s'' nicht holen';

  SUnknownConversion = 'Unbekannte Dateierweiterung f�r RichEdit-Konvertierung (.%s)';
  SDuplicateMenus = 'Men� ''%s'' wird bereits von einem anderen Formular benutzt';

  SPictureLabel = 'Bild:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = 'Vorschau';

  SCannotOpenAVI = 'AVI kann nicht ge�ffnet werden';

  SNotOpenErr = 'Kein MCI-Ger�t ge�ffnet';
  SMPOpenFilter = 'Alle Dateien (*.*)|*.*|Wave-Dateien (*.WAV)|*.WAV|Midi-Dateien (*.MID)|*.MID|Video f�r Windows (*.avi)|*.avi';
  SMCINil = '';
  SMCIAVIVideo = 'AVIVideo';
  SMCICDAudio = 'CDAudio';
  SMCIDAT = 'DAT';
  SMCIDigitalVideo = 'DigitalVideo';
  SMCIMMMovie = 'MMMovie';
  SMCIOther = 'Andere';
  SMCIOverlay = 'Overlay';
  SMCIScanner = 'Scanner';
  SMCISequencer = 'Sequencer';
  SMCIVCR = 'VCR';
  SMCIVideodisc = 'Videodisc';
  SMCIWaveAudio = 'WaveAudio';
  SMCIUnknownError = 'Unbekannter Fehlercode';

  SBoldItalicFont = 'Fett kursiv';
  SBoldFont = 'Fett';
  SItalicFont = 'Kursiv';
  SRegularFont = 'Normal';

  SPropertiesVerb = 'Eigenschaften';

