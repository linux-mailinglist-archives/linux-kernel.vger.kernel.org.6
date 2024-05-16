Return-Path: <linux-kernel+bounces-181277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B78C79D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B71C215C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882F14D6E0;
	Thu, 16 May 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkYGEUO1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A71459F3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874798; cv=none; b=hFK8fKvUijlkh539Kx8qmDh35nMVhZVH0pAV1gXSRY0xno6EPCdRyLnpiRFjVkM2eMSPyF8xZVBV53ImMp6djDaxe7Y6lSkLTz6oUOWT9uwas99dlV6mpUw8OGFQkE5CajF6Fs+L7kRpMN0xHrBAnj6ivKdHTaOFD+AhOd5MG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874798; c=relaxed/simple;
	bh=vJXNK/Tqo8zBAUsSHhEd6zAfV9a1tg/5MoYyOWTdTs0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e+Ghw4teENt/apNnMme7Ul5pDnpZlLOgGL40QzbUlENjMsGTNEKe0Z6oBAu1GANQhYZOw/BOhT4Ev1v5Ct22nj3croo7yFH7d1FB1Dd6zT0NvKyVhT9AHN4cu/ZBFssZToPSJf2RNXQKc7y6IF5Fzz7iO71BGHZRNyhjrRWtzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkYGEUO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 816E9C113CC;
	Thu, 16 May 2024 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715874798;
	bh=vJXNK/Tqo8zBAUsSHhEd6zAfV9a1tg/5MoYyOWTdTs0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VkYGEUO1BBeAKvdwFP0HGPkPnL7zHKxaGWxMoQkK92nbXG3j7yLrzn/wTu3IfokU9
	 9lNsKXyTV/t2Ze8nRekL6yE1gqsmv4EOg9aDqT73auZR4GFuT2SjiABKsO8dAWkph/
	 JeOogGCYFH7IsH2jYRN/wluMc8lxPhHRBMyD072QMv3Etx/5NI7RTDkVMXx14uxqZJ
	 M1mynW+M4C4a224YNYJ0YL3dCPtx2PtFgdj4KXtKL6DtcAMXHnxy9N66FP7tjGmi5J
	 CbvTmDTgESagRKyh9wGoluAoLxNAkTCBWfrRafy+A+ycUT9iGPzmaYz1vcixdPCcBB
	 XAhdWQdJTBhhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79488C41620;
	Thu, 16 May 2024 15:53:18 +0000 (UTC)
Subject: Re: [git pull] drm urgent for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
References: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-16
X-PR-Tracked-Commit-Id: 431c590c3ab0469dfedad3a832fe73556396ee52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 972a2543e3dd87f7310d65944b857631b4290e12
Message-Id: <171587479849.7101.896680176648713686.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 15:53:18 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 12:53:52 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/972a2543e3dd87f7310d65944b857631b4290e12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

