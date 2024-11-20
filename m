Return-Path: <linux-kernel+bounces-415095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D969D3182
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98579B234F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0525182D0;
	Wed, 20 Nov 2024 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIsmN5u2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D312B71
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732063753; cv=none; b=lTJMQt0kgGT3luQtPlWmtt3cKJ7ET6nBR/suTXwGFDl1Dy9QPqdCwo1T5oO5a8Rgys4zG1lNkbqgYUqRXe9Zj+endcweZmTsAAIFHVnwsYXrB9+6uoF3T6D1nHnkRnsMkU1xh8YLJYya1fyihzHoALn8nXWIffcmcLjUkV6x/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732063753; c=relaxed/simple;
	bh=G0KDTA/aRxARRADOPJb0aN0avXERC+BWkG96eI50Yek=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UePG/0oQQmKg70zwTEEp4p+R7FM/VO2PAwhjpxXXARuhflHIHJFGv8obdGpVQNIUkfA112yAiTMB8Rsy4WTN46tX13m8CGicx0Gp64w/roA1KdxHRc+91pQR6Pup5zj/6bIqzNJMid5MHRnRe4AyVfWtXG9qML9XDbRHukoSBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIsmN5u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17323C4CECF;
	Wed, 20 Nov 2024 00:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732063753;
	bh=G0KDTA/aRxARRADOPJb0aN0avXERC+BWkG96eI50Yek=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CIsmN5u20nI8CL02VmWI5hzo/FA09jwzXjeSwNZp/Qph2tTp55NQkyGuN4GWsTc9y
	 5GXzzVmfgD20vqfgJtnH6ZalWkY+hlc/xXFXXJ/DmUuC6nQ9x5siiLizFNBT7Diw2I
	 hE71KRi82nMe0ra3sLB9kxh/tYRbdQ2bu6vvdq597DrXm8WIqLRe1od9Jv7vlzZTP/
	 ti3cgXnJ0nGp2yY23NJbulZbYabxzXivlYU+TWJhM6XpMpRXl5CrdTTm44z9RY3uy6
	 H6OBtoe1THlFd+pcDQFC8fTfoJHdYETvgaI4FjI1QLZVBlnHQ5sSk4NwfrY7SLQnx+
	 Bmg2+AqxinfGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC4D3809A80;
	Wed, 20 Nov 2024 00:49:25 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <173195758303.1896928.8330927472936200835.tglx@xen13>
References: <173195757899.1896928.6143737920583881655.tglx@xen13> <173195758303.1896928.8330927472936200835.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173195758303.1896928.8330927472936200835.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-11-18
X-PR-Tracked-Commit-Id: 1f181d1cda56c2fbe379c5ace1aa1fac6306669e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c2b050848337f393011ee7fcd2e9f2663eec40d
Message-Id: <173206376452.738777.16488604326756878079.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 00:49:24 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 20:21:52 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c2b050848337f393011ee7fcd2e9f2663eec40d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

