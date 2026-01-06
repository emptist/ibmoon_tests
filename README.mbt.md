# IB MoonBit API - Real-World Examples

This project contains real-world examples demonstrating how to use the IB MoonBit API wrapper across different target platforms.

## Overview

The ibmoon_tests project provides practical examples for each target platform:
- **JavaScript/Node.js** (`cmd/js/`) - For Node.js environments
- **WebAssembly** (`cmd/wa/`) - For WebAssembly deployments
- **C/Native** (`cmd/c/`) - For native/C compilation

## Project Structure

```
ibmoon_tests/
├── cmd/
│   ├── js/                      # JavaScript/Node.js examples
│   │   ├── main.mbt             # JavaScript real-world example
│   │   └── moon.pkg.json        # Package configuration
│   ├── wa/                      # WebAssembly examples
│   │   ├── main.mbt             # WebAssembly real-world example
│   │   └── moon.pkg.json        # Package configuration
│   ├── c/                       # C/Native examples
│   │   ├── main.mbt             # Native real-world example
│   │   └── moon.pkg.json        # Package configuration
│   └── main/                    # Original integration test
│       ├── main.mbt
│       └── moon.pkg.json
├── moon.mod.json
├── moon.pkg.json
└── README.md
```

## Quick Start

### Prerequisites

1. **IB TWS or Gateway** must be running
2. **API Connections** must be enabled in TWS/Gateway settings
3. **Port 7496** (or 7497 for Gateway) must be accessible
4. **Client ID** (default: 1) must not be in use

### Running Examples

#### JavaScript/Node.js Example

```bash
cd ibmoon_tests
moon test --target js cmd/js
```

#### WebAssembly Example

```bash
cd ibmoon_tests
moon test --target wasm cmd/wa
```

#### C/Native Example

```bash
cd ibmoon_tests
moon test --target native cmd/c
```

## Example Details

### 1. JavaScript/Node.js Example (`cmd/js/main.mbt`)

**Purpose**: Demonstrates IB API usage in Node.js environment

**Features**:
- Connect to IB TWS/Gateway
- Retrieve managed accounts
- Get account summary
- Fetch current positions
- Display target-specific notes and troubleshooting

**Use Cases**:
- Node.js backend services
- Cloud functions
- Development and testing
- JavaScript ecosystem integration

**Target-Specific Notes**:
- Uses Node.js net module for socket communication
- Supports async/await patterns
- Ideal for server-side JavaScript applications

### 2. WebAssembly Example (`cmd/wa/main.mbt`)

**Purpose**: Demonstrates IB API usage in WebAssembly environment

**Features**:
- Connect to IB TWS/Gateway
- Retrieve managed accounts
- Get account summary
- Fetch current positions
- Display target-specific notes and limitations

**Use Cases**:
- Browser-based applications (with WebSocket proxy)
- Serverless functions
- Edge computing platforms
- Portable WebAssembly deployments

**Target-Specific Notes**:
- Uses WebAssembly host functions
- Near-native performance in WASM runtime
- Browser limitations require WebSocket proxy
- Ideal for edge computing and serverless

### 3. C/Native Example (`cmd/c/main.mbt`)

**Purpose**: Demonstrates IB API usage in native/C environment

**Features**:
- Connect to IB TWS/Gateway
- Retrieve managed accounts
- Get account summary
- Fetch current positions
- Display target-specific notes and performance characteristics

**Use Cases**:
- High-frequency trading applications
- Low-latency market data processing
- Production trading systems
- Performance-critical applications

**Target-Specific Notes**:
- Uses POSIX sockets
- Compiles to native machine code
- Maximum performance with minimal overhead
- Direct system access

## Common Examples Across All Targets

Each example demonstrates three common use cases:

### Example 1: Get Managed Accounts

```moonbit
let client = lib::set_managed_accounts_callback(client, fn(accounts : String) {
  println("Managed Accounts: " + accounts)
})

match lib::req_managed_accounts(client) {
  Ok(_) => {
    // Process messages to receive accounts
    for i = 0; i < 10; i = i + 1 {
      let _ = lib::client_process_messages(client)
    }
  }
  Err(e) => {
    println("Failed: " + lib::client_error_to_string(e))
  }
}
```

### Example 2: Get Account Summary

```moonbit
let client = lib::set_account_summary_callback(client, fn(req_id : Int, account : String, tag : String, value : String, currency : String) {
  println("Account: " + account + " | " + tag + " = " + value + " " + currency)
})

match lib::req_account_summary(client, 1, "All", "$LEDGER") {
  Ok(_) => {
    // Process messages to receive account summary
    for i = 0; i < 15; i = i + 1 {
      let _ = lib::client_process_messages(client)
    }
  }
  Err(e) => {
    println("Failed: " + lib::client_error_to_string(e))
  }
}
```

### Example 3: Get Positions

```moonbit
let client = lib::set_position_callback(client, fn(account : String, contract : lib::Contract, position : Double, avg_cost : Double) {
  println(account + " | " + lib::contract_symbol(contract) + " | Position: " + lib::double_to_string(position))
})

match lib::req_positions(client) {
  Ok(_) => {
    // Process messages to receive positions
    for i = 0; i < 15; i = i + 1 {
      let _ = lib::client_process_messages(client)
    }
  }
  Err(e) => {
    println("Failed: " + lib::client_error_to_string(e))
  }
}
```

## Target Selection Guide

### Choose JavaScript/Node.js if:
- Building Node.js applications
- Need rapid development and testing
- Want maximum JavaScript ecosystem compatibility
- Performance requirements are moderate

### Choose WebAssembly if:
- Building browser applications
- Need portable WebAssembly deployment
- Want near-native performance in web environments
- Can work with WebSocket proxy limitations

### Choose C/Native if:
- Need maximum performance
- Building production trading systems
- Require low latency
- Want direct system access
- Running on Linux/macOS

## Troubleshooting

### Connection Failed

1. **Check IB TWS/Gateway**: Ensure TWS or Gateway is running
2. **Enable API**: Enable API connections in TWS/Gateway settings
3. **Port**: Ensure port 7496 (TWS) or 7497 (Gateway) is accessible
4. **Client ID**: Ensure client ID (1) is not already in use
5. **Firewall**: Check firewall and network settings

### For WebAssembly (Browser)

1. **WebSocket Proxy**: Browsers cannot make direct TCP connections
2. **Proxy Setup**: Set up a WebSocket proxy for IB API access
3. **CORS**: Configure CORS if needed
4. **WASM Runtime**: Ensure WASM runtime supports host functions

### For C/Native (Windows)

1. **Winsock**: Ensure Winsock is properly configured
2. **Compilation**: Use appropriate compiler for Windows
3. **Libraries**: Link required socket libraries

## Related Projects

- **ibmoon**: Main project with all FFI implementations
- **ibmoonjs**: JavaScript/Node.js target library
- **ibmoonwa**: WebAssembly target library
- **ibmoonc**: C/Native target library

## Documentation

- [ibmoon README](../ibmoon/README.md) - Main library documentation
- [ibmoonjs README](../ibmoonjs/README.md) - JavaScript target documentation
- [ibmoonwa README](../ibmoonwa/README.md) - WebAssembly target documentation
- [ibmoonc README](../ibmoonc/README.md) - C/Native target documentation
- [Multi-Target Summary](../ibmoonc/MULTI_TARGET_SUMMARY.md) - Comparison of all targets

## License

Apache-2.0

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review target-specific documentation
3. Open an issue on GitHub