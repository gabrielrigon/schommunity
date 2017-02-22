#:nodoc:
module Constantine
  def self.included(base)
    base.extend(ClassMethods)
  end

  #:nodoc:
  module ClassMethods
    def constantine(attributte = :name)
      return unless table_exists?

      all.each do |item|
        constant_name = item.try(attributte)
                            .remove_non_ascii_and_spaces_and_number_start.upcase
                            .to_sym
        const_set(constant_name, item.id) unless const_defined?(constant_name)
      end
    end

    def invoke(model, constant_obj)
      Constantine.invoke(model, constant_obj)
    end
  end

  def self.invoke(model, constant_obj)
    if constant_obj.class == Array
      values = constant_obj.map do |obj|
        constant_value(model, obj)
      end

      values
    else
      constant_value(model, constant_obj)
    end
  end

  def self.invoke!(model, constant_obj)
    result = invoke(model, constant_obj)

    return result unless
      (result.class == Array && result.include?(0)) || result.zero?

    raise NameError, 'uninitialized constant'
  end

  def self.constant_value(model, object)
    constant_name = object.to_s.upcase
    model.const_defined?(constant_name) ? model.const_get(constant_name) : 0
  end

  def invoke(model, constant_obj)
    Constantine.invoke(model, constant_obj)
  end
end

ActiveRecord::Base.class_eval { include Constantine }
