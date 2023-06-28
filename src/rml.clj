(ns cpp-extractor.rml
  (:require [clojure.java.io :as io])
  (:import 
   [be.ugent.idlab.knows.functions.agent Agent AgentFactory]
   [be.ugent.rml Executor Utils]
   [be.ugent.rml.records RecordsFactory]
   [be.ugent.rml.store QuadStore QuadStoreFactory RDF4JStore]
   [be.ugent.rml.term NamedNode]))

(def mapping-file (Utils/getFile "mapping.ttl"))

(def mapping-stream (io/input-stream mapping-file))

(def rml-store (QuadStoreFactory/read mapping-stream))

(def factory (RecordsFactory. (.getParent mapping-file)))

(def function-agent (AgentFactory/createFromFnO "fno/functions_idlab.ttl" "fno/functions_idlab_test_classes_java_mapping.ttl"))

(def output-store (RDF4JStore.))

(def executor (Executor. rml-store factory output-store (utils/getBaseDirectiveTurtle mapping-stream) function-agent))

(def result (.get (.execute executor (NamedNode. "rmlmapper://default.store"))))

