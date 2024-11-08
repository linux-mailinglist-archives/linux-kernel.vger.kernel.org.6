Return-Path: <linux-kernel+bounces-402116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757B99C2424
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CA2828B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B71C1F16;
	Fri,  8 Nov 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlgrENs9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D81C1F0A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087552; cv=none; b=ohhM1x71uMDnfHdBIV/A+S/ipug/vpSdrgBlyw6T0NYm292i9vAy5V5gNycZMWK1EFrN5ohN1Np7k79KdZNRgV+aPJfHJlxQm5kta8Ak1vqZsmMPQfrCo/Sr8Uy1ztjN5TW6Tf8AzTP46AY0Vc+cRFIbxbv8DL04mRv8AQ9JpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087552; c=relaxed/simple;
	bh=jZWxf+QcD+gI1jabJG1dw75G4oBevEzP8cH4NrsrTnU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lO2PL+N+tHgb2s8uFAJ6dg4wDK6qFJkiURMGqiuwpflVqG1m5a4CR8dr7lNybuitVgxkYC01fnRap0jHaOmAu2ac5TL1uiJt84/Ks5u1Z0+bMJr0iVXWcTiDHXRZT4qHZQgUfzkbTZK/EfyiVsScgpAZsEuSQb8z8lAjBYrNO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlgrENs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E826C4CED0;
	Fri,  8 Nov 2024 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087551;
	bh=jZWxf+QcD+gI1jabJG1dw75G4oBevEzP8cH4NrsrTnU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DlgrENs9yvb418FCZi/HA/zeukry5mavqei5Z0qyEIBskZXVYgiwR1ODg50JNuH3c
	 FY65nMFWJPYW7sm7/ncMl5D4NGdgw/FrTbCDFIb3vzKHqwluHj5u7AlPMiAHg1BUeF
	 KAjVjFRKi3ey/H6KGTRLRSibZ09WNsqw0zRtkHcs9kpsgwKzGWJN/qcvEgNFO6D4Eb
	 VD+Qw/qSGPf+Vu2sZKpwP5uGWqmZZihEXNpLPs0sdbxOLhqS6oBADJlLXdcXEaml9j
	 2qEaGVYCCp3HnX268z51uSdCIVDlNg5ecfVOI2LpQIAB6gZVNCFoqIVhaDNLsRPDfl
	 K9NzDy9gkoatA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348ED3809A80;
	Fri,  8 Nov 2024 17:39:22 +0000 (UTC)
Subject: Re: [GIT PULL] slab fix for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <c7ebcc0a-3b2a-4a1c-ad8c-2856fed2ade0@suse.cz>
References: <c7ebcc0a-3b2a-4a1c-ad8c-2856fed2ade0@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <c7ebcc0a-3b2a-4a1c-ad8c-2856fed2ade0@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12-rc7
X-PR-Tracked-Commit-Id: 9c9201afebea1efc7ea4b8f721ee18a05bb8aca1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1dce1f09380e28633b8b910fd87b103d5a8e11e
Message-Id: <173108756071.2704280.476899529317953101.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 17:39:20 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Nov 2024 14:43:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1dce1f09380e28633b8b910fd87b103d5a8e11e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

