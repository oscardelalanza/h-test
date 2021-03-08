require "test_helper"

class OwnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @owner = Owner.new(name: 'test owner', available_day: 'Monday', hour_start: '09:00', hour_end: '12:00',
                       password: '123456', password_confirmation: '123456', phone: '6663332222')
  end

  test 'Owner creates correctly' do
    assert @owner.save
  end

  test 'Owner has a valid name' do
    @owner.name = ''
    assert_not @owner.save
    @owner.name = 'a' * 256
    assert_not @owner.save
    @owner.name = 'owner test'
    assert @owner.save
  end

  test 'Owner has a valid available_day' do
    @owner.available_day = ''
    assert_not @owner.save
    @owner.available_day = 'tomorrow morning'
    assert_not @owner.save
    @owner.available_day = 7
    assert_not @owner.save
    @owner.available_day = 'Monday'
    assert @owner.save
  end

  test 'Owner has a valid hour_start' do
    @owner.hour_start = nil
    assert_not @owner.save
    @owner.hour_start = 'noon'
    assert_not @owner.save
    @owner.hour_start = '07:00'
    assert_not @owner.save
    @owner.hour_start = '23:42'
    assert_not @owner.save
    @owner.hour_start = '14:34'
    assert @owner.save
  end

  test 'Owner has a valid hour_end' do
    @owner.hour_end = nil
    assert_not @owner.save
    @owner.hour_end = 'noon'
    assert_not @owner.save
    @owner.hour_end = '07:00'
    assert_not @owner.save
    @owner.hour_end = '23:42'
    assert_not @owner.save
    @owner.hour_end = '14:34'
    assert @owner.save
  end

  test 'Owner has a valid phone' do
    @owner.phone = ''
    assert_not @owner.save
    @owner.phone = 'random'
    assert_not @owner.save
    @owner.phone = '2' * 11
    assert_not @owner.save
    @owner.phone = '6664443333'
    assert @owner.save
  end
end
