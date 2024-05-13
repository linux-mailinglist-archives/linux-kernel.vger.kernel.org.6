Return-Path: <linux-kernel+bounces-177814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529908C44EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4971C23149
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE415884F;
	Mon, 13 May 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ork59cum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA30157A5C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616908; cv=none; b=UCxP2kOVJeq+yaS9Kqb1O4UsdJBYRIA0qtuYu6IiUbcbqJ/ndT1U9lubQNmWnTnMSGIvKhFMoOfEHuhqlNsGhxcltHwrUJOpk6VFQ4q5VCPvKXafZUjqWd5q3sc6z5ynbAhJxBsFzWstZFlXMVZ0iS3g0D2Ga5t7oJDr0LazfzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616908; c=relaxed/simple;
	bh=hbob51UY2zWUXra/06zfmP48WvK9EY0+ipOUTGHzS/Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F37sKv6Xck0WuDaRwlYLATJhCww1zEXJI6khpeauPR1HHiKPGuaeWtDkJPYSqMBL1noiGIs2XaEayyVxk4jK/w/FgsmlWiPJhnzgJ7C5hMFqvW0i5ZL/T4vWAv2Lz6/Vi8r2mecyGjb2SELUg6EsWMBOAKcmzdiVD7vXefC5OBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ork59cum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7907C4AF09;
	Mon, 13 May 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616907;
	bh=hbob51UY2zWUXra/06zfmP48WvK9EY0+ipOUTGHzS/Y=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=ork59cum2TqIq9Sf8vWr8b7w4g3zL6c/zAy14yrVgvhYW0PKueUbW0mcZE4+rG5bB
	 2PrwAI4QZX2tol/mxf4vSgGGjuYwdeQQ2ueHAkQdvWCx3hjeXqjGQHFe7aL8buJkL5
	 o7T1RG0cQh3ABIIKxPX8ydxDbiwXmv00en1VBBrjMoj0r+LEf7xzkkT5Qp+VDIyLiJ
	 VYAp/aHtVtvz39F3B2zlIpYczvqnpd2F+yI9Gyk4H6V3YqW+3xpt8f0ytLHPenCe9s
	 C5F0mmeGqFs5SM7+093pI4YgDwjsmJ7VtvGhrAZ4QEOu9NNMq9suqxjXK4BSyZTd9A
	 1SilcpB3w412Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFA2BC433E9;
	Mon, 13 May 2024 16:15:07 +0000 (UTC)
Subject: Re: [GIT PULL 3/4] soc: arm code changes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <0d70e9ef-5291-4134-b41f-183b1233b39b@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com> <0d70e9ef-5291-4134-b41f-183b1233b39b@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d70e9ef-5291-4134-b41f-183b1233b39b@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.10
X-PR-Tracked-Commit-Id: 428ae88ef519f2009fac37563de76ffa6f93046f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c2212926dc2ead410031977839af9157a895013
Message-Id: <171561690784.7727.13723429178491017701.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 16:15:07 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 23:12:36 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c2212926dc2ead410031977839af9157a895013

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

