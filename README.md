# Bowling Kata

**2015-02-10**  
The essence of this kata is simple. Score a bowling game based on a series of frames. It's not as straight forward as it seems. I've been building it up and tearing it down over and over, and it's been pretty ugly. I started by creating
a class for both `Frame` and `Game`. I thought that a frame should have some responsibility... Storing it's own rolls, labeling itself a strike or spare. I think that makes sense. The game would own a set of ten frames, and allow you to load them up with their respective rolls.

The trick to this kata is to focus on scoring. I think having a frame class can help manage data and game play. That's all great, but to score a bowling game you need a broader context than a single frame. Frame scores can rely on subsequent rolls, and those subsequent rolls can happen across one or two frames. And then there's the possibility of extra frames that only have one or two rolls and they aren't really the same as the other frames because they only serve to resolve the overall game score. By locking up the rolls inside of frames, the scoring of the game becomes tricky and the code to make it work is yuck.

The following was one of my earlier solutions. It assumes access to a dataset made up of frames, as described above. For brevity, I'm just showing the scoring methods.
```ruby
# Example data
[
  { :strike => false, :spare => false, :rolls => [1, 1] },
  { :strike => false, :spare => true, :rolls => [5, 5] },
  { :strike => true, :spare => false, :rolls => [10] }
  ...
]
```
```ruby
# Solution
class BowlingGame

  def score_game(fs) # fs = frame set
    i = 0 # i = the current frame
    fs.inject(0) do |total, frame|
      i += 1
      score = frame[:rolls].inject(:+)
      if frame[:strike]
        if fs[i][:strike]
          score += fs[i][:rolls][0] + fs[i+1][:rolls][0]
        else
          score += fs[i][:rolls][0] + fs[i][:rolls][1]
        end
      elsif frame[:spare]
        score += fs[i][:rolls][0]
      end
      total + (i < 11 ? score: 0)
    end
  end
end
```
That's a pretty nasty web of conditionals. The code works, but it's ugly. It relies on tracking the index as I loop through each frame. And because I'm jumping ahead in the frames to add subsequent rolls to the total, it's error prone. The only up side to this is having expressive property names on the dataset. Every variation I've done of this kata, using frames as the basis for adding up the score, has ended up similar to this.

After looking over the work that a couple cohorts did, I found a much cleaner solution. Yeah, I basically stole this. I did refactor it, and I like where it is now. It assumes that all rolls are contained in a flat array with no concept of frames. See below.
```ruby
# Example data
[ 2, 5, 10, 5, ... ]
```
```ruby
####################################
# Solution inspired by Yock & Cat
####################################

class BowlingGame

  def score(rolls)
    score = []
    10.times do
      if(score << shift(rolls)).last == 10
        score << rolls.fetch(0, 0) << rolls.fetch(1, 0)
        next
      end
      if score.last + (score << shift(rolls)).last == 10
        score << rolls.fetch(0, 0)
      end
    end
    score.reduce(:+)
  end

  private
  def shift(arr)
    (arr.shift || 0)
  end

end
```
The key to simplifying the code is to get rid of frames all together. Even if the data was stored in a set of frames, the best way to score it would be to pull it out into a flat array. Another important part of this solution is that it loops ten times exactly. No reliance on iterating over all frames. This means that there are no special conditions to deal with for extra frames. If they exist, they do their job in adding to the total score, but they don't get iterated themselves. It's pretty robust. It can handle incomplete frame sets and It can handle more than extra frames. Twelve strikes will score 300 and fifty strikes will still score 300.

##Take away

[`Array.fetch(index, default)`](http://ruby-doc.org/core-2.2.0/Array.html#method-i-fetch)
