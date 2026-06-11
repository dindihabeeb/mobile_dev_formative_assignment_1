# ALU Mobile Dev – Formative Assignment 1                                                                          
                                                                                                                   
  A flutter app that strengthens student engagement and collaboration within the African Leadership University ecosystem.
                                                                                                                     
  ---                                                                                                                
                                                                                                                     
  ## Getting Started                                                                                                 

  ```bash
  flutter pub get
  flutter run
                                                                                                                     
  Requires Flutter 3.x and Dart SDK ^3.11.
                                                                                                                     
  ---                                                                                                              
  Folder Structure
                                                                                                                     
  lib/
    main.dart          # entry point, MaterialApp + routes                                                           
    models/            # plain Dart data classes (Post, Club, …)                                                     
    screens/           # one file per full screen
    widgets/           # reusable UI components                                                                      
    services/          # state stores (PostStore, …)                                                                 
    theme/             # app colours, text styles
                                                                                                                     
  Rules:                                                                                                             
  - screens/ — full pages only. Just layout + calls to stores.
  - widgets/ — stateless or locally-stateful UI pieces that can be reused.
  - models/ — pure data, no Flutter imports.                                                                       
  - services/ — ValueNotifier-based stores. No direct setState for shared state.                                     
                                                                                                                     
  ---                                                                                                                
  Branch & PR Workflow                                                                                               
                                                                                                                     
  Branch naming                                                                                                    

  ┌─────────┬───────────────────┬─────────────────────┐
  │  Type   │      Pattern      │       Example       │
  ├─────────┼───────────────────┼─────────────────────┤                                                              
  │ Feature │ feat/<short-name> │ feat/community-page │
  ├─────────┼───────────────────┼─────────────────────┤                                                              
  │ Bug fix │ fix/<short-name>  │ fix/nav-crash       │                                                            
  └─────────┴───────────────────┴─────────────────────┘

  Rules                                                                                                              
   
  1. Always branch off main, never off a teammate's branch.                                                          
  2. One feature per branch — keep PRs focused.                                                                    
  3. Open a PR when your feature is ready. Do not merge your own PR.                                                 
  4. Habeeb reviews and merges all PRs to main.                                                                      
  5. Delete your branch after it is merged.                                                                          
                                                                                                                     
  PR title format                                                                                                    
                                                                                                                     
  feat: short description of what was added                                                                        
  fix: short description of what was fixed

  Quick reference

  # Start a new feature                                                                                              
  git checkout feat/architecture
  git pull origin feat/architecture                                                                             
  git checkout -b feat/your-feature-name                                                                           

  # Push and open PR                                                                                                 
  git push -u origin feat/your-feature-name
  # open PR on GitHub targeting feat/architecture                                                                             
                                                                                                                   
  ---
  State Management
                                                                                                                     
  We use plain setState for local UI state and. No external state packages.                                                   
                                                                                                                   
  Local UI state (e.g. which tab is active, form field values) → setState inside the widget.                         
                                                                                                                   
                                                                                                                     
  ---                                                                                                              
  Navigation
            
  AppShell in screens/shell.dart owns the bottom nav and tab state. Screens are kept alive with IndexedStack.
                                                                                                       
  Named routes are defined in main.dart. To push a new screen:
                                                                                                                 
  Navigator.pushNamed(context, '/post/create');                                                                    

  Back button on any tab screen exits the app — this is intentional. Only detail/create screens push onto the
  back-stack.
