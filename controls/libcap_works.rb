title 'Tests to confirm libcap binaries work as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libcap")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libarchive' do
  impact 1.0
  title 'Ensure libarchive binaries are working as expected'
  desc '
  We check that each of the binaries libcap installs exist and then run checks on them to verify that they are excecutable.
  '
  
  capsh_works = command("/bin/capsh --help")
  describe capsh_works do
    its('stdout') { should match /usage: \/bin\/capsh/ }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  getcap_works = command("/bin/getcap -h")
  describe getcap_works do
    its('stdout') { should be_empty }
    its('stderr') { should match /usage: getcap/ }
    its('exit_status') { should eq 1 }
  end

  getpcaps_works = command("/bin/getpcaps")
  describe getpcaps_works do
    its('stdout') { should be_empty }
    its('stderr') { should match /usage: getcaps/ }
    its('exit_status') { should eq 1 }
  end

  setcap_works = command("/bin/setcap --help")
  describe setcap_works do
    its('stdout') { should be_empty }
    its('stderr') { should match /usage: setcap/ }
    its('exit_status') { should eq 1 }
  end
end
