Return-Path: <linux-kernel+bounces-264250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A693E0C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42320B214F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5446230358;
	Sat, 27 Jul 2024 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC6JKK9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940442F2F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110837; cv=none; b=SaZXVs+l7EMGFkjMIqgXfjcChvvpbgojjXN3SJM5k3gT2E/8gBr6wlIWMdxWqV1kcH2Mxe87fIQFBqLwpMRbaR7CHugYWfCP1bvJjt1Gv+A3BdWpSAjOx2bOTGJSnUwE4oHyhWeXdo8XNNNH7DTnoO1CGixtJEoyJ5ji9Cdkrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110837; c=relaxed/simple;
	bh=+DV4kCRHLIGABvSMp8Zc9czMIuhamMhxIql3DNJsYWQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LEqwkmfKNkWRlIt7l9DPTdqOG1vHM2poQ9tr64FMmFulVu9xCZmy+KzxUMK9mvKA0COabiiP1M/8eOAJ4CDMKKCewA6pIpSNYmjPJpdFH8KJVUDupor2KHvCYVhb+2U0b3cerhKsFAchkswMPAMCwhHt1gN5fD31sDdbzz1rBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC6JKK9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77735C32781;
	Sat, 27 Jul 2024 20:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110837;
	bh=+DV4kCRHLIGABvSMp8Zc9czMIuhamMhxIql3DNJsYWQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CC6JKK9RWSFS5cV12YxQT2Ok4K84sX6yIGDb5hSl7gTWC5wfw19YU6N5LJhNxiu0T
	 sX37WOBrzjkwfipOtBagSyVC54pgT0Y9QcC3yw8+ugUQrvIhsvBsHPLYIenZhjBTgc
	 hB2HxbaFx6DNhwUzOP6u+2jYC//9837anK5cxtwc7bCMWbpOyDaF/UkLebCvkKtDp0
	 U8VsN6v3hfEVRYWCL2AKcipxKGLWhGBZl6YPR+/Pp3c2qIwsB7iDpMhRnA419f7CLJ
	 kSdl3MxkDPdB5ym7TWMsyW/rQbH57zkWjka/lsYC2y6OIBjkYVJ8reuSFyP9qTFL14
	 nhdHuzNVikdXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65141C4333D;
	Sat, 27 Jul 2024 20:07:17 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.11 Merge Window, Part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
References: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-mw2
X-PR-Tracked-Commit-Id: 52420e483d3e1562f11a208d3c540b27b5e5dbf4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9f33436d85b72b2addfd9423eae864cb8dac1da
Message-Id: <172211083740.16614.18306159259071737244.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:17 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jul 2024 06:29:14 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9f33436d85b72b2addfd9423eae864cb8dac1da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

