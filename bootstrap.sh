#!/usr/bin/env bash
# claude-toolkit bootstrap
# Fetches the skill repos Victor uses, fresh from each upstream source.
#
# Usage:
#   bash bootstrap.sh            # everything
#   bash bootstrap.sh web        # web build set
#   bash bootstrap.sh seo        # web build set + SEO/content set
#   bash bootstrap.sh writing    # stop-slop only
#   bash bootstrap.sh video      # remotion
#   bash bootstrap.sh app        # superpowers + product manager skills
#   bash bootstrap.sh context    # context engineering
#   bash bootstrap.sh convert    # markitdown
#
# Destination defaults to /home/claude. Override with TOOLKIT_DEST=/path.

set -e
DEST="${TOOLKIT_DEST:-/home/claude}"
PROFILE="${1:-all}"

clone() {
  local repo="$1" dir="$2"
  if [ -d "$DEST/$dir/.git" ]; then
    echo "  already here, pulling latest: $dir"
    git -C "$DEST/$dir" pull -q || true
  else
    echo "  cloning: $repo -> $dir"
    git clone -q --depth 1 "https://github.com/$repo.git" "$DEST/$dir" || echo "  WARN could not clone $repo"
  fi
  sleep 0.5
}

web()      { clone coreyhaines31/marketingskills marketingskills
             clone hardikpandya/stop-slop stop-slop
             clone nextlevelbuilder/ui-ux-pro-max-skill ui-ux-pro-max-skill
             clone pbakaus/impeccable impeccable; }

seo()      { web
             clone AgriciDaniel/claude-seo claude-seo
             clone AgriciDaniel/claude-blog claude-blog
             clone inhouseseo/superseo-skills superseo-skills
             clone addyosmani/web-quality-skills web-quality-skills; }

writing()  { clone hardikpandya/stop-slop stop-slop; }

video()    { clone remotion-dev/skills remotion-skills; }

app()      { clone obra/superpowers superpowers
             clone deanpeters/Product-Manager-Skills Product-Manager-Skills; }

context()  { clone muratcankoylan/Agent-Skills-for-Context-Engineering context-engineering; }

convert()  { clone microsoft/markitdown markitdown; }

# Private personal context (about-me, my-company, anti-ai-writing-style).
# Lives in a private repo, so the clone needs a token. Set GH_TOKEN in the
# environment before running. No token is stored in this public file.
context_files() {
  local dir="claude-context"
  if [ -d "$DEST/$dir/.git" ]; then
    echo "  already here, pulling latest: $dir"
    git -C "$DEST/$dir" pull -q || true
  elif [ -n "$GH_TOKEN" ]; then
    echo "  cloning private context: $dir"
    git clone -q --depth 1 "https://${GH_TOKEN}@github.com/vpastor01/claude-context.git" "$DEST/$dir" \
      || echo "  WARN could not clone claude-context (check GH_TOKEN)"
  else
    echo "  skipping private context: set GH_TOKEN to load about-me / my-company / anti-ai-writing-style"
  fi
  sleep 0.5
}

echo "claude-toolkit: profile = $PROFILE  ->  $DEST"
context_files
case "$PROFILE" in
  web)      web ;;
  seo)      seo ;;
  writing)  writing ;;
  video)    video ;;
  app)      app ;;
  context)  context ;;
  convert)  convert ;;
  all)      seo; video; app; context; convert ;;
  *)        echo "unknown profile: $PROFILE"; exit 1 ;;
esac
echo "done."
