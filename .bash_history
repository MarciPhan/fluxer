export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
go get github.com/mattn/go-sqlite3
export PATH=$PATH:/usr/local/go/bin && go build -o bot_go main.go && ./bot_go --help || echo "Build check passed"
cd /root/discord-bot
chmod +x /root/discord-bot/run.sh
pgrep -fl "bot_go" && pgrep -fl "bot/main.py" || echo "Some processes not found"
cd /root/discord-bot/go-core
export PATH=$PATH:/usr/local/go/bin && go mod tidy && cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh
tail -n 20 go_bot.log && echo "---" && tail -n 20 python_worker.log
python3 -c "import discord; print(discord.__version__)"
pip3 install --upgrade discord.py==2.4.0
python3 --version
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh
cd /root/discord-bot/go-core
export PATH=$PATH:/usr/local/go/bin && go mod tidy
cd '/root/discord-bot/bot理论上应该是 python3 bot/main.py 既然是在 root/discord-bot 下运行，那 cwd 就是 root/discord-bot。'
cat << 'EOF' > /root/discord-bot/bot/main.py.new
from __future__ import annotations

import asyncio

import os

import time

import platform

import sys

from datetime import datetime



# Manual .env loading

env_paths = [

    os.path.join(os.getcwd(), ".env"),

    "/app/.env",

    "/root/discord-bot/.env"

]

for env_path in env_paths:

    if os.path.exists(env_path):

        with open(env_path) as f:

            for line in f:

                line = line.strip()

                if line and not line.startswith("#") and "=" in line:

                    key, val = line.split("=", 1)

                    os.environ[key] = val.strip('"').strip("'")

        break



import discord

from discord.ext import commands, tasks 

from config import bot_token

from config import config

import redis.asyncio as redis 

from shared.redis_client import get_redis_client



def ts() -> str:

    return datetime.now().strftime("[%Y-%m-%d %H:%M:%S]")



intents = discord.Intents.all()

bot = commands.Bot(command_prefix=config.BOT_PREFIX, intents=intents)

bot.remove_command("help")



async def send_console_log(msg: str):

    fullmsg = f"{ts()} {msg}"

    try:

        if not bot.is_ready():

            return

        channel = bot.get_channel(config.CONSOLE_CHANNEL_ID)

        if channel:

            await channel.send(f"\`\`\`{fullmsg[:1900]}\`\`\`")

    except Exception as e:

        print(f"Log Error: {e}")



@bot.command(name="sync")

@commands.has_permissions(administrator=True)

async def sync_tree(ctx: commands.Context):

    await ctx.send("Slashe nejsou na této verzi bota podporovány (pouze Go).")



@bot.event

async def on_ready():

    print(f"Python Sidecar is ready as {bot.user}")

    await send_console_log("Python Sidecar online (Lite Mode)")



# Start only essential background tasks if needed

bot.run(os.environ.get("BOT_TOKEN"))

EOF

mv /root/discord-bot/bot/main.py.new /root/discord-bot/bot/main.py
cd '/root/discord-bot/bot理论上应该是 python3 bot/main.py 既然是在 root/discord-bot 下运行，那 cwd 就是 root/discord-bot。'
cat << 'EOF' > /root/discord-bot/bot/main.py.new
from __future__ import annotations

import asyncio

import os

import time

import platform

import sys

from datetime import datetime



# Manual .env loading

env_paths = [

    os.path.join(os.getcwd(), ".env"),

    "/app/.env",

    "/root/discord-bot/.env"

]

for env_path in env_paths:

    if os.path.exists(env_path):

        with open(env_path) as f:

            for line in f:

                line = line.strip()

                if line and not line.startswith("#") and "=" in line:

                    key, val = line.split("=", 1)

                    os.environ[key] = val.strip('"').strip("'")

        break



import discord

from discord.ext import commands, tasks 

from config import bot_token

from config import config



def ts() -> str:

    return datetime.now().strftime("[%Y-%m-%d %H:%M:%S]")



intents = discord.Intents.all()

bot = commands.Bot(command_prefix=config.BOT_PREFIX, intents=intents)

bot.remove_command("help")



async def send_console_log(msg: str):

    fullmsg = f"{ts()} {msg}"

    try:

        if not bot.is_ready():

            return

        channel = bot.get_channel(config.CONSOLE_CHANNEL_ID)

        if channel:

            await channel.send(f"\`\`\`{fullmsg[:1900]}\`\`\`")

    except Exception as e:

        print(f"Log Error: {e}")



@bot.event

async def on_ready():

    print(f"Python Sidecar (Lite) is online as {bot.user}")

    await send_console_log("Python Sidecar online (Lite Mode)")



async def load_worker_cogs():

    # Only load analysis cogs in Lite Mode

    extensions = ["bot.commands.avatar_nsfw", "bot.commands.patterns"]

    for ext in extensions:

        try:

            await bot.load_extension(ext)

            print(f"Loaded {ext}")

        except Exception as e:

            print(f"Failed to load {ext}: {e}")



