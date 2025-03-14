Return-Path: <linux-kernel+bounces-562109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDFA61C42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7162819C1E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1627207A2A;
	Fri, 14 Mar 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYo3TMaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB0204C2B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983205; cv=none; b=tgMf4ncmj/8w7qh89n5XNPIOHkqvHB/vvIXIw1rbgMUt3CWdveaVMbTRiDNOEm9frA03nXUtrXwDl/1yolNWoHLIaLbhuXgO4pONJREamRD7R87lWSO9U/W1fw7/cIULbu81taczhd5uFvdZO8An/Ibs887T4CiqPjQtAjnxDT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983205; c=relaxed/simple;
	bh=48TzJKv7N3cXDf8utlWSIHcmtKoHbj/swfhOX2g7Hs0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ddyf71k4BM1mbpbaciDzn360ZqYO7vyzfsl23tp2LzievuOHntRrCiDx/4HGRy8RxNFHcXRokYJfUCCSXFSNlF4euM3wojUmcGSJ1QAE70457061FCYdiqWfq3jpvUfpg1ETPHGZ3McjVYVXMhElCBbB6hVHSizgot6ZPkYBPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYo3TMaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EB0C4CEE3;
	Fri, 14 Mar 2025 20:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983205;
	bh=48TzJKv7N3cXDf8utlWSIHcmtKoHbj/swfhOX2g7Hs0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BYo3TMawtkVML7nZ/VAYK767+X0RNU1AgYToMYs1u1szrC0gKOtigdospLS9+cmm2
	 zsspicoBT4GpcIHSZOJpv5slzcxXmRTh61eGrxzUkM3pACYMipjbxZh/r48mzQceF6
	 r3aRqO4XS8Aa2BVrDLSTFNmWOrufqoUoJu8lrvkUzXI8ir1S00+cllzP2vIAHoCzDp
	 owGO1mbhUzGmRzkQ1fQTmG7XvhS/c+XPOO3e0vZIoBJO9IVA7VWSzqZYWHdQhT/frx
	 OwyRV0lF4AoZwuDDHx3626jCcDo3gzf6jkaw8kYb7IZ6imP/dDI2H7NGr7Mm5vi9FV
	 Cbz7UsbJzVuHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6D1380CEE2;
	Fri, 14 Mar 2025 20:14:00 +0000 (UTC)
Subject: Re: [GIT PULL] core kernel fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9Pv-InPlIE03148@gmail.com>
References: <Z9Pv-InPlIE03148@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9Pv-InPlIE03148@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2025-03-14
X-PR-Tracked-Commit-Id: 366fef794bd2b7c2e9df933f6828dd9739bfba84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70e23dda3817f8e74f71385e4c24dc891780deca
Message-Id: <174198323955.2369576.12108954519318367571.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 20:13:59 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 09:59:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2025-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70e23dda3817f8e74f71385e4c24dc891780deca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

