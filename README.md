# PlantCare

PlantCare is a chat-first plant care assistant. Instead of navigating a traditional app, people can describe what they want in everyday language, and the assistant can answer questions or carry out actions on their plant collection.

## How it works

The assistant interprets a request and uses the plant data model to guide the interaction. When information is missing, it asks for the required values in a conversational way. It can leave optional values unset, and should make clear when it has inferred or assumed something.

Before saving a new plant or applying a meaningful change, PlantCare shows a structured card with the details for review. The person can confirm, edit the card, or correct a value in plain language. Destructive actions such as removing a plant should ask for confirmation.

### Example: adding a plant

```text
Person: Add a monstera.
Assistant: What would you like to call it?
Person: Monty.
Assistant: Where is Monty?
Person: In the living room.
```

The assistant then shows a review card:

```text
Monty
Plant: Monstera
Location: Living room
Watering schedule: Not set
Light: Not set

Does this look right? [Save plant] [Edit details]
```

The person can also make a correction conversationally, for example: “Actually, it’s in the bedroom.” The assistant updates the card before saving.

## Example requests

- “Show me all my plants.”
- “Which plants need watering?”
- “What might be wrong with this plant?”
- “Move Monty to the bedroom.”
- “Change Monty’s watering schedule.”
- “Remove the plant by the window.”

When a request could refer to more than one plant, the assistant asks which one. For plant health questions, it can ask for more details or a photo when needed.

## First version

The initial experience should support:

1. Adding a plant through schema-guided questions and a review card.
2. Listing plants and answering questions using the person's saved plant data.
3. Updating plant details through chat, with a clear preview before saving.
4. Removing a plant with confirmation.

Reminders and photo-based plant diagnosis can be added later.

## App structure

The iOS app separates plant data, chat behavior, local model execution, and screens. `PlantChatViewModel` coordinates conversational requests and streams output from an engine behind a protocol. `GardenViewModel` manages the saved plant collection and its schedules.

```text
PlantCare/
├── App/
│   ├── PlantCareApp.swift           # @main application entry point
│   └── Assets.xcassets              # App icon, colors, plant placeholder graphics
├── Models/
│   ├── Plant.swift                  # Saved plant: ID, species, location, watering schedule
│   ├── ChatMessage.swift            # Chat history: ID, role, content, and timestamp
│   └── ModelConfig.swift            # LLM settings, including plant care system prompt
├── Engine/
│   ├── LLMEngineProtocol.swift      # Swift interface for model inference
│   ├── PlantCareMLEngine.swift      # Core ML token inference and execution pipeline
│   ├── Tokenizer.swift              # Text-to-token and token-to-text conversion
│   └── KVCache.swift                # Key/value cache for LLM context history
├── ViewModels/
│   ├── PlantChatViewModel.swift     # Main-actor chat state, streaming, and plant context
│   └── GardenViewModel.swift        # Plant collection and schedule management
├── Views/
│   ├── Chat/
│   │   ├── PlantChatView.swift      # Main chat interface
│   │   ├── MessageBubble.swift      # Chat message formatting
│   │   └── PlantComposerBar.swift   # Input field and send/stop controls
│   ├── Garden/
│   │   ├── MyGardenView.swift       # Overview of the user's plants
│   │   └── PlantDetailView.swift    # Plant health and diagnostic history
│   └── Settings/
│       └── ModelSettingsView.swift  # Model selection, cache, and memory settings
├── Utilities/
│   ├── Extensions/
│   │   └── View+Extensions.swift    # UI styling and helper utilities
│   └── FileUtils.swift              # Load local Core ML model files
└── Resources/
    └── Models/                      # Bundled or downloaded model assets
        └── PlantCareLLM.mlmodelc    # Example compiled Core ML model
```

### Responsibilities and request flow

1. `PlantChatView` displays the conversation. `PlantComposerBar` handles text entry and send/stop controls, while `MessageBubble` renders each message.
2. `PlantChatViewModel` owns chat state, assembles relevant plant context, and streams assistant output. It calls `LLMEngineProtocol` with the conversation and `ModelConfig`, keeping UI logic independent from the inference backend.
3. For plant actions, the chat flow coordinates with plant data and uses review cards to collect missing values and confirm changes before saving. `GardenViewModel` supplies plant collection and schedule operations to the garden screens and chat features.
4. `PlantCareMLEngine` prepares prompts, uses `Tokenizer` to encode and decode text, runs Core ML inference, and streams generated text. `KVCache` stores reusable transformer state where the model supports it.
5. `MyGardenView` presents the collection, and `PlantDetailView` shows an individual plant's details and diagnostic history. `ModelSettingsView` exposes model and memory controls. `FileUtils` locates models in the app bundle or the app's Documents directory.

The `.mlmodelc` entry is illustrative: compiled Core ML models are directory bundles and may be too large to ship inside the app. A downloaded model can instead live in the app's Documents directory. A `.mlpackage` may also be used as the source model and compiled for execution. The tokenizer, cache behavior, and inference loop depend on the selected model and its Core ML conversion, so those details belong behind the engine interface.

The local model generates and interprets language; plant collection changes should go through explicit app actions and the plant data layer. This keeps model output separate from saved state and supports the schema-guided questions, review cards, and confirmations described above.
