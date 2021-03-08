require "test_helper"

class PartnerTest < ActiveSupport::TestCase
  def setup
    @partner = Partner.new(name: 'The partner')
  end

  test 'partner saves correctly' do
    assert @partner.save
  end

  test 'partner has a valid name' do
    @partner.name = ''
    assert_not @partner.save
    @partner.name = 'random partner'
    assert @partner.save
  end

  test 'partner has a token' do
    assert_not @partner.auth_token
    @partner.save
    assert @partner.auth_token
  end
end
