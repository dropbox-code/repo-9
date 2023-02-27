module NetSuite
  module Records
    class CheckLandedCostList < Support::Sublist
      include Namespaces::TranBank

      sublist :landed_cost, LandedCostSummary

      alias :landed_costs :landed_cost

    end
  end
end
