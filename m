Return-Path: <linux-kernel+bounces-446524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBB89F256C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9749164744
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5691BF7FC;
	Sun, 15 Dec 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syNsE6Fa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D901BDAAE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734288324; cv=none; b=u4C89MRjJWHJ6jmiRaqtx9yAklByj7ACS5DCxmkb2ZzAQQ2e5DB2U9C4IX6qtfGE0TpeLLYn5jNZgHyfdxyiTmq/GzNlyA7jTZrCPYK96/CSIKZiMs5A9shU5PVBRwUjejhURp9jkuWLEQfhRlYElohWgvHRzDbqA8J6VJrKjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734288324; c=relaxed/simple;
	bh=j7Q76B2+Anq3oyukyzGz6oCH36JZfQWiesciP7HR+Ws=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mgMtaI0pxHO2937eIwDF2gDH0LWIsnGGYxdDCfkeg0EhUV0NQSVSEZKb675t+ceABltWrhUF4YikwQBueAPi1FThkJ/X3H+gx8cbjUhCIc8+oXwa5MUZtA/bDG+pbekEjOF2FTlnB+CDnkEIqctCte8clLEt3HHwG3NnRWIeaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syNsE6Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF7FC4CEDE;
	Sun, 15 Dec 2024 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734288323;
	bh=j7Q76B2+Anq3oyukyzGz6oCH36JZfQWiesciP7HR+Ws=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=syNsE6FaKIpWq27OPfGvtftj4DWUzJLLtDh1ItUbRq63A5lPmEM3QpBzHaXCFsLiQ
	 4hQfyI/if3nn6kI+JYVUj256anr3gzzKk2Ivjmp6DjpL1BVihBlaFUTrfEOEgLl4y8
	 BF5yB0/0uKst68ZrIJQBdxnHmVoISmIynNdbGFTlotvQ84BhVGGOEbDcKGbYgNverc
	 rg+yBkvXGTICPKsckRed8CqKSlTz87t4vHWpx5/K+E6T9rqsRoEb1MH9zR3Ikxxrpf
	 nJ4TNdxxLwZPdzgYUjJOxsmgvmWagraZjJOqbHkN/TsnPJnbITLTxoSR/EsawErnm0
	 W4yB+Pw7Ra+1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAB3806656;
	Sun, 15 Dec 2024 18:45:41 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241215121239.GAZ17Ht6EXiItke-uz@fat_crate.local>
References: <20241215121239.GAZ17Ht6EXiItke-uz@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241215121239.GAZ17Ht6EXiItke-uz@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc3
X-PR-Tracked-Commit-Id: 773c05f417fa14e1ac94776619e9c978ec001f0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7c7a1ba222a546438921b0d378a07e7776f9b43
Message-Id: <173428834055.3562041.13138179943726968379.pr-tracker-bot@kernel.org>
Date: Sun, 15 Dec 2024 18:45:40 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Dec 2024 13:12:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7c7a1ba222a546438921b0d378a07e7776f9b43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

