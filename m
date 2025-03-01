Return-Path: <linux-kernel+bounces-539701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC1A4A791
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BE116AC31
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656735962;
	Sat,  1 Mar 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NipXy2HG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECA182D2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793227; cv=none; b=egG+0zhEZq8cuZfOxbbZ70blMadpq/Q33eRD1QNkR9ca5x2XQPsrupoawYGJrPEwpgRyelisTJi9l6dJ64ODydcJLMWXOn82vsxC0McRPI2VYkEtmfRY3bzqHSCWKLBW2X5T9b5m4hvj7acJVBtFz3FKiLmVKC8WO+9+ypS5hug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793227; c=relaxed/simple;
	bh=FM7BRiC8845ZKZGeuMaBWEgLyC+AmQvgkYrzx8BmPh8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qXHx0I4mQ1ICw/o/Et9F8LMF//aBST36Udmag17m1xTExjmmxsInBSrcNS3sKFP3SGIyrkbck6ninteh34JBPkXKzZAuiZ/1UffZtUexuzabGdUGsr6D/lZaBEwciNvedJ28rKXWLWB2NqQ59X6XwDvgUF1Hc77CUBlnwNs8Hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NipXy2HG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBA3C4CED6;
	Sat,  1 Mar 2025 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793227;
	bh=FM7BRiC8845ZKZGeuMaBWEgLyC+AmQvgkYrzx8BmPh8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NipXy2HGwo0ut390Yz2fjf5B+YPv5PQiCqaeErtQnFT204swCT7E5fbFM46AjWLJJ
	 6iNZj2AvkZHzc+mPScsxNBeW/09KqwxJuiVU1mRv2wS4Q6rwcY2AqbUmV3nsbHh2ZP
	 G/sspnPorBC/7CQZYZPY6/mGEwZsXnvAfZudT+jKIZGLtx6xYAwH4h8OR5nQWZ212D
	 sc+Ruy2JhCA5idC9WtbWlhC6OJRQQAhQggAIAxWC+yyfTuwYL2qlmN8i6OOa9COm50
	 qfcX1RNRPOwE/rK6euG3E1/ouvkIFh+cAFr5Rx61+XfvDtstx0IoqojQDVTFDUZGcd
	 H2pHn2wRQoudQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2D5380CFF1;
	Sat,  1 Mar 2025 01:41:00 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8IITcV7pyylQLdb@gmail.com>
References: <Z8IITcV7pyylQLdb@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8IITcV7pyylQLdb@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-02-28
X-PR-Tracked-Commit-Id: b9a49520679e98700d3d89689cc91c08a1c88c1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 405a41d7599be266ae6880e73252ca41770760fe
Message-Id: <174079325924.2333772.13618018208300696109.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 01:40:59 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 20:02:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/405a41d7599be266ae6880e73252ca41770760fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

