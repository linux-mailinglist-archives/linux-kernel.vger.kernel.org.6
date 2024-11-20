Return-Path: <linux-kernel+bounces-416432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0579D44B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0865B24A15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7851C9ED4;
	Wed, 20 Nov 2024 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu6YEBtC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C31C07F9;
	Wed, 20 Nov 2024 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146615; cv=none; b=fNU6/az7y34+Z3JjOQUiXPCdTfBpAFSJIQfgf0ICPWoj6TMCoY74pUzmTFVweFvBdairST06WwBPPjeZeQoBp+ipnJEvnvp2dJxuXIbMEnjiZVHz8A84SbmORHqTuGv6ELchVS2zTGnqiT9sSu0pTaoxdolpwLJmS6U18cc5KAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146615; c=relaxed/simple;
	bh=OqAjSpUUNBYiOdRxJEe7prLlAds3BTXXfb9idsZe2eo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ixolbBwKrW3NKyfXxoFQj38jcg5idScyzRtpwhO3xMxpdKdJwcdBQu8B8yDQ/nrgNF3KHYlJApl8BQwQS303LM9Ciy9W89VubYa019V+45A0T6YiinM6UEm7YevCQmuaMtnsU9zcSpJtkru4vOOIlo4jcV1rjW5MMlmFYmvmBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu6YEBtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272DCC4CED3;
	Wed, 20 Nov 2024 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732146615;
	bh=OqAjSpUUNBYiOdRxJEe7prLlAds3BTXXfb9idsZe2eo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iu6YEBtCWcmALJTzIhwSZrMuKxxJy6zlrhO702EzXJf/PWYzwqeUW/pWB606NlaGY
	 nNYlFOHfMC8161hxjmfJAq8S1ZMEZ77Zvu46C1qAOBIjZ8dpl9fyqnPdbopGEetw8o
	 RN2D/yK7IXTFG799T1RdbAFGrnZgmU4pDbt9b6so1PxjvfracZoSpSrxfKIY2I1JAB
	 dJuZKLWCz3pEkr7PG+nGZYaEiO4CgK8k+PrU1DBKsA7itBjM+OpYNc5SwQXphMb5YG
	 yqjnVknIxj43WI61mY/WBqOw6TpwfpC8kUHUqqlWRHZDtdC3uwHn/OZj8m3xt/opI9
	 l31D3id9O9DaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E443809A80;
	Wed, 20 Nov 2024 23:50:28 +0000 (UTC)
Subject: Re: [GIT PULL 3/4] ARM: soc updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <8eb10ff6-08f3-4efc-8839-1d7559bb8c6f@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com> <8eb10ff6-08f3-4efc-8839-1d7559bb8c6f@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <8eb10ff6-08f3-4efc-8839-1d7559bb8c6f@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.13
X-PR-Tracked-Commit-Id: 9c6cb0377534e77265ea673fd4834f858d5d1a6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
Message-Id: <173214662694.1393168.5527301233918920474.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 23:50:26 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 00:02:53 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

