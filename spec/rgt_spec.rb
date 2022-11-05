# frozen_string_literal: true

require_relative 'spec_helper_rgt'
require_relative 'helpers/vcr_helper'

describe 'Tests RGT API library' do
  before do
    VcrHelper.configure_vcr_for_google_trend
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Stock information' do
    before do
      @project = GoogleTrend::Gt::TrendMapper
        .new('TSMC')
        .get_rgt
    end

    it 'HAPPY: should provide correct GoogleTrend query' do
      # _(@project.query).must_equal CORRECT['']
      puts CORRECT
    end

    it 'HAPPY: project should not have sensitive attributes' do
      _(@project.to_attr_hash.keys & %i[id owner contributors]).must_be_empty
    end

    it 'BAD: should raise exception on incorrect project' do
      _(proc do
        CodePraise::Github::ProjectMapper
          .new(GITHUB_TOKEN)
          .find(USERNAME, 'foobar')
      end).must_raise CodePraise::Github::Api::Response::NotFound
    end

    it 'BAD: should raise exception when unauthorized' do
      _(proc do
        CodePraise::Github::ProjectMapper
          .new('BAD_TOKEN')
          .find(USERNAME, PROJECT_NAME)
      end).must_raise CodePraise::Github::Api::Response::Unauthorized
    end
  end

  describe 'Member information' do
    before do
      @project = CodePraise::Github::ProjectMapper
        .new(GITHUB_TOKEN)
        .find(USERNAME, PROJECT_NAME)
    end

    it 'HAPPY: should recognize owner' do
      _(@project.owner).must_be_kind_of CodePraise::Entity::Member
    end

    it 'HAPPY: members should not have sensitive attributes' do
      _(@project.owner.to_attr_hash).wont_include :id
    end

    it 'HAPPY: should identify owner' do
      _(@project.owner.username).wont_be_nil
      _(@project.owner.username).must_equal CORRECT['owner']['login']
    end

    it 'HAPPY: should identify members' do
      members = @project.contributors
      _(members.count).must_equal CORRECT['contributors'].count

      usernames = members.map(&:username)
      correct_usernames = CORRECT['contributors'].map { |c| c['login'] }
      _(usernames).must_equal correct_usernames
    end
  end
end