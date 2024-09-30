Return-Path: <linux-kernel+bounces-344773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B798AE22
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF691C222C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFEE1A2572;
	Mon, 30 Sep 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmDZdTFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1D1A0B1D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727705; cv=none; b=DbAhVM+1s3WKftCyjICuKZLFjaLPbIc+5QG+mdmNULBlxfDLARfMxJxKAnJRPLfwrIbFXTTM8RJMJfXraRyskmAxKa3nbx4zaJ+Ee2KHys129u0uzhBjzjkjWMvevEd7pQOOggU/THRD9Ql4KyS4dRxYIoU60KRaLI6vsm90Chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727705; c=relaxed/simple;
	bh=pBHwEPa1nEoI3i4XHFR8F7ozj1ZXyykKzhsTIt4sfJE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X0UAxT9pTAUOGDN+PQZXETHF1Xk6uoEnj+hTYZuveq1EQa2j0CeUUCozPh6ubRMyH4iGbABcs2Dv2IsWtKEylASG61vqnZq0LvbNDFKS+6PDya/+Rgt9G7doEkdQzPpcqiSafZSuWqHxJmzgcXG3krEc3+VaPRdebrBSYPTdCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmDZdTFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7713EC4CEC7;
	Mon, 30 Sep 2024 20:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727705;
	bh=pBHwEPa1nEoI3i4XHFR8F7ozj1ZXyykKzhsTIt4sfJE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SmDZdTFpHiYqQ5sWxAb/G72lj7RJJ/IlcCBkQxSpWGvaszkomSZSFPRCsW8Wq9fbL
	 YzkMY32iwTru1odbWCcUr2QxxbwQ+KTmsVM6CyC28U0M81TpQwtnn9aCumQJv0trPA
	 sUijdl1wSWNEZ2SEkJveiuZBk2M7QXrFab1SQR7PzKMPvCLW+Mw2Twz76uQ2VjZHkF
	 ahTGzIBd1sXq/FArtVyslUxCdUDP2zPhpp0FF/XvljsmEJDqeMBandEE9R5nUdEqmC
	 J7OKwvZb7FRkXc/NQFDR25Nnlax+KLjt32TTUVeDWGxShh2wpKHcgNNS2ZIlbJ+b+Q
	 MndpwbRG/5k4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5563804CB9;
	Mon, 30 Sep 2024 20:21:49 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: A second set of fixes for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvsCeqjNGgqglWaD@slm.duckdns.org>
References: <ZvsCeqjNGgqglWaD@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvsCeqjNGgqglWaD@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc1-fixes-1
X-PR-Tracked-Commit-Id: 95b873693a0841e02b812e693296a884362fdd51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e32cde8d2bd7d251a8f9b434143977ddf13dcec6
Message-Id: <172772770837.3918229.14470609483808638910.pr-tracker-bot@kernel.org>
Date: Mon, 30 Sep 2024 20:21:48 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, sched-ext@meta.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 30 Sep 2024 09:56:42 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc1-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e32cde8d2bd7d251a8f9b434143977ddf13dcec6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

