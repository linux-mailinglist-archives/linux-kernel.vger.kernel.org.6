Return-Path: <linux-kernel+bounces-562110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F6BA61C47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847DD88447D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44D2080CC;
	Fri, 14 Mar 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss3ip0oz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C0207E19
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983206; cv=none; b=fEQDEVTvPhrdU/M7Mh0IwTPw+shaebKPvzOp+O2QrMlshhElKNPsh59bkx+LbO/d1HLPpiRQfHWOrKUumDScUSpRiMt4AUGsYS/BkMtLJ06yc8QkhjqqX8xnOShogRBWSTbsC+FWENBeGyyOWIbNLtXXBv7rjmgz/ChN97N6Oh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983206; c=relaxed/simple;
	bh=OcxlcOX6ym7nkmlHbLuSptP7iVzUlRJ1++sZ4YyWcQ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cb9P2tneBNnmu5vFIdPU/Xt+rJgUo407gXxCLAadBhI2WO4OC7vsfsPQvnSjjd2j65nGvpkzt6qRP6ShBmOQpkOVnffd07uHyPNzOkmMRMV3wtdkwaeJb6cs56UOzULIzC1qfSnIXLpQsUyh3yzv22lgb6QaUz9Xj51gVKLLYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss3ip0oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68992C4CEE3;
	Fri, 14 Mar 2025 20:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983206;
	bh=OcxlcOX6ym7nkmlHbLuSptP7iVzUlRJ1++sZ4YyWcQ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ss3ip0oz5Je2NF3i9OBuFmJG5Uix8SyWVUbSYZMxXuHp4wuVB+CUnyjFzgpwMrhhZ
	 M2l1Ai+SMu9kQhuDaVRswXyuX8VpwL6HFFpTeqx+F6MvOcfskBVdW4YePU3e3V8OKo
	 16AmbRis/UCD5nvtWNIEhpA57YHUZvpzaAXUebeaekbnzURVN8XGf7JfRI7eZAGBlo
	 UCxZMnwfJpK08r38VGyEPVhGzBHcRENGduMfoGPDQHFHQegHiH0pNGUaOWKTzOW2n3
	 i2cGHxbcYalYmJkjFhkSpmjyYLZA925reHdvs6msJ4KJn5pZsRFe/48eOUR4of2WXO
	 pgHXINYBwrQag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7110F380CEE2;
	Fri, 14 Mar 2025 20:14:02 +0000 (UTC)
Subject: Re: [GIT PULL] locking fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9Pxl-ItRBaAUd9Y@gmail.com>
References: <Z9Pxl-ItRBaAUd9Y@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9Pxl-ItRBaAUd9Y@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-03-14
X-PR-Tracked-Commit-Id: 85b2b9c16d053364e2004883140538e73b333cdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28c50999c977fc60ecbadfee4359a93116163d4f
Message-Id: <174198324113.2369576.8440713110756181399.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 20:14:01 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 10:06:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28c50999c977fc60ecbadfee4359a93116163d4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

