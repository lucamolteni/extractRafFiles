module Paths_ExtractRafFiles (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/luca/Haskell/ExtractRafFiles/.stack-work/install/x86_64-osx/lts-3.7/7.10.2/bin"
libdir     = "/Users/luca/Haskell/ExtractRafFiles/.stack-work/install/x86_64-osx/lts-3.7/7.10.2/lib/x86_64-osx-ghc-7.10.2/ExtractRafFiles-0.1.0.0-EXk8YXVXgvI9Q40dAiP0wV"
datadir    = "/Users/luca/Haskell/ExtractRafFiles/.stack-work/install/x86_64-osx/lts-3.7/7.10.2/share/x86_64-osx-ghc-7.10.2/ExtractRafFiles-0.1.0.0"
libexecdir = "/Users/luca/Haskell/ExtractRafFiles/.stack-work/install/x86_64-osx/lts-3.7/7.10.2/libexec"
sysconfdir = "/Users/luca/Haskell/ExtractRafFiles/.stack-work/install/x86_64-osx/lts-3.7/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ExtractRafFiles_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ExtractRafFiles_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "ExtractRafFiles_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ExtractRafFiles_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ExtractRafFiles_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
