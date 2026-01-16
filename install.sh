#!/bin/bash

# ============================================
# LEO'S ISHIKAWA ANALYZER - v4.0 CYBER FIXED
# Visual TRON/Matrix original mantido
# Multi-AI corrigido e funcionando
# ============================================

clear

if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
    INSTALL_DIR="$HOME/Desktop/IshikawaAnalyzer"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ -n "$WSL_DISTRO_NAME" ]]; then
    OS="windows"
    INSTALL_DIR="$HOME/Desktop/IshikawaAnalyzer"
else
    OS="linux"
    INSTALL_DIR="$HOME/Desktop/IshikawaAnalyzer"
fi

echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║   LEO'S ISHIKAWA ANALYZER v4.0 CYBER EDITION          ║"
echo "║   • Visual TRON/Matrix Original ✅                    ║"
echo "║   • Multi-AI Corrigido ✅                             ║"
echo "║   • Claude + Gemini + OpenAI ✅                       ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "❌ Python não encontrado!"
    exit 1
fi

if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
fi

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo "📦 Criando app com visual cyber original..."

# Criar index.html com VISUAL CYBER COMPLETO
cat > index.html << 'HTMLEND'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ishikawa Analyzer v4.0</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="cyber-grid"></div>
    <div class="container">
        <!-- HEADER COM VISUAL CYBER -->
        <div class="header">
            <div class="scan-line"></div>
            <h1 class="title cyber-text">ISHIKAWA ANALYZER</h1>
            <p class="subtitle">v4.0 Cyber Edition - Multi-AI Analysis System</p>
            <button class="settings-btn cyber-btn" onclick="openSettings()">⚙️ SETTINGS</button>
            <div class="ai-badge" id="aiBadge">SYSTEM READY</div>
        </div>

        <!-- MODAL SETTINGS -->
        <div id="settingsModal" class="modal">
            <div class="modal-content cyber-border">
                <div class="glow-line"></div>
                <h2 class="modal-title cyber-text">⚙️ SYSTEM CONFIGURATION</h2>
                
                <div id="apiStatus" class="status-display"></div>
                
                <label class="cyber-label">AI PROVIDER:</label>
                <select id="aiProvider" class="cyber-input" onchange="updateProviderInfo()">
                    <option value="gemini">Google Gemini (FREE)</option>
                    <option value="huggingface">Hugging Face (FREE)</option>
                    <option value="claude">Anthropic Claude</option>
                    <option value="openai">OpenAI GPT-4</option>
                </select>
                
                <div id="providerInfo" class="info-panel"></div>
                
                <label class="cyber-label">API KEY:</label>
                <input type="password" id="settingsApiKeyInput" class="cyber-input" placeholder="Enter API key...">
                
                <div class="btn-group">
                    <button class="btn-secondary cyber-btn" onclick="closeSettings()">CANCEL</button>
                    <button class="btn-primary cyber-btn" onclick="saveSettings()">SAVE CONFIG</button>
                </div>
            </div>
        </div>

        <!-- STEP 0: CONFIG -->
        <div id="step0" class="card cyber-card">
            <div class="glow-line"></div>
            <h2 class="card-title cyber-text">SYSTEM INITIALIZATION</h2>
            
            <label class="cyber-label">SELECT AI PROVIDER:</label>
            <select id="initialProvider" class="cyber-input" onchange="updateInitialInfo()">
                <option value="gemini">Google Gemini (FREE - Recommended)</option>
                <option value="huggingface">Hugging Face (FREE Alternative)</option>
                <option value="claude">Anthropic Claude</option>
                <option value="openai">OpenAI GPT-4</option>
            </select>
            
            <div id="initialInfo" class="info-panel"></div>
            
            <input type="password" id="apiKeyInput" class="cyber-input" placeholder="Paste API Key here...">
            <button class="btn-primary cyber-btn cyber-glow" onclick="saveApiKey()">
                <span class="btn-text">INITIALIZE SYSTEM</span>
                <span class="btn-icon">→</span>
            </button>
        </div>

        <!-- STEP 1: PROBLEM -->
        <div id="step1" class="card cyber-card hidden">
            <div class="glow-line"></div>
            <h2 class="card-title cyber-text">STEP 1: DEFINE PROBLEM</h2>
            
            <p class="cyber-subtitle">QUICK LOAD TEMPLATES:</p>
            <div class="example-grid">
                <button class="example-btn cyber-btn-outline" onclick="loadExample(0)">
                    <span class="icon">▶</span> High No-Show Rate
                </button>
                <button class="example-btn cyber-btn-outline" onclick="loadExample(1)">
                    <span class="icon">▶</span> Sales Not Improving
                </button>
                <button class="example-btn cyber-btn-outline" onclick="loadExample(2)">
                    <span class="icon">▶</span> Long Sales Cycle
                </button>
            </div>
            
            <label class="cyber-label">PROBLEM DESCRIPTION:</label>
            <textarea id="problemInput" class="cyber-textarea" placeholder="Describe the observed business problem..."></textarea>
            
            <label class="cyber-label">CONFIDENCE LEVEL: <span id="confidenceValue" class="confidence-value">7</span>/10</label>
            <input type="range" id="confidenceSlider" class="cyber-slider" min="1" max="10" value="7" oninput="updateConfidence(this.value)">
            <div class="range-labels">
                <span>LOW</span>
                <span>MEDIUM</span>
                <span>HIGH</span>
            </div>
            
            <button class="btn-primary cyber-btn cyber-glow" onclick="goToStep(2)">
                <span class="btn-text">PROCEED TO MAPPING</span>
                <span class="btn-icon">→</span>
            </button>
        </div>

        <!-- STEP 2: CATEGORIES -->
        <div id="step2" class="card cyber-card hidden">
            <div class="glow-line"></div>
            <h2 class="card-title cyber-text">STEP 2: SYMPTOM MAPPING</h2>
            <div class="stats-bar">
                <span class="stat-item">
                    <span class="stat-label">CATEGORIES:</span>
                    <span class="stat-value">8</span>
                </span>
                <span class="stat-item">
                    <span class="stat-label">SYMPTOMS:</span>
                    <span class="stat-value" id="totalSymptoms">0</span>
                </span>
            </div>
            <div id="categoriesContainer"></div>
            <div class="btn-group">
                <button class="btn-secondary cyber-btn" onclick="goToStep(1)">← BACK</button>
                <button class="btn-primary cyber-btn cyber-glow" onclick="runAnalysis()">
                    <span class="btn-text">RUN AI ANALYSIS</span>
                    <span class="btn-icon">⚡</span>
                </button>
            </div>
        </div>

        <!-- STEP 3: LOADING -->
        <div id="step3" class="card cyber-card hidden">
            <div class="loading-container">
                <div class="cyber-spinner"></div>
                <h2 class="loading-title cyber-text">ANALYZING ROOT CAUSES...</h2>
                <p class="loading-text" id="loadingText">Processing with AI...</p>
                <div class="progress-bar">
                    <div class="progress-fill"></div>
                </div>
            </div>
        </div>

        <!-- STEP 4: RESULTS -->
        <div id="step4" class="card cyber-card hidden">
            <div class="glow-line"></div>
            <h2 class="card-title cyber-text">DIAGNOSTIC RESULTS</h2>
            <div id="resultsContainer"></div>
            <div class="btn-group">
                <button class="btn-primary cyber-btn" onclick="resetAnalysis()">NEW ANALYSIS</button>
                <button class="btn-secondary cyber-btn" onclick="exportResults()">EXPORT DATA</button>
            </div>
        </div>
    </div>

    <script src="app.js"></script>
