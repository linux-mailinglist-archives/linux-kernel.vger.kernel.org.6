Return-Path: <linux-kernel+bounces-426732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CCB9DF717
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED24B214CF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B51D8E10;
	Sun,  1 Dec 2024 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NShcuV+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC01D88DB
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733086204; cv=none; b=cI73o48ibPpFEl3M+iRPEInOI5F+i6eDOgY7MGw11ZKMtOlIsFk/sMbliY8VaqPfIWeXhik1nnlY99kyXzqDA1G+9gYH0pFy8B1QSU7BSlcn90F8C6j4yH3kPBb0+H55PHwgxRSNm09bOH+6F2hQZOjx1eeeqmufX02f6BopCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733086204; c=relaxed/simple;
	bh=gtmc/XG9FzMHYTcjwiqp6wqFyG6XPiT3RYXIFR0ALHc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ruBpeAqOsTnsHt+Uyx2FAyJZyljSRvP29F1z1XbPnNNXanG//0+wRi2EarKu4Y557/tXBq3CY0mOKkXihwZ1yRLcx7jspCfILBsAHdbdOy9xL4kPHdRszTxnsGDyyGlVYCPRBd2sp3Ut2MpxxtInzrSStWqaWxwG1SBE2r+AriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NShcuV+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A665CC4CED2;
	Sun,  1 Dec 2024 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733086204;
	bh=gtmc/XG9FzMHYTcjwiqp6wqFyG6XPiT3RYXIFR0ALHc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NShcuV+wadms6DeM7NONOhMUVrNCqz+omGd5Dl1AoKm6BtmxZwuXdeJyqQ31lsGXh
	 kixpKXWmSVhUNT/1SL0rGY+oXXQJUbiQ4eTkMlN5SbdbT0HG8iorBd6pK3X69Y4e7B
	 BIlnbUzbicqLxYnv14RvJmXeOQIz5FNNMkFz+izDTZd3k2KkNQBd32w/uHIG+RHsV7
	 qErT9F9LXIQEZI4yKop6USJn3akVASSFL6q1HcLz+JmQQP6m0avBtMYHX2JzBOKG6a
	 yzHHwuoOzw8bruv88S9tHhRKWZrP2wdtTHmn9BtBKJLA/wSf0dGtFCdYKSjwY7dfQY
	 oZRD+q2Am7c4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB7C3806657;
	Sun,  1 Dec 2024 20:50:19 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241201104921.GAZ0w_Mev3hhUdkHHr@fat_crate.local>
References: <20241201104921.GAZ0w_Mev3hhUdkHHr@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241201104921.GAZ0w_Mev3hhUdkHHr@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.13_rc1
X-PR-Tracked-Commit-Id: ff6cdc407f4179748f4673c39b0921503199a0ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58ac609b99db0b03f3b09299c8fa3a76face3370
Message-Id: <173308621847.2752601.14854697276002748193.pr-tracker-bot@kernel.org>
Date: Sun, 01 Dec 2024 20:50:18 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 1 Dec 2024 11:49:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.13_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58ac609b99db0b03f3b09299c8fa3a76face3370

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

