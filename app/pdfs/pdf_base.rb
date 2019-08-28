class PdfBase
  # I feel like this is where I should make all of my delclarations that are available to all PDF classes

  include Prawn::View
  include ActionView::Helpers::TextHelper
  # First up, let's get a global document header.
  def header
  end
end
