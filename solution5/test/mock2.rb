class MockSR

  attr_reader :sent, :received

  def initialize(send_method_name, request_method_name, *requests)
    @send = send_method_name
    @request = request_method_name
    @requests = requests
    @requests.map do |req|
      req[:request] = regexify(req[:request])
      req[:index] = 0
    end
  end

  define_method(:@send) do |msg|
    @latest_message = msg;
  end
  # def write(msg); @latest_message = msg; end

  define_method(:@request) do |msg|
    received = msg
    @requests.each do |req|
      if msg.match(req[:question])
        sent = req[:answers][q[:index]]
        req[:index] += 1
        break
      end
    end
    sent
  end
  # def request(msg)
  #   received = msg
  #   @requests.each do |req|
  #     if msg.match(req[:question])
  #       sent = req[:answers][q[:index]]
  #       req[:index] += 1
  #       break
  #     end
  #   end
  #   sent
  # end

  def reset
    @requests.each { |q| q[:index] = 0 }
  end

  private
  def regexify(str)
    /#{Regexp.escape(str)}/
  end

end

mock = MockSR.new("send", "request",
  {
    question: regexify("Add a player (name) "),
    answers: ["Suzy", "Nate", "Karl"],
    index: 0
  },
  {
    question: regexify("Add another? (y/n) "),
    answers: ["y", "y", "n"],
    index: 0
  },
  {
    question: regexify("How many pins would you like to knock down? "),
    answers: [10, 5, 5, 1],
    index: 0
  }
)

p mock
