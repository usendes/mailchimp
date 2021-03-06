defmodule Mailchimp.MemberTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Mailchimp.{Account, List, Member}

  doctest List

  setup_all do
    HTTPoison.start()
  end

  describe "update/1" do
    test "updates member" do
      use_cassette "member.update" do
        account = Account.get!()
        [list] = Account.lists!(account)
        member = List.get_member!(list, "mailchimp1-test@elixir.com")
        {:ok, %Member{language: "en"}} = Member.update(Map.put(member, :language, "en"))
        %Member{language: "en"} = Member.update!(Map.put(member, :language, "en"))
      end
    end
  end
end
