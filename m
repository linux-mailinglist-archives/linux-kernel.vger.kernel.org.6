Return-Path: <linux-kernel+bounces-342151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD0988B05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD731C22877
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F311C32E2;
	Fri, 27 Sep 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCzAVFDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814C15FCE5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467234; cv=none; b=OYRwwS95GI/xU1YGF4nIatXjcaE1iH+2AkG4kfH/mvEVzdhC36gaZB50HNpYfa9MHYMXRQ7Y18yggymclNuo4rguN6Bj/oAfuMDZDbwqwHVBynI7bckk8JbHMWaiNk5cvrMTgASfvKBifGiUtgAKsDBg6gBobT7SQ7INYtpaUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467234; c=relaxed/simple;
	bh=YJ9F80sAsIr33/PSUGQudPVJdjIJZBKx+I+tMgKicH4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d26TsMMH/ZObw8gdVDpoyukCegcwZDHuJsvAlI+eC6hmGl40JjWNILJF2r+IFrMroWA+5JYXSJ4fcUex05hpaFQD8VhFs5tyiKcHlH3G07Lu2JxgZsMYlGCsd2Nnrhxr8A8EpeN6XFlgDioLblpshqiLg96IUzL8DlTTPcfyGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCzAVFDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4424BC4CEC4;
	Fri, 27 Sep 2024 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467234;
	bh=YJ9F80sAsIr33/PSUGQudPVJdjIJZBKx+I+tMgKicH4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZCzAVFDUVcS/IIWiaPiq/YinCQwKfxqwWeNh0CX2Cu1wYfW03EPUSUzIM2AUVlXSj
	 +h0jks/3VRFFbTVWxhjFjS85G4gW9/cQvdEgFdqFaEbBSiZlKyi5unzGqU06KMhXmS
	 0L/UnRRmFhtS4uLdxuyajUdeRiCs0qXaYPrxwZlr3TsBCwDwX+7rroC5tMbfRheTcx
	 IatRA5UrNH2BCnGGVsHqYxIAtXq7VzzfDE9juQRsM/V6/1pJ00zpqc7Oi1fTY8bXlx
	 msGLN+iHAVgkUP/u/06AulNC9hsIpTpld/LjpSpipR99R6kEMLZuiNWLXcPxPdjpwE
	 fSzxYYt09OXPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 352EC3809A81;
	Fri, 27 Sep 2024 20:00:38 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240927174507.1795312-1-Jason@zx2c4.com>
References: <20240916121358.3666562-1-Jason@zx2c4.com> <20240927174507.1795312-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240927174507.1795312-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus
X-PR-Tracked-Commit-Id: 9805f39d423a30a7189158905ec3d71774fe98a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34e1a5d43c5deec563b94f3330b690dde9d1de53
Message-Id: <172746723685.2065565.2165573073264177639.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:00:36 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 19:45:07 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34e1a5d43c5deec563b94f3330b690dde9d1de53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

