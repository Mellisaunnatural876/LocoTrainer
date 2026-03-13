#!/bin/bash
set -e

echo "=========================================="
echo "LocoTrainer Dev Environment Setup"
echo "=========================================="
echo ""

# Check/install uv
if ! command -v uv &> /dev/null; then
    echo "→ Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "✓ uv already installed ($(uv --version))"
fi

# Check repo
if [ ! -f "pyproject.toml" ]; then
    echo "Error: Run this script from the LocoTrainer repo root."
    echo "  git clone https://github.com/LocoreMind/LocoTrainer.git"
    echo "  cd LocoTrainer"
    echo "  ./scripts/setup_locotrainer_dev.sh"
    exit 1
fi

# Sync dependencies
echo "→ Syncing dependencies with uv..."
uv sync

# Create .env from example
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "✓ Created .env from .env.example"
    echo "  → Edit .env with your API key before running"
else
    echo "✓ .env already exists"
fi

# Verify
echo ""
echo "=========================================="
echo "Dev Environment Ready"
echo "=========================================="
uv run locotrainer --version | sed 's/^/✓ /'

echo ""
echo "=========================================="
echo "Next Steps"
echo "=========================================="
echo ""
echo "1. Edit your API configuration:"
echo "   nano .env"
echo ""
echo "2. Run LocoTrainer:"
echo "   uv run locotrainer run -q \"What are the default LoRA settings in ms-swift?\""
echo ""
echo "3. Run with a specific codebase:"
echo "   uv run locotrainer run -q \"How does authentication work?\" -c /path/to/project"
echo ""
