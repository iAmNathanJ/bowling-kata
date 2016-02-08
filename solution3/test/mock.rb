class FrameSet

  def self.all_strikes # 300 points
    ["X","X","X","X","X","X","X","X","X","X","X","X"]
  end

  def self.all_spares # 150 points
    [5,"/",5,"/",5,"/",5,"/",5,"/",5,"/",5,"/",5,"/",5,"/",5,"/",5]
  end

  def self.all_open # 20 points
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
  end

  def self.mixed_frames # 139 points
    [5, "/", "X", 5, 4, 5, "/", 5, 4, 5, 4, 5, 4, 5, 4, 5, "/", "X", 5, 5]
  end
end
