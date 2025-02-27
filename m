Return-Path: <linux-kernel+bounces-537017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A91A48719
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA1F188C6D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720E1F5827;
	Thu, 27 Feb 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSEL4u1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C51DE3B7;
	Thu, 27 Feb 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678869; cv=none; b=fPx69lXQJZbbaALZIGz8gHQhewWnZtYCuhjgzcijP2Rol4CpKe6kqHJwb2EEXNsEtOvNDgrODY2UHBp7f6+ZgvKc58XFnPL4nOLGf7gFr4drJnwHxKBMx6CemrAJtLlsqg1aPFqdbt6tNqxDjF6ZW3uWAppm3el962zyLSy9oAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678869; c=relaxed/simple;
	bh=S02zTvbL3+eRRVplJS+PBhMPAL9V8UPLaHK5FAzZ+54=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NRPdlxEVfAd2anXO4bHceqNzHXldrS0uWuaparXFdEcTgS0flvsSfN9cwPS2x7Hn9BaK8f8JDieBuCZ2XJ13XdUnP/PAeLT2hjTalePJDnxPhzMpnGeMIuHS5B3Tk/HXbgBx94ytVdtn/omhw6sSAaziC5Yk+8IRf7S9BD4FTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSEL4u1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1582C4CEDD;
	Thu, 27 Feb 2025 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678869;
	bh=S02zTvbL3+eRRVplJS+PBhMPAL9V8UPLaHK5FAzZ+54=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZSEL4u1iY0y8Q5pXsC7DPH08EOs5oNfXVzymBlVsxy8Ct2YkzdxLd88amBuO0hYiN
	 ZnvR7YdIXAJ0tWxsFc/JUW8RsD5bfc1PianqRYpPPw/KCAHlFqLiA1lQ6Amj/okqYo
	 K+XRa/ATykcccVW4zB3e1k8hvLRBDsCiQquTeTjublK47JAAzuavgpiCmAbmfeJAX8
	 GdycFXIbjKvKtz+ELc6brPrDfwuxv+YjbCzTFCEqnP6/kVUJipBcIb4F7twd+1KtHG
	 vKisLXMaZRv3IIQkm/zP+QqYyT9qeBMRgs9myT3G5YnR/hROM/vTlmtvJYCD66OD6R
	 UKANK5/a9li3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6F380AACB;
	Thu, 27 Feb 2025 17:55:02 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <87mse75pdj.wl-tiwai@suse.de>
References: <87mse75pdj.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87mse75pdj.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc5
X-PR-Tracked-Commit-Id: fe1544deda605f6100cbff1d5aeb179c3aa1515c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f09d694cf799d27d6de25f04f3fd5ba9190631e1
Message-Id: <174067890147.1513849.12801631979481455909.pr-tracker-bot@kernel.org>
Date: Thu, 27 Feb 2025 17:55:01 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Feb 2025 17:22:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f09d694cf799d27d6de25f04f3fd5ba9190631e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

