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
        features: ["Feature a", "Feature b", "Feature c"]},
      {name: "Maccha Bronze", price: 15,
        features: ["Feature 1", "Feature 2", "Feature 3"]},
      {name: "Maccha Silver", price: 25,
        features: ["Feature 4", "Feature 5", "Feature 6"]},
      {name: "Maccha Gold", price: 40,
        features: ["Feature 7", "Feature 8", "Feature 9"]}
    ]
  end
end
