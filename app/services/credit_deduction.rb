class CreditDeduction
  attr_accessor :credit, :user
  def initialize(user)
    @credit = Credit.new(user)
    @user = user
  end

  def deduct_credit
    if UserLevelPolicy.new(user).premium?
      credit = credit - 1
    else
      credit = credit - 2
    end

    credit.save

    if credit.depleted?
      AppMailer.notify_insufficient_credit(user).deliver
    elsif credit.low_balance?
      AppMailer.notify_low_balance(user).deliver
    end
  end
end
