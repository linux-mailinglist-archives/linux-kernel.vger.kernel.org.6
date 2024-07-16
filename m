Return-Path: <linux-kernel+bounces-253309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2652C931F65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7655B22416
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537841C683;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/zzXPfW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2618028
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101299; cv=none; b=YDBkF3q325zPdmcIdHK1o820tEkBHQgGGd/AEKlrcuHZkqdd2Xxxl5gcvsxyHJdB8kxZeBMYbR4fvfIuAXh4VCxjxDJUzfjKfHBDNy/asiuV6auQxIvxf3jZDy2nu2vSec10Ptp0D/Uw9/t2eCMdFz6NEm8Pcr2iZOB2KCQB6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101299; c=relaxed/simple;
	bh=es8gWhaM4gPuBXgBcmPIH+KUHr9WrLzw7oDfgEQNtXQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QBvy4HqEttCelHAto8F/s1tUd/kdVJAFNLN1epQYDEx6SOjzUVn4tYGT4I2A0oQzoDR6hZ2P87cP6TGHFmE9UaPn61lxYFMVJwPaJkC4K5a3YxfDeKWjh7i8WI+pCKyxwOW13QIm4emzY935lcgIrsT4Coh7m+YUH31u91l1uUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/zzXPfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D6CDC116B1;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101299;
	bh=es8gWhaM4gPuBXgBcmPIH+KUHr9WrLzw7oDfgEQNtXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o/zzXPfWoxB+ZaL72xzlmHpsDRefElM/m2Vbe7fVrklHDUB+cBo5VDcdIXD1skWM0
	 8yEMgbMzo7UezHdyau2iQWySldqN4Gs3iYdyPcjG0Lr8+6IKyKDBKn1MAK8Ok7P/Ic
	 LhT6uOWCL26/Xo2P+X1Omk/tdzWDzvazdQ/UtX4I20UjgDfebJzf6v9eAPhFd3MbfW
	 A67WzvubMLoxJXv0shq3PQkJLqNcRLE9c/+rLIqC0oFHopJkzJ1bnOJFAjEnqc6v0f
	 iKAZDzsweMQ128ePRio/ditpNq66cjawc0MCuaXuAL01hT4KxheXKzzpoihSCj8k//
	 sRwPboXVpMmKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54C74C43443;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/alternatives for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715105528.GAZpUAIBt5b-zr4ot5@fat_crate.local>
References: <20240715105528.GAZpUAIBt5b-zr4ot5@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715105528.GAZpUAIBt5b-zr4ot5@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_alternatives_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 0d3db1f14abb4eb28613fbeb1e2ad92bac76debf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 208c6772d3839203fa34a8c77dd1fb7750c4f34a
Message-Id: <172110129933.18508.7669870237341168237.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 12:55:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_alternatives_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/208c6772d3839203fa34a8c77dd1fb7750c4f34a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

