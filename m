Return-Path: <linux-kernel+bounces-516758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CDA37705
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00715189065B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0CA1A0BF1;
	Sun, 16 Feb 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoFLqd23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453332C8B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732305; cv=none; b=B3vtNNjsRPf+/r+P/tl+c7VytgVUQpXWbxzyM39Ml+XI2rzUA0RUiZOYhXgd30yx28ciuj+BJ4NKHEDd84N3kl+6WDzCCU3wzvQ4COS9CRr2EZpCB7vuM9IisQNVPrrmpUX4XAp9oE43s/MKenolDUEr0aGO4ifzKFJM+cH6sDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732305; c=relaxed/simple;
	bh=302iYr+aFdBdX2K7qKEkMk8JthIFUbdbhm+DiFpDdH4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qQA5glopbXMyjv6m1RBTH43uEgKBqZpSL+dMBEql8QJoct3TLvl595HJtdSXaJmuk92ZKqHsQSD08wHZigKIynvKbdvmpNPl627jycMc+J/mdI7sE5cClpPH0Bu31kn8ZnWK5V/WqRYpifBwva0+Ue13kV7/VEY9cHHA0NAKv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoFLqd23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2D9C4CEDD;
	Sun, 16 Feb 2025 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739732305;
	bh=302iYr+aFdBdX2K7qKEkMk8JthIFUbdbhm+DiFpDdH4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LoFLqd23b3TN6rUPuDqAHi3Z6EhzXVYRYLOMFRwCG1Y4YK5cu0rGbLT7wNmvvazFD
	 8bivBNyjgnhvWAGwyvSlNiNdp2fQL87y5n5eD5Ur+vDMafeHdE0+q57Njvrs+RDLT+
	 PkhFtBp5ecKETUvLJKtm/1OfZyTs0E6SGqFq2gXLCOyM0yv93uFwoJpXxLIpL1HSZj
	 X20kd1JC3TnB+RJKL8wps7QeQ+nTC4VT19ODg5fG9mHG7P2Fo0pR/vBqv8UVbiDD14
	 0Lrx26Qrhyn8+W/rj42oMDJnxqV4Y1Jfsw5+hxZxghoaD8PoCGjda3zJQlX8d/0rP3
	 2M3cMGf4bUChw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8A380AA7F;
	Sun, 16 Feb 2025 18:58:56 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250216090002.GAZ7GpEpdWUKHyUtr4@fat_crate.local>
References: <20250216090002.GAZ7GpEpdWUKHyUtr4@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250216090002.GAZ7GpEpdWUKHyUtr4@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/objtool_urgent_for_v6.14_rc3
X-PR-Tracked-Commit-Id: 7e501637bd5b702a2fa627e903a0025654110e1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 592c358ea963d7227e3e7b8ace91b2b5dd81f6cb
Message-Id: <173973233487.2551255.1412854134617794573.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 18:58:54 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Feb 2025 10:00:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/objtool_urgent_for_v6.14_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/592c358ea963d7227e3e7b8ace91b2b5dd81f6cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

