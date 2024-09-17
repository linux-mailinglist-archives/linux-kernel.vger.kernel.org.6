Return-Path: <linux-kernel+bounces-331758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D197B0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125061C23E59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3A18F2C5;
	Tue, 17 Sep 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UipNDzxB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D82186298
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580402; cv=none; b=eBeLad8/4ArUbPkZPdrdxGLooSxEdKVVX4kPnM2ONGA8xwjLoNxRZWDuZqQmrsEl4Y+reV+wz1bn85ArSeSicQ2OZW1I35D9Utz6tLmsJIxnqJDboQczh2dbsFr0kSSB26Oum+Cff94PLHJZuikjAz05Ry/6Yo0cAM5/mPQRA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580402; c=relaxed/simple;
	bh=qUwAvbR7Dea5aqfJoUkcp68cYfLc/+vFMsB4WoveYY4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i5L+fZSTkIrR5ZXqaSgSSx+kabsDWNvjK5xN5FK5lIVv/tJgLHnx0+Zlwy6TPoRspSSTsxkG6yyKn78uk19P2H7L1Oi2ruHpIO/WFDmox9WdyTChntFQpWMfOp6sg4IQkW/TtrSJBNy8BSA2I0uGAjTBh3w8rC+KAvs4NRQpyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UipNDzxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488D4C4CECE;
	Tue, 17 Sep 2024 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580402;
	bh=qUwAvbR7Dea5aqfJoUkcp68cYfLc/+vFMsB4WoveYY4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UipNDzxBzx4DfMzdO9xhb5nVsS4gIhGXDuBLaISbMKhELpPFrIy6ThFUJDQ14FeKM
	 lE2e7qnTsBOP+ZUYtrxHk/tNiCjRwASBS3SuZYHUcUECHHtoeFQAN80/uGJamo42Kx
	 swTfnLKl4Q/Qo82zg+vRD7pmCYg1UpPxLV5VGo8cURr+EhtFs+dmnIzopr2/H/eFMc
	 XXjjIh4K2GBeP3nBLO/jLz+wXmx0178PZ0yVZTl3MzzpHAYQykBe2hMEfQeyhgiCUm
	 zYT6nSFPX8P1O+DLYGPaG1R8eyx64507Xw3hnBzd+JqsqBckXAWKDVMALBGipnkQOK
	 DsjhQdO5KHsBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE83809A80;
	Tue, 17 Sep 2024 13:40:05 +0000 (UTC)
Subject: Re: [GIT pull] x86/mm for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656199227.2471820.13578261908219597067.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656199227.2471820.13578261908219597067.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656199227.2471820.13578261908219597067.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-09-17
X-PR-Tracked-Commit-Id: 50c6dbdfd16e312382842198a7919341ad480e05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70f43ea3a360c5a7d3474b0cfbabb80be6424596
Message-Id: <172658040389.145065.1068694032952723595.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:40:03 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:15 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70f43ea3a360c5a7d3474b0cfbabb80be6424596

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

