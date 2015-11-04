module Remotipart

 module RenderOverrides

    def render_with_remotipart *args

      render_without_remotipart *args

      if remotipart_submitted?

        textarea_body = response.content_type == 'text/html' ? html_escape(response.body) : response.body

        response.body = textarea_body

        response.content_type = Mime::HTML

      end

      response_body

    end

  end

end