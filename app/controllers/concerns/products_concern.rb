# frozen_string_literal: true

module ProductsConcern
  extend ActiveSupport::Concern

  def gen_serial
    match = true
    serial = 0
    loop do
      serial = (rand * 100_000_000).to_i
      match = Product.exists?(serial_no: serial)
      break if match == false
    end
    serial
  end
end
