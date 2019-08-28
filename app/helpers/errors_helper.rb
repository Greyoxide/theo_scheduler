module ErrorsHelper
  def errors(object)
    if object.errors.any?
      content_tag :div do
        content_tag :ul, class: "errors" do
          object.errors.full_messages.collect do |error|
            content_tag :li do
              content_tag :p, error
            end
          end.join.html_safe
        end
      end
    end
  end
end
