module ApplicationHelper
  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "remove_fields(this)")
  end

  def current_user? user
    user == current_user
  end

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to name, "#", class: "add_fields",
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def answer_class answer
    answer.try(:is_correct?) ? "correct_answer" : "well"
  end

  def get_answer_correct word
    word.answers.each {|e| return e if e.is_correct?}
  end

  def update_status lesson
    "doing" if lesson.ready?
  end

  def link_to_object activity
    object = binding.eval("#{activity.trackable_type}.find_by_id activity.trackable_id")
    if object.nil?
      link_to t("error._error"), help_path
    else
      object = object.category if object.class == Lesson
      link_to truncate(object.name, length: Settings.length_title), object
    end
  end

  def activity_title activity
    t "activities.#{activity.key}"
  end
end
