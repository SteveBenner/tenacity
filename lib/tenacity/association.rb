module Tenacity
  class Association
    attr_reader :type, :name, :class_name, :foreign_key

    def initialize(type, name, options={})
      @type = type
      @name = name
      @foreign_key = options[:foreign_key]

      if options[:class_name]
        @class_name = options[:class_name]
      else
        @class_name = name.to_s.singularize.camelcase
      end
    end

    def associate_class
      @clazz ||= Kernel.const_get(@class_name)
    end

    def foreign_key(clazz=nil)
      if @type == :t_belongs_to
        @foreign_key || @class_name.underscore + "_id"
      elsif @type == :t_has_one
        @foreign_key || "#{ActiveSupport::Inflector.underscore(clazz)}_id"
      elsif @type == :t_has_many
        if clazz
          @foreign_key || "#{ActiveSupport::Inflector.underscore(clazz)}_id"
        else
          "t_" + ActiveSupport::Inflector.singularize(name) + "_ids"
        end
      end
    end
  end
end
