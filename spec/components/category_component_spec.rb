# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoryComponent, type: :component do
  it "render an empty category" do
    render_inline(described_class.new)
    expect(page).to have_text("All")
  end

  it "render a category" do
    category = create(:category)
    render_inline(described_class.new(category:))
    expect(page).to have_text(category.name)
  end
end
