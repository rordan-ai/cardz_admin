#!/bin/bash

echo "=== GIT MONITOR STATUS ==="
echo "Current time: $(date)"
echo

# בדיקת תהליך רץ
if pgrep -f git_monitor.sh > /dev/null; then
    echo "✅ Git Monitor: RUNNING"
    echo "Process ID: $(pgrep -f git_monitor.sh)"
else
    echo "❌ Git Monitor: NOT RUNNING"
fi

echo

# הצגת לוג אחרון
if [ -f /tmp/git_monitor.log ]; then
    echo "📋 Last Monitor Log:"
    tail -10 /tmp/git_monitor.log
else
    echo "⚠️  No monitor log found"
fi

echo

# הצגת commit אחרון שנבדק
if [ -f /tmp/last_commit_hash ]; then
    echo "🔍 Last Checked Commit:"
    echo "Hash: $(cat /tmp/last_commit_hash)"
    git log --format="%h - %s (%an, %ar)" -n 1 $(cat /tmp/last_commit_hash)
else
    echo "⚠️  No commit hash found"
fi

echo

# הצגת דוחות בדיקה אחרונים
echo "📊 Recent Code Reviews:"
ls -la /tmp/code_review_*.log 2>/dev/null | tail -3 || echo "No review logs found"