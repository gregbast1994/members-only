module ApplicationHelper
    def full_title(title = '')
        base = "Members Only"
        title.empty? ? base : title.first(50) + ' | ' + base
    end
end
