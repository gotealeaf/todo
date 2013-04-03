class TodoDecorator
  attr_reader :todo

  def initialize(todo)
    @todo = todo
  end

  def display_text
    todo.name + tag_text
  end

  private

  def tag_text
    if tags.any?
      " (#{tags.one? ? 'tag' : 'tags' }: #{tags.map(&:name).first(4).join(", ")}#{', more...' if tags.count > 4})"
    else
      ""
    end
  end

end
