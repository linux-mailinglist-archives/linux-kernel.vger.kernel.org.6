Return-Path: <linux-kernel+bounces-402148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A039C246D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886C8285F11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BA2259E8;
	Fri,  8 Nov 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6VyTSjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509F2259CC;
	Fri,  8 Nov 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088134; cv=none; b=R8/Xfxw+EDOmIMAZE+4yfEMdHq50c5YwZqRe1js9k+MCArEbBua0vkcqMottUzJhBg3WzCKEs5o/vnHdgmqG+VSrYnPazAaLhYu0ec5XqA0AtoNSpeBZRHUFRzP/vy+vdOvcJVRqXeHkonBbOD18Iqear3AM3bU5bWw7i1CMcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088134; c=relaxed/simple;
	bh=v1N5tqWP6ZXetrNngk1R62500mwFZS/4w+SiVtqzhbY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RiSZEAPO2N5dOOG/zRiWl/GfR9QFHqNPMUQ5rACZaDnxScnfNBv1LqLd5R5ixaODbsWFHL5dyx6mk+9WJHU6Oij6mSq32JHahauwF5YT9Xlq0o/B9J2X8XyzJ89lBihImC8mtdD7wpEf/WQh0QZavs1o0cgoV34bWtCiTdX9KMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6VyTSjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8697AC4CECF;
	Fri,  8 Nov 2024 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731088134;
	bh=v1N5tqWP6ZXetrNngk1R62500mwFZS/4w+SiVtqzhbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P6VyTSjSZx84KuoUE5NIa4oS68tlotmPWa1hmckUlaEvkoRWF8L+W3iQ+vkH4ASnB
	 qGKczfuaTJyTUStEMEe7AwlHHKPDOmrbWfEA6+RBdypVVqulAstMN/75RUSFvD9RPv
	 OjuQD3ZUVpDs4135OXn+Pyvr+BwFy4v20dSoIQ90rmRM4qPTBmbmN57Mbzlp/FCkRN
	 lhfbFgeQ7WnjtqJPOxKDfkdOObVGmyk36JAOe3eB+34Sxh2yJy2eSi7L+swcabQzZ8
	 uollAsVVtzKt0GkLhbZZn6w2mancV/Tk4RV+Ze3mmK3P+vGaKui94Sed5jRxkH/A5B
	 jUBj/7vzP82IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE43809A80;
	Fri,  8 Nov 2024 17:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ed3lg73g.wl-tiwai@suse.de>
References: <87ed3lg73g.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ed3lg73g.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc7
X-PR-Tracked-Commit-Id: fa59caa7859813b2a20f33e7c1f89459e7b6055f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50643bbc9eb697636d08ccabb54f1b7d57941910
Message-Id: <173108814373.2713429.5251858070898735668.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 17:49:03 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Nov 2024 14:58:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50643bbc9eb697636d08ccabb54f1b7d57941910

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

