class Thing::Cell < Cell::Concept
  include ::Cell::Hamlit
  include ActionView::Helpers::DateHelper
  include ApplicationController::Rails::Timeago::Helper

  property :name
  property :created_at

  def show
    render
  end

  def classes
    classes = %w(box small-3 columns)
    classes << 'end' if options[:last] == model
    classes
  end

  def created_at
    timeago_tag(super)
  end

  def name_link
    link_to name, model
  end

  def edit_link
    link_to 'Edit', edit_thing_path(model)
  end

  def new_comment_link
    link_to 'Add comment', new_thing_comment_path(model)
  end

  class Grid < Cell::Concept
    def show
      things = Thing.all.order(created_at: :desc)
      concept('thing/cell', collection: things, last: things.last)
    end
  end
end