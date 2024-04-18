//
//  AINameGenerator.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/17/24.
//

import Foundation

func getRandomAIName() -> String {
  
  let randomIndex = Int.random(in: 0..<aiNames.count)
  return aiNames[randomIndex]
}

let aiNames = [
  "Alpha",
  "Bolt",
  "Circuit",
  "Cipher",
  "CodeRed",
  "Cognito",
  "Comet",
  "Cortex",
  "Cyber",
  "Datastream",
  "Enigma",
  "Euclid",
  "Glitch",
  "Helix",
  "Horizon",
  "Impulse",
  "Interface",
  "Kernel",
  "Logic",
  "Maven",
  "Maze",
  "Meta",
  "Mosaic",
  "Neuron",
  "Nexus",
  "Oracle",
  "Paradox",
  "Phase",
  "Phoenix",
  "Pioneer",
  "Pixel",
  "Portal",
  "Prime",
  "Prism",
  "Protocol",
  "Quantum",
  "Quasar",
  "Raven",
  "Relay",
  "Rift",
  "Sage",
  "Sigma",
  "Spark",
  "Spectre",
  "Synapse",
  "Theory",
  "Titan",
  "Vector",
  "Weaver",
  "Zenith"
]
