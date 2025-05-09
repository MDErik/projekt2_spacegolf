require 'ruby2d'

set width: 768, height: 512
set title: "Benny Hill's Galactic Moderatbandy"
set background: 'navy'

game_window = nil
difficulty = nil
game_scene = nil 
$x_level_selector = 150

$moveright = false
$moveleft = false
$moveup = false
$movedown = false

class Background
  def initialize
    @y_velocity = rand(-5..0)
    @shape = Circle.new(
      x: rand(Window.width),
      y: rand(Window.height),
      radius: rand(1..2),
      color: 'random')
    @rectangle = Rectangle.new(
      x: $x_level_selector, y: 300,
      width: 20, height: 30, color: 'white')
  end

  def move
    @shape.y = (@shape.y + @y_velocity) % Window.height
    @rectangle.x = $x_level_selector
  end
end

class MainMenu
  def initialize
    @stars = Array.new(100).map {Background.new}

    title = Text.new("Benny Hill's Galactic Moderatbandy!",
    x: 115, y: 40, size: 30, color: 'white')

    title_instruction = Text.new("Choose Difficulty:",
    x: 300, y: 80, size: 18, color: 'white')

    @Easy = Circle.new(x: 160, y: 200, radius:32, sectors: 128, color: 'green', z: 10)
    Rectangle.new(x: 120, y: 160, width: 80, height: 110, color: 'black')
    easy_title = Text.new("Putter", x: 135, y: 240, size: 18, color: 'green')

    @Intermediate = Circle.new(x: 355, y: 200, radius:32, sectors: 128, color: 'orange', z: 10)
    Rectangle.new(x: 315, y: 160, width: 80, height: 110, color: 'black')
    intermediate_title = Text.new("Iron", x: 340, y: 240, size: 18, color: 'orange')

    @Extreme = Circle.new(x: 560, y: 200, radius:32, sectors: 128, color: 'red', z: 10)
    Rectangle.new(x: 520, y: 160, width: 80, height: 110, color: 'black')
    hard_title = Text.new("Driver", x: 535, y: 240, size: 18, color: 'red')

    Text.new("Controls:", x: 320, y: 450 , size: 18 , color: 'white')
    key_w = Sprite.new(
      'w-key.png',
      x: 430, y: 430,
      clip_width: 32,
      time: 300,
      loop: true
    )
    key_w.play
    key_a = Sprite.new(
      'a-key.png',
      x: 400, y: 460,
      clip_width: 32,
      time: 300,
      loop: true
    )
    key_a.play
    key_s = Sprite.new(
      's-key.png',
      x: 430, y: 460,
      clip_width: 32,
      time: 300,
      loop: true
    )
    key_s.play
    key_d = Sprite.new(
      'd-key.png',
      x: 460, y: 460,
      clip_width: 32,
      time: 300,
      loop: true
    )
    key_d.play
  end

  def update
    if Window.frames % 2 == 0
      @stars.each { |star| star.move}
    end
  end
end

class Game_scene
  def initialize(game_window)
    if game_window != nil && $x_level_selector == 150
      @player = Square.new(x: 175, y: 120, size: 20, color: 'white', z: 40)
      @enemy = Image.new('Ice.png', x: 400 , y: 220, width: 50, height: 50, z: 40)
      @goal = Rectangle.new(x: 600, y: 280, width: 75, height: 125, color:'yellow', z: 39)


    elsif game_window != nil  && $x_level_selector == 345
      @player = Square.new(x: 175, y: 120, size: 20, color: 'white', z: 40)
      @enemy = Image.new('Ice.png', x: 200 , y: 220, width: 50, height: 50, z: 40)
      @enemytwo = Image.new('Baren.png', x: 400 , y:240 , width: 50 , height: 50 , z: 40)
      @goal = Rectangle.new(x: 600, y: 280, width: 75, height: 125, color:'yellow', z: 39)

    elsif game_window != nil && $x_level_selector == 540
      @player = Square.new(x: 100, y: 200, size: 20, color: 'white', z: 40)
      @enemy = Image.new('Ice.png', x: 400 , y: 220, width: 50, height: 50, z: 40)
      @goal = Rectangle.new(x: 600, y: 280, width: 75, height: 125, color:'yellow', z: 39)
    end
  end

  def update
    @player.x += 1 if $moveright
    @player.x -= 1 if $moveleft
    @player.y -= 1 if $moveup
    @player.y += 1 if $movedown

    if @player.x.between?(@enemy.x - 200, @enemy.x + 200) && @player.y.between?(@enemy.y - 100, @enemy.y + 100)
      @player.y += 0.1 if @player
      @player.x += 0.5 if $moveright  
      @player.x -= 0.5 if $moveleft     
    end

    if @enemytwo && @player.x.between?(@enemytwo.x - 200, @enemytwo.x + 200) &&@player.y.between?(@enemytwo.y - 100, @enemytwo.y + 100)
 
     @player.y += 0.1 if @player
     @player.x += 0.3 if $moveright  
     @player.x -= 0.3 if $moveleft
    end

    if @player.x >= 600 && @player.x <= 675 && @player.y >= 280 && @player.y <= 405
      $moveright = false
      $moveleft = false
      $moveup = false   
      $movedown = false 
      end
  end
end

on :key_down do |event|
  if event.key == 'return' && game_window == nil
    game_window = Rectangle.new(
      x: 100, y: 80,
      width: 600, height: 335,
      z: 30, color: 'black'
    )

    game_scene = Game_scene.new(game_window)
  end

  if event.key == 'd'
    $moveright = true
  end
  if event.key == 'w'
    $moveup = true
  end
  if event.key == 's'
    $movedown = true
  end
  if event.key == 'a'
    $moveleft = true
  end

  if event.key == 'escape' && game_window
    game_window.remove
    game_window = nil
  end

  if event.key == 'right'
    $x_level_selector += 195
    if $x_level_selector > 586
      $x_level_selector = 150
    end
  end
end

mainmenu = MainMenu.new

update do
  mainmenu.update
  game_scene.update unless game_scene.nil?  # Only call update if game_scene is not nil
end

show