Return-Path: <linux-kernel+bounces-216442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77061909F61
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 21:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3F61F230C9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A121A4964A;
	Sun, 16 Jun 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An4VMlzs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABDE554;
	Sun, 16 Jun 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718564425; cv=none; b=b2C+xHx7BX1eUAjChITNCgohvNEnrefrk4TkYnW8dxcKf568NV74AUHCw+wiKMKZ33x6DisYtJYj/GfhZXGRSwyuVLcHtZbNqqsGBSP847AGgmpw70tAMg4LZ9ZsVB3VGT7rvOl3B1jS29sHsN66EI/u5SBXYZt46VYCH8qISPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718564425; c=relaxed/simple;
	bh=F1qNgLDKvZyzxDQyOpZj2Ea9pIJdSAorjSKZLmKd5kE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HtWcxeNWdCgZqZbAeFHkY/v2ulOtFUIWZuWglI4RACreMs+ha2xwZOxeJQvPd+zYXlWnmesPnqvz7pPNfXs5hC2dH/svP5ip7ZDfvLnaCRF4+3suzka88zrTKjX0obJhnBOJmCcNnT1rcKWK4cAAGiHmfOPUdxovdbG5YlfpnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An4VMlzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61189C2BBFC;
	Sun, 16 Jun 2024 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718564424;
	bh=F1qNgLDKvZyzxDQyOpZj2Ea9pIJdSAorjSKZLmKd5kE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=An4VMlzs8MSTTURAvLhVySuYlh4bfEIrJ9yzOnbwshoZwcTA7dk5dTi0bPL05dxYk
	 OBLQgAtl5bJXMNJAE6Kf3ANGX9w6MNJKR1Rb6c7ih+vdf8U7M06PKDVdDswHBs+F/T
	 XK4BVqYa8zWudwTLMHMVjUIwOKZdLPmkryPaNyUuKFiIcteWsPouaHatED6pXOkI6a
	 jvuaUYlEdm0lDyMnMgzz0cZEhWg8ZwNLMKTtZfr1NL4HSh/s3ixytVwmylCjvo8sZg
	 CRnz1a3u/pe+LRBKbofUhJuSgbcogaFpQz6pE80jKn9eY5bpGnyrVIlxVPWGr7RRh9
	 edWPb27QqDavg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5728AC43613;
	Sun, 16 Jun 2024 19:00:24 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fix for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm79OUifsEhG8CMT@p100>
References: <Zm79OUifsEhG8CMT@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm79OUifsEhG8CMT@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.10-rc4
X-PR-Tracked-Commit-Id: 72d95924ee35c8cd16ef52f912483ee938a34d49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6456c4256d1cf1591634b39e58bced37539d35b1
Message-Id: <171856442434.18923.12860606226726239274.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 19:00:24 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 16:56:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6456c4256d1cf1591634b39e58bced37539d35b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

