function todos --description "Aggregate open tasks across ~/notes/project_tasks"
    set -l root ~/notes/project_tasks
    set -l total 0

    if not test -d $root
        echo "No $root directory found."
        return 1
    end

    # All daily notes, newest first — carries forward unfinished items from past days
    for file in (find $root/daily -maxdepth 1 -name '*.md' -type f 2>/dev/null | xargs ls -t 2>/dev/null)
        set -l items (grep -n '^\s*- \[ \]' $file)
        if test (count $items) -gt 0
            set_color cyan --bold
            echo "daily ("(basename $file)")"
            set_color normal
            for entry in $items
                set -l text (string replace -r '^\d+:\s*-\s*\[ \]\s*' '' -- $entry)
                echo "  ○ $text"
            end
            set total (math $total + (count $items))
            echo ""
        end
    end

    # Project folders — skip reserved names
    for dir in $root/*/
        set -l name (basename $dir)
        if contains $name daily templates done
            continue
        end

        for file in (find $dir -maxdepth 1 -name '*.md' -type f)
            set -l items (grep -n '^\s*- \[ \]' $file)
            if test (count $items) -gt 0
                set_color cyan --bold
                echo $name
                set_color normal
                for entry in $items
                    set -l text (string replace -r '^\d+:\s*-\s*\[ \]\s*' '' -- $entry)
                    echo "  ○ $text"
                end
                set total (math $total + (count $items))
                echo ""
            end
        end
    end

    if test $total -eq 0
        set_color green
        echo "No open tasks."
        set_color normal
    else
        set_color yellow
        echo "$total open across tracked notes."
        set_color normal
    end
end