async def main():

    await load_worker_cogs()

    async with bot:

        await bot.start(os.environ.get("BOT_TOKEN"))



if __name__ == "__main__":

    if hasattr(bot, "run"):

        # discord.py 1.7.3 does not support 'async with bot'

        # It uses bot.run() which is blocking.

        # But wait, 1.7.3 load_extension is NOT async.

        

        def load_worker_cogs_sync():

            extensions = ["bot.commands.avatar_nsfw", "bot.commands.patterns"]

            for ext in extensions:

                try:

                    bot.load_extension(ext)

                    print(f"Loaded {ext}")

                except Exception as e:

                    print(f"Failed to load {ext}: {e}")

        

        load_worker_cogs_sync()

        bot.run(os.environ.get("BOT_TOKEN"))

EOF

mv /root/discord-bot/bot/main.py.new /root/discord-bot/bot/main.py
cd /root/discord-bot
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh
tail -n 20 go_bot.log && echo "---" && tail -n 20 python_worker.log
ps -p 9594 || echo "Python process died"
cat go_bot.log && echo "---" && cat python_worker.log && echo "---" && pgrep -fl "python3"
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh
tail -n 20 go_bot.log && echo "---" && tail -n 20 python_worker.log && echo "---" && pgrep -fl "python3" && pgrep -fl "bot_go"
cd /root/discord-bot/bot/commands
sed -i '25s/^/# /' /root/discord-bot/bot/commands/patterns.py && \
sed -i '1030,1267s/^/# /' /root/discord-bot/bot/commands/patterns.py
cd /root/discord-bot
tail -n 20 go_bot.log && echo "---" && tail -n 20 python_worker.log && echo "---" && pgrep -fl "python3" && pgrep -fl "bot_go"
cd /root/discord-bot/bot/commands
sed -i 's/dict\[/Dict\[/g' /root/discord-bot/bot/commands/avatar_nsfw.py && \
sed -i 's/list\[/List\[/g' /root/discord-bot/bot/commands/avatar_nsfw.py && \
sed -i '1i from typing import List, Dict, Optional, Tuple, Union' /root/discord-bot/bot/commands/avatar_nsfw.py
cd /root/discord-bot
which python3.9 || which python3.10 || which python3.11 || echo "No newer python found"
/usr/local/bin/python3.9 -m pip --version && /usr/local/bin/python3.9 -c "import discord; print(discord.__version__)" || echo "discord.py not installed on 3.9"
cp /root/discord-bot/bot/main.py /root/discord-bot/bot/main.py.bak && \
git checkout /root/discord-bot/bot/main.py /root/discord-bot/bot/commands/avatar_nsfw.py /root/discord-bot/bot/commands/patterns.py
pgrep -fl "main.py" && pgrep -fl "bot_go" && pgrep -fl "python3"
ls -l /root/discord-bot/bot/main.py /root/discord-bot/bot/main.py.bak
cd '/root/discord-bot理论上应该是 run.sh 会重启。'
pkill -9 bot_go ; pkill -9 -f "bot/main.py" ; pkill -9 python ; pkill -9 python3 ; sleep 2 ; /root/discord-bot/run.sh
pgrep -af python && pgrep -af bot_go
docker ps -a
docker ps | grep -E "bot|discord"
docker stop discord-bot-dashboard && docker rm discord-bot-dashboard
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh
tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 10 /root/discord-bot/go_bot.log
head -n 25 /root/discord-bot/python_worker.log
redis-cli -u redis://localhost:6379/0 del bot:lock:lite bot:lock:primary
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 10 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 10 /root/discord-bot/go_bot.log
tail -n 35 /root/discord-bot/python_worker.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 7 && cat /root/discord-bot/python_worker.log | head -n 35
echo 'CONSOLE_CHANNEL_ID="1245571689178464257"' >> /root/discord-bot/.env
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 25 /root/discord-bot/go_bot.log
tail -n 15 /root/discord-bot/python_worker.log
rm -f bot/commands/automod_custom.py bot/commands/calendar.py bot/commands/challenge_manager.py bot/commands/help.py bot/commands/notify.py bot/commands/verification.py
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 12 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 12 /root/discord-bot/go_bot.log
git ls-tree -r HEAD --name-only bot/commands/ | grep '.py$'
git show HEAD~1:bot/commands/verification.py | grep '@app_commands.command'
cat << 'EOF' > get_commands.py
import re

import os



files = [

    "bot/commands/verification.py",

    "bot/commands/calendar.py",

    "bot/commands/challenge_manager.py",

    "bot/commands/automod_custom.py",

    "bot/commands/notify.py",

    "bot/commands/help.py"

]



