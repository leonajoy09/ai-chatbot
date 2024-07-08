import os
import json

def generate_training_data_from_tf_files(tf_directory, output_file="finetuning_data.jsonl"):
    # List to hold the training data
    training_data = []

    # Function to generate a conversation based on file name or content
    def generate_conversation(file_name, file_content):
        conversation = [
            {"role": "system", "content": "I am a helpful assistant."},
            {"role": "user", "content": f"Generate a Terraform configuration for the following use case: {file_name.split('.')[0]}"},
            {"role": "assistant", "content": file_content}
        ]
        return conversation

    # Read all .tf files and create training data
    for file_name in os.listdir(tf_directory):
        if file_name.endswith(".tf"):
            file_path = os.path.join(tf_directory, file_name)
            with open(file_path, 'r') as file:
                content = file.read()
                conversation = generate_conversation(file_name, content)
                training_data.append({"messages": conversation})

    # Write training data to a JSON file
    with open(output_file, 'w') as json_file:
        json.dump(training_data, json_file, indent=2)

    print(f"Training data written to {output_file}")
