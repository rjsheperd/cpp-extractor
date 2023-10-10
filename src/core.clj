(ns cpp-extractor.core
  (:require [clojure.string :as str])
  (:import [org.python.util PythonInterpreter]))

(def py (PythonInterpreter.))

(defn exec [& s]
  (.exec py (str/join "\n" s)))

(exec 
"import sys"
"print(sys.version)")


