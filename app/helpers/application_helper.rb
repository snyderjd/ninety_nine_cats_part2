module ApplicationHelper
    def auth_token
        "<input 
            type=\"hidden\"
            name=\"authenticity_token\"
            value=\"#{form_authenticity_token}\"
        />".html_safe
    end

    # def highlight(text)
    #     "<strong class=\"highlight\">#{h(text)}</strong>".html_safe
    #   end
end
