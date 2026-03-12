#!/bin/bash

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

FOLDER_NAME=$(basename "$(cd "$(dirname "$0")" && pwd)")

clear

echo ""
echo -e "${RED}"
cat << 'EOF'
   _____ _ _      __             
  / ____(_) |    / _|            
 | |  __ _| |_  | |_ ___  _ __  
 | | |_ | | __| |  _/ _ \| '__| 
 | |__| | | |_  | || (_) | |    
  \_____|_|\__| |_| \___/|_|    
                 _ _     _            
  ___  __ _  __| (_)___| |_ ___ _ __ 
 / __|/ _` |/ _` | / __| __/ _ \ '__|
 \__ \ (_| | (_| | \__ \ ||  __/ |   
 |___/\__,_|\__,_|_|___/\__\___|_|   
EOF
echo -e "${NC}"
echo -e "                          😈😈😈"

echo ""
echo -e "${CYAN}🚀🚀🚀  Running tests for ${FOLDER_NAME}...  🚀🚀🚀${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Run jest verbose, capture output, show only test names
TEST_OUTPUT=$(npx jest --verbose 2>&1)
TEST_EXIT_CODE=$?
echo "$TEST_OUTPUT" | grep -E '(✓|✕|✗|×|√)' | while IFS= read -r line; do
    if echo "$line" | grep -qE '(✓|√|PASS )'; then
        echo -e "  ${GREEN}${line}${NC}"
    else
        echo -e "  ${RED}${line}${NC}"
    fi
done

echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉${NC}"
    echo ""
    echo -e "${GREEN}  ✅  Tests for ${FOLDER_NAME} passed!  ✅${NC}"
    echo ""
    echo -e "${GREEN}  🏆 Du klarade det! 💪🔥⭐${NC}"
    echo ""
    echo -e "${GREEN}🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉${NC}"
else
    echo -e "${RED}💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀${NC}"
    echo ""
    echo -e "${RED}  ❌  TESTS FAILED!  ❌${NC}"
    echo ""
    echo -e "${RED}  😭 Försök igen... 😈💔🫠😤${NC}"
    echo ""
    echo -e "${RED}💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀${NC}"
fi

echo ""
exit $TEST_EXIT_CODE
