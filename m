Return-Path: <linux-kernel+bounces-189548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A118CF17B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FAC1F21317
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5F129A9C;
	Sat, 25 May 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDomPCQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545E126F06
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716673989; cv=none; b=C2w0SkcC9MDAYIUiPgYU2HbWcqnI6Mms1speww/5V0klwYzi0Ijt57vFtkaE57HfsfXyAmhsrxCBcLvXPLfDrjcz3NONB4R8LomCfbEbGHk5m0k0jSRu2+1ukxTNF/Utp06m77xhhNKZB27GjbP4KrIGMl6KYD3LA9ihgACyZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716673989; c=relaxed/simple;
	bh=itMZUEv54XBKY8m7jWhWODpCkpCtXQ0TcHl6W/MwWQg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xrm9OrTjKBvreGMSZT/GUSosEKo9dekv4txfaKvc+nHP9V1R1+6AqEAGXXTLK9sUjm4DJ0Vntomu1f0c/1u8Zai17C/n/EIbQYxdtxf4EjmUzPALgxIcIN+23QM0jm5+qmcxg2AHdQSASXcHx0VGU/6VbW8B0uGINvM0EiMfjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDomPCQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26CC5C2BD11;
	Sat, 25 May 2024 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716673989;
	bh=itMZUEv54XBKY8m7jWhWODpCkpCtXQ0TcHl6W/MwWQg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gDomPCQ3mr0oq58Vq69Dza9FAlepNzL1/7w/ITs89+sqXJymyavdvej+vjEi43YIt
	 wKKHCyebpO9P1QiqWAJnxHBMktY3ccB9yLRwk+HvuHANUBD3QUbl15zcCdTxGUTkJF
	 SEW10HX0iMCIT7mDRpnd5nQ8aI/6XJdEv87CgA+Z1LoPA6WQC8aarBd9fP096LjxCS
	 PRwIZapK/od5IJW//R1FJUryBhw7b37DRHENCIXsfS8qgZ2+W4PpspFCUmK0YGCphP
	 zwIky9vcFGUDaBARyrxqUupF94Lf/8HRwOIRRiRfpxvByPoIhxM5yH1lkx6ChLkLr/
	 JHqJSrnnKWpfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B24AC433F2;
	Sat, 25 May 2024 21:53:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlG_4Xvh7ssQrUYL@gmail.com>
References: <ZlG_4Xvh7ssQrUYL@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlG_4Xvh7ssQrUYL@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-25
X-PR-Tracked-Commit-Id: 93022482b2948a9a7e9b5a2bb685f2e1cb4c3348
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a390f24b77328395cb7dfe05739889aff6897a6
Message-Id: <171667398910.5622.14484623620732974803.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:53:09 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 May 2024 12:39:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a390f24b77328395cb7dfe05739889aff6897a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

