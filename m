Return-Path: <linux-kernel+bounces-281318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49F94D572
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF21C21241
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379FE7344C;
	Fri,  9 Aug 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1/FC6fA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBBA41;
	Fri,  9 Aug 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224675; cv=none; b=OxZhqT57H8C66GwmOW4qnLWtTBHyJJzhBB0kzSo4ntpW439rVZz5P+vy3eMvFQVDb7Dk7ewIuTy87odW8joKCz6nIFBbEahZPnwiE6SBtJYjwsAledu7iV36RVqmEJENxMSVWLMG//SmO3qhzAtpg8BWI2RPmVBo6sEUCTLVyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224675; c=relaxed/simple;
	bh=QRuvaosOhAa+BOFHbay8mCENTDT2+MAB2VbQfAfkK0g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l/0dOxyvUAAw65UDYj0fyxWEYd3QOzn5tU7oZShpDFTfGfRy2AxxdwkmCjUEVGTdoCkwR2Li964jemJkWZXrE1Hv4cLG2l8EUc+ZuXm9a9eOlbscSxm1a04BuCdftLH6EkbwKOKW6xmU0RLD5vVBCNyoRNSvRKN3f3dhS3Nny5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1/FC6fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5BFC32782;
	Fri,  9 Aug 2024 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723224675;
	bh=QRuvaosOhAa+BOFHbay8mCENTDT2+MAB2VbQfAfkK0g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r1/FC6fA8iuF2mvKCy0TjivgSoPhIQyhmfT2wddMQp8ru24LfDJJUWbpIIDB4D8hR
	 n11GUDMazDsunMy0T6JOWXnBRdHix+RSuyk8usfy79kmsYqkCw9BoIia+4m+VOg79R
	 miqsgDeIYPXij0Mo0VJGf86TrhQAw+YHJ09LMR4+6nVJZ/+SvQiPhIILxDPJzSu/wl
	 lb5euSnxmP7XzLuR6vIisMQFtIYqtFv4YvUHpG4CjSjmjtlEPI8hRGInFIsCYsga27
	 mfGhna7CHwJxbtj2AVYj3+YIQjn7WzuzzeF0T1lxNX6zjKyn++P3pZwycdsvITh7j7
	 XVDFRLe4gDLkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71733382333D;
	Fri,  9 Aug 2024 17:31:15 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ikw9n9nc.wl-tiwai@suse.de>
References: <87ikw9n9nc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ikw9n9nc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc3
X-PR-Tracked-Commit-Id: d3e82ced462b4ed956504b62603a11d52a599f99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 377773dd6be500d17b94de08271ff9ed643554f1
Message-Id: <172322467401.3855220.17975493456338306114.pr-tracker-bot@kernel.org>
Date: Fri, 09 Aug 2024 17:31:14 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 09 Aug 2024 14:49:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/377773dd6be500d17b94de08271ff9ed643554f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

