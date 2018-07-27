{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Asterius.TypesConv
  ( marshalToModuleSymbol
  , zEncodeModuleSymbol
  ) where

import Asterius.Types
import qualified Data.ByteString.Char8 as CBS
import qualified Data.ByteString.Short as SBS
import qualified Data.Vector as V
import qualified GhcPlugins as GHC

{-# INLINEABLE marshalToModuleSymbol #-}
marshalToModuleSymbol :: GHC.Module -> AsteriusModuleSymbol
marshalToModuleSymbol (GHC.Module u m) =
  AsteriusModuleSymbol
    { unitId = SBS.toShort $ GHC.fs_bs $ GHC.unitIdFS u
    , moduleName =
        V.fromList $
        map SBS.toShort $
        CBS.splitWith (== '.') $ GHC.fs_bs $ GHC.moduleNameFS m
    }

{-# INLINEABLE zEncodeModuleSymbol #-}
zEncodeModuleSymbol :: AsteriusModuleSymbol -> String
zEncodeModuleSymbol AsteriusModuleSymbol {..} =
  GHC.zString $
  GHC.zEncodeFS $
  GHC.mkFastStringByteString $
  SBS.fromShort unitId <> "_" <>
  CBS.intercalate
    "."
    [SBS.fromShort mod_chunk | mod_chunk <- V.toList moduleName]
