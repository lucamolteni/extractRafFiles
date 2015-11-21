{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import Filesystem.Path

main :: IO ()
main = do
  dir <- view (convertedJpegFiles <|> rafFiles)
  return ()


convertedJpegFiles :: Shell Filesystem.Path.FilePath
convertedJpegFiles = do raf <- rafFiles
                        let jpeg = toJpeg raf
                        return jpeg

rafFiles :: Shell Turtle.FilePath
rafFiles = find (suffix "RAF") "/Users/luca/Pictures"

toJpeg :: Turtle.FilePath -> Turtle.FilePath
toJpeg fp = addExtension (dropExtension fp) "jpg"
