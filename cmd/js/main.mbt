// Real-world example for IB MoonBit API - JavaScript/Node.js target
// This demonstrates connecting to IB API and retrieving account data

test "javascript_realworld_example" {
  println("=== IB MoonBit API - JavaScript/Node.js Real-World Example ===")
  println("Target: JavaScript/Node.js")
  println("Library: ibmoonjs")
  println("")
  
  // Import ibmoonjs library
  use lib "username/ibmoonjs"
  
  // Create client configuration
  println("Creating client configuration...")
  let config = lib::connection_config("127.0.0.1", 7496, 1, None)
  let client = lib::new_client(config)
  println("✓ Client configuration created")
  println("")
  
  // Try to connect
  println("Attempting to connect to IB TWS/Gateway...")
  match lib::client_connect(client) {
    Ok(client) => {
      println("✓ Connected to IB API successfully!")
      println("")
      
      // Example 1: Get Managed Accounts
      println("--- Example 1: Get Managed Accounts ---")
      let client = lib::set_managed_accounts_callback(client, fn(accounts : String) {
        println("  Managed Accounts: " + accounts)
      })
      
      match lib::req_managed_accounts(client) {
        Ok(_) => {
          println("  ✓ Managed accounts requested")
          
          // Process messages
          for i = 0; i < 10; i = i + 1 {
            let _ = lib::client_process_messages(client)
          }
        }
        Err(e) => {
          println("  ✗ Failed: " + lib::client_error_to_string(e))
        }
      }
      println("")
      
      // Example 2: Get Account Summary
      println("--- Example 2: Get Account Summary ---")
      let client = lib::set_account_summary_callback(client, fn(req_id : Int, account : String, tag : String, value : String, currency : String) {
        println("  Account: " + account + " | " + tag + " = " + value + " " + currency)
      })
      
      match lib::req_account_summary(client, 1, "All", "$LEDGER") {
        Ok(_) => {
          println("  ✓ Account summary requested")
          
          // Process messages
          for i = 0; i < 15; i = i + 1 {
            let _ = lib::client_process_messages(client)
          }
        }
        Err(e) => {
          println("  ✗ Failed: " + lib::client_error_to_string(e))
        }
      }
      println("")
      
      // Example 3: Get Positions
      println("--- Example 3: Get Positions ---")
      let client = lib::set_position_callback(client, fn(account : String, contract : lib::Contract, position : Double, avg_cost : Double) {
        println("  " + account + " | " + lib::contract_symbol(contract) + " | Position: " + lib::double_to_string(position) + " | Avg Cost: " + lib::double_to_string(avg_cost))
      })
      
      match lib::req_positions(client) {
        Ok(_) => {
          println("  ✓ Positions requested")
          
          // Process messages
          for i = 0; i < 15; i = i + 1 {
            let _ = lib::client_process_messages(client)
          }
        }
        Err(e) => {
          println("  ✗ Failed: " + lib::client_error_to_string(e))
        }
      }
      println("")
      
      // Disconnect
      println("Disconnecting from IB API...")
      match lib::client_disconnect(client) {
        Ok(_) => {
          println("✓ Disconnected successfully")
        }
        Err(e) => {
          println("✗ Disconnect failed: " + lib::client_error_to_string(e))
        }
      }
    }
    Err(e) => {
      println("✗ Connection failed: " + lib::client_error_to_string(e))
      println("")
      println("JavaScript/Node.js Target Notes:")
      println("- Uses Node.js net module for socket communication")
      println("- Supports async/await patterns")
      println("- Ideal for Node.js backend services")
      println("- Can be used in cloud functions and serverless environments")
      println("")
      println("Troubleshooting:")
      println("1. Ensure IB TWS or Gateway is running on port 7496")
      println("2. Enable API connections in TWS/Gateway settings")
      println("3. Ensure client ID (1) is not already in use")
      println("4. Check firewall and network settings")
    }
  }
  
  println("")
  println("=== JavaScript/Node.js Example Complete ===")
}