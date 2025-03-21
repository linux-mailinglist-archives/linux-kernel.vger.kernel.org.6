Return-Path: <linux-kernel+bounces-571752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3AA6C1B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC72481C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB522E3F1;
	Fri, 21 Mar 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhfw93/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CF22E3E2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578753; cv=none; b=RK6c4LL+2vb6+FrGX8G4CTP6cYQpW3fHvgbGq4/tCdpwh10ElvQPKjZuTTzRzzBeHYj0DSvGL1D744gHe26f2WHJjuhYhAMtInPFOLD1imUdVJ3BMkz5TG8JJURAZ5CjSfEOPH/7nFS/0NfcIm43VINQPoaIAcM1zW+pEpkHVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578753; c=relaxed/simple;
	bh=bMuHPiV0ev4FxcF9dt7Ykn32/KSCe/U7p7IiEsJDcJQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qdvbi+IWf4aNw6MVagstcT7nPhtZ4m5EVVLro+P69hI7bRK0jvhIGvLIe8PEWQzyiR6Cuby5stTszncSLdhw6pGlC52VbnT8wLwyg4BiUkEFyQ9hPLxELiNOyH9PHMS2ggU8tZBJDFui6HB+C2VQicX19eY7dKiLFygTx+CXnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhfw93/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CDBC4CEE3;
	Fri, 21 Mar 2025 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578752;
	bh=bMuHPiV0ev4FxcF9dt7Ykn32/KSCe/U7p7IiEsJDcJQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uhfw93/OMu1GKrhFlI3OwiNBWS1R1ubNw6y/skbew2lGFP6/nYssRG+51i4OUTD2A
	 RbAAVNLMhWNQdgbDUxqiJtcJegeWACpNb0xYisQGlVLV4PNVeG87ksKJStzyvvbyY0
	 7qG4Yqxhiojhp14icYRhTNDpIYl7G62DSRaowscSHn7tUFww/giCNrMXLYELit2VfW
	 +zunH7/5KVIm1jeScXVQ8Ujfl8biAMn52g2HqpWUQEh79oWnmfm8JbA/iOQQO/qGgY
	 qRjoNShokvadCM1VTBML2heLGYWk1fuPJTdozj6ah3rwkIvGkUiG4oHbozKZJ14Nib
	 khJr/4pkPr5SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF8503806659;
	Fri, 21 Mar 2025 17:39:49 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z91A2-z01UOBKTN9@gmail.com>
References: <Z91A2-z01UOBKTN9@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z91A2-z01UOBKTN9@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-21
X-PR-Tracked-Commit-Id: 76f970ce51c80f625eb6ddbb24e9cb51b977b598
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb90c8df91d08aebb62ef77bd1c7f41a31bdc924
Message-Id: <174257878830.2568142.7931356114018335375.pr-tracker-bot@kernel.org>
Date: Fri, 21 Mar 2025 17:39:48 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 11:35:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb90c8df91d08aebb62ef77bd1c7f41a31bdc924

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

