require File.expand_path('../../../spec_helper', __FILE__)

module Pod
  describe Command::Search do

    extend SpecHelper::TemporaryRepos

    before do
      @test_source = Source.new(fixture('spec-repos/test_repo'))
      Source::Aggregate.any_instance.stubs(:all).returns([@test_source])
    end

    it "runs with correct parameters" do
      lambda { run_command('search', 'JSON') }.should.not.raise
      lambda { run_command('search', 'JSON', '--full') }.should.not.raise
    end

    it "complains for wrong parameters" do
      lambda { run_command('search') }.should.raise CLAide::Help
      lambda { run_command('search', 'too', 'many') }.should.raise CLAide::Help
      lambda { run_command('search', 'too', '--wrong') }.should.raise CLAide::Help
      lambda { run_command('search', '--wrong') }.should.raise CLAide::Help
    end

    it "searches for a pod with name matching the given query ignoring case" do
      output = run_command('search', 'json')
      output.should.include? 'JSONKit'
    end

    it "searches for a pod with name, summary, or description matching the given query ignoring case" do
      output = run_command('search', 'Engelhart', '--full')
      output.should.include? 'JSONKit'
    end
  end
end
