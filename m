Return-Path: <linux-kernel+bounces-340777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A09877B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA811F27254
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A801662FA;
	Thu, 26 Sep 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMmAkJBu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404B165F19
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368688; cv=none; b=l0u3QVmTV7v1N8yRfNTUoAlTBQGxatYxmwSFe/rJcITijt1gnTCh0bRk5S/P9EQMKUzscYYFVxmtoFmU/uO1LZVRgb49+B5a3ql95x1du0M0e+q4czTr/2OrX3fsVMGLRgEm4EX0QZbYf6kgYjnX2g5vGftYttMxMTj26ZiWNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368688; c=relaxed/simple;
	bh=eyHJGXLmkdMypSLFgXdpvFHMQKQeNI6ccHktoIMvbD8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I14cPEBPvvygzGHlUB1zuMuaGJJprtHWekHxm8i3ezxG7Pq3XEVgEiMpLO0K4teFbmBiSBtpO39jI9muqsAsav8P1u65JcuOwj7Hoq70dbqe3xNrTwbVhmM+RjY8RqVoOrb8cwTSQYf2aFXKEH1IuWt9vPSXLQa3/VcYetMG0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMmAkJBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC3FC4CECE;
	Thu, 26 Sep 2024 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727368687;
	bh=eyHJGXLmkdMypSLFgXdpvFHMQKQeNI6ccHktoIMvbD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pMmAkJBuQDO0HSDSEqJSFR5c3MmYJouu3A/0XGk2qu8brBR0P6mp7TbSMGVDBf9q3
	 Y2QZB1RuIlCiIOmYFX39Vw5bxr8bIvD7ePUAMePzBob4iNAU0AY5UtnEk6cIHZdZUh
	 tLYEmaOY6NapbMAS4OnkWPEQyNBy3FKspFAFtna6BYx9HC65TBuiOBb3JxNQilZvxl
	 r0BDI/nqoNv1g5Op9yUYLG/gGJwoAV4xCDtyiW/dbYL0NLg2D7RwoOmipDcLevjxoj
	 Jb40T8KXjoRx/pHQsTfAfyIUxbny1ubn6LbZDTPzm14FAsC4GHBlsLrw2pPtR6ay9A
	 bnViesJYTQkTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F3380DBF5;
	Thu, 26 Sep 2024 16:38:11 +0000 (UTC)
Subject: Re: [GIT PULL] HID fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2409261135400.31206@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2409261135400.31206@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2409261135400.31206@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024092601
X-PR-Tracked-Commit-Id: 1ee68f172482ab3d165468b989026fe67d6ea908
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13882369ceb9b0953f9f5ff8563bbccfd80d0ffd
Message-Id: <172736868990.1312674.13576607440934473106.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 16:38:09 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 11:41:28 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024092601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13882369ceb9b0953f9f5ff8563bbccfd80d0ffd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

