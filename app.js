const EMBEDDED_SHORTCUTS_DATA = {
  "categories": [
    {
      "id": "basic",
      "title": "Universal Basics",
      "description": "Базовые команды, которые работают почти везде",
      "icon": "basic",
      "color": "purple"
    },
    {
      "id": "app",
      "title": "App Switching",
      "description": "Переключение приложений, окон и рабочих столов",
      "icon": "app-switch",
      "color": "blue"
    },
    {
      "id": "windows",
      "title": "Windows & Tabs",
      "description": "Окна, вкладки и режимы просмотра",
      "icon": "window-tabs",
      "color": "green"
    },
    {
      "id": "finder",
      "title": "Finder & Files",
      "description": "Файлы, папки и навигация Finder",
      "icon": "finder-file",
      "color": "orange"
    },
    {
      "id": "screenshots",
      "title": "Screenshots",
      "description": "Скриншоты, запись экрана и буфер обмена",
      "icon": "screenshot",
      "color": "indigo"
    },
    {
      "id": "text",
      "title": "Text Editing",
      "description": "Редактирование текста, курсор и выделение",
      "icon": "edit-text",
      "color": "pink"
    },
    {
      "id": "documents",
      "title": "Documents",
      "description": "Документы, форматирование и печать",
      "icon": "documents",
      "color": "brown"
    },
    {
      "id": "system",
      "title": "System Control",
      "description": "Системные команды и управление macOS",
      "icon": "systems",
      "color": "teal"
    },
    {
      "id": "accessibility",
      "title": "Accessibility",
      "description": "Универсальный доступ и вспомогательные функции",
      "icon": "accessibility",
      "color": "red"
    },
    {
      "id": "safari",
      "title": "Safari & Web",
      "description": "Браузер, вкладки, поиск и страницы",
      "icon": "safari-web",
      "color": "blue"
    }
  ],
  "shortcuts": [
    {
      "id": "basic-001",
      "category": "basic",
      "combo": "⌘ C",
      "title": "Copy",
      "description": "Скопировать выбранный объект или текст"
    },
    {
      "id": "basic-002",
      "category": "basic",
      "combo": "⌘ V",
      "title": "Paste",
      "description": "Вставить содержимое буфера обмена"
    },
    {
      "id": "basic-003",
      "category": "basic",
      "combo": "⌘ X",
      "title": "Cut",
      "description": "Вырезать выбранный объект или текст"
    },
    {
      "id": "basic-004",
      "category": "basic",
      "combo": "⌘ Z",
      "title": "Undo",
      "description": "Отменить последнее действие"
    },
    {
      "id": "basic-005",
      "category": "basic",
      "combo": "⇧ ⌘ Z",
      "title": "Redo",
      "description": "Повторить отменённое действие"
    },
    {
      "id": "basic-006",
      "category": "basic",
      "combo": "⌘ A",
      "title": "Select All",
      "description": "Выделить всё содержимое"
    },
    {
      "id": "basic-007",
      "category": "basic",
      "combo": "⌘ F",
      "title": "Find",
      "description": "Найти текст или объект"
    },
    {
      "id": "basic-008",
      "category": "basic",
      "combo": "⌘ G",
      "title": "Find Next",
      "description": "Перейти к следующему совпадению"
    },
    {
      "id": "basic-009",
      "category": "basic",
      "combo": "⇧ ⌘ G",
      "title": "Find Previous",
      "description": "Перейти к предыдущему совпадению"
    },
    {
      "id": "basic-010",
      "category": "basic",
      "combo": "⌘ S",
      "title": "Save",
      "description": "Сохранить текущий документ"
    },
    {
      "id": "basic-011",
      "category": "basic",
      "combo": "⇧ ⌘ S",
      "title": "Save As / Duplicate",
      "description": "Сохранить как или создать копию"
    },
    {
      "id": "basic-012",
      "category": "basic",
      "combo": "⌘ O",
      "title": "Open",
      "description": "Открыть выбранный объект или файл"
    },
    {
      "id": "basic-013",
      "category": "basic",
      "combo": "⌘ P",
      "title": "Print",
      "description": "Открыть окно печати"
    },
    {
      "id": "basic-014",
      "category": "basic",
      "combo": "⌘ N",
      "title": "New",
      "description": "Создать новый документ или окно"
    },
    {
      "id": "basic-015",
      "category": "basic",
      "combo": "⌘ T",
      "title": "New Tab",
      "description": "Открыть новую вкладку"
    },
    {
      "id": "basic-016",
      "category": "basic",
      "combo": "⌘ W",
      "title": "Close",
      "description": "Закрыть окно или вкладку"
    },
    {
      "id": "basic-017",
      "category": "basic",
      "combo": "⌘ Q",
      "title": "Quit App",
      "description": "Завершить приложение"
    },
    {
      "id": "basic-018",
      "category": "basic",
      "combo": "⌘ ,",
      "title": "Preferences",
      "description": "Открыть настройки приложения"
    },
    {
      "id": "basic-019",
      "category": "basic",
      "combo": "⌘ ?",
      "title": "Help",
      "description": "Открыть меню справки"
    },
    {
      "id": "basic-020",
      "category": "basic",
      "combo": "Space",
      "title": "Quick Look / Preview",
      "description": "Быстрый просмотр выбранного объекта"
    },
    {
      "id": "app-001",
      "category": "app",
      "combo": "⌘ Tab",
      "title": "Switch Apps",
      "description": "Переключиться на следующее приложение"
    },
    {
      "id": "app-002",
      "category": "app",
      "combo": "⇧ ⌘ Tab",
      "title": "Switch Apps Back",
      "description": "Переключиться на предыдущее приложение"
    },
    {
      "id": "app-003",
      "category": "app",
      "combo": "⌘ `",
      "title": "Switch App Windows",
      "description": "Переключаться между окнами текущего приложения"
    },
    {
      "id": "app-004",
      "category": "app",
      "combo": "⇧ ⌘ `",
      "title": "Switch Windows Back",
      "description": "Переключаться назад между окнами приложения"
    },
    {
      "id": "app-005",
      "category": "app",
      "combo": "⌘ H",
      "title": "Hide App",
      "description": "Скрыть текущее приложение"
    },
    {
      "id": "app-006",
      "category": "app",
      "combo": "⌥ ⌘ H",
      "title": "Hide Others",
      "description": "Скрыть остальные приложения"
    },
    {
      "id": "app-007",
      "category": "app",
      "combo": "⌘ M",
      "title": "Minimize Window",
      "description": "Свернуть текущее окно"
    },
    {
      "id": "app-008",
      "category": "app",
      "combo": "⌥ ⌘ M",
      "title": "Minimize All",
      "description": "Свернуть все окна приложения"
    },
    {
      "id": "app-009",
      "category": "app",
      "combo": "⌃ ↑",
      "title": "Mission Control",
      "description": "Показать Mission Control"
    },
    {
      "id": "app-010",
      "category": "app",
      "combo": "⌃ ↓",
      "title": "App Exposé",
      "description": "Показать окна текущего приложения"
    },
    {
      "id": "app-011",
      "category": "app",
      "combo": "⌃ ←",
      "title": "Previous Space",
      "description": "Перейти на предыдущий рабочий стол"
    },
    {
      "id": "app-012",
      "category": "app",
      "combo": "⌃ →",
      "title": "Next Space",
      "description": "Перейти на следующий рабочий стол"
    },
    {
      "id": "app-013",
      "category": "app",
      "combo": "⌃ 1",
      "title": "Space 1",
      "description": "Перейти на рабочий стол 1"
    },
    {
      "id": "app-014",
      "category": "app",
      "combo": "⌃ 2",
      "title": "Space 2",
      "description": "Перейти на рабочий стол 2"
    },
    {
      "id": "app-015",
      "category": "app",
      "combo": "F3",
      "title": "Mission Control Key",
      "description": "Открыть Mission Control клавишей"
    },
    {
      "id": "app-016",
      "category": "app",
      "combo": "Fn F3",
      "title": "Mission Control Fn",
      "description": "Mission Control на компактной клавиатуре"
    },
    {
      "id": "app-017",
      "category": "app",
      "combo": "⌃ ⌘ Q",
      "title": "Lock Screen",
      "description": "Заблокировать экран"
    },
    {
      "id": "app-018",
      "category": "app",
      "combo": "⌘ ⌥ Esc",
      "title": "Force Quit",
      "description": "Открыть окно принудительного завершения"
    },
    {
      "id": "windows-001",
      "category": "windows",
      "combo": "⌘ W",
      "title": "Close Window / Tab",
      "description": "Закрыть активное окно или вкладку"
    },
    {
      "id": "windows-002",
      "category": "windows",
      "combo": "⌥ ⌘ W",
      "title": "Close All Windows",
      "description": "Закрыть все окна приложения"
    },
    {
      "id": "windows-003",
      "category": "windows",
      "combo": "⇧ ⌘ W",
      "title": "Close Window Group",
      "description": "Закрыть группу окон или вкладок"
    },
    {
      "id": "windows-004",
      "category": "windows",
      "combo": "⌘ T",
      "title": "New Tab",
      "description": "Открыть новую вкладку"
    },
    {
      "id": "windows-005",
      "category": "windows",
      "combo": "⇧ ⌘ T",
      "title": "Reopen Closed Tab",
      "description": "Открыть последнюю закрытую вкладку"
    },
    {
      "id": "windows-006",
      "category": "windows",
      "combo": "⌘ ]",
      "title": "Next Tab",
      "description": "Перейти к следующей вкладке"
    },
    {
      "id": "windows-007",
      "category": "windows",
      "combo": "⌘ [",
      "title": "Previous Tab",
      "description": "Перейти к предыдущей вкладке"
    },
    {
      "id": "windows-008",
      "category": "windows",
      "combo": "⌃ Tab",
      "title": "Next Tab Alt",
      "description": "Перейти к следующей вкладке"
    },
    {
      "id": "windows-009",
      "category": "windows",
      "combo": "⌃ ⇧ Tab",
      "title": "Previous Tab Alt",
      "description": "Перейти к предыдущей вкладке"
    },
    {
      "id": "windows-010",
      "category": "windows",
      "combo": "⌘ 1",
      "title": "Select Tab 1",
      "description": "Перейти к первой вкладке"
    },
    {
      "id": "windows-011",
      "category": "windows",
      "combo": "⌘ 2",
      "title": "Select Tab 2",
      "description": "Перейти ко второй вкладке"
    },
    {
      "id": "windows-012",
      "category": "windows",
      "combo": "⌘ 9",
      "title": "Last Tab",
      "description": "Перейти к последней вкладке"
    },
    {
      "id": "windows-013",
      "category": "windows",
      "combo": "⌘ +",
      "title": "Zoom In",
      "description": "Увеличить масштаб"
    },
    {
      "id": "windows-014",
      "category": "windows",
      "combo": "⌘ -",
      "title": "Zoom Out",
      "description": "Уменьшить масштаб"
    },
    {
      "id": "windows-015",
      "category": "windows",
      "combo": "⌘ 0",
      "title": "Actual Size",
      "description": "Вернуть масштаб 100%"
    },
    {
      "id": "windows-016",
      "category": "windows",
      "combo": "⌃ ⌘ F",
      "title": "Full Screen",
      "description": "Переключить полноэкранный режим"
    },
    {
      "id": "windows-017",
      "category": "windows",
      "combo": "⌥ ⌘ I",
      "title": "Inspector",
      "description": "Показать инспектор там, где доступно"
    },
    {
      "id": "windows-018",
      "category": "windows",
      "combo": "⌘ R",
      "title": "Reload / Refresh",
      "description": "Обновить окно или страницу"
    },
    {
      "id": "finder-001",
      "category": "finder",
      "combo": "⌘ N",
      "title": "New Finder Window",
      "description": "Открыть новое окно Finder"
    },
    {
      "id": "finder-002",
      "category": "finder",
      "combo": "⇧ ⌘ N",
      "title": "New Folder",
      "description": "Создать новую папку"
    },
    {
      "id": "finder-003",
      "category": "finder",
      "combo": "⌥ ⌘ N",
      "title": "New Smart Folder",
      "description": "Создать умную папку"
    },
    {
      "id": "finder-004",
      "category": "finder",
      "combo": "⌘ O",
      "title": "Open Selected",
      "description": "Открыть выбранный объект"
    },
    {
      "id": "finder-005",
      "category": "finder",
      "combo": "⌘ ↓",
      "title": "Open Item",
      "description": "Открыть выбранный объект"
    },
    {
      "id": "finder-006",
      "category": "finder",
      "combo": "⌘ ↑",
      "title": "Enclosing Folder",
      "description": "Перейти в родительскую папку"
    },
    {
      "id": "finder-007",
      "category": "finder",
      "combo": "⌘ I",
      "title": "Get Info",
      "description": "Показать информацию об объекте"
    },
    {
      "id": "finder-008",
      "category": "finder",
      "combo": "⌥ ⌘ I",
      "title": "Inspector",
      "description": "Открыть инспектор"
    },
    {
      "id": "finder-009",
      "category": "finder",
      "combo": "⌃ ⌘ I",
      "title": "Summary Info",
      "description": "Показать сводную информацию"
    },
    {
      "id": "finder-010",
      "category": "finder",
      "combo": "⌘ D",
      "title": "Duplicate",
      "description": "Дублировать выбранный файл"
    },
    {
      "id": "finder-011",
      "category": "finder",
      "combo": "⌘ L",
      "title": "Make Alias",
      "description": "Создать псевдоним"
    },
    {
      "id": "finder-012",
      "category": "finder",
      "combo": "⌘ R",
      "title": "Show Original",
      "description": "Показать оригинал псевдонима"
    },
    {
      "id": "finder-013",
      "category": "finder",
      "combo": "⌘ E",
      "title": "Eject",
      "description": "Извлечь выбранный диск"
    },
    {
      "id": "finder-014",
      "category": "finder",
      "combo": "⌘ ⌫",
      "title": "Move to Trash",
      "description": "Переместить в корзину"
    },
    {
      "id": "finder-015",
      "category": "finder",
      "combo": "⇧ ⌘ ⌫",
      "title": "Empty Trash",
      "description": "Очистить корзину"
    },
    {
      "id": "finder-016",
      "category": "finder",
      "combo": "⌥ ⇧ ⌘ ⌫",
      "title": "Empty Trash Without Dialog",
      "description": "Очистить корзину без подтверждения"
    },
    {
      "id": "finder-017",
      "category": "finder",
      "combo": "⌘ F",
      "title": "Finder Search",
      "description": "Начать поиск в Finder"
    },
    {
      "id": "finder-018",
      "category": "finder",
      "combo": "⌘ J",
      "title": "Show View Options",
      "description": "Параметры отображения"
    },
    {
      "id": "finder-019",
      "category": "finder",
      "combo": "⌘ K",
      "title": "Connect to Server",
      "description": "Подключиться к серверу"
    },
    {
      "id": "finder-020",
      "category": "finder",
      "combo": "⌘ Y",
      "title": "Quick Look",
      "description": "Быстрый просмотр"
    },
    {
      "id": "finder-021",
      "category": "finder",
      "combo": "Space",
      "title": "Quick Look Space",
      "description": "Быстрый просмотр через пробел"
    },
    {
      "id": "finder-022",
      "category": "finder",
      "combo": "⌘ 1",
      "title": "Icon View",
      "description": "Показать как значки"
    },
    {
      "id": "finder-023",
      "category": "finder",
      "combo": "⌘ 2",
      "title": "List View",
      "description": "Показать списком"
    },
    {
      "id": "finder-024",
      "category": "finder",
      "combo": "⌘ 3",
      "title": "Column View",
      "description": "Показать колонками"
    },
    {
      "id": "finder-025",
      "category": "finder",
      "combo": "⌘ 4",
      "title": "Gallery View",
      "description": "Показать галереей"
    },
    {
      "id": "finder-026",
      "category": "finder",
      "combo": "⇧ ⌘ C",
      "title": "Computer",
      "description": "Открыть Computer"
    },
    {
      "id": "finder-027",
      "category": "finder",
      "combo": "⇧ ⌘ D",
      "title": "Desktop",
      "description": "Открыть Desktop"
    },
    {
      "id": "finder-028",
      "category": "finder",
      "combo": "⇧ ⌘ F",
      "title": "Recents",
      "description": "Открыть Recents"
    },
    {
      "id": "finder-029",
      "category": "finder",
      "combo": "⇧ ⌘ G",
      "title": "Go to Folder",
      "description": "Перейти к папке"
    },
    {
      "id": "finder-030",
      "category": "finder",
      "combo": "⇧ ⌘ H",
      "title": "Home Folder",
      "description": "Открыть домашнюю папку"
    },
    {
      "id": "finder-031",
      "category": "finder",
      "combo": "⇧ ⌘ I",
      "title": "iCloud Drive",
      "description": "Открыть iCloud Drive"
    },
    {
      "id": "finder-032",
      "category": "finder",
      "combo": "⇧ ⌘ K",
      "title": "Network",
      "description": "Открыть Network"
    },
    {
      "id": "finder-033",
      "category": "finder",
      "combo": "⌥ ⌘ L",
      "title": "Downloads",
      "description": "Открыть Downloads"
    },
    {
      "id": "finder-034",
      "category": "finder",
      "combo": "⇧ ⌘ O",
      "title": "Documents Folder",
      "description": "Открыть Documents"
    },
    {
      "id": "finder-035",
      "category": "finder",
      "combo": "⇧ ⌘ R",
      "title": "AirDrop",
      "description": "Открыть AirDrop"
    },
    {
      "id": "finder-036",
      "category": "finder",
      "combo": "⌃ ⇧ ⌘ T",
      "title": "Add to Dock",
      "description": "Добавить выбранный объект в Dock"
    },
    {
      "id": "finder-037",
      "category": "finder",
      "combo": "⌃ ⌘ T",
      "title": "Add to Sidebar",
      "description": "Добавить выбранный объект в боковую панель"
    },
    {
      "id": "screenshots-001",
      "category": "screenshots",
      "combo": "⇧ ⌘ 3",
      "title": "Full Screen Screenshot",
      "description": "Сделать снимок всего экрана"
    },
    {
      "id": "screenshots-002",
      "category": "screenshots",
      "combo": "⇧ ⌘ 4",
      "title": "Selected Area Screenshot",
      "description": "Сделать снимок выбранной области"
    },
    {
      "id": "screenshots-003",
      "category": "screenshots",
      "combo": "⇧ ⌘ 5",
      "title": "Screenshot Toolbar",
      "description": "Открыть панель снимка и записи экрана"
    },
    {
      "id": "screenshots-004",
      "category": "screenshots",
      "combo": "⇧ ⌘ 6",
      "title": "Touch Bar Screenshot",
      "description": "Сделать снимок Touch Bar, если есть"
    },
    {
      "id": "screenshots-005",
      "category": "screenshots",
      "combo": "⌃ ⇧ ⌘ 3",
      "title": "Full Screen to Clipboard",
      "description": "Снимок всего экрана в буфер обмена"
    },
    {
      "id": "screenshots-006",
      "category": "screenshots",
      "combo": "⌃ ⇧ ⌘ 4",
      "title": "Area to Clipboard",
      "description": "Снимок области в буфер обмена"
    },
    {
      "id": "screenshots-007",
      "category": "screenshots",
      "combo": "⌃ ⇧ ⌘ 5",
      "title": "Options to Clipboard",
      "description": "Панель снимка с сохранением в буфер"
    },
    {
      "id": "screenshots-008",
      "category": "screenshots",
      "combo": "Space after ⇧ ⌘ 4",
      "title": "Capture Window",
      "description": "Снимок выбранного окна"
    },
    {
      "id": "screenshots-009",
      "category": "screenshots",
      "combo": "Esc",
      "title": "Cancel Screenshot",
      "description": "Отменить создание снимка"
    },
    {
      "id": "screenshots-010",
      "category": "screenshots",
      "combo": "⇧ ⌘ 4 then Space",
      "title": "Window Screenshot",
      "description": "Выбрать окно для снимка"
    },
    {
      "id": "screenshots-011",
      "category": "screenshots",
      "combo": "⇧ ⌘ 5 then Record",
      "title": "Screen Recording",
      "description": "Запись экрана через панель"
    },
    {
      "id": "screenshots-012",
      "category": "screenshots",
      "combo": "⌃ ⇧ ⌘ 6",
      "title": "Touch Bar to Clipboard",
      "description": "Снимок Touch Bar в буфер"
    },
    {
      "id": "text-001",
      "category": "text",
      "combo": "⌘ B",
      "title": "Bold",
      "description": "Жирный шрифт"
    },
    {
      "id": "text-002",
      "category": "text",
      "combo": "⌘ I",
      "title": "Italic",
      "description": "Курсив"
    },
    {
      "id": "text-003",
      "category": "text",
      "combo": "⌘ U",
      "title": "Underline",
      "description": "Подчеркнуть текст"
    },
    {
      "id": "text-004",
      "category": "text",
      "combo": "⌘ K",
      "title": "Insert Link",
      "description": "Вставить ссылку"
    },
    {
      "id": "text-005",
      "category": "text",
      "combo": "⌘ A",
      "title": "Select All Text",
      "description": "Выделить весь текст"
    },
    {
      "id": "text-006",
      "category": "text",
      "combo": "⌘ ←",
      "title": "Beginning of Line",
      "description": "Перейти в начало строки"
    },
    {
      "id": "text-007",
      "category": "text",
      "combo": "⌘ →",
      "title": "End of Line",
      "description": "Перейти в конец строки"
    },
    {
      "id": "text-008",
      "category": "text",
      "combo": "⌥ ←",
      "title": "Previous Word",
      "description": "Перейти на слово назад"
    },
    {
      "id": "text-009",
      "category": "text",
      "combo": "⌥ →",
      "title": "Next Word",
      "description": "Перейти на слово вперёд"
    },
    {
      "id": "text-010",
      "category": "text",
      "combo": "⌘ ↑",
      "title": "Top of Document",
      "description": "Перейти в начало документа"
    },
    {
      "id": "text-011",
      "category": "text",
      "combo": "⌘ ↓",
      "title": "Bottom of Document",
      "description": "Перейти в конец документа"
    },
    {
      "id": "text-012",
      "category": "text",
      "combo": "⇧ ⌘ ←",
      "title": "Select to Line Start",
      "description": "Выделить до начала строки"
    },
    {
      "id": "text-013",
      "category": "text",
      "combo": "⇧ ⌘ →",
      "title": "Select to Line End",
      "description": "Выделить до конца строки"
    },
    {
      "id": "text-014",
      "category": "text",
      "combo": "⇧ ⌥ ←",
      "title": "Select Previous Word",
      "description": "Выделить предыдущее слово"
    },
    {
      "id": "text-015",
      "category": "text",
      "combo": "⇧ ⌥ →",
      "title": "Select Next Word",
      "description": "Выделить следующее слово"
    },
    {
      "id": "text-016",
      "category": "text",
      "combo": "⇧ ⌘ ↑",
      "title": "Select to Top",
      "description": "Выделить до начала документа"
    },
    {
      "id": "text-017",
      "category": "text",
      "combo": "⇧ ⌘ ↓",
      "title": "Select to Bottom",
      "description": "Выделить до конца документа"
    },
    {
      "id": "text-018",
      "category": "text",
      "combo": "⌃ A",
      "title": "Move to Paragraph Start",
      "description": "В начало строки или абзаца"
    },
    {
      "id": "text-019",
      "category": "text",
      "combo": "⌃ E",
      "title": "Move to Paragraph End",
      "description": "В конец строки или абзаца"
    },
    {
      "id": "text-020",
      "category": "text",
      "combo": "⌃ F",
      "title": "Forward Character",
      "description": "На символ вперёд"
    },
    {
      "id": "text-021",
      "category": "text",
      "combo": "⌃ B",
      "title": "Backward Character",
      "description": "На символ назад"
    },
    {
      "id": "text-022",
      "category": "text",
      "combo": "⌃ P",
      "title": "Previous Line",
      "description": "На строку вверх"
    },
    {
      "id": "text-023",
      "category": "text",
      "combo": "⌃ N",
      "title": "Next Line",
      "description": "На строку вниз"
    },
    {
      "id": "text-024",
      "category": "text",
      "combo": "⌃ D",
      "title": "Delete Forward",
      "description": "Удалить символ справа"
    },
    {
      "id": "text-025",
      "category": "text",
      "combo": "⌃ H",
      "title": "Delete Backward",
      "description": "Удалить символ слева"
    },
    {
      "id": "text-026",
      "category": "text",
      "combo": "⌃ K",
      "title": "Delete to Line End",
      "description": "Удалить до конца строки"
    },
    {
      "id": "text-027",
      "category": "text",
      "combo": "⌥ Delete",
      "title": "Delete Previous Word",
      "description": "Удалить слово слева"
    },
    {
      "id": "text-028",
      "category": "text",
      "combo": "Fn Delete",
      "title": "Forward Delete",
      "description": "Удалить символ справа"
    },
    {
      "id": "text-029",
      "category": "text",
      "combo": "⌘ Delete",
      "title": "Delete to Line Start",
      "description": "Удалить до начала строки"
    },
    {
      "id": "text-030",
      "category": "text",
      "combo": "⌥ ⇧ ⌘ V",
      "title": "Paste and Match Style",
      "description": "Вставить без форматирования"
    },
    {
      "id": "documents-001",
      "category": "documents",
      "combo": "⌘ P",
      "title": "Print Document",
      "description": "Напечатать документ"
    },
    {
      "id": "documents-002",
      "category": "documents",
      "combo": "⌘ S",
      "title": "Save Document",
      "description": "Сохранить документ"
    },
    {
      "id": "documents-003",
      "category": "documents",
      "combo": "⇧ ⌘ S",
      "title": "Save As",
      "description": "Сохранить как"
    },
    {
      "id": "documents-004",
      "category": "documents",
      "combo": "⌘ O",
      "title": "Open Document",
      "description": "Открыть документ"
    },
    {
      "id": "documents-005",
      "category": "documents",
      "combo": "⌘ N",
      "title": "New Document",
      "description": "Создать документ"
    },
    {
      "id": "documents-006",
      "category": "documents",
      "combo": "⌘ W",
      "title": "Close Document",
      "description": "Закрыть документ"
    },
    {
      "id": "documents-007",
      "category": "documents",
      "combo": "⌘ D",
      "title": "Select Desktop in Dialog",
      "description": "Выбрать Desktop в диалоге открытия/сохранения"
    },
    {
      "id": "documents-008",
      "category": "documents",
      "combo": "⌘ Delete",
      "title": "Delete in Dialog",
      "description": "Удалить выбранный объект в диалоге"
    },
    {
      "id": "documents-009",
      "category": "documents",
      "combo": "Space",
      "title": "Quick Look in Dialog",
      "description": "Предпросмотр в диалоге"
    },
    {
      "id": "documents-010",
      "category": "documents",
      "combo": "⌘ L",
      "title": "Center Align",
      "description": "Выровнять по центру"
    },
    {
      "id": "documents-011",
      "category": "documents",
      "combo": "⇧ ⌘ {",
      "title": "Align Left",
      "description": "Выровнять по левому краю"
    },
    {
      "id": "documents-012",
      "category": "documents",
      "combo": "⇧ ⌘ }",
      "title": "Align Right",
      "description": "Выровнять по правому краю"
    },
    {
      "id": "documents-013",
      "category": "documents",
      "combo": "⌥ ⌘ C",
      "title": "Copy Style",
      "description": "Скопировать стиль"
    },
    {
      "id": "documents-014",
      "category": "documents",
      "combo": "⌥ ⌘ V",
      "title": "Paste Style",
      "description": "Вставить стиль"
    },
    {
      "id": "documents-015",
      "category": "documents",
      "combo": "⌥ ⇧ ⌘ V",
      "title": "Paste and Match Style",
      "description": "Вставить и согласовать стиль"
    },
    {
      "id": "documents-016",
      "category": "documents",
      "combo": "⌥ ⌘ T",
      "title": "Show Toolbar",
      "description": "Показать или скрыть панель инструментов"
    },
    {
      "id": "documents-017",
      "category": "documents",
      "combo": "⌘ ;",
      "title": "Spelling",
      "description": "Найти ошибки правописания"
    },
    {
      "id": "documents-018",
      "category": "documents",
      "combo": "⌘ :",
      "title": "Spelling and Grammar",
      "description": "Открыть правописание и грамматику"
    },
    {
      "id": "documents-019",
      "category": "documents",
      "combo": "⌥ ⌘ F",
      "title": "Search Field",
      "description": "Перейти в поле поиска"
    },
    {
      "id": "documents-020",
      "category": "documents",
      "combo": "⌘ Page Up",
      "title": "Previous Page",
      "description": "Предыдущая страница"
    },
    {
      "id": "documents-021",
      "category": "documents",
      "combo": "⌘ Page Down",
      "title": "Next Page",
      "description": "Следующая страница"
    },
    {
      "id": "system-001",
      "category": "system",
      "combo": "⌘ Space",
      "title": "Spotlight",
      "description": "Открыть Spotlight"
    },
    {
      "id": "system-002",
      "category": "system",
      "combo": "⌥ ⌘ Space",
      "title": "Finder Search Window",
      "description": "Открыть поиск Finder"
    },
    {
      "id": "system-003",
      "category": "system",
      "combo": "⌃ ⌘ Space",
      "title": "Character Viewer",
      "description": "Открыть emoji и символы"
    },
    {
      "id": "system-004",
      "category": "system",
      "combo": "⌃ ⌘ Q",
      "title": "Lock Screen",
      "description": "Заблокировать экран"
    },
    {
      "id": "system-005",
      "category": "system",
      "combo": "⌘ ⌥ Esc",
      "title": "Force Quit",
      "description": "Принудительно завершить приложение"
    },
    {
      "id": "system-006",
      "category": "system",
      "combo": "⌘ ⌥ ⏏",
      "title": "Sleep",
      "description": "Перевести Mac в сон"
    },
    {
      "id": "system-007",
      "category": "system",
      "combo": "⌃ ⇧ ⏏",
      "title": "Sleep Displays",
      "description": "Усыпить дисплеи"
    },
    {
      "id": "system-008",
      "category": "system",
      "combo": "⌃ ⌘ ⏏",
      "title": "Restart",
      "description": "Перезагрузить Mac"
    },
    {
      "id": "system-009",
      "category": "system",
      "combo": "⌃ ⌥ ⌘ ⏏",
      "title": "Shut Down",
      "description": "Выключить Mac"
    },
    {
      "id": "system-010",
      "category": "system",
      "combo": "⌃ Power",
      "title": "Power Dialog",
      "description": "Показать диалог выключения"
    },
    {
      "id": "system-011",
      "category": "system",
      "combo": "⌃ ⇧ Power",
      "title": "Sleep Displays Power",
      "description": "Усыпить дисплеи через Power"
    },
    {
      "id": "system-012",
      "category": "system",
      "combo": "⌃ ⌘ Power",
      "title": "Restart Power",
      "description": "Перезагрузить через Power"
    },
    {
      "id": "system-013",
      "category": "system",
      "combo": "⌃ ⌥ ⌘ Power",
      "title": "Shut Down Power",
      "description": "Выключить через Power"
    },
    {
      "id": "system-014",
      "category": "system",
      "combo": "Fn Q",
      "title": "Quick Note",
      "description": "Создать быструю заметку"
    },
    {
      "id": "system-015",
      "category": "system",
      "combo": "Fn C",
      "title": "Control Center",
      "description": "Открыть Control Center"
    },
    {
      "id": "system-016",
      "category": "system",
      "combo": "Fn H",
      "title": "Show Desktop",
      "description": "Показать рабочий стол"
    },
    {
      "id": "system-017",
      "category": "system",
      "combo": "Fn A",
      "title": "Dock",
      "description": "Показать Dock"
    },
    {
      "id": "system-018",
      "category": "system",
      "combo": "Fn N",
      "title": "Notification Center",
      "description": "Открыть Центр уведомлений"
    },
    {
      "id": "system-019",
      "category": "system",
      "combo": "Fn E",
      "title": "Emoji",
      "description": "Открыть emoji и символы"
    },
    {
      "id": "system-020",
      "category": "system",
      "combo": "⌘ Drag",
      "title": "Move Background Window",
      "description": "Переместить окно на фоне"
    },
    {
      "id": "system-021",
      "category": "system",
      "combo": "⌥ Click Menu",
      "title": "Alternate Menu Item",
      "description": "Показать альтернативные пункты меню"
    },
    {
      "id": "accessibility-001",
      "category": "accessibility",
      "combo": "⌥ ⌘ F5",
      "title": "Accessibility Shortcuts",
      "description": "Открыть панель быстрых команд универсального доступа"
    },
    {
      "id": "accessibility-002",
      "category": "accessibility",
      "combo": "⌃ ⌥ ⌘ 8",
      "title": "Invert Colors",
      "description": "Инвертировать цвета"
    },
    {
      "id": "accessibility-003",
      "category": "accessibility",
      "combo": "⌃ ⌥ ⌘ ,",
      "title": "Reduce Contrast",
      "description": "Уменьшить контраст"
    },
    {
      "id": "accessibility-004",
      "category": "accessibility",
      "combo": "⌃ ⌥ ⌘ .",
      "title": "Increase Contrast",
      "description": "Увеличить контраст"
    },
    {
      "id": "accessibility-005",
      "category": "accessibility",
      "combo": "⌥ ⌘ 8",
      "title": "Zoom On / Off",
      "description": "Включить или выключить масштабирование"
    },
    {
      "id": "accessibility-006",
      "category": "accessibility",
      "combo": "⌥ ⌘ =",
      "title": "Zoom In",
      "description": "Увеличить масштаб экрана"
    },
    {
      "id": "accessibility-007",
      "category": "accessibility",
      "combo": "⌥ ⌘ -",
      "title": "Zoom Out",
      "description": "Уменьшить масштаб экрана"
    },
    {
      "id": "accessibility-008",
      "category": "accessibility",
      "combo": "⌃ ⌥ ⌘ /",
      "title": "Zoom Options",
      "description": "Настройки масштабирования"
    },
    {
      "id": "accessibility-009",
      "category": "accessibility",
      "combo": "⌘ F5",
      "title": "VoiceOver",
      "description": "Включить или выключить VoiceOver"
    },
    {
      "id": "accessibility-010",
      "category": "accessibility",
      "combo": "⌃ ⌥ F8",
      "title": "VoiceOver Utility",
      "description": "Открыть утилиту VoiceOver"
    },
    {
      "id": "accessibility-011",
      "category": "accessibility",
      "combo": "⌃ ⌥ ⇧ ↓",
      "title": "Interact",
      "description": "Войти во взаимодействие VoiceOver"
    },
    {
      "id": "accessibility-012",
      "category": "accessibility",
      "combo": "⌃ ⌥ ⇧ ↑",
      "title": "Stop Interacting",
      "description": "Выйти из взаимодействия VoiceOver"
    },
    {
      "id": "safari-001",
      "category": "safari",
      "combo": "⌘ L",
      "title": "Address Bar",
      "description": "Перейти в адресную строку"
    },
    {
      "id": "safari-002",
      "category": "safari",
      "combo": "⌘ R",
      "title": "Reload Page",
      "description": "Обновить страницу"
    },
    {
      "id": "safari-003",
      "category": "safari",
      "combo": "⌥ ⌘ R",
      "title": "Reload Without Cache",
      "description": "Обновить без кеша"
    },
    {
      "id": "safari-004",
      "category": "safari",
      "combo": "⌘ .",
      "title": "Stop Loading",
      "description": "Остановить загрузку страницы"
    },
    {
      "id": "safari-005",
      "category": "safari",
      "combo": "⌘ T",
      "title": "New Tab",
      "description": "Открыть новую вкладку"
    },
    {
      "id": "safari-006",
      "category": "safari",
      "combo": "⇧ ⌘ T",
      "title": "Reopen Closed Tab",
      "description": "Открыть закрытую вкладку"
    },
    {
      "id": "safari-007",
      "category": "safari",
      "combo": "⌘ N",
      "title": "New Window",
      "description": "Открыть новое окно"
    },
    {
      "id": "safari-008",
      "category": "safari",
      "combo": "⇧ ⌘ N",
      "title": "New Private Window",
      "description": "Открыть приватное окно"
    },
    {
      "id": "safari-009",
      "category": "safari",
      "combo": "⌘ W",
      "title": "Close Tab",
      "description": "Закрыть вкладку"
    },
    {
      "id": "safari-010",
      "category": "safari",
      "combo": "⌥ ⌘ W",
      "title": "Close Other Tabs",
      "description": "Закрыть остальные вкладки"
    },
    {
      "id": "safari-011",
      "category": "safari",
      "combo": "⌘ 1",
      "title": "Tab 1",
      "description": "Перейти к первой вкладке"
    },
    {
      "id": "safari-012",
      "category": "safari",
      "combo": "⌘ 9",
      "title": "Last Tab",
      "description": "Перейти к последней вкладке"
    },
    {
      "id": "safari-013",
      "category": "safari",
      "combo": "⌃ Tab",
      "title": "Next Tab",
      "description": "Следующая вкладка"
    },
    {
      "id": "safari-014",
      "category": "safari",
      "combo": "⌃ ⇧ Tab",
      "title": "Previous Tab",
      "description": "Предыдущая вкладка"
    },
    {
      "id": "safari-015",
      "category": "safari",
      "combo": "⌘ F",
      "title": "Find on Page",
      "description": "Найти на странице"
    },
    {
      "id": "safari-016",
      "category": "safari",
      "combo": "⌘ G",
      "title": "Find Next",
      "description": "Следующее совпадение"
    },
    {
      "id": "safari-017",
      "category": "safari",
      "combo": "⇧ ⌘ G",
      "title": "Find Previous",
      "description": "Предыдущее совпадение"
    },
    {
      "id": "safari-018",
      "category": "safari",
      "combo": "⌘ D",
      "title": "Add Bookmark",
      "description": "Добавить закладку"
    },
    {
      "id": "safari-019",
      "category": "safari",
      "combo": "⌥ ⌘ B",
      "title": "Show Bookmarks",
      "description": "Показать закладки"
    },
    {
      "id": "safari-020",
      "category": "safari",
      "combo": "⇧ ⌘ L",
      "title": "Show Sidebar",
      "description": "Показать боковую панель"
    },
    {
      "id": "safari-021",
      "category": "safari",
      "combo": "⌘ Y",
      "title": "History",
      "description": "Показать историю"
    },
    {
      "id": "safari-022",
      "category": "safari",
      "combo": "⌥ ⌘ L",
      "title": "Downloads",
      "description": "Показать загрузки"
    },
    {
      "id": "safari-023",
      "category": "safari",
      "combo": "⌘ +",
      "title": "Zoom In",
      "description": "Увеличить страницу"
    },
    {
      "id": "safari-024",
      "category": "safari",
      "combo": "⌘ -",
      "title": "Zoom Out",
      "description": "Уменьшить страницу"
    },
    {
      "id": "safari-025",
      "category": "safari",
      "combo": "⌘ 0",
      "title": "Actual Size",
      "description": "Реальный размер"
    }
  ]
};

