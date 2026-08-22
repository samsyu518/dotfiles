# xkbcommon Keysym 參考（Hyprland keybind 用）

用法：`hl.bind("SUPER + <keysym>", ...)` 裡的 key 名稱必須是下列 xkbcommon 名稱，
不能直接寫原始字元（例如 `=` 要寫 `equal`）。

查完整清單：`grep "^#define XKB_KEY_" /usr/include/xkbcommon/xkbcommon-keysyms.h`，
去掉 `XKB_KEY_` 前綴即為 keysym 名稱。

---

## 標點符號 / 可見字元

| 按鍵 | keysym |
|------|--------|
| `space` | `space` |
| `!` | `exclam` |
| `"` | `quotedbl` |
| `#` | `numbersign` |
| `$` | `dollar` |
| `%` | `percent` |
| `&` | `ampersand` |
| `'` | `apostrophe` |
| `(` | `parenleft` |
| `)` | `parenright` |
| `*` | `asterisk` |
| `+` | `plus` |
| `,` | `comma` |
| `-` | `minus` |
| `.` | `period` |
| `/` | `slash` |
| `:` | `colon` |
| `;` | `semicolon` |
| `<` | `less` |
| `=` | `equal` |
| `>` | `greater` |
| `?` | `question` |
| `@` | `at` |
| `[` | `bracketleft` |
| `\` | `backslash` |
| `]` | `bracketright` |
| `^` | `asciicircum` |
| `_` | `underscore` |
| `` ` `` | `grave` |
| `{` | `braceleft` |
| `\|` | `bar` |
| `}` | `braceright` |
| `~` | `asciitilde` |

---

## 特殊鍵

| 按鍵 | keysym |
|------|--------|
| Enter | `Return` |
| Backspace | `BackSpace` |
| Tab | `Tab` |
| Esc | `Escape` |
| Delete | `Delete` |
| Insert | `Insert` |
| Home | `Home` |
| End | `End` |
| Page Up | `Page_Up` |
| Page Down | `Page_Down` |
| ↑ | `Up` |
| ↓ | `Down` |
| ← | `Left` |
| → | `Right` |
| Print Screen | `Print` |
| Scroll Lock | `Scroll_Lock` |
| Pause | `Pause` |
| Caps Lock | `Caps_Lock` |
| Num Lock | `Num_Lock` |

---

## 功能鍵

`F1` ~ `F35`（直接寫，如 `F1`、`F12`）

---

## 數字鍵盤

| 按鍵 | keysym |
|------|--------|
| Numpad 0–9 | `KP_0` ~ `KP_9` |
| Numpad Enter | `KP_Enter` |
| Numpad `+` | `KP_Add` |
| Numpad `-` | `KP_Subtract` |
| Numpad `*` | `KP_Multiply` |
| Numpad `/` | `KP_Divide` |

---

## 媒體鍵（XF86）

| 功能 | keysym |
|------|--------|
| 音量增 | `XF86AudioRaiseVolume` |
| 音量減 | `XF86AudioLowerVolume` |
| 靜音 | `XF86AudioMute` |
| 麥克風靜音 | `XF86AudioMicMute` |
| 播放/暫停 | `XF86AudioPlay` |
| 暫停 | `XF86AudioPause` |
| 停止 | `XF86AudioStop` |
| 上一首 | `XF86AudioPrev` |
| 下一首 | `XF86AudioNext` |
| 螢幕亮度增 | `XF86MonBrightnessUp` |
| 螢幕亮度減 | `XF86MonBrightnessDown` |
| 上一頁（瀏覽器） | `XF86Back` |
| 下一頁（瀏覽器） | `XF86Forward` |
| Eject | `XF86Eject` |
| Sleep | `XF86Sleep` |

---

## 備用：用 keycode 綁定

如果 keysym 查不到，可改用 scancode：

```lua
hl.bind("SUPER + code:28", hl.dsp.exec_cmd("..."))
```

查 scancode：`wev`（Wayland event viewer）或 `xev`（XWayland）
