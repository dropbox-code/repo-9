module NetSuite
  module Records
    class AccountingBookDetailList < Support::Sublist
      include Namespaces::PlatformCommon

      sublist :accounting_book_detail, AccountingBookDetail

      alias :accounting_book_details :accounting_book_detail

    end
  end
end