</body>
</html>
HTMLEND

# Criar CSS com visual CYBER COMPLETO
cat > style.css << 'CSSEND'
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Courier New', monospace;
    background: #000;
    color: #0f0;
    min-height: 100vh;
    position: relative;
    overflow-x: hidden;
}

/* CYBER GRID BACKGROUND */
.cyber-grid {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: 
        linear-gradient(rgba(255, 215, 0, 0.03) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255, 215, 0, 0.03) 1px, transparent 1px);
    background-size: 50px 50px;
    animation: gridMove 20s linear infinite;
    pointer-events: none;
    z-index: 0;
}

@keyframes gridMove {
    0% { transform: translate(0, 0); }
    100% { transform: translate(50px, 50px); }
}

.container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px;
    position: relative;
    z-index: 1;
}

/* HEADER CYBER */
.header {
    text-align: center;
    margin-bottom: 40px;
    padding: 30px;
    background: linear-gradient(135deg, rgba(220, 38, 38, 0.1), rgba(0, 0, 0, 0.8));
    border: 2px solid #DC2626;
    border-radius: 4px;
    position: relative;
    overflow: hidden;
    box-shadow: 
        0 0 20px rgba(255, 215, 0, 0.3),
        0 0 40px rgba(255, 0, 0, 0.2),
        inset 0 0 20px rgba(255, 215, 0, 0.1);
}

.scan-line {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 2px;
    background: linear-gradient(90deg, transparent, #FFD700, transparent);
    animation: scan 3s linear infinite;
}

@keyframes scan {
    0% { transform: translateY(0); opacity: 1; }
    100% { transform: translateY(200px); opacity: 0; }
}

.title {
    font-size: 2.5rem;
    font-weight: bold;
    margin-bottom: 10px;
    letter-spacing: 4px;
}

.cyber-text {
    background: linear-gradient(to right, #FF0000, #FFD700, #FF0000);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-shadow: 0 0 20px rgba(255, 215, 0, 0.5);
    animation: textGlow 2s ease-in-out infinite;
}

@keyframes textGlow {
    0%, 100% { filter: brightness(1); }
    50% { filter: brightness(1.3); }
}

.subtitle {
    color: #9CA3AF;
    font-size: 0.9rem;
    letter-spacing: 2px;
}

.settings-btn {
    position: absolute;
    top: 20px;
    right: 20px;
    padding: 10px 20px;
    background: linear-gradient(135deg, #3B82F6, #1D4ED8);
    border: 2px solid #3B82F6;
    color: #fff;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.3s;
}

.settings-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 20px rgba(59, 130, 246, 0.6);
}

.ai-badge {
    display: inline-block;
    margin-top: 15px;
    padding: 8px 16px;
    background: rgba(16, 185, 129, 0.2);
    border: 1px solid #10B981;
    border-radius: 4px;
    color: #10B981;
    font-size: 0.85rem;
    letter-spacing: 2px;
    animation: badgePulse 2s ease-in-out infinite;
}

@keyframes badgePulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.7; }
}

/* CARDS */
.card {
    background: linear-gradient(135deg, rgba(10, 10, 10, 0.95), rgba(0, 0, 0, 0.98));
    border: 2px solid #DC2626;
    border-radius: 4px;
    padding: 40px;
    margin-bottom: 20px;
    position: relative;
    box-shadow: 
        0 0 30px rgba(255, 0, 0, 0.2),
        inset 0 0 20px rgba(255, 215, 0, 0.05);
}

