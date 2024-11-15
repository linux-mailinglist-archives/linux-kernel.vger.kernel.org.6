Return-Path: <linux-kernel+bounces-411192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11A9CF4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C891B2C3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E41E25FD;
	Fri, 15 Nov 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJCvQurq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553821E2306;
	Fri, 15 Nov 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697147; cv=none; b=f3Rm+7uYzO7/gLxZd5QntVURELICvK09ruiVhZpxWcrFM/UK6qFOLIDeidwemzx9gWrfQ2HTmFCNr8Z88Kd4qLycFJfhuvaWx4/Mu/a162nsvdqMZYq0SxtcQgfbHFVeb4RHconHzRziBmDeCaot463lXbk7ZVNVTtLvwFFy3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697147; c=relaxed/simple;
	bh=6tgPB6hEwpMupszGst2FI5CrWkJRUC5qJZcZHFGaF3U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QEGasvx2+8pwv2Qpw7iOfSoAzOtyaqg2mTx8Am36lQ3U5fDn/IGUTCFoD1jAvznbto8/O/vpSzk3slBWlbf9wox4plCP6E3qbfesdygTTl8LqaQytUefUbKfC2qkRXsdoJdMXQzjPgrXl66m3GIHNNmBwiP+7BvureUMtYKCD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJCvQurq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3148CC4CECF;
	Fri, 15 Nov 2024 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731697147;
	bh=6tgPB6hEwpMupszGst2FI5CrWkJRUC5qJZcZHFGaF3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DJCvQurqqY1VUZRsBBCgQHwxoZEwyjZsGZaWYj0Y5QfaRtbbkmTvMZhjm/P8G8QBK
	 xjC/6g4gLOPByD/9QCR6jhXg6gqZSlJmXCIgHm1qf7YaSoJtFzs6WeBvKpTPRBJxjF
	 AppZYgOCzGKy4led6tl5IlPVDnqmjhB/1M4FUI5XjDpWMxsad5qf1eKyOeBZX2qwdW
	 01ZKfFn0WscH3ah6ZPEYE4+dOGs28z8OsaSnh99Kc5+eJz1+P9ncOez5bU/NaDDNUD
	 DKvuI8hBwyUKeXVxxTNUyzgbuBKZDM+ywVqFMJ9Kjc5t2ot0/95kmiK7gDzJH8GoNu
	 3VUnuBk05e0pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349EF3809A80;
	Fri, 15 Nov 2024 18:59:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <877c94stpv.wl-tiwai@suse.de>
References: <877c94stpv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <877c94stpv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12
X-PR-Tracked-Commit-Id: 5ec23a1b53a98dbd7ea33954db5f0fe7110903aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eeae5ef6bf76b1d828eff26d2ae393cfebac72ad
Message-Id: <173169715782.2685462.13336643957091062645.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 18:59:17 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 10:59:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eeae5ef6bf76b1d828eff26d2ae393cfebac72ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

