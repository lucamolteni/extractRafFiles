{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import Filesystem.Path

main :: IO ()
main = do (source, target)
            <- options "find all raw + jpeg pairs and copy to target" args
          sh $ copyAll source target

args :: Parser (Turtle.FilePath, Turtle.FilePath)
args = (,) <$> argPath "sourceDir" "The source directory where to find"
                <*> argPath "targetDirectory" "The directory to put the files"

copy :: Turtle.FilePath -> Turtle.FilePath -> IO ()
copy fp destinationDir = cp fp (destinationDir </> filename fp)

copyAll :: Filesystem.Path.FilePath -> Filesystem.Path.FilePath -> Shell ()
copyAll source target = do files <- allFiles source
                           liftIO $ copy files target

allFiles :: Filesystem.Path.FilePath -> Shell Filesystem.Path.FilePath
allFiles source = convertedJpegFiles <|> rafFiles
                where rafFiles = find (suffix "RAF") source
                      convertedJpegFiles = fmap toJpeg rafFiles

toJpeg :: Turtle.FilePath -> Turtle.FilePath
toJpeg fp = addExtension baseName "JPG"
            where baseName = dropExtension fp
