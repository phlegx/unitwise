require 'test_helper'

describe Unitwise::Number do
  describe ".simplify" do
    it "simplifies to an Integer" do
      [2, 2.0, BigDecimal.new(2), Rational(2, 1), '2', '2.0'].each do |n|
        assert_equal Unitwise::Number.simplify(n), 2
      end
    end

    it "simplifies to a Float" do
      [2.25, BigDecimal.new('2.25'), Rational(9, 4), '2.25'].each do |n|
        assert_equal Unitwise::Number.simplify(n), 2.25
      end
    end

    it "doesn't simplify complex BigDecimals" do
      s = "1234567890.0123456789"
      d = BigDecimal.new(s)
      [s, d].each do |n|
        assert_equal Unitwise::Number.simplify(n), d
      end
    end

    it "doesn't simplify complex Rationals" do
      r = Rational(22, 7)
      assert_equal Unitwise::Number.simplify(r), r
    end
  end

  describe ".coefficify" do
    it "converts integer values to Integers" do
      [1, 1.0, "1.0", "1"].each do |n|
        assert Unitwise::Number.coefficify(n).eql?(1)
      end
    end

    it "converts decimal values to BigDecimals" do
      [1.5, "1.5", "1.50", "0.15e1"].each do |n|
        assert Unitwise::Number.coefficify(n).eql?(BigDecimal.new("1.5"))
      end
    end
  end
end