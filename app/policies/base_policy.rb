class BasePolicy
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def method_missing(_method_name, *_args)
    false
  end
end
