Return-Path: <linux-kernel+bounces-178264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0D8C4B46
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2368285AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB701BC5C;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odCQrtYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A311712
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655089; cv=none; b=RIGEtEpexwA0t01x49a8od/DAs4Dl1rkCHkPelKmT/J1FPGQR6cOzZIQuWnr7iz/PknB4IQiQHpcK6iher58Y2fou/P/303Mk5RCcpxtFrvDbC3nQOqBEfdWeQnKjX+rjRbZ8M2aykUC2AMMzAoCO4MBBLrPGlMH2hKHUUEQtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655089; c=relaxed/simple;
	bh=LhBB1TrdTKHvRtneVBrDzhRyXtyayqQhR1z82xHYxu0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WWqs2Wf9kB/lInloB4pnsiWf44axxlSoDnBCVInflCi+EpZ2rd1ZiuEBWLYKNJX+Bfu/N9No2DP9OhSl1Mp7SsBIcjj7YNGy5BdpxaRKlBGko0RxetLSiqKFTYApmxVRLvVLtGHa0ml2VRWVyw5zotuOaLcOXqwD6w4ma5MloNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odCQrtYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16295C4AF08;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655089;
	bh=LhBB1TrdTKHvRtneVBrDzhRyXtyayqQhR1z82xHYxu0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=odCQrtYfEqDP0dN3FCREbqxwuZAE223EqyyBTYvZKKlqFZj+IroVN/5o17BBiIM3V
	 PSAdjDe6H3OxvfajHainI3gq8vinJEX5T1Xjftjur3tt8wgOOcAH2SerJ4Jvdy1Ekf
	 Am6llARviPtByIEhayX57UJ8D7FpcslWyvSZif3J89h/9fPcD88OEE1Q+j2jph9NZb
	 4D//lg2DPLGLx0foRwjG9BBeOXWySZnvyOW2RWPIRS620LkIK5vQsdxSPwk4Z6rBWo
	 Yq9rSq3iVtARP0db3EtATdpOZ4h0t4UaD3BDRMfGJ510R0rrIaVo3odjpDS8VdM2ob
	 NYSKO06rSFI1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 093D4C433E9;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkG0nxxBPB/03Q/l@gmail.com>
References: <ZkG0nxxBPB/03Q/l@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkG0nxxBPB/03Q/l@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-05-13
X-PR-Tracked-Commit-Id: 97450eb909658573dcacc1063b06d3d08642c0c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e5a0c30b616bfff6926ecca5d88e3d06e6bf79a
Message-Id: <171565508903.649.3212535844698239477.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 08:35:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e5a0c30b616bfff6926ecca5d88e3d06e6bf79a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

