<h1>⚡ Flippedu Mobile — MQTT Control & Wireless Signal Monitor</h1>

<p>
  <img src="https://img.shields.io/badge/Swift-5.10-orange"/>
  <img src="https://img.shields.io/badge/Platform-iOS-lightgrey"/>
  <img src="https://img.shields.io/badge/Protocol-MQTT-blue"/>
</p>

<p>
  <strong>Flippedu Mobile</strong> is an educational iOS app designed to interact with a custom ESP32-based device, offering real-time infrared control, jammer detection visualization, and an intuitive learning experience about wireless communication technologies.
</p>

<hr/>

<h2>📱 About the App</h2>

<p>
  <strong>Flippedu Mobile</strong> is the interface layer of the Flippedu device — a simplified, academic alternative inspired by the Flipper Zero.<br/>
  The app connects to the ESP32 through <strong>MQTT</strong>, sending commands and receiving live status updates.
</p>

<p>It focuses on two main areas:</p>

<ul>
  <li><strong>Infrared Control Module</strong> (IR ON/OFF)</li>
  <li><strong>Jammer / Wireless Interference Detection</strong></li>
</ul>

<p>
  The UI is clean, reactive, and built for learning — helping students understand embedded systems, RF interference, IR communication, and MQTT.
</p>

<hr/>

<h2>🌟 Main Features</h2>

<ul>
  <li>🔌 <strong>MQTT connection</strong> with customizable host/port</li>
  <li>🛰️ <strong>Jammer detection visualization</strong>:
    <ul>
      <li>🟢 No interference</li>
      <li>🟠 Scanning</li>
      <li>🔴 Jammer detected</li>
    </ul>
  </li>
  <li>📡 <strong>Infrared control</strong> (send ON/OFF commands)</li>
  <li>📥 Receive JSON messages from the ESP32</li>
  <li>📤 Send commands through MQTT topics</li>
  <li>📚 <strong>Educational mode</strong> explaining IR, BLE, RF interference</li>
</ul>

<hr/>

<h2>🧠 App Architecture</h2>

<p>The app is built with <strong>SwiftUI</strong> in a reactive architecture:</p>

<ul>
  <li><strong>CocoaMQTT</strong> for MQTT</li>
  <li><strong>ObservableObject</strong> for state management</li>
  <li><strong>MVVM-inspired structure</strong></li>
  <li><strong>Async event handling</strong></li>
</ul>

<h3>📡 MQTT Message Structure</h3>

<p><strong>Incoming example:</strong></p>

<pre>
{
  "command": "jammersDetected",
  "payload": null
}
</pre>

<p><strong>Supported command types:</strong></p>

<pre>
enum FlipperCommandType: String, Decodable {
    case jammersDetected
    case infraOn
    case infraOff
}
</pre>

<p><strong>Outgoing app commands:</strong></p>

<ul>
  <li><code>infraOn</code></li>
  <li><code>infraOff</code></li>
  <li><code>requestJammerScan</code></li>
</ul>

<hr/>

<h2>🖥️ Screens</h2>

<h3>🔧 Connection Screen</h3>
<p>Configure MQTT hostname and port.</p>

<h3>🛰️ Jammer Detector View</h3>
<p>Animated interface showing interference status.</p>

<h3>🔦 Infrared Control View</h3>
<p>Buttons to send IR ON/OFF commands.</p>

<h3>📚 Educational Section</h3>
<p>Concepts of IR, Bluetooth interference, signal flooding, and RF basics.</p>

<hr/>

<h2>🚀 How to Test</h2>

<ol>
  <li>Open the project in <strong>Xcode 15+</strong></li>
  <li>Run on simulator or real device</li>
  <li>Configure MQTT:
    <ul>
      <li><strong>Host:</strong> test.mosquitto.org</li>
      <li><strong>Port:</strong> 1883</li>
    </ul>
  </li>
  <li>Publish test messages using an MQTT client:</li>
</ol>

<pre>
# Jammer detected
mosquitto_pub -h test.mosquitto.org -t flipper/status \
  -m '{"command":"jammersDetected"}'
</pre>

<pre>
# Infrared ON
mosquitto_pub -h test.mosquitto.org -t flipper/status \
  -m '{"command":"infraOn"}'
</pre>

<hr/>

<h2>📁 Project Structure</h2>

<pre>
FlippeduMobile/
├── Views/
│   ├── ConnectionView.swift
│   ├── JammerDetectorView.swift
│   └── InfraredControlView.swift
├── Core/
│   ├── MQTTManager.swift
│   ├── FlipperCommand.swift
│   └── PulseAnimationView.swift
└── Resources/
    └── Assets.xcassets
</pre>

<hr/>

<h2>🔒 Security</h2>

<p>The MQTT setup is currently <strong>unauthenticated</strong> (development mode).</p>

<p>For production:</p>

<ul>
  <li>TLS/SSL</li>
  <li>Username/password</li>
  <li>Restricted topics</li>
</ul>

<hr/>

<h2>👥 Credits</h2>

<p>
  Academic project for the course:<br/>
  <strong>Microcontrollers & Microprocessors — Computer Engineering (IFCE)</strong>
</p>

<p><strong>Mobile Development:</strong><br/>
João Roberto • Hadassa Vitória</p>

<p><strong>Hardware Team (ESP32 + sensors):</strong><br/>
Lucas Wagner • Matheus de Sousa • Miller Monteiro</p>

<hr/>

<h2>📄 License</h2>

<p>This is an <strong>educational project</strong>. Not intended for commercial use.</p>
