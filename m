Return-Path: <linux-kernel+bounces-257654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E8937D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC391C212DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64031487D8;
	Fri, 19 Jul 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZjY2RQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB31482E4;
	Fri, 19 Jul 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721418877; cv=none; b=NDIpvJSWi8KN83rZ8BIRlPLSR7H6G7yiKwLEGZNlSr5RTaaxsMaNmCtudg928XwH9jVFi2kTQgrnd8Nkznrc1sNqMGBbfNQQ0VRJNas8BbBelGjS8oUFg64gTO7p19omtuXGC6UJjZOMFCbCys4a06NKZumYINeIcd8RSqHEQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721418877; c=relaxed/simple;
	bh=VNM01rkeSr+xN3jpmM8tVqea1oaq/uzNvbrgTNEMPtU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a5cyo5uV1oeIou7w27eCLyTWFQEmWFy9z7LlpXNPiSR126vHKn1yaPc+SYU+zDt/xqXpbzKsgvp2yuFn01zsgNpuBmTURj2IpmGRbMlxb8sNCAYEIMdOyhwZ2UsJCxswAgpSlLEm1CkqGokJPtxxUEU3T8h9KUX02JiVBy/WXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZjY2RQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C27BEC32782;
	Fri, 19 Jul 2024 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721418876;
	bh=VNM01rkeSr+xN3jpmM8tVqea1oaq/uzNvbrgTNEMPtU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hZjY2RQcQwaasTNVAHO7i78Yh/C6o0aaiqi0WvK8eRhMVvmpQvX9Tud7qvaVTA9nY
	 38kJrnUGsxGmxDj8KUPs04OOjjwmxBX3C74J/fO6bISb8sne/0blNqjyF7aCcgrd98
	 YCcGdcF+tEvKhusQzwHu/tJHt+/IMB2aeXJGt3qXQuhwTcZmD2uyBwRHIy0YS0eQnX
	 Mmzl2mkObAk/nbXAsv8gDr4evHDdDYwIKOHv3BPnzqx6sT+yIVLX6uFPuFc0A4OEej
	 XAZGlYQVdOI/vvod/qtoqimkrw3PX+In0URA2rq2oZbzM/Il6uFJjP6QJ13DP/i79i
	 rlLgzI5B071dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9335C43335;
	Fri, 19 Jul 2024 19:54:36 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87v811u95j.wl-tiwai@suse.de>
References: <87v811u95j.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v811u95j.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc1
X-PR-Tracked-Commit-Id: 4594d26fca91fab0e1621d2ab196f3f9bab96bc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12cc3d5389f313f07222b000fefa2cd8fc98c4f8
Message-Id: <172141887674.7828.13718589694542145906.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 19:54:36 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 09:35:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12cc3d5389f313f07222b000fefa2cd8fc98c4f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

