Return-Path: <linux-kernel+bounces-342149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A8988B03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D0E1F23D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338E1C1AC9;
	Fri, 27 Sep 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbz1fgvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF0015FCE5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467231; cv=none; b=iWzzwLrtU1G8r8/dAIayAuMgrZTji8krssV3fCEBPY5I1PhwBXt0Goh823XAzdg7u4QegV9DXeszFAAJ8F0IVbNf/jyYbITZeA6XNVZD1lSOQra/KM9ROLlP8uFopKxfd7payp8x75JwBtKS4mnw7EHcp5uNwIIbKIVc7vvStgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467231; c=relaxed/simple;
	bh=oEfHUL4XE9Kb76eeqRvMDCG+U73Flp/DyQb7+GFyiuc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W+l7RDaid9IR7j1RD5xk++baut+fEiteU1ft4nrwa/O4iR02PMVcmISplF2Lqlt6/H7Pa4F+/qmqtBqFyYYv6J1yth1xQh0dLl+GS+xIz8F7xqojDdkRsBwCgl563cvXHGLrUlxWX5suU7wlfD4741IkIftwsVh1ydBoBTSC+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbz1fgvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4C8C4CEC4;
	Fri, 27 Sep 2024 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467231;
	bh=oEfHUL4XE9Kb76eeqRvMDCG+U73Flp/DyQb7+GFyiuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Sbz1fgvCIww8KWUeNYvSVUO4/CoRwPWYoLupY1A8jFQq9gLbFiQgynlH1n026OlyG
	 4Cc53mwNSh1z2llCCmSxm1PRy+yLghVEDB/jHrnKgq6EoRrOSTWuEoD8V862TWk38z
	 wkFDlSCeWuUu56M3efyeUFz/YoURYDF3x0oJoRAQcOMa4D5tUlAvyCjhCnQ/ofmhs6
	 LNf6Abzkek++SErN+ayfx2PtWpVtzVIUot/gChU2PfS45RnJWyf8tBYC6iroqjAfKF
	 ckCg8cA6VdAKN642umNOSrutfnXB9a7nImjKmRykHnt5GKN4vnSuSGO15JotfyxumV
	 WB0bVwWXH63mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3413809A80;
	Fri, 27 Sep 2024 20:00:34 +0000 (UTC)
Subject: Re: [GIT PULL] tomoyo update for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
X-PR-Tracked-Remote: git://git.code.sf.net/p/tomoyo/tomoyo.git tags/tomoyo-pr-20240927
X-PR-Tracked-Commit-Id: ada1986d07976d60bed5017aa38b7f7cf27883f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba33a49fcd42a94d405221cd0677388db1b69ed2
Message-Id: <172746723358.2065565.443633616045671588.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:00:33 +0000
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 19:43:05 +0900:

> git://git.code.sf.net/p/tomoyo/tomoyo.git tags/tomoyo-pr-20240927

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba33a49fcd42a94d405221cd0677388db1b69ed2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

