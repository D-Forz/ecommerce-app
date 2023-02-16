# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoryComponent, type: :component do
  it "should render an empty category" do
    render_inline(CategoryComponent.new)
    expect(page).to have_text("All")
  end

  it "should render a category" do
    category = create(:category)
    render_inline(CategoryComponent.new(category:))
    expect(page).to have_text(category.name)
  end
end
