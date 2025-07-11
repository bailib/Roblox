import discord
from discord import app_commands
from discord.ext import commands
import asyncio

intents = discord.Intents.default()
intents.message_content = True

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user} (ID: {bot.user.id})')
    print('------')
    try:
        synced = await bot.tree.sync()
        print(f"Synced {len(synced)} command(s)")
    except Exception as e:
        print(e)

@bot.tree.command(name="delete_webhook", description="删除指定的webhook")
@app_commands.describe(
    webhook_url="要删除的webhook URL",
    reason="删除原因(可选)"
)
async def delete_webhook(interaction: discord.Interaction, webhook_url: str, reason: str = None):
    try:
        if not webhook_url.startswith(("https://discord.com/api/webhooks/", "https://canary.discord.com/api/webhooks/")):
            await interaction.response.send_message("❌ 无效的webhook URL", ephemeral=True)
            return
            
        webhook = discord.Webhook.from_url(webhook_url, session=bot.http._HTTPClient__session)

        await webhook.delete(reason=reason)
        await interaction.response.send_message(f"✅ Webhook 已成功删除！{'原因: ' + reason if reason else ''}", ephemeral=True)
        
    except discord.NotFound:
        await interaction.response.send_message("❌ 找不到webhook，可能已被删除或URL无效", ephemeral=True)
    except discord.Forbidden:
        await interaction.response.send_message("❌ 没有权限删除此webhook", ephemeral=True)
    except Exception as e:
        await interaction.response.send_message(f"❌ 删除webhook时出错: {str(e)}", ephemeral=True)

@bot.tree.command(name="spam_webhook", description="向webhook发送多条消息")
@app_commands.describe(
    webhook_url="webhook URL",
    message="要发送的消息内容",
    amount="发送次数(1-10)",
    delay="每条消息之间的延迟(秒)"
)
async def spam_webhook(interaction: discord.Interaction, webhook_url: str, message: str, amount: int = 5, delay: float = 1.0):
    try:
        if not webhook_url.startswith(("https://discord.com/api/webhooks/", "https://canary.discord.com/api/webhooks/")):
            await interaction.response.send_message("❌ 无效的webhook URL", ephemeral=True)
            return
            
        if amount < 1 or amount > 10:
            await interaction.response.send_message("❌ 发送次数必须在1-10之间", ephemeral=True)
            return
            
        if delay < 0 or delay > 5:
            await interaction.response.send_message("❌ 延迟时间必须在0-5秒之间", ephemeral=True)
            return
            
        await interaction.response.send_message(f"⏳ 开始向webhook发送{amount}条消息...", ephemeral=True)
        
        webhook = discord.Webhook.from_url(webhook_url, session=bot.http._HTTPClient__session)
        
        for i in range(amount):
            try:
                await webhook.send(content=f"{message} ({i+1}/{amount})")
                if i < amount - 1 and delay > 0:
                    await asyncio.sleep(delay)
            except Exception as e:
                await interaction.followup.send(f"❌ 发送消息时出错: {str(e)}", ephemeral=True)
                return
                
        await interaction.followup.send(f"✅ 成功向webhook发送了{amount}条消息！", ephemeral=True)
        
    except discord.NotFound:
        await interaction.response.send_message("❌ 找不到webhook，可能已被删除或URL无效", ephemeral=True)
    except Exception as e:
        await interaction.response.send_message(f"❌ 发送webhook消息时出错: {str(e)}", ephemeral=True)

# your bot token
bot.run("")
