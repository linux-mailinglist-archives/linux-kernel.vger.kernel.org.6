Return-Path: <linux-kernel+bounces-574730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5543A6E924
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881E316B0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770301C84DF;
	Tue, 25 Mar 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZsxwca4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAA1C5D56
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878961; cv=none; b=r+FRmalDtMWeZx+SrMlJes10UiMn7BnLtLjzp2uhFAkjNaAnn3ZV8rbmwGZVnyKgWFwFjQaG3F7pfpo/BduiYwnIyEpXzrqujtkYRPxSLP7yESkM/KnLsIVBYnRSXfopdXyJdG+13AagxUkpOe9JxhYmFNGkYS8hCmWSJjHEwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878961; c=relaxed/simple;
	bh=uRz1+lUlRFd897dS0Wo+7xo6Bfqmg7roN74UNv9mD+M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RDeuHG+o/nekkaE9zKxaXfvmur+YLVTYcdmu7SAQaF6XTk12h6XkMWcfRgcc+X6nwMbsY4Ms/B0KMS/gbYTIMuE+5Ti/ugvwu80jq72SKeo9pk8DnagDUCQ46Tz+NZplsT2uDZMjlug+1qn+2L46pKeFj4C/6EAadqlZTcZRJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZsxwca4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FF7C4CEED;
	Tue, 25 Mar 2025 05:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742878961;
	bh=uRz1+lUlRFd897dS0Wo+7xo6Bfqmg7roN74UNv9mD+M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gZsxwca4gjW+sBEuzbI4lY8VIcOVGPp43UgytedmSkPIVQqre9DgD8Bo8PKrtZSh2
	 JVMoXHYhKsEYt6IoAmMZahNwPaFnsQN+ys4bJ08WKwTuH0CdkaetqG1N+VhALQdPcH
	 3zSheW0f2WnXl/pCvSuEJ9VorLaNXxvFIOEpNHy5mCaIrTJyRuPiXrxdoHWiQd/U82
	 tJGH3Hw+tbDJoeVqUEYmEh2U4EA2p8T0b8WRDM47m0eqPvQ8LZXrJp5BbUwlUuMxck
	 FXYrTCMnKGK8Gq6BWLRebpTT1SIykvFNFcMVNgDPllOSJFpxhTRdEM18CGBQKPTAql
	 o50cihBYe6oiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DC213380DBCD;
	Tue, 25 Mar 2025 05:03:18 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96PbgNRBu_LYr7t@gmail.com>
References: <Z96PbgNRBu_LYr7t@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96PbgNRBu_LYr7t@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-03-22
X-PR-Tracked-Commit-Id: 3785c7dbae0f733f13f8857beaaada5d7dc63e02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32b22538bea83bd48f00ab1403e5a4dbce41f0d0
Message-Id: <174287899752.94045.11902860412851792135.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 05:03:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:22:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32b22538bea83bd48f00ab1403e5a4dbce41f0d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

