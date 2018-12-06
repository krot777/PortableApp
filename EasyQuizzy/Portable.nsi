
!define AppName "easyQuizzy"
;подкл библотек и описание переменных
!define AppVerName "easyQuizzy 2.0.442"
!define AppVersion "2.0.0.442"
!define AppPublisher "easyQuizzy"
!define AppSupportURL "http://easyquizzy.com"
!define AppIcon "./icon.ico"
!define APPDIR "app"
!define AppData "data"
!define AppExe "easyQuizzy.exe"
!define AppINI "${APPNAME}Portable.ini"
!define APPSWITCH 	``
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "Registry.nsh"

;имя выходного файла и икона , параметры запуска 
Name "${APPNAME} Portable"
OutFile "${APPNAME} Portable.exe"
Icon "${APPICON}"
WindowIcon off
SilentInstall silent
AutoCloseWindow true

VIProductVersion "${AppVersion}"
  VIAddVersionKey /LANG=0x440 "CompanyName" "${AppPublisher}"
  VIAddVersionKey /LANG=0x440 "FileDescription" "${AppName} ${AppVersion}"
  VIAddVersionKey /LANG=0x440 "FileVersion" "${AppVersion}"
  VIAddVersionKey /LANG=0x440 "Publisher" "${AppPublisher}"
  VIAddVersionKey /LANG=0x440 "LegalCopyright" "${AppPublisher}"
  VIAddVersionKey /LANG=0x440 "PortableBuild" "EBX440"
  VIAddVersionKey /LANG=0x440 "License" "Activated"




Section Main
call Unpack
Call CheckStart
Call  ChekReg
  Call  Launch
  Call SaveReg
  Call DeleteReg
SectionEnd



Function CheckStart
	Call CheckDirExe
	Call CheckRunExe
	Call CheckGoodExit
FunctionEnd

Function CheckDirExe
CreateDirectory "$EXEDIR\data"
	IfFileExists "$EXEDIR\${APPDIR}\${APPEXE}" +3
	MessageBox MB_OK|MB_ICONEXCLAMATION `${APPEXE} was not found in $EXEDIR\${APPDIR}`
	Abort
FunctionEnd

Function CheckRunExe
	ReadINIStr $0 "$EXEDIR\${Appdata}\${AppINI}" "${APPNAME}Portable" "AllowMultipleInstances"
	StrCmp $0 "" 0 +2
	WriteINIStr "$EXEDIR\${Appdata}\${AppINI}" "${APPNAME}Portable" "AllowMultipleInstances" "false"
	FindProcDLL::FindProc "${APPEXE}"
		Pop $R0
		StrCmp $R0 "1" 0 CheckRunEnd
	ReadINIStr $0 "$EXEDIR\${Appdata}\${AppINI}" "${APPNAME}Portable" "AllowMultipleInstances"
	StrCmp $0 "true" SecondLaunch
		MessageBox MB_OK|MB_ICONINFORMATION `Another ${APPNAME} is running. Close ${APPNAME} before running ${APPNAME} Portable.`
		Abort
SecondLaunch:
	SetOutPath "$EXEDIR\${APPDIR}"
	${GetParameters} $0
	Exec `"$EXEDIR\${APPDIR}\${APPEXE} $0`
	Abort
CheckRunEnd:
FunctionEnd


Function CheckGoodExit

	ReadINIStr $0 "$EXEDIR\Data\${AppINI}" "${APPNAME}Portable" "GoodExit"
	StrCmp $0 "false" 0 CheckExitEnd
	ReadINIStr $0 "$EXEDIR\${AppINI}" "${APPNAME}Portable" "AllowMultipleInstances"
	StrCmp $0 "true" 0 +4
	FindProcDLL::FindProc "${APPEXE}"
		Pop $R0
		StrCmp $R0 "1" CheckExitEnd
	MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION `Last exit of ${APPNAME}Portable did'nt restore settings.$\nWould you try to restore local and portable settings now?` IDOK RestoreNow IDCANCEL CheckExitEnd
	RestoreNow:
	Call Restore
	CheckExitEnd:
