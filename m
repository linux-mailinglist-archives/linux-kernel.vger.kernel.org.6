Return-Path: <linux-kernel+bounces-516759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA13A37706
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD4F16FD17
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F3E1A287E;
	Sun, 16 Feb 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlcVY/Hf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679041A23B5
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732307; cv=none; b=ErWd9KnVlVXI/qrAZhvqfQVl1eKn7zjp74KYZCVPgEIudca3W2P54ygZ8DInX3MYOiNp+pt6i+0zx7xXF0NigGFFfmivFZ8kzGrxrLiUwFN8YxBaSfLiRM1Rf9nBcaWB2Rahdzv7p5FxHMK3Mp4MYneuXdVt5M9sGWEExZnevYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732307; c=relaxed/simple;
	bh=tTYg8W5N+FVWve2p8w23zcBkY/WRjAh0Ubn71VfCNxs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CoHr9MDCNlRD3+8NBPrYptau6mg8KZDMFlmtMqvwF6Ip/0zO2QF3KcR8ZkX++C2uHYfZp+5MQhEfKWmyIYkWsrXWUsdxWGIAh+mXhExytMpHBf3hnxVJfg/n44JLyH14+5amUkKpqzx5h9IIgF6rSo8ABKD3ER3xB50EVTWEw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlcVY/Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B542C4CEDD;
	Sun, 16 Feb 2025 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739732307;
	bh=tTYg8W5N+FVWve2p8w23zcBkY/WRjAh0Ubn71VfCNxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MlcVY/HfZFvl1KKfZHDXc2vVP7bGQKDu//tYd91OwlkRZqCVm0q7SGX2RRCz2LyO4
	 x7xFO1u3hVddyRJ+q87gn995TEaPxb57/h4iBdCQw1GjfMFrurxImhHWTOVUBp75t8
	 auUUpF0c7QO4ESD1Lrnu7Bpp1FeyyBXqZgPSOwwBdZWplhWpyVk5nUN7/WhKzEquDc
	 qquoEUSwjI0cQr5zCkkQZBz0kG5Vs4BgJsPAaLdquoVABFVYbmr58++TSkcVxYpRMI
	 YCImqSSwbop+Btpryqp6j1oB1g432Z2UhX6aLaqLW5iJxMAyODklv1FGR/88/1Fpni
	 h4bjnMqAQWx0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711A6380AA7F;
	Sun, 16 Feb 2025 18:58:58 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250216091038.GAZ7GrjtV16Hk0TmHk@fat_crate.local>
References: <20250216091038.GAZ7GrjtV16Hk0TmHk@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250216091038.GAZ7GrjtV16Hk0TmHk@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.14_rc3
X-PR-Tracked-Commit-Id: bcc6244e13b4d4903511a1ea84368abf925031c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff3b373ecc88098103b6ae80d96d6527210b2e64
Message-Id: <173973233693.2551255.17573948158290893251.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 18:58:56 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Feb 2025 10:10:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.14_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff3b373ecc88098103b6ae80d96d6527210b2e64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

