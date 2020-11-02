module InventoryItemsHelper
  def get_expiration_class_and_text(item)
    days = item.try(:days_til_exp)
    if days.nil?
      %w[text-info -]
    elsif days <= 30 && days.positive?
      ['text-warning', "Food expires in #{days} days"]
    elsif days <= 0
      ['text-danger', 'Expired food in stock']
    else
      ['text-success', "Food expires in #{days} days"]
    end
  end
end