FunctionEnd

Function Writedata
    WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software" "" ""

  WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "language" ""
  WriteRegBin HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "reminder_option" 813216c43435e540
  WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "user_name_uncoded" "Urfik"
 WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "activation_code" "bijiglkdig`iklqi"
 WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "last_author" ""
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "insert_img_dlg_x" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "insert_img_dlg_y" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "insert_img_dlg_width" 0x2bc
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "insert_img_dlg_height" 0x226
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "insert_img_dlg_viewstyle" 0x702d
WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "insert_img_dlg_dir" ""
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "open_dlg_x" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "open_dlg_y" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "open_dlg_width" 0x2bc
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "open_dlg_height" 0x226
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "open_dlg_viewstyle" 0x702c
WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "open_dlg_dir" ""
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "save_dlg_x" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "save_dlg_y" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "save_dlg_width" 0x2bc
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "save_dlg_height" 0x226
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "save_dlg_viewstyle" 0x702c
WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "save_dlg_dir" ""
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "import_dlg_x" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "import_dlg_y" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "import_dlg_width" 0x2bc
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "import_dlg_height" 0x226
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "import_dlg_viewstyle" 0x702c
WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "import_dlg_dir" ""
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "export_dlg_x" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "export_dlg_y" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "export_dlg_width" 0x2bc
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "export_dlg_height" 0x226
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "export_dlg_viewstyle" 0x702c
WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "export_dlg_dir" ""
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "addqfromfile_dlg_x" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "addqfromfile_dlg_y" 0x14
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "addqfromfile_dlg_width" 0x2bc
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "addqfromfile_dlg_height" 0x226
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "addqfromfile_dlg_viewstyle" 0x702c
WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "addqfromfile_dlg_dir" ""
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "window_x" 0x12f
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "window_y" 0x0
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "window_width" 0x320
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "window_height" 0x2bc
WriteRegStr HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "window_maximized" "FALSE"
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "qtree_width" 0xfa
WriteRegDWORD HKEY_CURRENT_USER "Software\NetCrate Software\easyQuizzy" "main_font_size" 0x2
FunctionEnd

Function Restore

  Call	Close
  
FunctionEnd

Function Close
RMDir /r "$EXEDIR/data"
Call Writedata
FunctionEnd

Function Launch
SetOutPath "$EXEDIR\${APPDIR}"
${GetParameters} $0
ExecWait `"$EXEDIR\${APPDIR}\${APPEXE}"${APPSWITCH} $0`
WriteINIStr "$EXEDIR\Data\${APPINI}" "${APPNAME}Portable" "GoodExit" "true"
WriteINIStr "$EXEDIR\Data\${APPINI}" "${APPNAME}Portable" "LastDirectory" "$EXEDIR"
FunctionEnd

Function "ChekReg"
IfFileExists "$EXEDIR\Data\Setting.0x440" 0 NotFiles
Call RestoreReg
 Goto Done
NotFiles:
Call Writedata
Done:
FunctionEnd

Function SaveReg
${registry::SaveKey} "HKCU\Software\NetCrate Software\easyQuizzy" "$EXEDIR\Data\Setting.0x440" "/G=1 /D=2" $R0
	${registry::Unload}
	FunctionEnd


Function RestoreReg
${registry::RestoreKey} "$EXEDIR\Data\Setting.0x440" $R0
	${registry::Unload}
FunctionEnd

Function DeleteReg
${registry::DeleteKey} "HKCU\Software\NetCrate Software\easyQuizzy" $R0
FunctionEnd

;Здесь распаковка программы
Function Unpack
CreateDirectory "$EXEDIR\app"
IfFileExists "$EXEDIR\app\EasyQuzzy.exe" 0 NotFiles
 Goto Done
NotFiles:
SetOutPath "$EXEDIR\app"
File "D:\SmailProject\EasyQuzzy\AppFiles\*.*"
Done:
FunctionEnd


