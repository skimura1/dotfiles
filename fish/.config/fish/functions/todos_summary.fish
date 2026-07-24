function todos_summary --description "One-line cross-project backlog count, for fish_greeting (excludes today's agenda, shown separately)"
    set -l root ~/notes/project_tasks
    set -l total 0

    if not test -d $root
        return
    end

    # Daily notes except the latest (today's — shown separately by todays_agenda)
    set -l daily_files (find $root/daily -maxdepth 1 -name '*.md' -type f 2>/dev/null | xargs ls -t 2>/dev/null)
    if test (count $daily_files) -gt 1
        for file in $daily_files[2..-1]
            set -l n (grep -c '^\s*- \[ \]' $file 2>/dev/null)
            set total (math $total + $n)
        end
    end

    for dir in $root/*/
        set -l name (basename $dir)
        if contains $name daily templates done
            continue
        end
        for file in (find $dir -maxdepth 1 -name '*.md' -type f)
            set -l n (grep -c '^\s*- \[ \]' $file 2>/dev/null)
            set total (math $total + $n)
        end
    end

    if test $total -gt 0
        echo "$total open task(s) — run 'todos' for detail"
    end
end
