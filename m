Return-Path: <linux-kernel+bounces-253317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373C931F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11399B223B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D643146;
	Tue, 16 Jul 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGe+ERCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E791CA9F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101300; cv=none; b=ROhAGy2GGcQcP8vxpQKWpmRrd7t0fkteeqsrcAjLpUVwNEAog1OlkLCmKHfWfgO2tYKLavx0kf7BG29zB07Kg0fGKMGo7IV/VGpMWj127HKF5jOZe9qT6p/2ADU67aHZF47Xl61Xtr8fB7SwXAjGrmUvb/jM9fldhxjlqTWidxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101300; c=relaxed/simple;
	bh=fgryNsPBfRwKy7IpziCXESXvZslxMkn6NTy6X99Yy/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M1Uad+65xzrjZj2QfhqD+Me83dry/WH1a0TPU63jjFJD83zXYnSkcHoUqT5tD3/GMdtcTyKoLM2XmLI9D4QAGeo0y6p9F3ll3etL1t+rCadF2dCRS8dOW3VCZXQnJVoqhEex4J4k3zoNE4/i5J+Vh7RDcyJ8EHhArq77qNtcNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGe+ERCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 680B2C4AF12;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101300;
	bh=fgryNsPBfRwKy7IpziCXESXvZslxMkn6NTy6X99Yy/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EGe+ERCXarCwafesTCJFK3ppgHKJEHYB0Xa02kfb/p3cl9MDORhgHnr0IzijcHw4J
	 Z+rK/mIHX+ZHGNBgrsneM2N8Fe5uUkg6rMOgrm5n27JxtlpJnXQIaXvk9F54FQ8/0R
	 9V4Kcx1pXn0x0M6jm4blqqYAqwwS0C1PW/3rKsJQNyDxKOzg6F5pnQv64H4qqHQ9g7
	 gRbmlFb7DZfqqab4RSVfV200ZdfVRsJmBIqb/2DaF0eQfAIXOpzwkq2jgl9/b1nyQM
	 KEOtP0LzBX1vEL4WXEfrdGOLvvFx9X8FuRe2ytE+O2k6rnz1aeipInILIY6Zo1DY7/
	 JqGgVvGdPI23w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E120C43443;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715173433.GAZpVdqWGG1ymjPfER@fat_crate.local>
References: <20240715173433.GAZpVdqWGG1ymjPfER@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715173433.GAZpVdqWGG1ymjPfER@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 42c141fbb651b64db492aab35bc1d96eb4c20261
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2439a5eaa753d22759fb4248e0f5e459503fffad
Message-Id: <172110130038.18508.18016066553228514599.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:40 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 19:34:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2439a5eaa753d22759fb4248e0f5e459503fffad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

