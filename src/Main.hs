{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import Filesystem.Path


main :: IO ()
main = sh copyAll

copyAll = do files <- allFiles
             liftIO $ copy files

allFiles = convertedJpegFiles <|> rafFiles

copy :: Turtle.FilePath -> IO ()
copy fp = cp fp ("/Users/luca/Desktop/toronto" </> filename fp)

convertedJpegFiles :: Shell Filesystem.Path.FilePath
convertedJpegFiles = do raf <- rafFiles
                        let jpeg = toJpeg raf
                        return jpeg

rafFiles :: Shell Turtle.FilePath
rafFiles = find (suffix "RAF") "/Users/luca/Pictures"

toJpeg :: Turtle.FilePath -> Turtle.FilePath
toJpeg fp = addExtension (dropExtension fp) "JPG"
