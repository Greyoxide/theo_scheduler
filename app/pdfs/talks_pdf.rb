class TalksPdf < PdfBase

  include Rails.application.routes.url_helpers

  def initialize(talks, view)
    @talks = talks
    @view = view

    header
    schedule
  end

  def header
    text "Talk Schedule #{@date_range}", size: 20, style: :bold
    move_down 30
  end

  def schedule
    @talks.group_by(&:date).each do |date, talk_group|
      text date.strftime("%b-%e"), size: 11, style: :bold
      talk_group.group_by(&:kind).each do |kind, talks|
        unless kind == "Incoming"
          move_down 10
          text "#{pluralize(talks.count, 'Outgoing Speaker')}", size: 10, style: :italic
        end
        talks.sort.each do |talk|
          move_down 10
          if talk.incoming?
            indent 10 do
              text talk.outline.title.titleize, style: :bold
              text "#{talk.speaker.full_name} from #{talk.speaker.congregation.name.titleize}"
              text "Host group: #{talk.group.full_name}"
            end
          else
            indent 10 do
              text "#{talk.speaker.full_name} to #{talk.congregation.name.titleize}"
              indent 10 do
                text talk.outline.title, style: :italic
              end
            end
          end
        end
      end # end kind, talks
      move_down 10
      stroke_horizontal_rule
      move_down 10
    end
  end

end