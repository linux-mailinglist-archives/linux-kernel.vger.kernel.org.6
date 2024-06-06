Return-Path: <linux-kernel+bounces-204767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C868FF35F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74059B2B0D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01EC198E61;
	Thu,  6 Jun 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i84zjgpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632F22315
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693636; cv=none; b=AqPQSV4XggsiQ41BDHYG9DLPkSL+m0HD1vba1yre+kt5t8gkITYgm1iN+wIZHphGhLOcDCGKalF+70bNJ3KNgydLqHBe8Q9jmSVgKF3FWlTlwZJAkmJ2jxvW4ukt2YPi5zc072tyvk3e7PpB+rxEjVi/5A9tPPgRR7J7I91/I3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693636; c=relaxed/simple;
	bh=J92iRjJjxKxHRs/fx/8OiA0hnZoL4FCpC64oYSU2VXg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EC+TV3X6O7KPa9vZpjTbotx0kQx/LuIIt4eXmpQakwJBPwiAYHaciOmRC7uEl0XN6T+866fB+4OWm2EtkRTs6iZeKvcpcJJvFGTxJksrA3PDtsnq+jFWNd6zYITmbeS9h90I8AzScQQGPbLLbJNuoIhivjjPhuxTTuN9HnXZcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i84zjgpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3170C2BD10;
	Thu,  6 Jun 2024 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693635;
	bh=J92iRjJjxKxHRs/fx/8OiA0hnZoL4FCpC64oYSU2VXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i84zjgpBRlC49CTerD1zgyKMEvbQZgGVVFiwVLA/49+kpfEG96xlBAznTW3wnQB9E
	 KeyoPgKNpKqTTkhPTu6wlgLRDelqCNEP9xZRLzUZV0eOCqiLobvYokma7OwbXfRhBJ
	 cBFF/C5ReuvE6Tck/P4MgZ0V+7Z7HyKuStwNsGO9EJrk0GKfJ4Y1O1gdQUpT965n5d
	 FgusV6NGBg4FaslT5HBi5uAnWJ87GW90ptAhpg7pPJ7vbBEa9PhN80CCpWXkdKXIm9
	 Qkx2OnizPm4oYLr7phvUwD92cHHYB49htm8i+tDmoiX416Y1A8346nFolArmRzARqO
	 lSKEP3GhNaOdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D83ABD2039C;
	Thu,  6 Jun 2024 17:07:15 +0000 (UTC)
Subject: Re: [GIT PULL] tomoyo update for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
References: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
X-PR-Tracked-Remote: git://git.code.sf.net/p/tomoyo/tomoyo.git refs/heads/master
X-PR-Tracked-Commit-Id: c6144a21169fe7d0d70f1a0dae6f6301e5918d30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2faf6332c506fc3bd23815f8fe8f6d0c35271c17
Message-Id: <171769363588.23076.15096060781666655477.pr-tracker-bot@kernel.org>
Date: Thu, 06 Jun 2024 17:07:15 +0000
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Jun 2024 23:40:08 +0900:

> git://git.code.sf.net/p/tomoyo/tomoyo.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2faf6332c506fc3bd23815f8fe8f6d0c35271c17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