.cyber-card::before {
    content: '';
    position: absolute;
    top: -2px;
    left: -2px;
    right: -2px;
    bottom: -2px;
    background: linear-gradient(45deg, #FF0000, #FFD700, #FF0000);
    border-radius: 4px;
    z-index: -1;
    opacity: 0.3;
    filter: blur(10px);
}

.glow-line {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 2px;
    background: linear-gradient(90deg, #FF0000, #FFD700, #FF0000);
    animation: lineGlow 2s ease-in-out infinite;
}

@keyframes lineGlow {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
}

.card-title {
    font-size: 1.8rem;
    margin-bottom: 25px;
    letter-spacing: 3px;
}

/* INPUTS CYBER */
.cyber-label {
    display: block;
    color: #FFD700;
    font-size: 0.85rem;
    margin-bottom: 8px;
    letter-spacing: 1px;
    font-weight: bold;
}

.cyber-input, .cyber-textarea {
    width: 100%;
    padding: 15px;
    background: rgba(0, 0, 0, 0.8);
    border: 1px solid #374151;
    border-radius: 4px;
    color: #0f0;
    font-family: 'Courier New', monospace;
    font-size: 1rem;
    margin-bottom: 15px;
    box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.5);
    transition: all 0.3s;
}

.cyber-input:focus, .cyber-textarea:focus {
    outline: none;
    border-color: #FFD700;
    box-shadow: 
        inset 0 0 20px rgba(0, 0, 0, 0.5),
        0 0 10px rgba(255, 215, 0, 0.5);
}

.cyber-textarea {
    min-height: 120px;
    resize: vertical;
}

/* BUTTONS */
.cyber-btn {
    padding: 15px 30px;
    border: 2px solid;
    border-radius: 4px;
    font-family: 'Courier New', monospace;
    font-weight: bold;
    font-size: 1rem;
    cursor: pointer;
    letter-spacing: 2px;
    transition: all 0.3s;
    position: relative;
    overflow: hidden;
}

.btn-primary {
    background: linear-gradient(135deg, #DC2626, #991B1B);
    border-color: #FF0000;
    color: #fff;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 20px rgba(255, 0, 0, 0.6);
}

.cyber-glow {
    animation: btnGlow 2s ease-in-out infinite;
}

@keyframes btnGlow {
    0%, 100% {
        box-shadow: 0 0 20px rgba(255, 215, 0, 0.3);
    }
    50% {
        box-shadow: 0 0 40px rgba(255, 215, 0, 0.6);
    }
}

.btn-secondary {
    background: rgba(26, 26, 26, 0.8);
    border-color: #374151;
    color: #9CA3AF;
}

.btn-secondary:hover {
    border-color: #FFD700;
    color: #FFD700;
}

.cyber-btn-outline {
    background: transparent;
    border: 1px solid #374151;
    color: #D1D5DB;
    padding: 12px 20px;
}

.cyber-btn-outline:hover {
    border-color: #DC2626;
    background: rgba(220, 38, 38, 0.1);
    color: #FFD700;
}

.btn-group {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}

.btn-group .cyber-btn {
    flex: 1;
}

.btn-text {
    margin-right: 10px;
}

/* EXAMPLE GRID */
.example-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 12px;
    margin-bottom: 25px;
}

.example-btn .icon {
    color: #FF0000;
    margin-right: 8px;
}

/* SLIDER */
.cyber-slider {
    width: 100%;
    height: 8px;
    background: rgba(55, 65, 81, 0.5);
    border-radius: 4px;
    outline: none;
    margin-bottom: 10px;
    -webkit-appearance: none;
}

.cyber-slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 24px;
    height: 24px;
    background: linear-gradient(135deg, #FF0000, #FFD700);
    border-radius: 50%;
    cursor: pointer;
    box-shadow: 0 0 10px rgba(255, 215, 0, 0.8);
}

.confidence-value {
    color: #FFD700;
    font-size: 1.2rem;
    font-weight: bold;
}

.range-labels {
    display: flex;
    justify-content: space-between;
    color: #6B7280;
    font-size: 0.75rem;
    margin-bottom: 20px;
    letter-spacing: 1px;
}

/* STATS BAR */
.stats-bar {
    display: flex;
    gap: 30px;
    margin-bottom: 25px;
    padding: 15px;
    background: rgba(0, 0, 0, 0.5);
    border: 1px solid #374151;
    border-radius: 4px;
}

.stat-item {
    display: flex;
    gap: 10px;
}

.stat-label {
    color: #9CA3AF;
    font-size: 0.85rem;
}

.stat-value {
    color: #FFD700;
    font-weight: bold;
    font-size: 1.1rem;
}

/* LOADING */
.loading-container {
    text-align: center;
    padding: 60px 20px;
}

.cyber-spinner {
    width: 80px;
    height: 80px;
    margin: 0 auto 30px;
    border: 4px solid rgba(255, 215, 0, 0.2);
    border-top-color: #FF0000;
    border-right-color: #FFD700;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

.loading-title {
    font-size: 1.8rem;
    margin-bottom: 15px;
}

.loading-text {
    color: #9CA3AF;
    margin-bottom: 30px;
    font-size: 1.1rem;
}

.progress-bar {
    width: 100%;
    height: 6px;
    background: rgba(55, 65, 81, 0.5);
    border-radius: 3px;
    overflow: hidden;
    margin: 0 auto;
    max-width: 400px;
}

.progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #FF0000, #FFD700);
    animation: progress 2s ease-in-out infinite;
}

@keyframes progress {
    0% { width: 0%; }
    50% { width: 100%; }
    100% { width: 0%; }
}

/* MODAL */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.95);
    z-index: 1000;
    align-items: center;
    justify-content: center;
}

.modal.active {
    display: flex;
}

.modal-content {
    background: linear-gradient(135deg, rgba(10, 10, 10, 0.98), rgba(0, 0, 0, 1));
    border: 2px solid #3B82F6;
    border-radius: 4px;
    padding: 40px;
    max-width: 600px;
    width: 90%;
    position: relative;
    box-shadow: 0 0 50px rgba(59, 130, 246, 0.5);
}

.modal-title {
    font-size: 1.5rem;
    margin-bottom: 25px;
    color: #3B82F6;
}

/* INFO PANEL */
.info-panel {
    background: rgba(26, 26, 26, 0.8);
    border: 1px solid #374151;
    border-radius: 4px;
    padding: 15px;
    margin-bottom: 15px;
    font-size: 0.85rem;
    line-height: 1.6;
    color: #D1D5DB;
}

