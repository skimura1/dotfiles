# Fish config: todo/greeting system

This directory's `functions/` contains a small set of interlocking commands for
tracking tasks in `~/notes/project_tasks/`. Fish autoloads one function per
file, matched by filename — keep that 1:1 mapping when editing, or a function
called from another function (e.g. `fish_greeting` calling `todos_summary`)
will fail with "Unknown command" in a fresh shell, since the file never gets
loaded.

## Layout

- `~/notes/project_tasks/daily/MMDDYYYY.md` — one file per day, created from
  `~/notes/project_tasks/templates/daily.md` (`{{title}}` placeholder filled
  with `date "+%B %d, %Y"`). Holds today's task checklist under `## Tasks`.
- `~/notes/project_tasks/<project_name>/todo.md` — per-project task list,
  created from `~/notes/project_tasks/templates/todo.md` (`{{title}}` filled
  with the raw project name) the first time `td <project_name>` is run for
  that project. Existing todo.md files are never overwritten by the template.
- `~/Documents/notes/todo.md` — general/misc todo file, unrelated to the
  per-project system.
- `~/notes/project_tasks/{done,templates}` and the `daily` folder itself are
  reserved names skipped when scanning "project folders".

## Commands

- `td` — opens today's daily note in nvim, creating it from the template
  first if it doesn't exist yet. (`functions/td.fish`)
- `td <project_name>` — opens `~/notes/project_tasks/<project_name>/todo.md`
  in nvim, creating the project directory and seeding todo.md from the
  template if needed.
- `td list` — prints existing project folder names (same reserved-name
  exclusions as `todos`), so you don't have to `ls` the directory to remember
  what to pass as `<project_name>`.
- `td complete <project_name>` — moves
  `~/notes/project_tasks/<project_name>` to
  `~/notes/project_tasks/done/<project_name>`. Errors if no name is given or
  the project doesn't exist.
- `todos` — prints every open (`- [ ]`) checklist item across *all* daily
  notes (newest first, one section per date — so unfinished items from prior
  days carry forward instead of disappearing once a new daily note is
  created) and all project todo files, with colored section headers and a
  running total. (`functions/todos.fish`)
- `todays_agenda` — prints just today's open checklist items, used by the
  greeting. Deliberately scoped to today's file only — overdue items from
  earlier daily notes surface via `todos`/`todos_summary`, not here.
  (`functions/todays_agenda.fish`)
- `todos_summary` — prints a one-line count of open tasks *excluding* today's
  daily note (today's items are shown separately by `todays_agenda`), but
  *including* unfinished items from earlier daily notes.
  (`functions/todos_summary.fish`)
- `fish_greeting` — overrides the builtin greeting; calls `todays_agenda`
  then `todos_summary` on every new interactive shell.
  (`functions/fish_greeting.fish`)

## History / decisions from this session

- `config.fish` used to `set fish_greeting ""` — removed, since it's dead:
  a user-defined `fish_greeting` function fully shadows the builtin one that
  variable controls.
- `config.fish` used to have `alias todo="nvim ~/Documents/notes/todo.md"`.
  Removed in favor of `td` (no args), which does the same thing plus the
  daily-note and per-project cases. Don't reintroduce a `todo` alias/function
  — it will silently shadow `td`'s sibling behavior and is confusing to have
  both.
- `todos_summary` and `todays_agenda` were originally written as second
  functions inside `todos.fish` / `fish_greeting.fish`'s call target — this
  broke autoloading (see note at top). Each now lives in its own file.
- `td` was deliberately kept simple: it just opens files in `$EDITOR`/nvim,
  no in-place task insertion via CLI args. An earlier version tried to parse
  and edit the markdown directly (find/replace the empty `- [ ] ` placeholder
  line, insert new lines via awk/fish list slicing) — scrapped as
  over-engineered for what's needed.
