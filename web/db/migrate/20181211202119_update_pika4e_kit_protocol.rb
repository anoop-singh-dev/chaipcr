class UpdatePika4eKitProtocol < ActiveRecord::Migration  
    def up  
      # Find the existing experiment definition  
      exp_def = ExperimentDefinition.find_by(guid: "pika_4e_kit")  
        
      if exp_def  
        # Define the new protocol parameters  
        protocol_params = {  
          lid_temperature: 110,  
          stages: [  
            {  
              stage: {  
                stage_type: "holding",   
                steps: [  
                  { step: { name: "Initial Denaturing", temperature: 95, hold_time: 30 } }  
                ]  
              }  
            },  
            {  
              stage: {  
                stage_type: "cycling",  
                num_cycles: 40,  
                steps: [  
                  { step: { name: "Denaturing", temperature: 95, hold_time: 4, ramp: { rate: 5.0 } } },  
                  { step: { name: "Annealing", temperature: 67, hold_time: 18, collect_data: true, ramp: { rate: 5.0 } } }  
                ]  
              }  
            }  
          ]  
        }  
          
        # Destroy existing protocol if it exists  
        exp_def.protocol.destroy if exp_def.protocol  
          
        # Create new protocol using the protected method  
        exp_def.protocol = exp_def.send(:create_protocol, protocol_params)  
          
        # Save the experiment definition  
        exp_def.save  
          
        puts "Successfully updated pika_4e_kit experiment definition"  
      else  
        puts "pika_4e_kit experiment definition not found"  
      end  
    end  
      
    def down  
      # Optional: Add rollback logic if needed  
      exp_def = ExperimentDefinition.find_by(guid: "pika_4e_kit")  
      if exp_def && exp_def.protocol  
        exp_def.protocol.destroy  
      end  
    end  
  end