.info-panel strong {
    color: #FFD700;
}

.info-panel a {
    color: #3B82F6;
    text-decoration: none;
}

.info-panel a:hover {
    text-decoration: underline;
}

/* STATUS DISPLAY */
.status-display {
    padding: 12px;
    border-radius: 4px;
    margin-bottom: 15px;
    font-size: 0.9rem;
}

.status-display.valid {
    background: rgba(16, 185, 129, 0.1);
    border: 1px solid #10B981;
    color: #10B981;
}

.status-display.invalid {
    background: rgba(239, 68, 68, 0.1);
    border: 1px solid #EF4444;
    color: #EF4444;
}

/* RESULTS */
.result-section {
    margin-bottom: 40px;
}

.result-title {
    font-size: 1.3rem;
    margin-bottom: 20px;
    letter-spacing: 2px;
}

.result-item {
    background: rgba(26, 26, 26, 0.6);
    border: 1px solid rgba(255, 215, 0, 0.3);
    border-radius: 4px;
    padding: 20px;
    margin-bottom: 15px;
    transition: all 0.3s;
}

.result-item:hover {
    border-color: rgba(255, 215, 0, 0.6);
    box-shadow: 0 0 15px rgba(255, 215, 0, 0.2);
}

/* UTILITIES */
.hidden {
    display: none !important;
}

.cyber-subtitle {
    color: #9CA3AF;
    font-size: 0.85rem;
    margin-bottom: 12px;
    letter-spacing: 1px;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .title {
        font-size: 1.8rem;
    }
    
    .settings-btn {
        position: static;
        display: block;
        width: 100%;
        margin-top: 15px;
    }
    
    .example-grid {
        grid-template-columns: 1fr;
    }
    
    .btn-group {
        flex-direction: column;
    }
}
CSSEND

# Criar app.js (continua no próximo bloco)
cat > app.js << 'APPJSEND'
let currentStep = 0, apiKey = '', aiProvider = 'gemini';
let problem = '', confidence = 7, categories = {}, results = null;

const PROVIDERS = {
    claude: {
        name: 'Anthropic Claude',
        url: 'https://console.anthropic.com',
        keyFormat: 'sk-ant-api03-',
        info: 'Best for complex analysis. Supports file uploads. API Key starts with sk-ant-api03-'
    },
    gemini: {
        name: 'Google Gemini',
        url: 'https://aistudio.google.com/app/apikey',
        keyFormat: 'AIza',
        info: '100% FREE! Model: gemini-1.5-flash (v1beta). Fast & smart. 1500 req/day. API Key starts with AIza'
    },
    openai: {
        name: 'OpenAI GPT-4',
        url: 'https://platform.openai.com/api-keys',
        keyFormat: 'sk-',
        info: 'Versatile and powerful. API Key starts with sk-'
    },
    huggingface: {
        name: 'Hugging Face (FREE)',
        url: 'https://huggingface.co/settings/tokens',
        keyFormat: 'hf_',
        info: '100% FREE! Community models. API Key starts with hf_'
    }
};

const EXAMPLES = [
    { desc: '40%+ no-show rate on scheduled discovery calls despite follow-ups', conf: 9 },
    { desc: 'Hired closers and sales coaches but performance did not improve', conf: 8 },
    { desc: 'Need 10-15+ touchpoints before prospects book discovery calls', conf: 7 }
];

const CATEGORIES_DATA = {
    strategy: { 
        name: 'Strategy & Positioning', 
        icon: '🎯', 
        color: '#3B82F6',
        commonIssues: [
            'Unclear ICP definition',
            'Multiple service offerings creating confusion',
            'Promise-delivery misalignment',
            'Weak competitive differentiation'
        ]
    },
    people: { 
        name: 'People & Skills', 
        icon: '👥', 
        color: '#8B5CF6',
        commonIssues: [
            'Closers not aligned with ICP',
            'High team turnover',
            'Skill gaps in key roles',
            'Lack of role clarity'
        ]
    },
    process: { 
        name: 'Processes & Workflow', 
        icon: '⚙️', 
        color: '#EC4899',
        commonIssues: [
            'Weak lead qualification',
            'Too many touchpoints required',
            'Unclear handoff between teams',
            'Bottlenecks in sales process'
        ]
    },
    tools: { 
        name: 'Tools & Technology', 
        icon: '🔧', 
        color: '#F97316',
        commonIssues: [
            'CRM not being used effectively',
            'Too many tools with low adoption',
            'Data scattered across systems',
            'Manual processes that could be automated'
        ]
    },
    data: { 
        name: 'Data & Metrics', 
        icon: '📊', 
        color: '#10B981', 
        hasUpload: true,
        commonIssues: [
            'No-show rate not tracked by source',
            'Activity metrics vs outcome metrics',
            'No attribution model',
            'Vanity metrics instead of actionable ones'
        ]
    },
    leadgen: { 
        name: 'Lead Gen & Marketing', 
        icon: '📈', 
        color: '#06B6D4',
        commonIssues: [
            'Volume optimization over intent',
            'Misleading ad promises',
            'Wrong lead magnet attracting wrong prospects',
            'Channel-ICP mismatch'
        ]
    },
    clients: { 
        name: 'Communication', 
        icon: '💬', 
        color: '#6366F1',
        commonIssues: [
            'Unclear value proposition',
            'Weak confirmation and reminder flow',
            'No perceived cost of missing meeting',
            'Misaligned expectations'
        ]
    },
    leadership: { 
        name: 'Leadership', 
        icon: '👔', 
        color: '#EF4444',
        commonIssues: [
            'Tactical fixes instead of structural changes',
            'Founder bottlenecks',
            'Reactive instead of proactive',
            'Strategy changing too frequently'
        ]
    }
};

// Initialize categories
Object.keys(CATEGORIES_DATA).forEach(key => {
    categories[key] = { ...CATEGORIES_DATA[key], issues: [], files: [] };
});

