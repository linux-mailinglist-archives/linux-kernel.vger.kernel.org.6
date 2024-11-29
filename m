Return-Path: <linux-kernel+bounces-425959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E99DECF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D47281BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC101A0AE9;
	Fri, 29 Nov 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR8f/bnA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6D3224;
	Fri, 29 Nov 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915999; cv=none; b=vFB9rfFMo1kzvvIiewZBqOISN9YZF6DFMeUdQ8MpYGHFUMHVFs3Q870ooU9W+81ElBxcN/PtUSsj0tPbDUzpCj1la6yUGMxLuKSpu/jXrMO3EsmsDW+qMoNHyecDbHw+iSiuDJAh+Tb7yBMqPjYdwFzPAvxmW/nyAyyMUtJBzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915999; c=relaxed/simple;
	bh=8RjqcbgMeeduYMYgvMVxAbtjiJr3JpdN6nK72DOBozI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WVKuCrWZ4Ys5zZjnCSM4GvGuZcBvjK0fMF/IsuTNb/kstDFOu929SnUwPyhB8COYs+xMocR+k2wsUmCGKoMHzegi5SJpjOUBrGIyHbMH2iGaemZMZewlwQFLaUuw7LMf/kbQUFxCRSqU9uyKHnCHZlYcH0SH56D56mJmOkKgVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR8f/bnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B16C4CECF;
	Fri, 29 Nov 2024 21:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732915999;
	bh=8RjqcbgMeeduYMYgvMVxAbtjiJr3JpdN6nK72DOBozI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UR8f/bnAluOVWVKdbX4uZWaNQHpNP1c2qBjDBRIKfcJ4v0V2b2lXrbmwUvm3fiI/4
	 BX3tZz0cBYrDFzf/1e/llga2ncuQTzcEz4GnUdCQbh8LIN/BtMz9KLNo6uw/tpq+0J
	 daEx5Hi7mIgVeOk440LKxRSZPdVfo6tITLP7o0/GQNV+PyyUHkswzxiL8eTf/4GQGt
	 XMe/s59eHHWS86+86HN+/zfKJyfeBWljEAd3TwrjQdaTPXxeQtBkWTxj4xivoNpscn
	 eUGcpQCo/urnStEzm4j+kOGsSz6aefoj97VAdwXT/xDoKLULHLKCvR6E+1OJJr+pF5
	 Pa9oSjnQDDTfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2B380A944;
	Fri, 29 Nov 2024 21:33:34 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sera5pdt.wl-tiwai@suse.de>
References: <87sera5pdt.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sera5pdt.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.13-rc1
X-PR-Tracked-Commit-Id: 2e5bf5b6d2617aff3bd6577bbc8e024cca436d76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 517363b4949e4442dfe54b281ef5a8bbfafa3bbb
Message-Id: <173291601272.2191389.18307558525290674641.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 21:33:32 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 11:02:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/517363b4949e4442dfe54b281ef5a8bbfafa3bbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

