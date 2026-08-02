FROM ubuntu:resolute

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    file \
    git \
    procps \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# zsh isn't installed yet (it comes from brew below), but useradd only needs
# the path to exist by the time the shell is actually invoked at runtime.
RUN useradd -m -s /home/linuxbrew/.linuxbrew/bin/zsh jgminder \
    && echo "jgminder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/jgminder/dotfiles

USER jgminder

# Build context is the repo root (see compose.yaml), so the brew scripts can
# be copied in and run here even though dotfiles itself is only populated
# at runtime via bind mount. This bakes packages into the image layer so
# container recreation doesn't have to refetch them. macos.sh and casks.sh
# no-op on Linux; only formulae.sh installs anything here.
COPY --chown=jgminder:jgminder brew/ /tmp/brew/
RUN bash /tmp/brew/install.sh && sudo rm -rf /tmp/brew

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# install.sh lives in the bind-mounted repo, so it can only run once the
# mount is live — i.e. at container start, not at build time. It's idempotent
# (brew skips installed formulae, stow re-links, LazyVim clone skips if
# already present), so recreated containers self-heal on every start.
COPY --chown=jgminder:jgminder docker/entrypoint.sh /home/jgminder/entrypoint.sh
RUN chmod +x /home/jgminder/entrypoint.sh

ENTRYPOINT ["/home/jgminder/entrypoint.sh"]
CMD ["zsh"]