function updateProviderInfo() {
    const p = PROVIDERS[document.getElementById('aiProvider').value];
    document.getElementById('providerInfo').innerHTML = `
        <strong>${p.name}</strong><br>
        ${p.info}<br>
        <a href="${p.url}" target="_blank">Get API Key →</a>
    `;
}

function updateInitialInfo() {
    const p = PROVIDERS[document.getElementById('initialProvider').value];
    document.getElementById('initialInfo').innerHTML = `
        <strong>${p.name}</strong><br>
        ${p.info}<br>
        <a href="${p.url}" target="_blank">Get API Key →</a>
    `;
}

function openSettings() {
    document.getElementById('settingsApiKeyInput').value = apiKey;
    document.getElementById('aiProvider').value = aiProvider;
    updateProviderInfo();
    updateApiStatus();
    document.getElementById('settingsModal').classList.add('active');
}

function closeSettings() {
    document.getElementById('settingsModal').classList.remove('active');
}

function updateApiStatus() {
    const status = document.getElementById('apiStatus');
    const p = PROVIDERS[aiProvider];
    if (apiKey) {
        status.className = 'status-display valid';
        status.innerHTML = `✅ ${p.name} configured<br>API Key: ${apiKey.substring(0, 20)}...`;
    } else {
        status.className = 'status-display invalid';
        status.textContent = '❌ No API Key configured';
    }
}

function saveSettings() {
    aiProvider = document.getElementById('aiProvider').value;
    apiKey = document.getElementById('settingsApiKeyInput').value.trim();
    if (!apiKey) { alert('Enter API Key'); return; }
    localStorage.setItem('ai_config', JSON.stringify({ provider: aiProvider, apiKey }));
    document.getElementById('aiBadge').textContent = PROVIDERS[aiProvider].name.toUpperCase();
    alert('✅ Configuration saved!');
    closeSettings();
    if (currentStep === 0) goToStep(1);
}

function saveApiKey() {
    aiProvider = document.getElementById('initialProvider').value;
    apiKey = document.getElementById('apiKeyInput').value.trim();
    if (!apiKey) { alert('Enter API Key'); return; }
    localStorage.setItem('ai_config', JSON.stringify({ provider: aiProvider, apiKey }));
    document.getElementById('aiBadge').textContent = PROVIDERS[aiProvider].name.toUpperCase();
    goToStep(1);
}

function goToStep(step) {
    for (let i = 0; i <= 4; i++) {
        document.getElementById('step' + i).classList.add('hidden');
    }
    document.getElementById('step' + step).classList.remove('hidden');
    currentStep = step;
}

function loadExample(idx) {
    const ex = EXAMPLES[idx];
    document.getElementById('problemInput').value = ex.desc;
    problem = ex.desc;
    confidence = ex.conf;
    document.getElementById('confidenceSlider').value = ex.conf;
    updateConfidence(ex.conf);
}

function updateConfidence(val) {
    confidence = parseInt(val);
    document.getElementById('confidenceValue').textContent = confidence;
}

function renderCategories() {
    const container = document.getElementById('categoriesContainer');
    container.innerHTML = '';
    
    Object.entries(categories).forEach(([key, cat]) => {
        const card = document.createElement('div');
        card.className = 'result-item';
        card.style.borderColor = cat.color + '40';
        
        let html = `
            <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 15px;">
                <span style="font-size: 2rem;">${cat.icon}</span>
                <div style="flex: 1;">
                    <h3 style="color: ${cat.color}; font-size: 1.1rem; margin-bottom: 5px;">${cat.name}</h3>
                    <span style="color: #9CA3AF; font-size: 0.85rem;">${cat.issues.length} symptoms${cat.hasUpload ? ` • ${cat.files.length} files` : ''}</span>
                </div>
            </div>`;
        
        // Common issues quick add
        if (cat.commonIssues && cat.commonIssues.length > 0) {
            html += `
                <div style="margin-bottom: 15px;">
                    <button onclick="toggleCommonIssues('${key}')" class="cyber-btn-outline" style="width: 100%; padding: 8px; text-align: left; margin-bottom: 10px;">
                        <span style="color: #FFD700;">▶</span> COMMON ISSUES
                    </button>
                    <div id="common-${key}" class="hidden" style="background: rgba(0,0,0,0.5); border: 1px solid #374151; border-radius: 4px; padding: 10px;">`;
            
            cat.commonIssues.forEach(issue => {
                html += `
                    <button onclick="addIssue('${key}', \`${issue}\`)" 
                            style="display: block; width: 100%; padding: 8px; margin-bottom: 6px; background: transparent; border: none; color: #D1D5DB; font-size: 0.85rem; text-align: left; cursor: pointer; font-family: 'Courier New', monospace;"
                            onmouseover="this.style.color='#FFD700'" onmouseout="this.style.color='#D1D5DB'">
                        + ${issue}
                    </button>`;
            });
            
            html += `
                    </div>
                </div>`;
        }
        
        // File upload section for Data & Metrics
        if (cat.hasUpload) {
            html += `
                <div style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10B981; border-radius: 4px; padding: 12px; margin-bottom: 15px;">
                    <p style="color: #10B981; font-size: 0.85rem; margin-bottom: 10px;">💡 Upload data files (PDF, Excel, CSV, Images)</p>
                    <input type="file" id="fileInput-${key}" accept=".pdf,.jpg,.jpeg,.png,.xlsx,.xls,.csv" multiple style="display: none;" onchange="handleFileUpload('${key}', this.files)">
                    <button onclick="document.getElementById('fileInput-${key}').click()" class="btn-secondary cyber-btn" style="width: 100%; padding: 10px; background: linear-gradient(135deg, #10B981, #059669); border-color: #10B981; color: #fff;">
                        📎 UPLOAD FILES
                    </button>
                </div>
                <div id="files-${key}" style="margin-bottom: 15px;"></div>`;
        }
        
        html += `
            <div id="issues-${key}" style="margin-bottom: 15px;"></div>
            <input type="text" id="input-${key}" placeholder="Add custom symptom..." 
                   class="cyber-input" style="margin-bottom: 10px;"
                   onkeypress="if(event.key==='Enter'){addIssue('${key}', this.value); this.value='';}">
            <button onclick="addIssue('${key}', document.getElementById('input-${key}').value); document.getElementById('input-${key}').value='';" 
                    class="btn-secondary cyber-btn" style="width: 100%; padding: 10px;">
                ADD SYMPTOM
            </button>
        `;
        
        card.innerHTML = html;
        container.appendChild(card);
        renderIssues(key);
        if (cat.hasUpload) renderFiles(key);
    });
    
    updateTotalSymptoms();
}

