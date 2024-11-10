Return-Path: <linux-kernel+bounces-403322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695489C341B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E3E1F217D8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3971487DD;
	Sun, 10 Nov 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5SbPOV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D6146A79
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731260643; cv=none; b=CH4vdbcPZOuCR74T+8s6f/9Hm4rbGLke+0pVsq0c3pp+4y2DhOymDnDlcsmTLNZmpSBJ7UZSENjSc2a/nTvntYataCNrAIhOinAIW5pEFqqtj+t2gkIgeIEiV7R+rSDAlXtX7kCnnjqzidrQ7o3+h+tVLjp6Sj0rguwmG3qcVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731260643; c=relaxed/simple;
	bh=yk9LW15mG4+kD8QcjZo6l4d3jJ7R2HmjubfuudC8Sm4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nfHh/gaI4CVPVv8Hv89K9n4asBjX28ZmtiUhF0mERUD4VeEmuZt/B25VD1grHbpCCGKPfNst4dR7awym5psN/EMxuLYe8xwYosiXx01S4ejJ/8CaUF4PgIc+vX3Pn2QUWL8qp3Dmcyqy4qPBcyIf4FCYFE94t0MhboywyKCKSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5SbPOV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5897DC4CEDC;
	Sun, 10 Nov 2024 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731260643;
	bh=yk9LW15mG4+kD8QcjZo6l4d3jJ7R2HmjubfuudC8Sm4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I5SbPOV72f06b3mokHp+PCpP9KWgqxr7cPqYnq8QrF9brod0iFiB3nJKWqD53qYEh
	 DYAbLNNpfkqnqEEWZScbpSohOSSJWPh8qIWJH5Dfpaknft4mAErbZR8EdMOhHWXjyf
	 8suPKPlWQov3GyiZAlUm4HV6nBMDp2YNTD4bplGZ7C9G7VHUJFyOOCaxlnoVkl+55i
	 4Ykf9ILeLOB3NA1nZ7HMSJrh9TDULxL4A9MX+PUyD5Ktn/V4QAaHlp6lklaNV7/og1
	 yGyyotH88v97nkYt2o18Sf/C+sqHRpJ67FFvrNOCO0+8nedqyJ2Uc/oyjw18LDsgJ3
	 u6cg0nw8KOCDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF83809A80;
	Sun, 10 Nov 2024 17:44:14 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241110122754.GAZzCmyq5OfNCN4_Ts@fat_crate.local>
References: <20241110122754.GAZzCmyq5OfNCN4_Ts@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241110122754.GAZzCmyq5OfNCN4_Ts@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.12_rc7
X-PR-Tracked-Commit-Id: 464cb98f1c07298c4c10e714ae0c36338d18d316
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9cda7c0ffedb47b23002e109bd26ab2a2ab99c9
Message-Id: <173126065303.3189816.13973753326536317069.pr-tracker-bot@kernel.org>
Date: Sun, 10 Nov 2024 17:44:13 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Nov 2024 13:27:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.12_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9cda7c0ffedb47b23002e109bd26ab2a2ab99c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

