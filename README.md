# MyAHK.exe

Collection of [Richard Frost](http://richardfrost.info)'s [AutoHotKey L](http://ahkscript.org/) scripts.

_Although many of the contributions to MyAHK.exe were written by me, I have been influenced by the works of many others. Credits and thanks to all those who have contributed to the AutoHotKey community._

# Installation Instructions

MyAHK.exe must be placed in a trusted location such as &quot;C:\Program Files\&quot;. The executable will not run on until you install the digital certificate (Only needs to be done once):

### Accepting the Certificate:
  1. Open the properties for the executable.
  2. Click on the &quot;Digital Signatures&quot; tab.
  3. Double-click the Signature.
  4. Click on **View Certificate** and then click **Install Certificate**.
  5. Choose &quot;Current User&quot; and follow the wizard to install it.
  6. Choose &quot;Place all certificates in the following store&quot; and click **Browse**.
  7. Select the &quot;Trusted Root Certificate Authorities&quot; and then click **Okay**.
  8. Optional: Add a shortcut to your startup folder to start MyAHK automatically.

# Updating
  1. Download the newest copy of MyAHK.exe.
  2. Close MyAHK.exe (CTRL+ALT+BACKSPACE or end the process in Task Manager).
  3. View the properties of the new MyAHK.exe and click **Unblock** if it is being blocked from running.
  4. Copy the new MyAHK.exe over the old MyAHK.exe.
  5. Once you run MyAHK.exe again you will be running the updated version.

# Optional Environmental Variables

| Variable Name | Explanation | Example |
| --- | --- | --- |
| `SyncHome` | Favorite folder | `%UserProfile%\Dropbox` |
| `Working` | Favorite working folder | `%UserProfile%\Downloads` |
| `Cmder` | Path to Cmder executable | `%PathTo%\Cmder\Cmder.exe` |

# Shortcut List

| Shortcut | Description |
| --- | --- |
| `APPSKEY+ENTER` | Insert a line break (useful when hitting enter will submit a form) |
| `APPSKEY+TAB` | Insert a tab (useful when pressing tab would change the focus) |
| `APPSKEY+INSERT` | Search Google for selected text, or if URL go straight there |
| `LSHIFT+RSHIFT` | Reload AHK |
| `CTRL+ALT+BACKSPACE` | Close AHK |
| `ALT+PAUSE` | Enable/Disable AHK |
| `WIN+C` | Open/Activate Calculator |
| `WIN+SHIFT+C` | Open Calculator (New Instance) |
| `CTRL+W` | Close Calculator |
| `WIN+CAPSLOCK` | Changes the case of the currently selected text. |
| `` CTRL+` `` | Open Cmder if not already running |
| `CTRL+V` | Command Prompt – Paste |
| `CTRL+W` | Command Prompt – Close |
| `CTRL+UP/DOWN` | Command Prompt - Scroll Up/Down |
| `SHIFT+PGUP/PGDN` | Command Prompt - Scroll multiple lines at a time |
| `CTRL+;` | Insert the current date in short form (MM/DD/YY) |
| `CTRL+SHIFT+;` | Insert the current date in long form (Day, Month DD, YYYY) |
| `ALT+;` | Insert Time and Date |
| `CTRL+ALT+SHIFT+K` | Disable Keyboard (type &#39;unlock&#39; to enable) |
| `CTRL+ALT+SHIFT+M` | Toggle Mouse Input |
| `WIN+Z` | Executor (App) |
| `CTRL+SHIFT+Z` | Restart Executor |
| `CTRL+WIN+SHIFT+Z` | Toggle Executor Shortcut |
| `WIN+W` | Open/Activate Your &quot;SyncHome&quot; Folder In Explorer |
| `WIN+SHIFT+A` | Open a New Instance of Your &quot;SyncHome&quot; Folder In Explorer |
| `WIN+SHIFT+D` | Open/Activate Your &quot;Working&quot;/Desktop Folder In Explorer |
| `CTRL+ALT+L` | Lock workstation |
| `WIN+PGUP` | Media: Volume Up |
| `WIN+PGDN` | Media: Volume Down |
| `WIN+F9/INSERT` | Media: Mute |
| `WIN+F10/DELETE` | Media: Previous |
| `WIN+F11/HOME` | Media: Play/Pause |
| `WIN+F12/END` | Media: Next |
| `CTRL/APPSKEY+NUMPAD-0` | Send Left Mouse Clicks |
| `CTRL/APPSKEY+NUMPAD-.` | Send Right Mouse Clicks |
| `APPSKEY+ARROWS` | Move mouse pointer with Arrow keys |
| `CTRL+W` | Close Notepad.exe |
| `WIN+O` | Open Path From Clipboard In Explorer |
| `CTRL+SHIFT+V` | Paste Plain Text (Remove Formatting) |
| `CTRL+ALT+V` | Type Clipboard Contents (For slow windows; Escape to cancel) |
| `CTRL+ALT+SHIFT+V` | Type Clipboard Contents - Slow (For slow windows; Escape to cancel) |
| `WIN+S` | Window&#39;s Snipping Tool, CTRL+W Close (Automatic Snip Win 8+) |
| `APPSKEY+LWIN` | Disable Windows Keys (Useful for full-screen applications) |
| `APPSKEY+SHIFT+LWIN` | Re-enable Windows Keys |
| `CTRL+SHIFT+A` | Toggle Always On Top For Active Window |
| `APPSKEY+H` | Hide the current window (Can hide multiple windows) |
| `APPSKEY+SHIFT+H` | Restore hidden window(s) |
| `CTRL+F12` | Hide/Show The Desktop Icons |
| `WIN+Y` | Toggle Showing File Extensions In Explorer |
| `WIN+H` | Toggle Showing Hidden/System Files In Explorer |
| `` ALT+` `` | Switch between windows of the same class |
