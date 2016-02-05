class FrameSet

  def self.frameset # 20 points
    [
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true },
      { :strike => false, :spare => false, :rolls => [1, 1], :complete => true }
    ]
  end

  def self.all_strikes # 300 points
    [
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => false, :spare => false, :rolls => [10, 10], :complete => true }
    ]
  end

  def self.all_spares # 150 points
    [
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => false, :rolls => [5], :complete => true }
    ]
  end

  def self.mixed_frames # points
    [
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => true, :spare => false, :rolls => [10], :complete => true },
      { :strike => false, :spare => false, :rolls => [5, 4], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => false, :spare => false, :rolls => [5, 4], :complete => true },
      { :strike => false, :spare => false, :rolls => [5, 4], :complete => true },
      { :strike => false, :spare => false, :rolls => [5, 4], :complete => true },
      { :strike => false, :spare => false, :rolls => [5, 4], :complete => true },
      { :strike => false, :spare => true, :rolls => [5, 5], :complete => true },
      { :strike => true, :spare => true, :rolls => [10], :complete => true },
      { :strike => false, :spare => false, :rolls => [5, 5], :complete => true }
    ]
  end

end
