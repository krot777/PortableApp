;2018-10-26 19:32:25
!define PRODUCT_NAME "Easy Context Menu"
!define PRODUCT_VERSION "1.6.0.0"
!define PRODUCT_DIR "$EXEDIR\App"
!define PRODUCT_DATA "$EXEDIR\Data\Setting"
!define PRODUCT_SETTING "Data\Setting.ini"
!define PRODUCT_EXE "EcMenu.exe"
!define PRODUCT_PUBLISHER "BlueLife"
!define START_MENU "${PRODUCT_NAME}"
!define PRODUCT_WEB_SITE "http://www.sordum.org"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_RePacked "Shen440"
!define PRODUCT_KEYDIR_INI "$LOCALAPPDATA\Longtion\AutoRun Pro Enterprise\AutoRunEnterprise.ini"
SetCompressor lzma

!include "FileFunc.nsh"
!include "MUI2.nsh"
!include "x64.nsh"

!insertmacro MUI_LANGUAGE "English"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}.exe"

VIProductVersion "${PRODUCT_VERSION}"
!define /date date "%H:%M %d %b, %Y"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "Easily add to right-click menu options"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "By BlueLife"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${PRODUCT_PUBLISHER} All rights reserved"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "By BlueLife"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "RePackBuild" " by Sindged"


Section "main"
Call Raz
Call CheckApp
Call CopyProjects
;Call RegWriteData
Call End
SectionEnd

Function "Raz"
${If} ${RunningX64}
 SetShellVarContext all
StrCpy $1 "$PROGRAMFILES64"
${Else}
SetShellVarContext all

StrCpy $1 "$PROGRAMFILES"
${EndIf}
FunctionEnd


Function "CopyProjects"
CopyFiles "$EXEDIR\Data" "$1/Easy Context Menu"
FunctionEnd

Function "CopyEXEDir"
CopyFiles "$1/Easy Context Menu" "$EXEDIR\Data"
FunctionEnd

Function "CheckEXE"
    IfFileExists "${PRODUCT_DIR}\${PRODUCT_EXE}" +3
    MessageBox MB_OK|MB_ICONEXCLAMATION `${PRODUCT_EXE} $\n was not found in  $\n ${PRODUCT_DIR}`
    Abort
FunctionEnd


Function CheckApp
    Call CheckExe
    Call CheckRunExe
    Call CheckGoodExit
FunctionEnd

Function CheckRunExe
CreateDirectory "$EXEDIR\Data\"
     WriteINIStr "${PRODUCT_SETTING}" "${PRODUCT_NAME} Portable" "GoodExit" "true"
    ReadINIStr $0 "${PRODUCT_SETTING}" "${PRODUCT_NAME} Portable" "AllowMultipleInstances"
    StrCmp $0 "" 0 +2
    WriteINIStr "${PRODUCT_SETTING}" "${PRODUCT_NAME} Portable" "AllowMultipleInstances" "false"
    FindProcDLL::FindProc "${PRODUCT_EXE}"
        Pop $R0
        StrCmp $R0 "1" 0 CheckRunEnd
    ReadINIStr $0 "${PRODUCT_SETTING}" "${PRODUCT_NAME} Portable" "AllowMultipleInstances"
    StrCmp $0 "true" SecondLaunch
        MessageBox MB_OK|MB_ICONINFORMATION `Another ${PRODUCT_NAME} is running. Close ${PRODUCT_NAME} before running ${PRODUCT_NAME} Portable.`
        Abort
SecondLaunch:
    SetOutPath "${PRODUCT_DIR}\"
    ${GetParameters} $0
    Exec `${PRODUCT_DIR}\${PRODUCT_EXE} $0`
    Abort
CheckRunEnd:
FunctionEnd


Function CheckGoodExit

    ReadINIStr $0 "${PRODUCT_SETTING}" "${PRODUCT_NAME} Portable" "GoodExit"
    StrCmp $0 "false" 0 CheckExitEnd
     WriteINIStr "${PRODUCT_SETTING}" "${PRODUCT_NAME} Portable" "GoodExit" "true"
    ReadINIStr $0 "${PRODUCT_SETTING}" "${PRODUCT_NAME} Portable" "AllowMultipleInstances"
    StrCmp $0 "true" 0 +4
    FindProcDLL::FindProc "${PRODUCT_EXE}"
        Pop $R0
        StrCmp $R0 "1" CheckExitEnd
    MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION `Last exit of ${PRODUCT_NAME}Portable did'nt restore settings.$\nWould you try to restore local and portable settings now?` IDOK RestoreNow IDCANCEL CheckExitEnd
    RestoreNow:
    Call Restore
    CheckExitEnd:
FunctionEnd

Function "Restore"
RMDir /r "$EXEDIR/Data"
FunctionEnd

Function "End"
RMDir /r "$1/Easy Context Menu"
FunctionEnd