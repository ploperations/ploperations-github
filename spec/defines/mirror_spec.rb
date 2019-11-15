require 'spec_helper'

describe 'github::mirror' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:title) { 'my_mirror' }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
