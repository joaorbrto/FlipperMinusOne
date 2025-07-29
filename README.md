<h1>FlipperMinusOne</h1>

<p><strong>FlipperMinusOne</strong> é um projeto acadêmico desenvolvido para a disciplina de <strong>Microcontroladores/Microprocessadores</strong> do curso de <strong>Engenharia de Computação do IFCE</strong> (Instituto Federal do Ceará).</p>

<h2>👥 Equipe</h2>

<ul>
  <li><strong>Software (iOS + interface):</strong> 
    <a href="https://github.com/joaorbrto">@João Roberto</a>, 
    <a href="https://github.com/hadvtr">@Hadassa Vitória</a>
  </li>
  <li><strong>Hardware (ESP32 + sensores):</strong> 
    <a href="https://github.com/lusca0x01">@Lucas Wagner</a>, 
    <a href="https://github.com/MTR-S">@Matheus de Sousa</a>, 
    <a href="https://github.com/uiLLer">@Miller Monteiro</a>
  </li>
</ul>

<p>O objetivo do trabalho é integrar <strong>hardware (ESP32)</strong> com <strong>software (um app iOS)</strong>, criando uma solução funcional e educativa voltada para <strong>cibersegurança prática</strong>.</p>

<p>O nome <em>FlipperMinusOne</em> faz referência ao famoso dispositivo Flipper Zero, sendo esta uma versão simplificada, com foco em:</p>

<ul>
  <li>Detecção de jammers (bloqueadores de sinal),</li>
  <li>Emulação de comandos infravermelhos (ligar/desligar),</li>
  <li>Comunicação em tempo real entre o app e o ESP32 via protocolo MQTT,</li>
  <li>Conteúdos educativos e artigos sobre segurança digital.</li>
</ul>

<h2>📲 Funcionalidades</h2>

<ul>
  <li>🔌 <strong>Conexão com o ESP32 via MQTT</strong> configurável</li>
  <li>📡 <strong>Detecção de Jammers</strong> com visualização animada:
    <ul>
      <li>Vermelho: Jammer detectado</li>
      <li>Verde: Nenhum jammer</li>
      <li>Laranja: Buscando</li>
    </ul>
  </li>
  <li>📥 <strong>Recebimento de comandos JSON</strong> do ESP32</li>
  <li>📤 <strong>Envio de comandos MQTT</strong>:
    <ul>
<!--       <li><code>infraOn</code> (ligar infravermelho)</li>
      <li><code>infraOff</code> (desligar)</li>
      <li><code>requestJammerScan</code> (solicita varredura)</li>
    </ul> -->
  </li>
  <li>📚 <strong>Modo educacional</strong> com artigos sobre cibersegurança</li>
</ul>

<h2>🧠 Arquitetura</h2>

<p>O app segue um padrão reativo com <code>ObservableObject</code>, e usa a biblioteca <a href="https://github.com/emqx/CocoaMQTT" target="_blank">CocoaMQTT</a> para conexão com o broker.</p>

<h3>Comunicação JSON</h3>

<pre><code>{
  "command": "jammersDetected",
  "payload": null
}
</code></pre>

<h3>Tipos de comando suportados:</h3>

<pre><code>enum FlipperCommandType: String, Decodable {
    case jammersDetected
    case infraOn
    case infraOff
}
</code></pre>

<h2>🖼️ Telas</h2>

<ul>
  <li><strong>Tela de conexão:</strong> configura host/porta MQTT.</li>
  <li><strong>JammerDetectorView:</strong> exibe pulsos animados conforme o status recebido.</li>
  <li><strong>Artigos:</strong> seção com materiais educativos (em desenvolvimento).</li>
</ul>

<h2>✅ Como testar</h2>

<ol>
  <li><strong>Execute o app no Xcode</strong> (simulador ou dispositivo físico).</li>
  <li><strong>Conecte-se ao broker MQTT</strong> (padrão: <code>test.mosquitto.org:1883</code>).</li>
  <li><strong>Simule mensagens com um cliente MQTT</strong>, como:</li>
</ol>

<pre><code># Jammer detectado
mosquitto_pub -h test.mosquitto.org -t flipper/status -m '{"command":"jammersDetected"}'

# Infravermelho ligado
mosquitto_pub -h test.mosquitto.org -t flipper/status -m '{"command":"infraOn"}'
</code></pre>

<h2>📁 Estrutura do Projeto</h2>

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

<h2>🔒 Segurança</h2>

<p>Atualmente, a conexão é sem autenticação (modo teste). Para produção, recomenda-se:</p>
<ul>
  <li>TLS/SSL</li>
  <li>Autenticação com login/senha</li>
  <li>Gerenciamento de tópicos com controle de acesso</li>
</ul>

<h2>🛠️ Tecnologias</h2>

<ul>
  <li>SwiftUI</li>
  <li>MQTT (via CocoaMQTT)</li>
  <li>ESP32 (firmware customizado)</li>
  <li>Xcode 15+</li>
</ul>

<h2>📄 Licença</h2>

<p>Projeto educacional. Sem licença de uso comercial.</p>