function toggleCommonIssues(catKey) {
    const element = document.getElementById('common-' + catKey);
    element.classList.toggle('hidden');
}

function handleFileUpload(catKey, files) {
    Array.from(files).forEach(file => {
        if (file.size > 10 * 1024 * 1024) {
            alert('File too large: ' + file.name + ' (max 10MB)');
            return;
        }
        
        const reader = new FileReader();
        reader.onload = function(e) {
            categories[catKey].files.push({
                name: file.name,
                type: file.type,
                size: file.size,
                base64: e.target.result.split(',')[1]
            });
            renderFiles(catKey);
            updateTotalSymptoms();
        };
        reader.readAsDataURL(file);
    });
}

function removeFile(catKey, idx) {
    categories[catKey].files.splice(idx, 1);
    renderFiles(catKey);
    updateTotalSymptoms();
}

function renderFiles(catKey) {
    const container = document.getElementById('files-' + catKey);
    if (!container) return;
    container.innerHTML = '';
    
    categories[catKey].files.forEach((file, idx) => {
        const div = document.createElement('div');
        const sizeKB = Math.round(file.size / 1024);
        const sizeText = sizeKB > 1024 ? (sizeKB / 1024).toFixed(1) + ' MB' : sizeKB + ' KB';
        
        div.style.cssText = 'display: flex; justify-content: space-between; align-items: center; background: rgba(16, 185, 129, 0.1); padding: 10px; margin-bottom: 8px; border: 1px solid #10B981; border-radius: 4px;';
        div.innerHTML = `
            <span style="color: #10B981; flex: 1; font-size: 0.9rem;">📄 ${file.name}</span>
            <span style="color: #6B7280; font-size: 0.75rem; margin: 0 10px;">${sizeText}</span>
            <button onclick="removeFile('${catKey}', ${idx})" 
                    style="background: transparent; border: none; color: #EF4444; cursor: pointer; font-size: 1.2rem; padding: 0 8px;">
                ×
            </button>
        `;
        container.appendChild(div);
    });
}

function addIssue(catKey, issue) {
    if (!issue || !issue.trim()) return;
    categories[catKey].issues.push(issue.trim());
    renderIssues(catKey);
    updateTotalSymptoms();
}

function removeIssue(catKey, idx) {
    categories[catKey].issues.splice(idx, 1);
    renderIssues(catKey);
    updateTotalSymptoms();
}

function renderIssues(catKey) {
    const container = document.getElementById('issues-' + catKey);
    if (!container) return;
    container.innerHTML = '';
    categories[catKey].issues.forEach((issue, idx) => {
        const div = document.createElement('div');
        div.style.cssText = 'display: flex; justify-content: space-between; align-items: center; background: rgba(0,0,0,0.5); padding: 10px; margin-bottom: 8px; border: 1px solid #374151; border-radius: 4px;';
        div.innerHTML = `
            <span style="color: #D1D5DB; flex: 1;">${issue}</span>
            <button onclick="removeIssue('${catKey}', ${idx})" 
                    style="background: transparent; border: none; color: #EF4444; cursor: pointer; font-size: 1.2rem; padding: 0 8px;">
                ×
            </button>
        `;
        container.appendChild(div);
    });
}

function updateTotalSymptoms() {
    const total = Object.values(categories).reduce((sum, cat) => sum + cat.issues.length, 0);
    document.getElementById('totalSymptoms').textContent = total;
}

