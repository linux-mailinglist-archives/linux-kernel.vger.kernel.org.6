Return-Path: <linux-kernel+bounces-263584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FE93D7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AD61F24A00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A017D37A;
	Fri, 26 Jul 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+rC0nS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808E17D366;
	Fri, 26 Jul 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017253; cv=none; b=eK2zSR+ccWQrcatTyQErs9qa2LiBqXTErZ13YIAMrFVdnbNCJg2wvFe5BbixbdpbJP0f39L0otd1DsCh2vkt3W+4OdZccAV+EO5FJpLr0t5cdQwFCI1WYB78e8O5XsGdO4UJPK32WBrm9O6mM0peJY4v7qh4nzkdHuw+21ivHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017253; c=relaxed/simple;
	bh=+zVZvqZ3sriL5W4o+oRhLEnsE5uwCnbUL1esfYlj6D8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jAXNTujgATpTfKQshw2gVJ+9iHne83e1outTs2tSezRKt/oVAYDLxaN1bGdIE+V5LaibkJ0q8rprePikUTmZZyDIktl4EF8Z7CXc8XgPsvdKyrik3g9ZufDK+8jUGf15hSFR00ZVqqnrvLkxKwiu46jgxd15satfwCwlKzE3FFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+rC0nS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D261C32782;
	Fri, 26 Jul 2024 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017253;
	bh=+zVZvqZ3sriL5W4o+oRhLEnsE5uwCnbUL1esfYlj6D8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U+rC0nS2CvDwbf1ZIcrUSDiSTuocfFvmHpAAVWqvnA1NkAI6viJBnS0MDe+Qepe5Q
	 S1ow2htOsJd5RMqmFv1uGWqCwrCPHs7iG9cSHtHA219b1ocYEzUBHl4FtEqi0fyvuI
	 lCarD4CgmsOUR7NrrLLepdoWQZqwlZjaKPAwOMFq1VVNVdPPVAAMN5frqR8xMZ9buG
	 HleCnnvWE+g2xy8Rbv7yKeW20KdxpXyfgrkBztW7OgSo8fEcx+nWkc5xsoef2wCp/M
	 ne+xpFbcx3UBuYzIubBFgh7keGmXupGtzJCJJfgmzEzR4cZwJ1Wpp47/4y2wvRm8V0
	 Rbq3K+1Hnihcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54AA2C433E9;
	Fri, 26 Jul 2024 18:07:33 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ttgchc3w.wl-tiwai@suse.de>
References: <87ttgchc3w.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ttgchc3w.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.11-rc1
X-PR-Tracked-Commit-Id: e8b96a66ae01d039699bac256c5b6b30b2284170
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb966e0c5f238ffeacc15543f1d25fb06a5100c2
Message-Id: <172201725334.32235.4822343686201388703.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:33 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 09:00:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb966e0c5f238ffeacc15543f1d25fb06a5100c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

