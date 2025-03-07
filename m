Return-Path: <linux-kernel+bounces-551945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF96A57348
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741743B3911
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344ED241681;
	Fri,  7 Mar 2025 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6jTj9CQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1F192B7F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381424; cv=none; b=YZp1jbyNHWG66dkI6BysQ05D33QGA98HOUJ8eL3mbgkqQVNQ4I7XQC29XCFTb4byNcKmPeOoSiUecVkP6iWJlDhVqs5USK0Wfs+fGlSm0ieJWerdQhZ1X+omE3M3UoC+brsDNyTINJBo2in2w+5/rMre4/FCHsw0n/QH3e/ngBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381424; c=relaxed/simple;
	bh=CPqKNUs686GlDomQmFbaLEb5hFqz+bgwkf8/FPqSAxI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UR9gIV4OUONL3QKHMxhar9+9xat3zvULh6zgwIcZThn5+sIi01Xnl7EanEgiOpzwhEGQ6W7XvLjn5AKoJ/3It/miM0LYFXMAFjrREkCh7TWKB8cdaq2DneKqVW1X01HGxLUiU9d+92AXcE+eWFWFSd6j5uOPKSRIsn99LzHCfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6jTj9CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B113C4CED1;
	Fri,  7 Mar 2025 21:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741381424;
	bh=CPqKNUs686GlDomQmFbaLEb5hFqz+bgwkf8/FPqSAxI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u6jTj9CQxQL5M+2ysWsdsMqR9kHrUOiok7Bl/hydRWeWN7EzEGMgCCFa82vS6QemO
	 tvopelXubMazSVRWrboRGX+nyrXGT44nZEynXYxXSIwVVQlqasoUt+k9PUh37db0cP
	 ZKgaHAn15uFMQRM6v6sRhYr5JEhWXzvj4CP6oElzISwZl4ZoZbWLNTRVJEuQEZ8IZP
	 eZUM9OJIS6fT9bEZFvq5qSx9nXMNlaCAZETefAo1mb6z4HPzqdJ28EQloFYgQwaTsx
	 q0HqnNzLggFn5Mx56vm26TvFLXsCk0gC7FzbPSGsR8xgmJksYkI72LN43YGOGpAxlP
	 KRo0XH85pEXFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE589380CFD7;
	Fri,  7 Mar 2025 21:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8rj_-8dP8rH4-9r@gmail.com>
References: <Z8rj_-8dP8rH4-9r@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8rj_-8dP8rH4-9r@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-07
X-PR-Tracked-Commit-Id: c00b413a96261faef4ce22329153c6abd4acef25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 042751d35326d4401d843ac3ee25957815aecd10
Message-Id: <174138145725.2483503.13395677638606940578.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 21:04:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 13:18:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/042751d35326d4401d843ac3ee25957815aecd10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