async function runAnalysis() {
    problem = document.getElementById('problemInput').value.trim();
    
    const totalSymptoms = Object.values(categories).reduce((sum, cat) => sum + cat.issues.length, 0);
    const totalFiles = Object.values(categories).reduce((sum, cat) => sum + (cat.files ? cat.files.length : 0), 0);
    
    if (!problem && totalSymptoms === 0 && totalFiles === 0) { 
        alert('Add problem description, symptoms, or upload files'); 
        return; 
    }
    
    if (!problem) {
        problem = 'Business problem analysis based on symptoms';
    }
    
    goToStep(3);
    document.getElementById('loadingText').textContent = `Processing with ${PROVIDERS[aiProvider].name}...`;

    const symptomsText = Object.entries(categories)
        .filter(([_, cat]) => cat.issues.length > 0)
        .map(([_, cat]) => `${cat.name}: ${cat.issues.join(', ')}`)
        .join('. ');

    const filesText = Object.entries(categories)
        .filter(([_, cat]) => cat.files && cat.files.length > 0)
        .map(([_, cat]) => `${cat.name}: ${cat.files.length} file(s) uploaded (${cat.files.map(f => f.name).join(', ')})`)
        .join('. ');

    const prompt = `Analyze this business problem using Ishikawa methodology.

PROBLEM: ${problem}
CONFIDENCE: ${confidence}/10
SYMPTOMS: ${symptomsText || 'None provided'}
${filesText ? `FILES UPLOADED: ${filesText}` : ''}

${totalFiles > 0 ? 'Note: User has uploaded data files. Consider this as additional evidence of data/metrics issues.' : ''}

Provide JSON response:
{
  "rootCauses": [{"cause": "...", "confidence": 9, "evidence": "..."}],
  "recommendations": [{"priority": "HIGH", "action": "...", "impact": "..."}],
  "insights": ["..."]
}

JSON only, no markdown.`;

    try {
        console.log('🤖 Using:', PROVIDERS[aiProvider].name);
        let response;

        if (aiProvider === 'claude') {
            response = await fetch('https://api.anthropic.com/v1/messages', {
                method: 'POST',
                headers: {
                    'x-api-key': apiKey,
                    'anthropic-version': '2023-06-01',
                    'content-type': 'application/json'
                },
                body: JSON.stringify({
                    model: 'claude-sonnet-4-20250514',
                    max_tokens: 4000,
                    messages: [{ role: 'user', content: prompt }]
                })
            });
        } else if (aiProvider === 'gemini') {
            // December 2025: Use v1beta with gemini-1.5-flash (recommended)
            console.log('🤖 Using Gemini model: gemini-1.5-flash (v1beta)');
            response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${apiKey}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    contents: [{ parts: [{ text: prompt }] }]
                })
            });
        } else if (aiProvider === 'huggingface') {
            // Use free Hugging Face Inference API
            response = await fetch('https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2', {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${apiKey}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    inputs: prompt,
                    parameters: {
                        max_new_tokens: 2000,
                        temperature: 0.7,
                        return_full_text: false
                    }
                })
            });
        } else {
            response = await fetch('https://api.openai.com/v1/chat/completions', {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${apiKey}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    model: 'gpt-4o',
                    messages: [{ role: 'user', content: prompt }],
                    max_tokens: 4000
                })
            });
        }

        if (!response.ok) {
            const errorData = await response.json().catch(() => ({}));
            console.error('API Error:', errorData);
            
            let errorMsg = `API Error ${response.status}\n\n`;
            
            if (response.status === 401) {
                errorMsg += '❌ API Key inválida ou expirada\n\n';
                errorMsg += 'Solução:\n';
                errorMsg += `• Vá em ${PROVIDERS[aiProvider].url}\n`;
                errorMsg += '• Crie nova API Key\n';
                errorMsg += '• Clique em ⚙️ SETTINGS e atualize';
            } else if (response.status === 429) {
                errorMsg += '❌ Limite de requisições excedido\n\n';
                errorMsg += 'Solução:\n';
                errorMsg += '• Aguarde 1-2 minutos\n';
                errorMsg += '• Ou troque de provedor (⚙️ SETTINGS)';
            } else if (response.status === 403) {
                errorMsg += '❌ Sem créditos ou acesso negado\n\n';
                if (aiProvider === 'openai') {
                    errorMsg += 'OpenAI requer créditos pagos:\n';
                    errorMsg += '• Adicione $5+ em platform.openai.com/settings/organization/billing\n';
                    errorMsg += '• OU use Gemini (grátis) em ⚙️ SETTINGS';
                } else if (aiProvider === 'claude') {
                    errorMsg += 'Claude requer créditos:\n';
                    errorMsg += '• Adicione créditos em console.anthropic.com\n';
                    errorMsg += '• OU use Gemini (grátis) em ⚙️ SETTINGS';
                } else {
                    errorMsg += 'Solução:\n';
                    errorMsg += '• Verifique sua conta\n';
                    errorMsg += '• Tente outro provedor';
                }
            } else if (response.status === 404) {
                errorMsg += '❌ Modelo não encontrado\n\n';
                errorMsg += 'Solução:\n';
                errorMsg += '• API do Google mudou\n';
                errorMsg += '• Tente Claude ou OpenAI\n';
                errorMsg += '• Ou aguarde atualização';
            } else {
                errorMsg += `Detalhes: ${JSON.stringify(errorData)}\n\n`;
                errorMsg += 'Solução:\n';
                errorMsg += '• Verifique API Key\n';
                errorMsg += '• Verifique créditos\n';
                errorMsg += '• Tente outro provedor';
            }
            
            throw new Error(errorMsg);
        }

        const data = await response.json();
        let content;
        if (aiProvider === 'claude') content = data.content[0].text;
        else if (aiProvider === 'gemini') content = data.candidates[0].content.parts[0].text;
        else if (aiProvider === 'huggingface') {
            // Hugging Face returns array with generated_text
            content = Array.isArray(data) ? data[0].generated_text : data.generated_text || '';
        }
        else content = data.choices[0].message.content;

        const jsonMatch = content.match(/\{[\s\S]*\}/);
        if (jsonMatch) {
            results = JSON.parse(jsonMatch[0]);
            displayResults();
            goToStep(4);
        } else {
            throw new Error('Invalid JSON response');
        }
    } catch (error) {
        console.error('Error:', error);
        goToStep(2);
        alert(`Error: ${error.message}\n\nCheck:\n• API Key valid?\n• Account has credits?\n• Internet connection?\n\nPress F12 to see console logs.`);
    }
}

