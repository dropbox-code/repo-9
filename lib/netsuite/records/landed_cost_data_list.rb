module NetSuite
  module Records
    class LandedCostDataList < Support::Sublist
      include Namespaces::PlatformCommon

      sublist :landed_cost_data, LandedCostData

    end
  end
end
