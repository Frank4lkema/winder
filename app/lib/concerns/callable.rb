# frozen_string_literal: true

module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args)
      new(*args).call
    end
  end

  def call
    raise NoMethodError, "Services must implement a #call method."
  end
end