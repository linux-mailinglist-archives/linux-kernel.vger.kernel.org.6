Return-Path: <linux-kernel+bounces-206797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C4C900DE3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8896286CEA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A8915572C;
	Fri,  7 Jun 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyEHQaJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469921552F5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798080; cv=none; b=c0LN3sqeDe0RrxB3gmdBsVnubltUa2uD+3VVcrSNi5UwIApx2BvPM0FPIxvfPb/9AeJo41kT9Dbp9x8eHqR9DVPhf2XVRiiY9Py0pZrNdo5Bm692ZPrDW/9Z0d6HmQ5mLAamSaJe/Ygnpqh/sfMuG+Dk4bPxvBjcgWNWKECF2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798080; c=relaxed/simple;
	bh=gFCX/2+fe+TC92v/LNNuECOPuo+VqmHtOgpUKdTkALg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FlShcDVYAklZq7wE5qD4wfGzisdwqh3XaWnQ8V3SVioqpfgtxYW7u0FhIt23Nv75NSWKSlrSyrvajnLhcNs25nHn/AXFOo/J2IJQ/vp3ESYZmYw4Np+UxJkXCk1HSoqE2V7WD2Mr3N3X3Uao9HX1QKAIxaKkVL8hsUyjJ7UnisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyEHQaJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E41DCC32781;
	Fri,  7 Jun 2024 22:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717798079;
	bh=gFCX/2+fe+TC92v/LNNuECOPuo+VqmHtOgpUKdTkALg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eyEHQaJMuIZGvwJPSMOaGTa+dkZGRlZOp2XxEt1NPAB3A3yFvIfqEl/I7spf9NIn1
	 RR8QLVKujjGyeXtDa34hHgfEL3fn7AIdgPH6cruhb4x52VJzf7TZx2+2AXFo23zoTz
	 AaFPi0v/NdxyFnQxty+4YNMTEaLSY4GL9y4UFZIK9J0XEnaoswGxU4RJJY94m4e/Zs
	 ny0CjxJ7WnHRtVmFX5Of2maocSX0QKb8BgjiA8pnIPl9CTG79Ac5cIPAcgfFYAO7CN
	 W89lBb/TE2RhrpWASPF10lSo6hWa3gexdg6dc041YN21XFHVjjWwsYH33aWA6JpTEV
	 LS4CA0om5bVIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9396C43168;
	Fri,  7 Jun 2024 22:07:59 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-1afb5c2b-25de-4eb4-a911-523495ad3939@palmer-ri-x1c9>
References: <mhng-1afb5c2b-25de-4eb4-a911-523495ad3939@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-1afb5c2b-25de-4eb4-a911-523495ad3939@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc3
X-PR-Tracked-Commit-Id: e2c79b4c5c4d83520abb570ca633ded09621c0a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a02756d9145725c1b9979f0486c268f91471a48
Message-Id: <171779807988.32288.747862417457855949.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 22:07:59 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 07 Jun 2024 07:25:49 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a02756d9145725c1b9979f0486c268f91471a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

