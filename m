Return-Path: <linux-kernel+bounces-576143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D90A70B89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F58C17AFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEAD266F1E;
	Tue, 25 Mar 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4fkebIt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3EA266B7F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934657; cv=none; b=czDtzwHo2QALkvpzbI0d68UDr/C+RFpBqFaD20QIOo4TYABxAWGLrr+8lSHmcb9hJRGjKO40uHC6G/GKWCmBTQ4bfgS+gTe4P/WV/R98ISPnjUuxFYt7DORrIQrIw1OrMosNkArn0Lv48BlRi4PJph8mmziG6kRYVBClVRmm/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934657; c=relaxed/simple;
	bh=MEtXIREjJRvQM+LA27D+RtWE1i/q1lSxhNHxDBASFcw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j9kcyloMUUMO6Bp5m83Eta2QFk0taPjWvN35IuenpH4hHoLFPFtSbGLMu3VC8NP+CtQwYeNWaAD6IL1OZuPLOzRKBluZ2cmHnMQIKS8afcNZUtkTL1D4oqFGd+SZcbnSoI03Tz4oYc2HizfVkbJXVZ+a7mM1k9sHnz/fQDUsNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4fkebIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD64C4AF09;
	Tue, 25 Mar 2025 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934657;
	bh=MEtXIREjJRvQM+LA27D+RtWE1i/q1lSxhNHxDBASFcw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I4fkebIt6UcsXq7Y7+0f49zZN/QIzlB0S/gNy9h3QrVFEvuLRB+NBVtXGoRl6KBaY
	 V4o2bFzKOm+rdwRxhQn8rRnq9k5hB98motXk1Vkp+IXNUpiHE75IuNFCDC/mUiMcb4
	 /zB7+BchTamVHMw8d8/LIG6PpNPcfXyKTPpwTZFzcX+yhLFFZomAOOI5OBtWZtCBov
	 /kkjp8wekxgEIAYIIeSQYfIg0rXyts0tx3oVrORbqJ1YzLj4dQxxZfV13ic3E3QmKr
	 m0EINESEpIb/TygeUkAp1RksAfv3QPXD76Qhw9SIEu9TXYMBctuQ7/kYSE9WHHP2lm
	 K4Z/gQ1jXGUJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF20E380DBFB;
	Tue, 25 Mar 2025 20:31:34 +0000 (UTC)
Subject: Re: [GIT pull] timers/cleanups for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <174275226234.1561082.3090009452237682595.tglx@xen13>
References: <174275225552.1561082.4969731002775597670.tglx@xen13> <174275226234.1561082.3090009452237682595.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <174275226234.1561082.3090009452237682595.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-cleanups-2025-03-23
X-PR-Tracked-Commit-Id: 86a578e780a9fb0e1a1b6f3f3aa847c29b5255b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a50b4fe095fb98e0b7da03b0a42fd1247284868e
Message-Id: <174293469329.715410.2293617495211391101.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:31:33 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 18:51:40 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-cleanups-2025-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a50b4fe095fb98e0b7da03b0a42fd1247284868e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

