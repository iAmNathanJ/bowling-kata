class MockIO

  attr_reader :received, :sent

  def initialize
    @requests = []
  end

  def write(msg); @sent = msg; end

  def request(msg)
    @received = msg
    find_request(msg) do |req|
      write(req[:response][req[:index]])
      req[:index] += 1
    end
    @sent
  end

  def add_requests(*reqs)
    reqs
      .map { |req| setup_req(req) }
      .each { |req| @requests << req }
  end

  def reset
    @requests = []
  end

  def reset_response_queue(target = nil)
    if target
      find_request(target) do |req|
        req[:index] = 0
      end
    else
      @requests.each { |req| req[:index] = 0 }
    end
  end

  private
  def find_request(target)
    @requests.each do |req|
      if target.match(req[:request])
        yield(req)
        break
      end
    end
  end

  def setup_req(req)
    req[:request] = regexify(req[:request])
    req[:index] = 0
    req
  end

  def regexify(str)
    /#{Regexp.escape(str)}/
  end

end
