# 🎯 Ishikawa Analyzer

> **v4.0 Cyber Edition** — A powerful multi-AI powered root cause analysis tool using the Ishikawa (Fishbone) methodology with a stunning TRON/Matrix-inspired cyber interface.

![Version](https://img.shields.io/badge/version-4.0-red)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Windows%20|%20macOS%20|%20Linux-blue)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Getting Started](#-getting-started)
- [Supported AI Providers](#-supported-ai-providers)
- [How to Use](#-how-to-use)
- [Ishikawa Categories](#-ishikawa-categories)
- [Export & Results](#-export--results)
- [Troubleshooting](#-troubleshooting)

---

## 🔍 Overview

The **Ishikawa Analyzer** is a web-based diagnostic tool that helps identify root causes of business problems using the classic Ishikawa (Fishbone) diagram methodology, enhanced with AI-powered analysis. Perfect for:

- Sales performance issues
- High no-show rates
- Long sales cycles
- Process bottlenecks
- Team performance gaps

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🤖 **Multi-AI Support** | Claude, Gemini (FREE), OpenAI GPT-4, Hugging Face (FREE) |
| 🎨 **Cyber Visual Theme** | TRON/Matrix-inspired red/gold/black interface |
| 📊 **8 Analysis Categories** | Comprehensive Ishikawa framework |
| ⚡ **Real-time Analysis** | Instant AI-powered root cause identification |
| 📁 **File Upload Support** | Attach data files for deeper analysis |
| 💾 **Export Results** | Download analysis as JSON |
| 📱 **Responsive Design** | Works on desktop and mobile |
| 🔒 **Local Storage** | API keys stored securely in browser |

---

## 📸 Screenshots

The interface features:

- Animated cyber grid background
- Glowing neon effects
- Scan line animations
- Pulsing buttons and badges

---

## 📦 Requirements

- **Python 3.x** (for local HTTP server)
- **Modern web browser** (Chrome, Firefox, Safari, Edge)
- **API Key** from one of the supported AI providers

---

## 🚀 Installation

### Quick Install (All Platforms)

```bash
# Clone the repository
git clone https://github.com/Project-Raptor/ishikawa-analyzer
cd ishikawa-analyzer

# Run the installer
chmod +x install.sh
./install.sh
```

### What the Installer Does

1. ✅ Detects your operating system (Windows/macOS/Linux)
2. ✅ Creates the application folder on your Desktop (`~/Desktop/IshikawaAnalyzer`)
3. ✅ Generates all necessary files (HTML, CSS, JavaScript)
4. ✅ Creates platform-specific launch scripts
5. ✅ Sets up a local Python HTTP server

### Installation Location

| OS | Installation Path |
|----|-------------------|
| Windows | `C:\Users\<username>\Desktop\IshikawaAnalyzer` |
| macOS | `~/Desktop/IshikawaAnalyzer` |
| Linux | `~/Desktop/IshikawaAnalyzer` |

---

## 🎬 Getting Started

### Step 1: Launch the Application

**macOS/Linux:**

```bash
cd ~/Desktop/IshikawaAnalyzer
./Abrir\ Leo\'s\ Ishikawa.command
```

**Windows:**

```env
Double-click "Abrir Leo's Ishikawa.bat"
```

### Step 2: Access in Browser

The application will automatically open at:

```env
http://localhost:8000
```

### Step 3: Get Your API Key

Choose a provider and obtain your API key:

| Provider | Free? | Get Key |
|----------|-------|---------|
| Google Gemini | ✅ YES | [aistudio.google.com](https://aistudio.google.com/app/apikey) |
| Hugging Face | ✅ YES | [huggingface.co/settings/tokens](https://huggingface.co/settings/tokens) |
| Anthropic Claude | ❌ Paid | [console.anthropic.com](https://console.anthropic.com) |
| OpenAI GPT-4 | ❌ Paid | [platform.openai.com](https://platform.openai.com/api-keys) |

### Step 4: Configure & Analyze

1. Paste your API key in the initialization screen
2. Click **"INITIALIZE SYSTEM"**
3. You're ready to analyze!

---

## 🤖 Supported AI Providers

### Google Gemini (Recommended - FREE)

- **Model:** `gemini-1.5-flash`
- **Limit:** 1,500 requests/day
- **Key Format:** Starts with `AIza`
- **Best For:** Fast, cost-effective analysis

### Hugging Face (FREE Alternative)

- **Key Format:** Starts with `hf_`
- **Best For:** Community models, experimentation

### Anthropic Claude

- **Key Format:** Starts with `sk-ant-api03-`
- **Best For:** Complex analysis, file processing

### OpenAI GPT-4

- **Key Format:** Starts with `sk-`
- **Best For:** Versatile, powerful reasoning

---

## 📖 How to Use

### Step 1: Define Your Problem

1. Select from **quick-load templates** or write your own problem description
2. Set your **confidence level** (1-10) for how certain you are about the problem
3. Click **"PROCEED TO MAPPING"**

**Example Problems:**

- "40%+ no-show rate on scheduled discovery calls despite follow-ups"
- "Hired closers and sales coaches but performance did not improve"
- "Need 10-15+ touchpoints before prospects book discovery calls"

### Step 2: Map Symptoms to Categories

1. Review each of the **8 Ishikawa categories**
2. Add relevant symptoms/issues to each category
3. Use the **suggested common issues** as inspiration
4. Upload supporting data files (optional)

### Step 3: Run AI Analysis

1. Click **"RUN AI ANALYSIS"**
2. Wait for the AI to process your inputs
3. Watch the cyber loading animation

### Step 4: Review Results

1. Examine the **root cause analysis**
2. Review **recommendations** and **action items**
3. **Export results** as JSON for documentation

---

## 📊 Ishikawa Categories

The analyzer uses 8 comprehensive categories based on the Ishikawa methodology:

| Category | Icon | Focus Area |
|----------|------|------------|
| **Strategy & Positioning** | 🎯 | ICP definition, service offerings, competitive differentiation |
| **People & Skills** | 👥 | Team alignment, turnover, skill gaps, role clarity |
| **Processes & Workflow** | ⚙️ | Lead qualification, handoffs, bottlenecks |
| **Tools & Technology** | 🔧 | CRM usage, tool adoption, automation |
| **Data & Metrics** | 📊 | Tracking, attribution, actionable metrics |
| **Lead Gen & Marketing** | 📈 | Volume vs intent, ad promises, channel fit |
| **Communication** | 💬 | Value proposition, follow-up flows, expectations |
| **Leadership** | 👔 | Strategic vs tactical, founder bottlenecks |

---

## 💾 Export & Results

### Export Format

Results are exported as JSON with the following structure:

```json
{
  "version": "4.0-cyber",
  "aiProvider": "Google Gemini",
  "problem": "Your problem description",
  "confidence": 7,
  "categories": [...],
  "results": {...},
  "timestamp": "2026-01-15T..."
}
```

### What's Included

- ✅ Problem definition and confidence level
- ✅ All mapped symptoms by category
- ✅ AI analysis results and recommendations
- ✅ Timestamp for documentation

---

## 🔧 Troubleshooting

### Application Won't Start

```bash
# Check if Python is installed
python3 --version

# Or try
python --version
```

### Port 8000 Already in Use

```bash
# Find and kill the process using port 8000
lsof -i :8000
kill -9 <PID>
```

### API Key Not Working

1. Verify the key format matches your provider
2. Check that the key hasn't expired
3. Ensure you have API credits (for paid providers)

### Browser Shows Blank Page

1. Clear browser cache
2. Try a different browser
3. Check the browser console for errors (F12)

---

## 🛑 Stopping the Server

Press `Ctrl+C` in the terminal to stop the local server.

---

## 📄 License

MIT License - Feel free to use, modify, and distribute.

