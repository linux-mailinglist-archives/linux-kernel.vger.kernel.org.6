Return-Path: <linux-kernel+bounces-290217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4B9550D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1BE286E90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B361C3F14;
	Fri, 16 Aug 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Ys8XK0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AC1C37B7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832904; cv=none; b=ZZ+0ktG+GS7dqkUfCAk5aR33a+YKTGGmtviX68WNY+0DYMBcaiPcBBJ7etsN+Am50e1GwglYxPLmTkLzWetc5TGK46KpB2GQL2Neb6f2nONSdK1/Lv9vkN7wvWjBUXf0eWFQSzOw8BmcV+SR92RGE6nkIFouWfcGgev0VBaSvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832904; c=relaxed/simple;
	bh=hVbsUNk5hQjdCOKWnbYwau4OwNFxR9Ldnt5Erd0EGM0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oubW3SAmEEQMBPW6DW9LB8DFMcAjO+wpiyUWKCrtOAoOZp2b5TJbrG0Gq11JGg2zXxtPsv1dq430bZXtvJLyt4EPaRdLTjvJP63kP4p2J0fN6OMFGHNbSI1OiQLgj0l1miTX983syzRWlyF74boXVJX6N16fHDQ/zjhJUwuCh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Ys8XK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC9BC4AF0E;
	Fri, 16 Aug 2024 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832903;
	bh=hVbsUNk5hQjdCOKWnbYwau4OwNFxR9Ldnt5Erd0EGM0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o2Ys8XK0uDeriwbqQJFQ82bB50ZBS0PkKfbSO/LhvYJ2/5K0He2ikvHCwD5WxlpVs
	 25t4izupVqgQZjz6MHgA7OKtBIIkyxiZLwngORpAHWBS/Z+t2t0TST25OxlNwaOrbw
	 fayy3HiTeK7DoW4NJS9T4A2xA7x2j8eFV4S9kczm+2v+hE7o3+WPjh807B1rNsXDOg
	 T4/M6UTrjAC9HWZOb1eF5Pj38CL09Tceq1M3rY3WDdkEgSDTgT9k1O21g7PEqhGwKA
	 YJfNQWHXtBZIn0pzP/lVRIocUOVQOa3fCAQk4tVH8xeddzAh1aLuL51glNrfp4KyZa
	 CjevnvMKjUUkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7129438232A9;
	Fri, 16 Aug 2024 18:28:24 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-24597fb0-2ef5-4a27-ac81-cd0aa42fdd56@palmer-ri-x1c9>
References: <mhng-24597fb0-2ef5-4a27-ac81-cd0aa42fdd56@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-24597fb0-2ef5-4a27-ac81-cd0aa42fdd56@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc4
X-PR-Tracked-Commit-Id: 32d5f7add080a936e28ab4142bfeea6b06999789
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b179fe052334ea81c9f1841bf782bb0878b61d2
Message-Id: <172383290310.3597757.17050790371795847106.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 18:28:23 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 08:11:53 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b179fe052334ea81c9f1841bf782bb0878b61d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

