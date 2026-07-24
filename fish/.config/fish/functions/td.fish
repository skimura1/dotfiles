function td --description "Open today's daily note; with a project name, open that project's todo.md"
    if test "$argv[1]" = list
        set -l root ~/notes/project_tasks
        for dir in $root/*/
            set -l name (basename $dir)
            if not contains $name daily templates done
                echo $name
            end
        end
        return
    end

    if test "$argv[1]" = complete
        set -l root ~/notes/project_tasks
        set -l name $argv[2]

        if test -z "$name"
            echo "usage: td complete <project_name>" >&2
            return 1
        end

        set -l src $root/$name
        if not test -d $src
            echo "no such project: $name" >&2
            return 1
        end

        mkdir -p $root/done
        mv $src $root/done/$name
        set_color green
        echo "Moved $name to done/"
        set_color normal
        return
    end

    if test (count $argv) -eq 0
        set -l root ~/notes/project_tasks
        set -l daily_dir $root/daily
        set -l template $root/templates/daily.md
        set -l file $daily_dir/(date +%m%d%Y).md

        mkdir -p $daily_dir

        if not test -f $file
            set -l title (date "+%B %d, %Y")
            if test -f $template
                string replace -- '{{title}}' $title <$template >$file
            else
                printf "# %s\n\n## Tasks\n\n## Notes\n\n" $title >$file
            end
        end

        nvim $file
        return
    end

    set -l root ~/notes/project_tasks
    set -l dir $root/$argv[1]
    set -l file $dir/todo.md
    set -l template $root/templates/todo.md

    mkdir -p $dir

    if not test -f $file
        if test -f $template
            string replace -- '{{title}}' $argv[1] <$template >$file
        else
            printf "# %s\n\n## Tasks\n\n## Notes\n\n" $argv[1] >$file
        end
    end

    nvim $file
end
