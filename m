Return-Path: <linux-kernel+bounces-373373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE409A55F1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E122820AB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C8197A7A;
	Sun, 20 Oct 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLSxPuCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0B197556
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451537; cv=none; b=UINiChKgsKxbyj8AIjJBHgJ661EjF+sfWWN8IAd7rpXilnoLkdl4y8HVNGGxp7zGwel0vPL2L4POLlAYVi2PW+lohUVEYEHDrvzCUh8XfCH8ne5PVNW3Dg/RrnxgaMe7/Ici/RyE9wtZtMlMyQj9rg69t02UIpXEJ+yItBod5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451537; c=relaxed/simple;
	bh=E/NbQSfZ07tpFzofNZb+ODdX0p/U2MbSqHjVDHYnmBM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GRqZzBmCqt1+1PxVIjK23XVTMWWPyoX994LtD4Quq4sJF4OuGXw0tny+OZhFHzYTpLk4mHrJHP5RnOAQMnZy1bu/WfxVuGwA+TVUpGDAr+ZbNz8wZ4hfLDsqywYAMGc48PVodex1JkYr8Qv5GzkftwEzh2BvFxfgv2ruFvkKIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLSxPuCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE13C4CEC6;
	Sun, 20 Oct 2024 19:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729451537;
	bh=E/NbQSfZ07tpFzofNZb+ODdX0p/U2MbSqHjVDHYnmBM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kLSxPuCCpga9lPs0shzY3gJDXnOot4rRwTH8KuVleSl0l58e3VknLewOk9t62FnPU
	 q96yYt6lPk61KFnDkmpLDtr7mnrAOOTxRvzL6EIHYr4QRb6nIGqXgh1Gbn17by32m0
	 op3dezRcUR7Do9nNz/3nD2au5AIASHLoY35QgoyDqsnQf9+3BENdIftFQsj33DKf07
	 tEX8IxCmlVQWhYzeEQSLXrQbi0FPbsrCqYDxxDNvgRs46ZlYASgemD/ypY5l1qofFj
	 16uJN4cGxS7ybbotxAK5gxQsCwBm91k4tFjgQ8e6arRrpmzhkEDTgtGUHie+SbQrXB
	 l+v2CXbWQdAoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E633805CC0;
	Sun, 20 Oct 2024 19:12:24 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241020104957.GAZxTgVRnWOwSC1EnE@fat_crate.local>
References: <20241020104957.GAZxTgVRnWOwSC1EnE@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241020104957.GAZxTgVRnWOwSC1EnE@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.12_rc4
X-PR-Tracked-Commit-Id: 5ec36fe24bd2d529ba415b9eaed44a689ab543ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b4d25010d0f2e359ff34e06c120e0cee3848fc7
Message-Id: <172945154291.3627590.15974564061231103888.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 19:12:22 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Oct 2024 12:49:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.12_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b4d25010d0f2e359ff34e06c120e0cee3848fc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

