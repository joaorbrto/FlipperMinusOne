<h1>FlipperMinusOne</h1>

<p><strong>FlipperMinusOne</strong> is an academic project developed for the course <strong>Microcontrollers/Microprocessors</strong> in the <strong>Computer Engineering</strong> program at <strong>IFCE</strong> (Federal Institute of Ceará).</p>

<h2>👥 Team</h2>

<ul>
  <li><strong>Software (iOS + interface):</strong> 
    <a href="https://github.com/joaorbrto">João Roberto</a>, 
    <a href="https://github.com/hadvtr">Hadassa Vitória</a>
  </li>
  <li><strong>Hardware (ESP32 + sensors):</strong> 
    <a href="https://github.com/lusca0x01">Lucas Wagner</a>, 
    <a href="https://github.com/MTR-S">Matheus de Sousa</a>, 
    <a href="https://github.com/uiLLer">Miller Monteiro</a>
  </li>
</ul>

<p>The goal of this project is to integrate <strong>hardware (ESP32)</strong> with <strong>software (an iOS app)</strong>, creating a functional and educational solution focused on <strong>practical cybersecurity</strong>.</p>

<p>The name <em>FlipperMinusOne</em> is a reference to the popular Flipper Zero device, representing a simplified version focused on:</p>

<ul>
  <li>Jammer (signal blocker) detection,</li>
  <li>Infrared command emulation (on/off),</li>
  <li>Real-time communication between the app and ESP32 via the MQTT protocol,</li>
  <li>Educational content and articles about digital security.</li>
</ul>

<h2>📲 Features</h2>

<ul>
  <li>🔌 <strong>MQTT connection</strong> with configurable host/port</li>
  <li>📡 <strong>Jammer detection</strong> with animated visualization:
    <ul>
      <li>Red: Jammer detected</li>
      <li>Green: No jammer</li>
      <li>Orange: Scanning</li>
    </ul>
  </li>
  <li>📥 <strong>Receive JSON commands</strong> from the ESP32</li>
  <li>📤 <strong>Send MQTT commands</strong>:
    <ul>
      <li><code>infraOn</code> (turn on infrared)</li>
      <li><code>infraOff</code> (turn off)</li>
      <li><code>requestJammerScan</code> (request scan)</li>
    </ul>
  </li>
  <li>📚 <strong>Educational mode</strong> with articles on cybersecurity</li>
</ul>

<h2>🧠 Architecture</h2>

<p>The app follows a reactive pattern with <code>ObservableObject</code>, and uses the <a href="https://github.com/emqx/CocoaMQTT" target="_blank">CocoaMQTT</a> library to connect to the broker.</p>

<h3>JSON Communication</h3>

<pre><code>{
  "command": "jammersDetected",
  "payload": null
}
</code></pre>

<h3>Supported command types:</h3>

<pre><code>enum FlipperCommandType: String, Decodable {
    case jammersDetected
    case infraOn
    case infraOff
}
</code></pre>

<h2>🖼️ Screens</h2>

<ul>
  <li><strong>Connection Screen:</strong> configure MQTT host/port.</li>
  <li><strong>JammerDetectorView:</strong> shows animated pulses based on the received status.</li>
  <li><strong>Articles:</strong> section with educational materials (under development).</li>
</ul>

<h2>✅ How to Test</h2>

<ol>
  <li><strong>Run the app in Xcode</strong> (simulator or physical device).</li>
  <li><strong>Connect to the MQTT broker</strong> (default: <code>test.mosquitto.org:1883</code>).</li>
  <li><strong>Simulate messages using an MQTT client</strong>, like:</li>
</ol>

<pre><code># Jammer detected
mosquitto_pub -h test.mosquitto.org -t flipper/status -m '{"command":"jammersDetected"}'

# Infrared turned on
mosquitto_pub -h test.mosquitto.org -t flipper/status -m '{"command":"infraOn"}'
</code></pre>

<h2>📁 Project Structure</h2>

<pre><code>FlipperMinusOne/
├── Views/
│   ├── ConnectionView.swift
│   ├── JammerDetectorView.swift
│   └── MQTTFormView.swift
├── Core/
│   ├── MQTTManager.swift
│   ├── FlipperCommand.swift
│   └── PulseDetectorView.swift
</code></pre>

<h2>🔒 Security</h2>

<p>Currently, the connection is unauthenticated (testing mode). For production, we recommend:</p>
<ul>
  <li>TLS/SSL</li>
  <li>Authentication with username/password</li>
  <li>Topic access control</li>
</ul>

<h2>🛠️ Technologies</h2>

<ul>
  <li>SwiftUI</li>
  <li>MQTT (via CocoaMQTT)</li>
  <li>ESP32 (custom firmware)</li>
  <li>Xcode 15+</li>
</ul>

<h2>📄 License</h2>

<p>Educational project. Not licensed for commercial use.</p>
