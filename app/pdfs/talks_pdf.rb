class TalksPdf < PdfBase

  include Rails.application.routes.url_helpers

  def initialize(talks, assignments, view)
    @talks = talks
    @view = view
    @assignments = assignments

    header
    schedule
  end

  def header
    text "Talk Schedule #{@date_range}", size: 20, style: :bold
    text "Printed: #{Date.today.strftime('%D')}", size: 12
    move_down 10
  end

  def schedule
    @talks.group_by(&:date).each do |date, talk_group|
      assignments = @assignments.select{ |a| a.date == date }
      text date.strftime("%b-%e"), size: 11, style: :bold
      if talk_group.first.special?
        move_down 8
        text talk_group.first.kind.titleize, size: 14, style: :bold
      else
        talk_group.group_by(&:in_out_or_special).each do |kind, talks|

          unless kind == "Incoming"
            move_down 10
            text "#{pluralize(talks.count, 'Outgoing Speaker')}", size: 10, style: :italic
          end

          talks.sort.each do |talk|
            move_down 8
            if talk.incoming?
              indent 8 do
                text talk.outline.title.titleize, style: :bold
                text "#{talk.speaker.full_name} from #{talk.speaker.congregation.name.titleize}"
                text "Host group: #{talk.group.full_name}"
              end

            else
              indent 8 do
                text "#{talk.speaker.full_name} to #{talk.congregation.name.titleize}"
                indent 10 do
                  text talk.outline.title, style: :italic
                end
              end
            end
          end
        end # end kind, talks

        unless assignments.blank?
          indent 8 do
            assignments.each do |as|
              text "#{as.kind.titleize}: #{as.person.full_name}", style: :italic
            end
          end
        end
      end

      move_down 8
      stroke_horizontal_rule
      move_down 8
    end
  end

end
