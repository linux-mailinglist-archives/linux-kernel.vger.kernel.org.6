Return-Path: <linux-kernel+bounces-178262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C615E8C4B43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5A51C21A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B2125B2;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkcZlnwW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC282AD53
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655088; cv=none; b=Z68SzkHxYBH8fHJMBhmy5HTbVwi5u647fGbMJfGKUAh4EdI/WE811tWLpk/Oql8jpcshbWNY7J32TCSZwD1TiHfXh65+4t75+hNCFInboZrpkXAAjGHxFYHXOipeGu2MdKmC2af5BMoPbp2FYgmkHWaNL3nz8ljwn/HZHVW24Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655088; c=relaxed/simple;
	bh=IsWY6nRwHES/2Ef8MmNmqhbH2sNBRyRN/ymD1qkBE/M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pzqZuL1BFhAEIivNPu84vLJnsKoXfsIzexStQ3nRvS7zqNrp4OylWlYwwSp3MSvbjdKunIjby+wXayWLbHQHHbXBU1gAVGeIBQZlEIJ/ec61SGa449/QQl3tMPmN49ee9WGpEj1Qu2+SG+2IGe63v9ngTD5rVzpW2Lg06aESl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkcZlnwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7B9AC32781;
	Tue, 14 May 2024 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655088;
	bh=IsWY6nRwHES/2Ef8MmNmqhbH2sNBRyRN/ymD1qkBE/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qkcZlnwWdcA6jT7lp29fPfYnNM/VLFqWPet0aFMWvi/hNhmlH++r9LfnDhuF2b2I3
	 VTMoYme7BT8/gioipJv+BRBJdis0DXM/V3puHVAkRPPAjRxyf22p8LudaEldXcg4g+
	 f60ghw56q1iGC91c9cvN0j9lB9jBl+KQuudALBpXK11Ttj1ahiS9bCzluQStmemkup
	 lupAkfqJchxLSScPV0SyxnBXmHw/1RTi1vvynyuWMTiQ8Ag6sXjLM18da3UhiTZtao
	 fLfQ1V2eEq6EWzzZLZ0d/0QDmHDvOULooriuf2EPs6fGanYR0RmkiZdBZpHMQyk9Ov
	 4Z4I4RGdrPlbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF6F4C433E9;
	Tue, 14 May 2024 02:51:28 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkGtVO7uhcFXEeX6@gmail.com>
References: <ZkGtVO7uhcFXEeX6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkGtVO7uhcFXEeX6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-05-13
X-PR-Tracked-Commit-Id: 532453e7aa78f3962fb4d86caf40ff81ebf62160
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48fc82c40bc29a80361b1eab0e4a9494628a7144
Message-Id: <171565508870.649.194842211316350194.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:28 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 08:04:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48fc82c40bc29a80361b1eab0e4a9494628a7144

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

