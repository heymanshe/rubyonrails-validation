class Computer < ApplicationRecord
  validates :mouse, presence: true,
                    if: [ Proc.new { |c| c.market == "retail" }, :desktop? ],
                    unless: Proc.new { |c| c.trackpad.present? }

  def desktop?
    device_type == "desktop"
  end
end
