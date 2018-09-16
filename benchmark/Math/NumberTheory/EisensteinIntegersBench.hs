{-# OPTIONS_GHC -fno-warn-type-defaults #-}
{-# OPTIONS_GHC -fno-warn-orphans       #-}

module Math.NumberTheory.EisensteinIntegersBench
  ( benchSuite
  ) where

import Control.DeepSeq
import Gauge.Main

import Math.NumberTheory.ArithmeticFunctions (tau)
import Math.NumberTheory.Quadratic.EisensteinIntegers

instance NFData EisensteinInteger

benchFindPrime :: Integer -> Benchmark
benchFindPrime n = bench (show n) $ nf findPrime n

benchTau :: Integer -> Benchmark
benchTau n = bench (show n) $ nf (\m -> sum [tau (x :+ y) | x <- [1..m], y <- [0..m]] :: Word) n

benchSuite :: Benchmark
benchSuite = bgroup "Eisenstein"
  [ bgroup "findPrime" $ map benchFindPrime [1000003, 10000141, 100000039, 1000000021, 10000000033, 100000000003, 1000000000039, 10000000000051]
  , bgroup "tau" $ map benchTau [10, 20, 40, 80]
  ]
