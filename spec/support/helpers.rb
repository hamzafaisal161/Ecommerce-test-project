# frozen_string_literal: true

module Helpers
  def redirection(path)
    expect(response).to redirect_to(path)
  end

  def template_render(action)
    expect(response).to render_template(action)
  end
end
