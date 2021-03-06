require 'spec_helper'

describe Measure do
  before do
    collection_fixtures 'measures', 'selected_measures'
  end
  
  it 'should group measures by category' do
    measures = Measure.all_by_category
    core = measures.find {|category| category['category'] == 'Core'}
    core.should_not be_nil
    core['measures'].should include('name' => 'Hypertension: Blood Pressure Measurement',
                                    'id' => '0013')
    core['measures'].should include('name' => 'Adult Weight Screening and Follow-Up',
                                    'id' => '0421')
    core['measures'].should_not include('name' => 'Cervical Cancer Screening',
                                        'id' => '0032')
  end
  
  it 'should group measures' do
    measures = Measure.all_by_measure
    aws = measures.find {|measure| measure['id'] == '0421'}
    aws['name'].should == 'Adult Weight Screening and Follow-Up'
    aws['subs'].length.should == 2
    
    ccs = measures.find {|measure| measure['id'] == '0032'}
    ccs['subs'].should be_empty
  end
  
  it 'should find non core measures' do
    measures = Measure.non_core_measures
    measures.length.should == 1
    
    measures.map {|c| c['category']}.should include("Women's Health")
    measures.map {|c| c['category']}.should_not include('Core')
    ccs = measures.find {|category| category['category'] == "Women's Health"}['measures'].first
    ccs['name'].should == 'Cervical Cancer Screening'
  end
  
  it 'should find core measures' do
    measures = Measure.core_measures
    
    measures.length.should == 2
    
    aws = measures.find {|measure| measure['id'] == '0421'}
    aws['name'].should == 'Adult Weight Screening and Follow-Up'
  end
  
  it "should add a measure to the selected measures if it isn't there" do
    measure = Measure.add_measure('andy','0421')
    measure['name'].should == 'Adult Weight Screening and Follow-Up'
    MONGO_DB['selected_measures'].count.should == 2
  end
  
  it "shouldn't add a measure if it is already there" do
    Measure.add_measure('andy', '0032').should be_nil
  end
  
  it "should be able to remove a measure" do
    Measure.remove_measure('andy', '0032')
    MONGO_DB['selected_measures'].count.should == 0
  end
end