function displayResults() {
    let html = `<div style="text-align: center; margin-bottom: 30px; padding: 15px; background: rgba(16,185,129,0.1); border: 1px solid #10B981; border-radius: 4px;">
        <span style="color: #9CA3AF;">Analysis powered by:</span>
        <span style="color: #10B981; font-weight: bold; margin-left: 10px; font-size: 1.1rem;">${PROVIDERS[aiProvider].name}</span>
    </div>`;
    
    if (results.rootCauses?.length) {
        html += '<div class="result-section"><h3 class="result-title cyber-text">🔴 ROOT CAUSES</h3>';
        results.rootCauses.forEach(c => {
            html += `<div class="result-item">
                <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                    <h4 style="color: #FFD700; font-size: 1.2rem; flex: 1;">${c.cause}</h4>
                    <span style="background: ${c.confidence >= 8 ? '#10B981' : c.confidence >= 6 ? '#F59E0B' : '#EF4444'}; color: #000; padding: 6px 14px; border-radius: 4px; font-weight: bold;">${c.confidence}/10</span>
                </div>
                ${c.evidence ? `<p style="color: #9CA3AF; line-height: 1.6;">${c.evidence}</p>` : ''}
            </div>`;
        });
        html += '</div>';
    }
    
    if (results.recommendations?.length) {
        html += '<div class="result-section"><h3 class="result-title cyber-text" style="color: #10B981;">✅ RECOMMENDATIONS</h3>';
        results.recommendations.forEach((r, i) => {
            const priorityColor = r.priority === 'HIGH' ? '#DC2626' : r.priority === 'MEDIUM' ? '#F59E0B' : '#6B7280';
            html += `<div class="result-item" style="background: linear-gradient(135deg, rgba(16,185,129,0.1), rgba(0,0,0,0.5)); border-color: #10B981;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 12px;">
                    <span style="color: #FFD700; font-weight: bold; font-size: 1.1rem;">[${i+1}]</span>
                    <span style="background: ${priorityColor}; color: #fff; padding: 4px 12px; border-radius: 4px; font-size: 0.85rem; font-weight: bold;">${r.priority}</span>
                </div>
                <p style="color: #fff; font-size: 1.05rem; margin-bottom: 12px; line-height: 1.6;">${r.action}</p>
                ${r.impact ? `<p style="color: #D1FAE5; font-style: italic; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 12px; margin-top: 12px;">Impact: ${r.impact}</p>` : ''}
            </div>`;
        });
        html += '</div>';
    }
    
    if (results.insights?.length) {
        html += '<div class="result-section"><h3 class="result-title cyber-text" style="color: #3B82F6;">💡 KEY INSIGHTS</h3>';
        results.insights.forEach(insight => {
            html += `<div class="result-item" style="border-color: #3B82F6;">
                <p style="color: #D1D5DB; line-height: 1.8; font-size: 1rem;">• ${insight}</p>
            </div>`;
        });
        html += '</div>';
    }
    
    document.getElementById('resultsContainer').innerHTML = html;
}

function resetAnalysis() {
    problem = ''; confidence = 7; results = null;
    Object.keys(categories).forEach(key => {
        categories[key].issues = [];
        categories[key].files = [];
    });
    document.getElementById('problemInput').value = '';
    document.getElementById('confidenceSlider').value = 7;
    updateConfidence(7);
    renderCategories();
    goToStep(1);
}

function exportResults() {
    const data = {
        version: '4.0-cyber',
        aiProvider: PROVIDERS[aiProvider].name,
        problem, confidence,
        categories: Object.entries(categories).map(([key, cat]) => ({
            name: cat.name,
            issues: cat.issues,
            filesCount: cat.files ? cat.files.length : 0
        })),
        results,
        timestamp: new Date().toISOString()
    };
    const blob = new Blob([JSON.stringify(data, null, 2)], {type: 'application/json'});
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'ishikawa-analysis-' + Date.now() + '.json';
    a.click();
    URL.revokeObjectURL(url);
}

window.onload = function() {
    const stored = localStorage.getItem('ai_config');
    if (stored) {
        const config = JSON.parse(stored);
        apiKey = config.apiKey;
        aiProvider = config.provider;
        document.getElementById('aiBadge').textContent = PROVIDERS[aiProvider].name.toUpperCase();
        goToStep(1);
        renderCategories();
    } else {
        updateInitialInfo();
    }
};
APPJSEND

# Scripts de inicialização
if [[ "$OS" == "mac" ]] || [[ "$OS" == "linux" ]]; then
    cat > "Abrir Leo's Ishikawa.command" << 'STARTSH'
#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
echo "╔════════════════════════════════════════════════════╗"
echo "║  LEO'S ISHIKAWA ANALYZER v4.0 CYBER              ║"
echo "╚════════════════════════════════════════════════════╝"
if command -v python3 &> /dev/null; then
    python3 -m http.server 8000 &
elif command -v python &> /dev/null; then
    python -m http.server 8000 &
fi
sleep 2
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "http://localhost:8000"
else
    xdg-open "http://localhost:8000" 2>/dev/null
fi
echo "✅ http://localhost:8000"
echo "⚠️  Close: Ctrl+C"
wait
STARTSH
    chmod +x "Abrir Leo's Ishikawa.command"
else
    cat > "Abrir Leo's Ishikawa.bat" << 'STARTBAT'
@echo off
cd /d "%~dp0"
start http://localhost:8000
python -m http.server 8000
STARTBAT
fi

cat > README.txt << 'README'
LEO'S ISHIKAWA ANALYZER v4.0 CYBER EDITION
===========================================

VISUAL TRON/MATRIX ORIGINAL MANTIDO!

FEATURES:
✅ Cyber visual style (red/gold/black)
✅ Multi-AI (Claude, Gemini, OpenAI)
✅ 8 Ishikawa categories
✅ Real-time analysis
✅ Export results
✅ Animated interface

HOW TO USE:
1. Double-click executable
2. Choose AI provider (Gemini = FREE!)
3. Paste API Key
4. Add symptoms
5. Run analysis!

Version: 4.0 Cyber Fixed
README

clear
echo "╔════════════════════════════════════════════════════════╗"
echo "║         ✅ v4.0 CYBER EDITION INSTALLED!              ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "📍 $INSTALL_DIR"
echo ""
echo "🎨 VISUAL CYBER TRON/MATRIX:"
echo "   • Red/Gold/Black theme"
echo "   • Animated grid background"
echo "   • Glowing effects"
echo "   • Cyber buttons and inputs"
echo ""
echo "🤖 MULTI-AI WORKING:"
echo "   • Gemini (FREE!)"
echo "   • Claude"
echo "   • OpenAI"
echo ""
echo "🚀 Double-click to launch!"
echo ""
read -p "Press ENTER..."
