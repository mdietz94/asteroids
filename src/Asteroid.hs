{-# LANGUAGE TemplateHaskell #-}

module Asteroid where

import Base.GraphicsManager (drawRect)
import Base.Geometry (Shape(..),collides,x,y)
import SDL (Renderer)
import Control.Lens

data Asteroid =	Asteroid {
		  _bounding :: Shape,
		  _vel :: (Int,Int),
                  _level :: Int
	      }

makeLenses ''Asteroid

levelSize :: Int -> Int
levelSize = (*5)

asteroidInitialize :: (Int,Int) -> (Int,Int) -> Int -> Asteroid
asteroidInitialize (x,y) vel lvl  =  Asteroid (Rectangle x y size size) vel lvl
    where
      size = levelSize lvl

update :: Asteroid -> Asteroid
update = move

draw :: Renderer -> Asteroid -> IO ()
draw r (Asteroid (Rectangle x y w h) _ _) = drawRect r (x,y) w h (0,0,0)

move :: Asteroid -> Asteroid
move mp@(Asteroid (Rectangle x y w h) (dx,dy) _) = (bounding .~ newRect) mp
    where
        newRect = Rectangle ((x+dx) `mod` 640) ((y+dy) `mod` 480) w h
        