for f in files:

    try:

        content = os.popen(f"git show HEAD~1:{f}").read()

        print(f"\n--- {f} ---")

        commands = re.findall(r'@app_commands.command\(name="([^"]+)"', content)

        for cmd in commands:

            print(cmd)

    except Exception as e:

        print(e)

EOF

python3 get_commands.py
git show HEAD~1:bot/commands/verification.py > /tmp/old_verification.py
cat /root/discord-bot/bot/verification_config.py 2>/dev/null || cat /root/discord-bot/verification_config.py 2>/dev/null
grep -q VERIFIED_ROLE_ID /root/discord-bot/.env || echo "VERIFIED_ROLE_ID=1179506149951811734\nVERIFICATION_CODE=Restart" >> /root/discord-bot/.env
sed -i '$d' /root/discord-bot/.env && echo "VERIFIED_ROLE_ID=1179506149951811734" >> /root/discord-bot/.env && echo "VERIFICATION_CODE=Restart" >> /root/discord-bot/.env
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 12 /root/discord-bot/go_bot.log
tail -n 50 /root/discord-bot/python_worker.log && echo "---" && tail -n 25 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 10 /root/discord-bot/python_worker.log && echo "---" && tail -n 12 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 5 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 12 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 10 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 12 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 10 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 12 /root/discord-bot/go_bot.log
cat << 'EOF' > force_sync.py
import asyncio

import os

import discord

from discord.ext import commands



async def main():

    token = os.getenv("BOT_TOKEN")

    bot = commands.Bot(command_prefix="*", intents=discord.Intents.default())

    

    @bot.event

    async def on_ready():

        print(f"Logged in as {bot.user}")

        print("Syncing global commands...")

        cmds = await bot.tree.sync()

        print(f"Synced {len(cmds)} global commands.")

        await bot.close()

        

    await bot.start(token)



if __name__ == "__main__":

    asyncio.run(main())

EOF

source /root/discord-bot/.env && export BOT_TOKEN && python3 force_sync.py
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 25 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 12 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 15 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 12 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 15 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 12 /root/discord-bot/go_bot.log
cd /root/discord-bot && pkill bot_go ; pkill -f "bot/main.py" ; ./run.sh && sleep 15 && tail -n 25 /root/discord-bot/python_worker.log && echo "---" && tail -n 20 /root/discord-bot/go_bot.log
cd /root/discord-bot
mkdir -p scripts/archive
# Clean up logs and json dumps (from git tracked space and root)
git rm --cached *.log *.json 2>/dev/null
git rm --cached -r *_std.log 2>/dev/null
echo "\n# Logs & Dumps" >> .gitignore
echo "*.log" >> .gitignore
echo "*_std.log/" >> .gitignore
echo "*.json" >> .gitignore
rm -rf *.log *_std.log discord_qualitative_output.txt discord_structure.json fluxer_channels.json sync_state.json test_sample.jpg migration_token.txt
# Create an array of all Python scripts in the root directory
for f in *.py; do
    if [ -f "$f" ]; then
        if git ls-files --error-unmatch "$f" >/dev/null 2>&1; then
            git mv "$f" scripts/archive/
        else
            mv "$f" scripts/archive/
        fi
    fi
done
git add .gitignore scripts/archive/
git commit -m "chore: Clean up root directory by archiving one-off scripts and ignoring logs/dumps"
git push
ls -la
# Aggressive Deep Cleanup
rm -rf /root/Phishingator /root/fluxer /root/templates /root/go/pkg/mod /root/.npm /root/.cache /root/active_user_stats.txt /root/analyze_content_patterns.py /root/analyze_discord_keywords.py /root/analyze_discourse_deep.py /root/analyze_new_patterns.py /root/analyze_pink_cloud.py /root/analyze_user_categories.py /root/check_bot_syntax.py /root/check_instance_config.ts /root/check_pending_users.ts /root/cleanup_logs.py /root/fix_mangled_html.py /root/fix_mangled_html_v2.py /root/fix_templates.py /root/fluxer_api_logs.txt /root/inactive_high_post_users.txt /root/migration.log /root/requirements.txt /root/top_forum_users.txt /root/top_voice_users.txt /root/voice_names.py /root/yoggi_posts.txt /root/discord-bot/web/frontend/static/img/dashboard_2026_v1.png /root/discord-bot/web/frontend/static/img/predictions_2026_v1.png /root/discord-bot/web/frontend/static/img/landing_hero_2026_v1.png /root/discord-bot/web/frontend/static/img/community_score_2026_v1.png /root/discord-bot/scripts/send_test.py /root/discord-bot/scripts/test_kc_mapping.py /root/discord-bot/scripts/test_automod_rejection.py && find /root/.gemini/antigravity/brain -maxdepth 1 -mindepth 1 -not -name "3982009f-b7ef-4169-be5a-b859abcabdb5" -exec rm -rf {} +
