experiment_definition = ExperimentDefinition.seed(:guid) do |s|
  s.guid = "pika_4e_kit"
  s.experiment_type = ExperimentDefinition::TYPE_TESTKIT
  s.protocol_params = {
    lid_temperature:110,
    stages: [
      {
        stage: {
          stage_type:"holding", steps: [
            { step: { name: "Initial Polymerase Activation/DNA Denaturation", temperature: 95, hold_time: 30 } } 
          ]
        }
      },
      {
        stage: {
          stage_type:"cycling",
          num_cycles: 40,
          steps: [
            { step: { name:"Denaturing", temperature:95, hold_time:4, ramp:{rate:5.0} } },
            { step: { name:"Annealing", temperature:67, hold_time:18, collect_data:true, ramp:{rate:5.0} } }
          ]
        }
      }
    ]
  }
end

# set the protocol lid temperature to 110
protocol = Protocol.seed(:experiment_definition_id) do |s|
  s.lid_temperature = 110
  s.experiment_definition_id = experiment_definition[0].id 
end
