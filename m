Return-Path: <linux-kernel+bounces-198365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76B8D7730
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA51C212E2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F45674B;
	Sun,  2 Jun 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSUZmKpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FB47A79
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346474; cv=none; b=F9yIFrli8VKL4bflQG/OiCVci5tC5GRS8qwfPYykFMmGwFfdAu7Ds2bSCC4AayX/nqgePJ72s2xFC6LDBftZ/VKvXggQBlQViMxMcwQFryRnFqxTjwwMGGqtfnBr5McnjLSi0us6VbLINdT2IKjJ/8vLyv/gqbnJGpY0HocltOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346474; c=relaxed/simple;
	bh=WsFLhf24B0oa0n0gsVNTsZUczx2GmAiDwV4E5ynao4Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RZsFZEtPrJnwUPMt6FigxAMGaLBaPvN/d+2bzfRYocaJEHQHWw855Ca40sXsD4IoKrYuaMyJN9wQC9yCUW4ydNxe/M60L2wNhlDTHbXQnhXvlAvGaH1DgTbCNwCjA5UJh7JcdExVX/JacHaAQy3MgkUMbwG+i2DQWnB9P3kcQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSUZmKpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC33C4AF09;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717346474;
	bh=WsFLhf24B0oa0n0gsVNTsZUczx2GmAiDwV4E5ynao4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aSUZmKpBWxdlMiYWaNLInyY+1BnLr+68VU3RCgGzbrNbCVSFl3foqPFKCLS83b6IF
	 dnOeOaP3AmXsG+1Q5i48BfWx0aTf2mUEUM3a10CM0sZmaCiwZfj2o7yFGPxCYb5eXt
	 6hu8e0YpU2nKl7mOPCbAoUyA2bgDZAhQ3o/FoMOMR5LdTCNRnQL3zCJIaiTe2OwEC+
	 Yh4PIiJ5iBV1plS/qpVdt8yzTg+8wroFaLATy2ZiWySd9GXvX4ByT0lUYhRWQK0yPQ
	 MI9Pc4gMMd4RrWwRfNiETb3CEVtvywWH5KWsYFlD5Ba4nxLHs4WWlG5ndClGUUewje
	 0vWo4jCEn/hJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DC88DEA716;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlwbdU0uaVMMra5f@gmail.com>
References: <ZlwbdU0uaVMMra5f@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlwbdU0uaVMMra5f@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-06-02
X-PR-Tracked-Commit-Id: d40605a6823577a6c40fad6fb1f10a40ea0389d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fca58ffad37a06912d25e5a1818afb3183cff17
Message-Id: <171734647431.21593.1738209370628265225.pr-tracker-bot@kernel.org>
Date: Sun, 02 Jun 2024 16:41:14 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Jun 2024 09:12:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fca58ffad37a06912d25e5a1818afb3183cff17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

