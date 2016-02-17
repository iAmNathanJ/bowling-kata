class MockIO

  attr_reader :input, :output

  def initialize
    @questions = [
      {
        question: regexify("(first name) "),
        answers: ["Suzy", "Nate", "Nathan"],
        index: 0
      },
      {
        question: regexify("(last name) "),
        answers: ["Riska", "Jacobs", "Jr."],
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
    ]
  end

  def write(msg); @output = msg; end

  def request(msg)
    @input = msg
    @questions.each do |q|
      if msg.match(q[:question])
        @output = q[:answers][q[:index]]
        q[:index] += 1
        break
      end
    end
    @output
  end

  def reset
    @questions.each { |q| q[:index] = 0 }
  end

  def regexify(str)
    /#{Regexp.escape(str)}/
  end

end
