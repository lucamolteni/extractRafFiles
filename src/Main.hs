{-# LANGUAGE OverloadedStrings #-}

module Main where

import Turtle
import Filesystem.Path (addExtension)
import Prelude hiding (FilePath)

main :: IO ()
main = do (source, target)
            <- options "find all raw + jpeg pairs and copy to target" args
          sh $ copyAll source target

args :: Parser (FilePath, FilePath)
args = (,) <$> argPath "sourceDir" "The source directory where to find"
                <*> argPath "targetDirectory" "The directory to put the files"

copy :: FilePath -> FilePath -> IO ()
copy file destinationDir = cp file (destinationDir </> filename file)

copyAll :: FilePath -> FilePath -> Shell ()
copyAll source target = do files <- allFiles source
                           liftIO $ copy files target

allFiles :: FilePath -> Shell FilePath
allFiles source = convertedJpegFiles <|> rafFiles
                where rafFiles = find (suffix "RAF") source
                      convertedJpegFiles = fmap toJpeg rafFiles

toJpeg :: FilePath -> FilePath
toJpeg fp = addExtension baseName "JPG"
            where baseName = dropExtension fp