const assetIconNames = new Set([
  'all-shortcut',
  'basic',
  'app-switch',
  'window-tabs',
  'finder-file',
  'screenshot',
  'edit-text',
  'documents',
  'systems',
  'accessibility',
  'safari-web'
]);

function assetIcon(name){
  const safe = String(name || 'all-shortcut').replace(/[^a-z0-9-]/gi,'');
  // ВАЖНО: здесь намеренно используются ТОЧНЫЕ имена файлов.
  // Просто замени SVG в assets/icons/ на свои оригиналы с такими же именами.
  return `<span class="asset-icon" style="--icon-url:url('assets/icons/${safe}.svg')" aria-hidden="true"></span>`;
}

const icons = {
  command:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M8 8h8v8H8z"/><path d="M8 8H6a3 3 0 1 1 3-3v3M16 8V6a3 3 0 1 1 3 3h-3M16 16h2a3 3 0 1 1-3 3v-3M8 16v2a3 3 0 1 1-3-3h3"/></svg>',
  grid:'<svg class="svg-icon" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/></svg>',
  clipboard:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M9 4h6l1 2h3v15H5V6h3z"/><path d="M9 4h6v4H9z"/></svg>',
  layers:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M5 8h11a3 3 0 0 1 3 3v8H8a3 3 0 0 1-3-3z"/><path d="M8 5h11v11"/></svg>',
  window:'<svg class="svg-icon" viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 9h18M7 5v4"/></svg>',
  folder:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M3 7h7l2 3h9v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><path d="M3 7V5h7l2 2"/></svg>',
  pencil:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M4 20l4.5-1 10-10a2.2 2.2 0 0 0-3.1-3.1l-10 10z"/><path d="M13.5 7.5l3 3"/></svg>',
  camera:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M5 8h3l2-3h4l2 3h3a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-8a2 2 0 0 1 2-2z"/><circle cx="12" cy="14" r="3.5"/></svg>',
  shield:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M12 3l8 3v6c0 5-3.4 8.5-8 9-4.6-.5-8-4-8-9V6z"/><path d="M9 12l2 2 4-5"/></svg>',
  document:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M6 3h8l4 4v14H6z"/><path d="M14 3v5h4"/></svg>',
  search:'<svg class="svg-icon" viewBox="0 0 24 24"><circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/></svg>',
  moon:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M20 15.5A8.5 8.5 0 0 1 8.5 4 7 7 0 1 0 20 15.5z"/></svg>',
  sun:'<svg class="svg-icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M4.93 19.07l1.41-1.41M17.66 6.34l1.41-1.41"/></svg>',
  globe:'<svg class="svg-icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3a14 14 0 0 1 0 18M12 3a14 14 0 0 0 0 18"/></svg>',
  sparkles:'<svg class="svg-icon" viewBox="0 0 24 24"><path d="M12 3l1.7 5.3L19 10l-5.3 1.7L12 17l-1.7-5.3L5 10l5.3-1.7z"/><path d="M19 15l.8 2.2L22 18l-2.2.8L19 21l-.8-2.2L16 18l2.2-.8z"/></svg>'
};
const keyIcons = {
  '⌘': '⌘',
  '⇧':'<svg viewBox="0 0 24 24"><path d="M12 4l7 8h-4v7H9v-7H5z"/></svg>',
  '⌥':'<svg viewBox="0 0 24 24"><path d="M4 7h5l6 10h5M15 7h5"/></svg>',
  '⌃':'<svg viewBox="0 0 24 24"><path d="M6 14l6-6 6 6"/></svg>',
  '⏏':'<svg viewBox="0 0 24 24"><path d="M12 5l7 8H5zM5 18h14"/></svg>'
};
const aliases = {cmd:'⌘', command:'⌘', shift:'⇧', option:'⌥', opt:'⌥', control:'⌃', ctrl:'⌃'};
const state = { categories: [], shortcuts: [], active: 'all', query: '' };
const nav = document.getElementById('categoryNav');
const cards = document.getElementById('cards');
const empty = document.getElementById('empty');
const searchInput = document.getElementById('searchInput');
const totalCount = document.getElementById('totalCount');
const visibleCount = document.getElementById('visibleCount');
const categoryCount = document.getElementById('categoryCount');
function hydrateIcons(root=document){ root.querySelectorAll('[data-icon]').forEach(el => el.innerHTML = assetIconNames.has(el.dataset.icon) ? assetIcon(el.dataset.icon) : (icons[el.dataset.icon] || icons.grid)); root.querySelectorAll('[data-key]').forEach(el => el.innerHTML = keyIcons[aliases[el.dataset.key] || el.dataset.key] || (aliases[el.dataset.key] || el.dataset.key)); }
function normalize(str){ return String(str).toLowerCase().replace(/command|cmd/g,'⌘').replace(/shift/g,'⇧').replace(/option|opt/g,'⌥').replace(/control|ctrl/g,'⌃').replace(/\s+/g,' ').trim(); }
function keycap(token){ const safe = token.replace(/</g,'&lt;').replace(/>/g,'&gt;'); return `<span class="keycap">${keyIcons[token] || safe}</span>`; }
function combo(str){ return String(str).split(' ').map(keycap).join(''); }
function countFor(categoryId){ return categoryId === 'all' ? state.shortcuts.length : state.shortcuts.filter(s => s.category === categoryId).length; }
function colorOf(categoryId){ return state.categories.find(c => c.id === categoryId)?.color || 'blue'; }
function iconOf(categoryId){ return state.categories.find(c => c.id === categoryId)?.icon || 'grid'; }
function renderNav(){
  nav.innerHTML = state.categories.map(c => `<button class="${state.active===c.id?'active':''}" data-id="${c.id}"><span class="nav-icon ${c.color}">${assetIcon(c.icon)}</span><b>${c.title}</b><em>${countFor(c.id)}</em></button>`).join('');
  nav.querySelectorAll('button').forEach(btn => btn.onclick = () => { state.active = btn.dataset.id; document.querySelector('.quick').classList.remove('active'); render(); });
  document.querySelector('.quick').onclick = () => { state.active = 'all'; document.querySelector('.quick').classList.add('active'); render(); };
  document.querySelector('.quick').classList.toggle('active', state.active === 'all');
}
function filtered(){
  const q = normalize(state.query);
  return state.shortcuts.filter(s => {
    const inCat = state.active === 'all' || s.category === state.active;
    if(!inCat) return false;
    if(!q) return true;
    const cat = state.categories.find(c => c.id === s.category);
    const hay = normalize(`${s.combo} ${s.title} ${s.description} ${cat?.title || ''}`);
    return hay.includes(q);
  });
}
function groupByCategory(list){ return state.categories.map(c => ({...c, items: list.filter(s => s.category === c.id)})).filter(c => c.items.length); }
function render(){
  renderNav();
  const list = filtered();
  visibleCount.textContent = list.length;
  empty.classList.toggle('hidden', list.length > 0);
  cards.classList.toggle('hidden', list.length === 0);
  const groups = groupByCategory(list);
  const single = state.active !== 'all' && groups.length === 1;
  cards.classList.toggle('single-category', single);
  cards.innerHTML = groups.map(group => `<article class="card ${single ? 'card-expanded' : ''}"><div class="card-head"><span class="cat-icon ${group.color}">${assetIcon(group.icon)}</span><div><div class="card-title ${group.color}">${group.title}</div><div class="card-subtitle">${group.description}</div></div><span class="badge">${group.items.length}</span></div><div class="shortcuts-list">${group.items.map(s => `<div class="shortcut-row"><div class="combo">${combo(s.combo)}</div><div class="label"><strong>${s.title}</strong><span>${s.description}</span></div></div>`).join('')}</div></article>`).join('');
}
async function init(){
  hydrateIcons();
  let data = null;
  try { data = await fetch('data/shortcuts.json').then(r => r.ok ? r.json() : null); } catch(e) { data = null; }
  if(!data) data = EMBEDDED_SHORTCUTS_DATA;
  state.categories = data.categories;
  state.shortcuts = data.shortcuts;
  totalCount.textContent = state.shortcuts.length;
  categoryCount.textContent = state.categories.length;
  searchInput.addEventListener('input', e => { state.query = e.target.value; render(); });
  document.getElementById('themeToggle').onclick = () => {
    const dark = document.documentElement.dataset.theme === 'dark';
    document.documentElement.dataset.theme = dark ? 'light' : 'dark';
    document.getElementById('themeToggle').innerHTML = dark ? icons.moon : icons.sun;
  };
  render();
}
init();
