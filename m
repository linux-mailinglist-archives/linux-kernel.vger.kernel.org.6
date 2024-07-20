Return-Path: <linux-kernel+bounces-257748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3DA937E66
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B6F1C21C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C910A0C;
	Sat, 20 Jul 2024 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOj2/BxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7FBA37;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433955; cv=none; b=NJ85jq9Ez+IzK193syKbbmYYq5DAzKPPc7K/EMIU3eIx39HGlOYdS6mjMkH472TweRDQURtSLGsZVMFPefu8t3RiFiIMNcsvXi6XxYeLWIq+2Q/VgtoLWg1LlZmxIVS3TLO6B4DmmjROiBOeHALF75kdix7bK2Qxx4lkXZFvKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433955; c=relaxed/simple;
	bh=qmgBOb/Ps0NCkFW8Zu6bDz1mZR3/gmxfq1zCQfFVkew=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mHBXS4v/bnCewalDb5MUrB6C/7QKgHAH/SQKPL6Q2mO7rMf9xh95rpb6JNwsKDqSryCzLZJTmPQSWaE6XKoob8yUILs0RXLgHKLFYVwYSNaHM2J7mX2Hsu0y7BOVSDfG5GrQqZzuBmGKx5vTsse0yd0KCfm271fX2R60h2N3UZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOj2/BxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82313C4AF09;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721433955;
	bh=qmgBOb/Ps0NCkFW8Zu6bDz1mZR3/gmxfq1zCQfFVkew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BOj2/BxRTDGKPK5on546KVSD7Pgj8iyxy434hA1wwVXKxIbMSg6Rir4ym01z1ATFV
	 GioxClEZy4kKZHXY+sn3pvOi+013PnxuAQxwarh+yp1cWl55tARWdU1EWPMRzCGeR1
	 sHn0NDYjIH0xDTSfZSVWS/8hBHwscaGbXQTiFKPWMR7aT4NpWhnHaAW3pF4+3N/bkJ
	 rjsNppxK/aLYvYTigu90BlRLPT2lhEMQRzp5xKWtuS/c58cMcOIYN8tQBNUfHlU8qZ
	 MHT1jtRHj2MkYii6dTPSg+yi2N9RM8jaFxzjQ2BxmNWM191ftHR4dsoVNhuuxcWvQf
	 1ucBRF+qQ/T5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7964DC4332E;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZppbX-7yYMwv7UJA@kroah.com>
References: <ZppbX-7yYMwv7UJA@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZppbX-7yYMwv7UJA@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.11-rc1
X-PR-Tracked-Commit-Id: 104e004739ef03890a1e175b3c2672d50c6d1a6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09ea8089abb5d851ce08a9b1a43706e42ef39db2
Message-Id: <172143395549.25682.3233372001133689911.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 00:05:55 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 14:26:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09ea8089abb5d851ce08a9b1a43706e42ef39db2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

