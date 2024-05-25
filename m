Return-Path: <linux-kernel+bounces-189537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1A8CF162
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533C42814F9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8412127E05;
	Sat, 25 May 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4jfikW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA82F2F
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716671301; cv=none; b=TNluyooKqssw7Psrk5tjdTAxjPVHzhbSumGVhBxOMEmTQBghv9dHIauGPbuQ5ii8fgVf0nWtO+UQNrbgMpBXO5k19sx+747Px5PeOZgsluoB9AlnSegnZedD5UzPy+Dw6VVP68ewC6xklj3ba0JzmW4+q0huQZqFW551dba8YBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716671301; c=relaxed/simple;
	bh=nEqzW9oyU97phZK7uKMU6F+19PuFaeFngjJCCflqxZQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZoesbVGOTEH1J9yGhsDQE8YpNsDXghs6eYpV2LqNbiGvH7MuOgv9egeEzyWgoHTu858gL+9H9MTbk3d6y25JviWdIjV/BFyGsuXRw/8CdDsp6exvhgEYsLRZ5UpWApTWIlw2y3zKZV2hHT5p0H7gJfN8urIAOY3ZPKQ0jflJE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4jfikW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3E1BC2BD11;
	Sat, 25 May 2024 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716671300;
	bh=nEqzW9oyU97phZK7uKMU6F+19PuFaeFngjJCCflqxZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a4jfikW636doLx2EGDH1HbLcxJr7Z6z/6pjy7lAkZkppcwxHwdN33XKfwH/6Xnxtb
	 WSe4kmvEomGswDc1YgcCtAgEGy06mNzMbC/jZC3ervetVlQfEkkkwig2r9t7TzLZt3
	 env1annT0VxaT15IFemG9lwekH1XBTldoByFGvvaAdSYVfX5ihDTAgnI2bpeq63vxh
	 Xc8cXiZrhCZI0OEqRBWHh89tjerg9aH1py0winOBxgR+qNVBMDDLL4OZFIfV0JL42K
	 RmGxKvRYiGIF/EodAp7bS/14JGTR2NVEEL0Wxf/7dT0Drbd1rCm0/D/md0JYe3gn49
	 xq/NheNJDHrVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACF8AC43333;
	Sat, 25 May 2024 21:08:20 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS2 changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1964508139.144819.1716585977753.JavaMail.zimbra@nod.at>
References: <1964508139.144819.1716585977753.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <1964508139.144819.1716585977753.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/jffs2-for-linus-6.10-rc1
X-PR-Tracked-Commit-Id: af9a8730ddb6a4b2edd779ccc0aceb994d616830
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6951abe8f37b1f4f9a0e7c036873f0ab4f56abf1
Message-Id: <171667130070.10959.173856068914692305.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:08:20 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 23:26:17 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/jffs2-for-linus-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6951abe8f37b1f4f9a0e7c036873f0ab4f56abf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

