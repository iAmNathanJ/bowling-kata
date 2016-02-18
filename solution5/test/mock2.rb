class MockInput

  attr_reader :sent, :received

  def initialize(send_method_name, request_method_name, *requests)
    @send = send_method_name
    @request = request_method_name
    @requests = requests.map do |req|
      req[:request] = regexify(req[:request])
      req[:index] = 0
      req
    end
  end

  define_method(@request) do |msg|
    received = msg
    @requests.each do |req|
      if msg.match(req[:request])
        @sent = req[:answers][req[:index]]
        req[:index] += 1
        break
      end
    end
    sent
  end

  define_method("send") do |msg|
    received = msg;
  end

  def reset
    @requests.each { |q| q[:index] = 0 }
  end

  private
  def regexify(str)
    /#{Regexp.escape(str)}/
  end

end

mock = MockInput.new("send", "request",
  {
    request: "Add a player (name) ",
    answers: ["Suzy", "Nate", "Karl"]
  },
  {
    request: "Add another? (y/n) ",
    answers: ["y", "y", "n"]
  },
  {
    request: "How many pins would you like to knock down? ",
    answers: [10, 5, 5, 1]
  }
)

p mock.request("Add a player (name) ")
