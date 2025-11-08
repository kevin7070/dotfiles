# Router AdGuard Logs Backup
getRouterLogs() {
    BACKUP_FILE=~/Desktop/adguardhome-data-$(date +%Y%m%d-%H%M%S).tar.gz
    echo "📥 Starting download..."
    ssh openwrt.local "cd /tmp/adguardhome && tar -czf - data 2>/dev/null" > "$BACKUP_FILE"
    echo "✅ Completed: $BACKUP_FILE ($(du -h "$BACKUP_FILE" | cut -f1))"
}
