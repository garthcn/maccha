class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def buyer_plans
    @buyer_plans ||= [
      {name: "No Plan", price: 0,
        features: ["Shipping varies by item", "Return varies by item"]},
      {name: "Maccha Basic", price: 5,
        features: ["Flat-rate Shipping ($4.99)",
          "Easy Returns (vary by item)"]},
      {name: "Maccha Limited", price: 10,
        features: ["Flat-rate Shipping ($4.99)",
          "Free Returns (within 30 days)"]},
      {name: "Maccha Unlimited", price: 15,
        features: ["Free 2-day Shipping",
          "Free Returns (within 365 days)"]}
    ]
  end

  def seller_plans
    @seller_plans ||= [
      {name: "No Plan", price: 0,
        features: ["Upgrade in order to sell"]},
      {name: "Maccha Bronze", price: 15,
        features: ["1 week bids", "2 pictures for upload", "No ads"]},
      {name: "Maccha Silver", price: 25,
        features: ["2 week bids", "4 pictures for upload", "1 ad every month"]},
      {name: "Maccha Gold", price: 40,
        features: ["4 week bids", "10 pictures for upload", "1 ad every week"]}
    ]
  end
end
