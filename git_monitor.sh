#!/bin/bash

# Git Monitor Script - בדיקת commits כל חצי שעה
LAST_COMMIT_FILE="/tmp/last_commit_hash"
LOG_FILE="/tmp/git_monitor.log"

echo "=== Git Monitor Started $(date) ===" >> $LOG_FILE

# שמירת commit נוכחי אם זו הפעלה ראשונה
if [ ! -f "$LAST_COMMIT_FILE" ]; then
    git log --format="%H" -n 1 > "$LAST_COMMIT_FILE"
    echo "Initial commit saved: $(cat $LAST_COMMIT_FILE)" >> $LOG_FILE
fi

while true; do
    # קבלת commit אחרון נוכחי
    CURRENT_COMMIT=$(git log --format="%H" -n 1)
    LAST_COMMIT=$(cat "$LAST_COMMIT_FILE")
    
    if [ "$CURRENT_COMMIT" != "$LAST_COMMIT" ]; then
        echo "=== NEW COMMIT DETECTED $(date) ===" >> $LOG_FILE
        echo "Previous: $LAST_COMMIT" >> $LOG_FILE  
        echo "Current: $CURRENT_COMMIT" >> $LOG_FILE
        
        # הצגת פרטי הcommit החדש
        git log --format="%h - %s (%an, %ar)" -n 1 >> $LOG_FILE
        
        echo "🔍 CALLING CONTEXT AGENT FOR CODE REVIEW" >> $LOG_FILE
        echo "----------------------------------------" >> $LOG_FILE
        
        # עדכון hash האחרון
        echo "$CURRENT_COMMIT" > "$LAST_COMMIT_FILE"
        
        # הפעלת בדיקת קוד אוטומטית
        echo "Starting code review..." >> $LOG_FILE
        ./code_review_agent.sh "$CURRENT_COMMIT" >> $LOG_FILE 2>&1
        echo "Code review completed for commit $CURRENT_COMMIT" >> $LOG_FILE
    fi
    
    # המתנה של 30 דקות (1800 שניות) 
    sleep 1800
done