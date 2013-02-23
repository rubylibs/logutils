###
#  to run use
#     ruby -I ./lib -I ./test test/test_logger.rb
#  or better
#     rake test

require 'test_helper'

class TestLogger < MiniTest::Unit::TestCase
  include LogUtils        # lets us use Logger instead of LogUtils::Logger

  ####
  # just for testing testing machinery
  #  simple tests

  def test_root
    l1 = Logger[ self ]
    l2 = Logger[ 'Test' ]
    l3 = Logger[ TestLogger ]
    
    ### nb: for now all return LogUtils::Kernel::STDLOGGER
    
    assert(l1 == LogUtils::Kernel::STDLOGGER )
    assert(l2 == LogUtils::Kernel::STDLOGGER )
    assert(l3 == LogUtils::Kernel::STDLOGGER )
  end
  
  class SampleClass
    include LogUtils  # NB: constant from containing class not available (only if class is nested in module)
    include Logging
  end
  
  class Sample2Class
    include LogUtils::Logging
  end
  
  def test_class
     obj  = SampleClass.new
     obj2 = Sample2Class.new
     
     assert( obj.logger == LogUtils::Kernel::STDLOGGER )
     assert( obj2.logger == LogUtils::Kernel::STDLOGGER )
  end
  
end