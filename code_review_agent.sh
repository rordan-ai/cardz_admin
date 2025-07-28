#!/bin/bash

# Code Review Agent - ביצוע בדיקה מקיפה של הקוד
COMMIT_HASH=$1
REVIEW_LOG="/tmp/code_review_$(date +%Y%m%d_%H%M%S).log"

echo "=== CODE REVIEW STARTED $(date) ===" > $REVIEW_LOG
echo "Commit Hash: $COMMIT_HASH" >> $REVIEW_LOG
echo "Reviewer: Context & Quality Agent" >> $REVIEW_LOG
echo "Rules: .cursor/rules/rules_contextandquality_agent.md" >> $REVIEW_LOG
echo "=====================================" >> $REVIEW_LOG

# 0. בדיקת כללי הסוכן
echo "0. כללי סוכן איכות:" >> $REVIEW_LOG
if [ -f ".cursor/rules/rules_contextandquality_agent.md" ]; then
    echo "✅ מסמך תפקידים נמצא" >> $REVIEW_LOG
    echo "📋 תחומי אחריות:" >> $REVIEW_LOG
    grep -A 4 "תחומי אחריות:" .cursor/rules/rules_contextandquality_agent.md | tail -4 >> $REVIEW_LOG
else
    echo "⚠️ מסמך תפקידים לא נמצא" >> $REVIEW_LOG
fi

# 1. בדיקת התאמה לאפיון
echo -e "\n1. בדיקת התאמה לאפיון:" >> $REVIEW_LOG
echo "- נבדקים כל הקבצים שנשתנו" >> $REVIEW_LOG

# רשימת קבצים שנשתנו בcommit
git diff-tree --no-commit-id --name-only -r $COMMIT_HASH >> $REVIEW_LOG

# 2. בדיקת איכות קוד  
echo -e "\n2. בדיקת איכות קוד:" >> $REVIEW_LOG

# בדיקת TypeScript errors
if command -v npx &> /dev/null; then
    echo "- בדיקת TypeScript..." >> $REVIEW_LOG
    npx tsc --noEmit 2>&1 | head -20 >> $REVIEW_LOG
fi

# 3. בדיקת אבטחה
echo -e "\n3. בדיקת אבטחה:" >> $REVIEW_LOG
echo "- נבדקים קבצי config ו-env" >> $REVIEW_LOG

# בדיקת חשיפת secrets
grep -r "password\|secret\|key\|token" --include="*.ts" --include="*.tsx" --include="*.js" . | head -10 >> $REVIEW_LOG

# 4. בדיקת רספונסיביות
echo -e "\n4. בדיקת רספונסיביות:" >> $REVIEW_LOG
grep -r "@media\|responsive\|mobile\|tablet" --include="*.css" --include="*.scss" . | wc -l >> $REVIEW_LOG

echo -e "\n=== REVIEW COMPLETED ===" >> $REVIEW_LOG
echo "Full log: $REVIEW_LOG" >> $REVIEW_LOG

# הודעה לקונסול
echo "📋 Code review completed for commit $COMMIT_HASH"
echo "📄 Review log: $REVIEW_LOG"