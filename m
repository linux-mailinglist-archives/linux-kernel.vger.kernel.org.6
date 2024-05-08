Return-Path: <linux-kernel+bounces-173621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455618C0305
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02135282828
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35A127E34;
	Wed,  8 May 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFeUyVBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD674CE19
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189045; cv=none; b=m97YbAy9Ag7VxuyYxq0a0Rp6zvWI5YcV2Dtl/zLmBbeycKeu0NSsFnaNqV/4lqh12dL2vYzNv5yu4c9dObp5EJk9cJKW/8+dbmiAB7kFSr5xLns/LLQCiNsoikZ56SwIx6gY+7JwzWvHSFGJx26uJPF6Fj89nLnbq5K5pZpz4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189045; c=relaxed/simple;
	bh=LVflNGpLJaDRSDa+a8HFciyMMmPpKmQmkHnSjlEEsaw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FkrfSpab2wQTXDTtYWDLYy/JhMV0c9rWFdIZrk7GBoIzeyyeTioaPqCV0GKugG5QhR7sqMbMcQj45g6ngsuhPDk9Buii+P5wy5PgeKX/T5T4I8q1EKTEDGkGJ/dXVFvauKzFYfO5Vo5wvr02UU4bHQhDTiZ7VYK0mMTav61eEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFeUyVBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73746C113CC;
	Wed,  8 May 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715189045;
	bh=LVflNGpLJaDRSDa+a8HFciyMMmPpKmQmkHnSjlEEsaw=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=AFeUyVBGD61n40gXZjUcqy5zC5tOFAi+f1TWmVm1uVebK4LvIkwoF6wG6bLPdkJ8g
	 ECNi9u8E3aY+KhS1uJcVvGGTDCTvq4cL/QBg+vDnGrzu36tveIcIHyx5z8sb1yWltN
	 PBE8PVuYY4tuieiqvTJ4TwDgz/tTxLhBd1w/XioNhhG3Re8twjZTwSKtvMj+cf2E33
	 ptoYv+RHJ4T8I3/m1N7bS7AGOaAhV3BMx8bnZsCURWiiZ9/26C6X/NbV3KF4uDkYhQ
	 0tFqaBHQ6pkHKxLOP5HK66Sxe7fNEd75IDogTIDslEU/4COjC+WxyitpaeHlbWUdiw
	 yM5XinCIa4DFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 666E8C43331;
	Wed,  8 May 2024 17:24:05 +0000 (UTC)
Subject: Re: [GIT PULL] ARM SoC fixes for 6.9, part 3
From: pr-tracker-bot@kernel.org
In-Reply-To: <7abb76bb-eb4a-4136-af2f-6b22fbf3d79f@app.fastmail.com>
References: <7abb76bb-eb4a-4136-af2f-6b22fbf3d79f@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7abb76bb-eb4a-4136-af2f-6b22fbf3d79f@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-3
X-PR-Tracked-Commit-Id: 5549d1e39989e2ba86c4775546d0bd8055746cfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d7ddd805123e03db0a16c7dbc8509366432a630
Message-Id: <171518904540.5238.12248743909624398844.pr-tracker-bot@kernel.org>
Date: Wed, 08 May 2024 17:24:05 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 08 May 2024 08:00:08 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d7ddd805123e03db0a16c7dbc8509366432a630

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

