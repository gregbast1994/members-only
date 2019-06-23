module ApplicationHelper
    def full_title(title = '')
        base = "Members Only"
        title.empty? ? base : title + ' | ' + base
    end
end
