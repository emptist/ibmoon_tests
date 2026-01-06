// Integration test for IB MoonBit API wrapper
// This test verifies that the ibmoon library can connect to a live IB API

test "test_connection_with_live_api" {
  println("=== IB MoonBit API Integration Test ===")
  println("Attempting to connect to IB API on 127.0.0.1:7496")
  println("")
  
  // Create client configuration
  let config = ibmoon::connection_config("127.0.0.1", 7496, 1, None)
  let client = ibmoon::new_client(config)
  
  // Try to connect
  match ibmoon::client_connect(client) {
    Ok(client) => {
      println("✓ Socket connected successfully!")
      println("")
      
      // Set callback for managed accounts
      let client = ibmoon::set_managed_accounts_callback(client, fn(accounts : String) {
        println("✓ Received managed accounts: " + accounts)
      })
      
      // Request managed accounts
      match ibmoon::req_managed_accounts(client) {
        Ok(_) => {
          println("✓ Managed accounts requested successfully")
          println("")
          
          // Process messages in a loop to receive managed accounts
          println("Processing messages (10 iterations)...")
          for i = 0; i < 10; i = i + 1 {
            match ibmoon::client_process_messages(client) {
              Ok(_) => ()
              Err(e) => {
                println("✗ Error processing messages: " + ibmoon::client_error_to_string(e))
              }
            }
          }
          println("")
        }
        Err(e) => {
          println("✗ Failed to request managed accounts: " + ibmoon::client_error_to_string(e))
        }
      }
      
      // Disconnect
      match ibmoon::client_disconnect(client) {
        Ok(_) => {
          println("✓ Disconnected successfully")
        }
        Err(e) => {
          println("✗ Disconnect failed: " + ibmoon::client_error_to_string(e))
        }
      }
    }
    Err(e) => {
      println("✗ Socket connection failed: " + ibmoon::client_error_to_string(e))
      println("")
      println("Troubleshooting:")
      println("1. Ensure IB TWS or Gateway is running on port 7496")
      println("2. Ensure API connections are enabled in TWS/Gateway settings")
      println("3. Ensure the client ID (1) is not already in use")
      println("4. Check firewall settings")
    }
  }
  
  println("")
  println("=== Test Complete ===")
}
