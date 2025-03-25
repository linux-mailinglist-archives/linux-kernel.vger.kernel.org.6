Return-Path: <linux-kernel+bounces-574657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22845A6E831
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D03172F53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EEA198E63;
	Tue, 25 Mar 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM9QfN8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65518E02A;
	Tue, 25 Mar 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867880; cv=none; b=a9bRnYYY962tRVA3vAxDuG/chWz3/BUZukFzp0bGyFZcNr0npXmWePDwTSpA7rux4NMmTBTLemmO+SSR/FgdDdj6i+BlVO0ODZTXNc23GFLIkL/bnlIaQ2GqCtXzxXIKyOWj6SQiZZ9kcutCZx44HAWSO083iep0+xWfILbH1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867880; c=relaxed/simple;
	bh=EQhuRSnLDPoPFmB4iFlaftDgrH6HhFnbk1f2sHI1RT8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iViVlRjHIEMfQxrkiGjRB+24GnQw1qVNQobU684nFH30OTtXwn5UG2WILX29vB4Ri4NvUoLIw/0i2voSKO2g1HRaN+BfchkmttrkP0sqOl7VxxrTyoVI/O5QZeOvOQEpPMbCNxx1JpWdOasBOWwrUY4VLR9KFcEpl1J+I+dTrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM9QfN8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0059C4CEF1;
	Tue, 25 Mar 2025 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742867880;
	bh=EQhuRSnLDPoPFmB4iFlaftDgrH6HhFnbk1f2sHI1RT8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AM9QfN8bwyxwdQ8RxLiwcPfIjKqZaL21zpBxSXzQlySCWA0gTHh4uoSFswhMcjBoo
	 61N8ZQ1R3FbYS5EZri1LiwjrZMo8rMhAU2UNqRLiiAM+gmNCSgFOZOgYnv8+Zycyat
	 7INIxuRQdIBJn7iAXyfWFNd+74Ayz+2u1Mm0On4e5PxL+CjCOzSD/jXgmwyDZwk7YV
	 nJpX8bD4VTgLcGmpSgfqj4EHN5bf1w/tU/mJxoJr0QOmF1VkvmCsIgrs8fTri9ir+l
	 8i43LXwh8pzIClqujoWtOZuBxW8bFIh18tQoUkkE/FPlxlIW81EOz2s6E5lIwLfdG2
	 u9EaYbkSKxdVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAF380DBCD;
	Tue, 25 Mar 2025 01:58:37 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <dbfe09b5-e5a4-4bf8-96eb-9fb6b98e2fb6@paulmck-laptop>
References: <dbfe09b5-e5a4-4bf8-96eb-9fb6b98e2fb6@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dbfe09b5-e5a4-4bf8-96eb-9fb6b98e2fb6@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/lkmm.2025.03.21a
X-PR-Tracked-Commit-Id: a2bfbf847c96196d62c9a59bd32e1fdafd1c205c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72b40807d21cc5d7d8e48bfa860d5d78769dc07a
Message-Id: <174286791594.53720.15242041260699194736.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 01:58:35 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, puranjay@kernel.org, jonas.oberhauser@huaweicloud.com, akiyks@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 16:15:39 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/lkmm.2025.03.21a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72b40807d21cc5d7d8e48bfa860d5d78769dc07a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

