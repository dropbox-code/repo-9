module NetSuite
  module Records
    class CheckItemList < Support::Sublist
      include Namespaces::TranBank

      sublist :item, CheckItem

      alias :items :item
    end
  end
end
