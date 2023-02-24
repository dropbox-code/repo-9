module NetSuite
  module Records
    class LandedCost
      include Support::Fields
      include Support::Records
      include Namespaces::PlatformCommon

      field :landed_cost_data_list, LandedCostDataList
    end
  end
end
