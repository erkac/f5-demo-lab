title "Test F5 DEMO Lab Deployment"

control "Standart VS" do
  impact 1.0
  title "DVWA http"
  describe http("http://10.1.10.17/login.php") do
    its('body') { should match /Damn Vulnerable Web Application/}
  end
end

control "Standard VS" do
  impact 1.0
  title "DVWA https"
  describe http("https://10.1.10.18/login.php", ssl_verify: false) do
    its('body') { should match /Damn Vulnerable Web Application/}
  end
end

control "Forwarding VS" do
  impact 1.0
  title "Self IP Test"
  describe host('10.1.10.240', port: 7, protocol: 'udp') do
    it { should be_reachable }
  end
end