; Function to retrieve the parent directory of a provided path.
; If the path provided doesn't have a backslash and it is a directory, add one before calling function.
; [Used in Explorer.ahk]


ParentDir(FullPath) {
  ;SplitPath, InputVar [, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive]
  SplitPath, FullPath, ,DirPath

  ; Remove drive letter and all folders from left
  StringLen,length, DirPath  ; get length of DirPath from SplitPath
  
  StringGetPos, pos, DirPath, \, r  ; find position of \ starting at the right
  EnvSub, length, %pos%  ; subtract pos from the length
  pos++ ; increment position to remove backslash
  StringTrimLeft,Dir,DirPath,%pos%  ; starting on the left, trim the path to only include the right-most directory.

  Return Dir
}