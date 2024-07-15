Return-Path: <linux-kernel+bounces-253176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D7931DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA09D282AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75621448C7;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIN49C0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A2143C41;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087784; cv=none; b=tIpiZbSrBi6+HDIdF+cJ+sDGYLm17BWz1SqWDASGRM4F2heq1OA3qCVySWQ/lSdp3+W7EVZebpoCVdkLCLrUpKhHYzP/bXvwaOdqDuQV0eLuBDndQhtXu6wzrNbXRmfSVqOsCVPG77EKvt26jdgsBo3ksnGBKmwo255p64sg4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087784; c=relaxed/simple;
	bh=a5/mN+4q7CbWeKk5VbDVrDUInCrLRSO5LBTyVpGg2zc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aEKebd0oz0T+FNyjedkt0nDjWXlzncNTYfeDelii+c6PYaVR0u9qTMQkRrhLOkq50no7BQuTZyxIINOGRRXnrHEX9hUFT8Lm8YzlQMKST+nDxq8pcggxJK6dhbrbjGHC8xDH92jATb335t1XabJdJK0zURqMzfalx/cdJ2GN+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIN49C0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCCE5C4AF15;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087783;
	bh=a5/mN+4q7CbWeKk5VbDVrDUInCrLRSO5LBTyVpGg2zc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IIN49C0lXtO0/HrCm3offShvibjSc/deEx6XfoAYilr5MbhAkWXyXmLs+nccv6nH6
	 vJn4ul6GLaq3pHjdy0ZpNBA6gGSSlTvzeBFAbTM66kWyMOYYcandM+l/7iMmYXXkTb
	 aqLaZLe09uOPsWqeDR5gPCRvTa6Yqj/roH7wt6ZZDpbxMmWUjt+ZpmJUM99dIrKPWM
	 vNrZLawQACovPqvd+oWCPGmIv4ddE9DdGrW2VW+zS7TsoRaUeqgmwvjajDGnFvhl/5
	 6ETzSThXMG4YQXjL9ZVwUwJ175QNJ/VTAyos5cRpakHEgFH+osof5p6pEsQdQ2xiXt
	 1on8+h/hBZAhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C22D0C43443;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <22048c72-ae8c-47c0-9cd8-3a64f84fcaea@paulmck-laptop>
References: <22048c72-ae8c-47c0-9cd8-3a64f84fcaea@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <22048c72-ae8c-47c0-9cd8-3a64f84fcaea@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2024.07.12a
X-PR-Tracked-Commit-Id: 02219caa92b5b0ed97f8d8b9cf580f6f34a9be31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9855e873285f1395b9a04613c56101f04a5ec9fb
Message-Id: <172108778378.25181.11076168582382605495.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:23 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org, oleg@redhat.com, frederic@kernel.org, qiang.zhang1211@gmail.com, quic_jjohnson@quicinc.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 09:43:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2024.07.12a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9855e873285f1395b9a04613c56101f04a5ec9fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

