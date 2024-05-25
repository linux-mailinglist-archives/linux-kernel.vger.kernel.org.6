Return-Path: <linux-kernel+bounces-189549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0FB8CF17C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D608928172E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61100129E6B;
	Sat, 25 May 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAIoBGcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3D127B72
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716673989; cv=none; b=LkN+4Zt8/SUiAFkbAvuN08uV5E8hAW/1RsOW7CsKsl/I9gzK1eLvOFWmfNsf1L4+0uzutzq5v6+PJDAQbEvu8FkDEMynSRpBqGhxhWuTh+Gbgil5zgHbfhJz3z0stTlTqmkqODziOMDhSXwVpzZ/8pEda+GswX6LuBb9HxqlY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716673989; c=relaxed/simple;
	bh=+/JVgedgUsO9MapMW5JvBdnb/J/Uhu0RZy+D21vNlWw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k78igGUpPGE85G6Mb00VG0R7qdOdw26zQchbFBOywpbH6jOmi4YfG3y5JiunknqsPw2gwHV3jKy+pVkz9FrjW0zXDlDedYxYihC9OA60aStnVW9A+Uz5z+8HgoN6kEmEYmVGNIwSPv50kkmIg4i/Mrzzpz+yoYfj6yST9IJ5OpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAIoBGcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48D53C32786;
	Sat, 25 May 2024 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716673989;
	bh=+/JVgedgUsO9MapMW5JvBdnb/J/Uhu0RZy+D21vNlWw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QAIoBGcPDIVPYb2+kEV/Fc7bGIC2+6XcoTcoDoVrlUaTbZeVYlS1FDU3lUNzY7Sq0
	 mo4w8r+2VKfZU31dFWnkHBMXJJyD0wbon9Zwu1DXHGuT49gl+vzSqQIg5sFm/mhuqX
	 OkCYXb2rXTblJjbkIEy84pig/sSgE1B3IGG8u/qo6FzxLfsCMH5efBBSZ5biYgX8Wk
	 yQR/Rv4xyqsnjI+UjQF+wy6zBPsQnl2vVWkC43CY8vtcqcf2wk9SkLelLUr840dnP6
	 o4UpigtFX8LDLe76mabuPyKN8e1NNicIhIPtAq0cYiO8YqqPwWBNDT1Bb7ydHOimZy
	 hz9cK6pu+a2tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35958C43617;
	Sat, 25 May 2024 21:53:09 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlHB5UO55nTuG6II@gmail.com>
References: <ZlHB5UO55nTuG6II@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlHB5UO55nTuG6II@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-05-25
X-PR-Tracked-Commit-Id: b84a8aba806261d2f759ccedf4a2a6a80a5e55ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0db36ed571397df9a3f507ee19913a74d4b97a5
Message-Id: <171667398921.5622.15992618639424528536.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:53:09 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 May 2024 12:48:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0db36ed571397df9a3f507ee19913a74d4b97a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

