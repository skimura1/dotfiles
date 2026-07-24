function todays_agenda --description "Show today's/latest daily note items in full, for fish_greeting"
    set -l root ~/notes/project_tasks
    set -l latest_daily (find $root/daily -maxdepth 1 -name '*.md' -type f 2>/dev/null | xargs ls -t 2>/dev/null | head -n 1)

    if test -z "$latest_daily"
        return
    end

    set -l items (grep -n '^\s*- \[ \]' $latest_daily)
    if test (count $items) -gt 0
        set_color cyan --bold
        echo "Today"
        set_color normal
        for entry in $items
            set -l text (string replace -r '^\d+:\s*-\s*\[ \]\s*' '' -- $entry)
            echo "  ○ $text"
        end
    end
end
