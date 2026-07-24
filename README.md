# Конфигурация Neovim

Минимальная ежедневная IDE-конфигурация для Rust с поддержкой Python, JavaScript, TypeScript и Vue. Основана на Neovim 0.12 и встроенном менеджере пакетов `vim.pack` — без Lazy.nvim.

![Dashboard](assets/dashboard.png)
![Editor](assets/editor.png)

## Идея

Конфиг намеренно не дублирует одинаковые инструменты. Snacks закрывает Explorer, поиск, терминал, Dashboard, уведомления и LazyGit; отдельные Telescope, Neo-tree, terminal- и session-плагины не нужны.

Основной принцип: встроенные возможности Neovim и небольшие модули `mini.nvim` там, где они не уступают крупному отдельному плагину.

## Что входит

### Интерфейс и навигация

- `snacks.nvim` — Dashboard, Explorer, поиск файлов и текста, терминал, Scratch TODO, уведомления, изображения и LazyGit;
- `kanagawa.nvim` — прозрачная тема Wave;
- `lualine.nvim` — компактная статусная строка;
- `which-key.nvim` — подсказки команд;
- `mini.icons` — иконки файлов.

### Редактирование

- `blink.cmp` — completion и подсказки сигнатур;
- `nvim-treesitter` — точная подсветка и отступы;
- `mini.ai`, `mini.pairs`, `mini.surround` — текстовые объекты, парные символы и окружения;
- `nvim-ts-autotag` — работа с HTML/Vue/JSX-тегами;
- `conform.nvim` — форматирование при сохранении.

### Языки, Rust и Git

- native LSP Neovim + Mason;
- `rustaceanvim` и `crates.nvim` для Rust/Cargo;
- Ruff и Ty для Python;
- VTSLS, Vue LS, ESLint, UnoCSS, CSS LS, HTML LS и Emmet для фронтенда;
- `gitsigns.nvim` для изменений текущего файла, LazyGit через Snacks — для staging, commit и push.

## Старт

- `nvim` — Dashboard с недавними проектами; выбор проекта сразу меняет рабочую директорию и открывает Explorer.
- `nvim .` — Dashboard с логотипом и Explorer текущего проекта.

## Основные клавиши

| Клавиша | Действие |
| --- | --- |
| `<leader>e` | Explorer |
| `<leader><leader>` | поиск файла |
| `<leader>/` | поиск текста по проекту |
| `<C-/>` | терминал Snacks |
| `<leader>gg` | LazyGit |
| `<leader>.` | проектный Scratch/TODO |
| `<leader>x` | переключить Markdown-чекбокс в Scratch |
| `<leader>n` | история уведомлений |
| `gd` / `gr` | определение / references |
| `<leader>ci` | implementations |
| `<leader>d` | полная диагностика под курсором |
| `<leader>ca` / `<leader>cr` | code action / rename |
| `<leader>cl` | выполнить Code Lens, например Rust Run/Debug |

## Требования и установка

- Neovim 0.12 или новее;
- Git;
- Nerd Font для иконок;
- языковые серверы и форматтеры из Mason либо установленные в системе;
- Ghostty для встроенного отображения изображений; ImageMagick расширяет поддержку форматов, кроме PNG.

```sh
git clone git@github.com:nequamy/nqvim.git ~/.config/nvim
nvim
```

При первом запуске `vim.pack` установит плагины из lockfile. Проверить окружение можно командой `:checkhealth`.

## Структура

```text
init.lua             точка входа и тема
lua/config.lua       базовые опции Neovim
lua/plugins.lua      плагины и их настройка
lua/keymap.lua       пользовательские клавиши
lua/lsp.lua          включение LSP и диагностика
lua/autocmd.lua      Explorer при nvim . и автосохранение
lua/settings/        настройки Snacks, Lualine, Treesitter и Which-key
lsp/                 отдельные конфиги языковых серверов
```
