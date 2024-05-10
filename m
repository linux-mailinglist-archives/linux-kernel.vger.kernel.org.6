Return-Path: <linux-kernel+bounces-176046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE58C293F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAAE284F44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07119182C3;
	Fri, 10 May 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elmAeG5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8951CFB6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362156; cv=none; b=Kqe/wcS2p/Z/sAsCVhY3quqU0bR9YiRyCF7tHjzrh6H9rV4UvTsc9IuJZeKyIXGr5/he1JTv1ROiyV5nlswT4/pjuENsszV27UCg3ANmVwqakP4xmHbrUoACryKIi0z9giiIVSTM1DTDx0Lsb6ojTmUMtApP1Y5WR2ZXhWtCsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362156; c=relaxed/simple;
	bh=lwgopdSUq/NVZKumDeHBrpw5t0Dug8sTguzl8hyUu+I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zl4NQCaXHSFXF5qicJr583DGQrR45xmj1JYT9AINM2gIDRnbcpojzBir9SawVcXenPT2HZJkKJBo26is4HyEYhpkpBsaTo8Qd78wTMvwMg9SUrXQ5RsMhOroH9MWNVvwgUeoeoumMxmenmtGvwot3esUWypM+LoUIH/RMJkilKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elmAeG5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D1EDC2BBFC;
	Fri, 10 May 2024 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362156;
	bh=lwgopdSUq/NVZKumDeHBrpw5t0Dug8sTguzl8hyUu+I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=elmAeG5AvlJYZqA115cqrf9ZzFDZZMdtgR6MZZu/U2f8iQLIL5MwBh8Jf8ZCHz/+i
	 2gCvWR483655eajEOifE/wwl9LN8d7LGP7bVWyWBHjb75rv/GPIHLWmIK4WNtqU395
	 Q718kgG57/+O/76fVZEi4A0vXoPUD3UYg3BzKdJ2rfWoac++wuIph9aO5Y4dEMJ5gh
	 ZSWTHtuPC3A8BDcqEW1OQ3CLiXgD0TioNPdjnKxbj13pct37uv0deuC0w81quq3On+
	 YUmMbg52gy/KG64/o6nPsGlQgEJTE75NkJkzeZRNljqmTqF20zOji4bUdPWPaYYTRl
	 WEMbCdwS2JSBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 252F9E7C112;
	Fri, 10 May 2024 17:29:16 +0000 (UTC)
Subject: Re: [GIT PULL] timer fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zj4BMV2Cf9s0X/mn@gmail.com>
References: <Zj4BMV2Cf9s0X/mn@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zj4BMV2Cf9s0X/mn@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-05-10
X-PR-Tracked-Commit-Id: d7ad05c86e2191bd66e5b62fca8da53c4a53484f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92d503011f2fa2c85624dde43429cd0c6a25ef6a
Message-Id: <171536215614.32093.1396884435488040913.pr-tracker-bot@kernel.org>
Date: Fri, 10 May 2024 17:29:16 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 13:12:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-05-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92d503011f2fa2c85624dde43429cd0c6a25ef6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

