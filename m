Return-Path: <linux-kernel+bounces-445324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D49F149D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783FC2817C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1931EB9F7;
	Fri, 13 Dec 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t93e+T0e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2D1E47DD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112878; cv=none; b=AZoRsxhRisudLZt+lbM/T1d8Zv4+VwDFRJlybakr90bQ87dnhXRPFN07/cKfUWDUboc2nFW4cknYuEEFFCAXzMuiCg7Qf8EiuTKwa6nyuly9EZGFATvKtKmLn1HgPiNn5VxeBgTttCmjB5vM+UnvP6EAZQGjTi7LeTQ8Hs5zNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112878; c=relaxed/simple;
	bh=Yh+xJiaIHmBFIYqaqehnVPgsk0JfItsYCRQBuSxUL2E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sUCfssyb5lG3TIRX1cPRU5JyFX+TkDELtYAOilLkCmgylU/jsDaNWrCdw5GVRpmHzyAGgIOP8RLNigiAeDXscSwTrNBMpZWjx+P1GyYUxYBl7MSpLRHXHdtH4QPpSXBQJjSrC6YozRiXf7vIz2EO+dTCTozrb5czRv02hVnyzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t93e+T0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A0BC4CEE3;
	Fri, 13 Dec 2024 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112878;
	bh=Yh+xJiaIHmBFIYqaqehnVPgsk0JfItsYCRQBuSxUL2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t93e+T0eKYA6s4LaIHnvigXaa5317S+npLSOb/jmQdX/Mg95Ta7J8mz9LQImHzR9t
	 XYNJCupPA50gu0WZzCeJ9lsbfuw/W4W66KskKVEenhfj3+8wLnCcpOCP9+k9jlGLvS
	 /jzQo5uRqX9uOd23wx3aQX+d7nRGtQRs0NRtIqALdAmkCWTsWYHeXeDR4ER8ClWkOZ
	 lo1dHXG//mJvkg5aSr4gVGzQuuE9HDR1B5haBw0lXtYUdTeaTNvfn6A/eygPex/wpl
	 /tg7RWWgN37GiAvKA2esQ/gyVxgTsfPUvUFAdsCN4OybiuHPD/v3tzwlA8iRREB97Z
	 49oyCSBeocFog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF60380A959;
	Fri, 13 Dec 2024 18:01:35 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <e68da20c-9f5d-493e-a436-cd9aa95a5441@suse.cz>
References: <e68da20c-9f5d-493e-a436-cd9aa95a5441@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <e68da20c-9f5d-493e-a436-cd9aa95a5441@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13-rc3
X-PR-Tracked-Commit-Id: b7ffecbe198e2dfc44abf92ceb90f46150f7527a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 266facde8367cac71d748f04dfb4f72a76bfe51e
Message-Id: <173411289461.3118228.17776937426300109044.pr-tracker-bot@kernel.org>
Date: Fri, 13 Dec 2024 18:01:34 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Shakeel Butt <shakeelb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 10:42:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/266facde8367cac71d748f04dfb4f72a76bfe51e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

