Return-Path: <linux-kernel+bounces-253183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEB931DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CAC282CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1EE145B26;
	Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5Kcd8dC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D10144D23
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087785; cv=none; b=t60kcUnuqTGTqtPtZxWV1SM8PxpzO4b/ecN+hl93aESnpxp0soPXZdAOPRdC5brRDDHNxPdzxCM/hng3QAdI+bAmQ55j44NH0N6tc/lpYvO5mBrvzFftQ67nK4jBfj1YwP168Ph5Yt9bSrzekIrpujLkny85zxauv+RW5H0HUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087785; c=relaxed/simple;
	bh=aLW27pgAaClf8LaFy2YdxxFwpbHVrGwBAhiyxAH+5NI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bbl0Q/wzeOcf+IXyLZeC77PQRz34Kee1HPk2B0Vyknt0Ttq8CRf5qMEtLAY1Re1Jnz2sj8Vbg51KJAS9WRs7mMgSv5GJCOj3vEvv82KDQu7AR7etKwvRAl3KLCxaBYpcWRpDUqQZjKcv9uXSN/Hsiam6W4mYLwRFsRWOD2jUbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5Kcd8dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 538B5C32782;
	Mon, 15 Jul 2024 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087785;
	bh=aLW27pgAaClf8LaFy2YdxxFwpbHVrGwBAhiyxAH+5NI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N5Kcd8dCaO1HYFj/7RhQtsgCbdTaKFhVkNB/hIweoSSDdy+I/mQoAQZ/4XR/NZlLC
	 ROhltsXf1XLo01W+sjtemuCvIUGJemnYcoWIL35/LYPF8UsgojQXubzdhevoN7n3Rf
	 pupy1vDO1XP8iLVb8Jwl1fgYfM9v9Mcwcv+Le8nx42nDB/TxdnJslnvQQJI3D8WIU0
	 SwlS6aaWfboACjiYHgsBI9hY6/Py1bVhip7lzEeTNb4ADkuLgSMYqp2zFIqZbxi4k/
	 AQ68QL+ZjiVy8+heA9ap7uLJcn3PrU9xg2Ja28yLQOxAUSxVhDbJr9rZ3BBA8cFha6
	 8xMOEHivuYc8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AE55C433E9;
	Mon, 15 Jul 2024 23:56:25 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <db9eca51-1e0a-4bd4-8bdf-6f60f4bc91b7@paulmck-laptop>
References: <db9eca51-1e0a-4bd4-8bdf-6f60f4bc91b7@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <db9eca51-1e0a-4bd4-8bdf-6f60f4bc91b7@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2024.07.15a
X-PR-Tracked-Commit-Id: 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f97b956b631a0340f5bf8abcca891a8e5a874f69
Message-Id: <172108778530.25181.5437046042808357237.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:25 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu, linux@weissschuh.net, skhan@linuxfoundation.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 15:26:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2024.07.15a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f97b956b631a0340f5bf8abcca891a8e5a874f69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

