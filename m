Return-Path: <linux-kernel+bounces-253315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A814931F69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AB7282D01
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA24207D;
	Tue, 16 Jul 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WheaJzcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1B1C286
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101300; cv=none; b=dAk+51OHbwJaGBoaVjpaF9D47nyJoxqCe7OPcWGM8gUjkK+E7SM1cNukcGfeGRQxVerRsRviw5s3DJU69v52N0GnxzxVGQ+HXteo4jvMV6Sic6D+pnJmiWzWG/4YNIRleSzybzizCeUoFRfn6lSRoJrOKGtaFz/eFAFMQF/WnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101300; c=relaxed/simple;
	bh=Adn2UmURwR5HceScJwQPmGKasVZH3twHaADjHp/0Whk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=grRvXk8Mzp0X47vKUe7qxsieh5hfo2k4p5tfMB50Y4Djl4hGYUsODJYPx0L7RB0GtrGxDWOh26+WXapSyw+YF9s+4GFfM/KYJhOeS8S8fBLfvsG91JCO76oDQSAxmd10MlSot/Y73d10bq8oHxmL6ChwotohD8xfu1MetFnf8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WheaJzcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAE4DC116B1;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101299;
	bh=Adn2UmURwR5HceScJwQPmGKasVZH3twHaADjHp/0Whk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WheaJzcLxrcITLCSCAqPvYTMVMc7bfhKwZdZwXnprGEyHzG+cA+JVeKCc9eZNiWKI
	 /xpK/g/Jnz1inSvOFKnqNG9FbAq6X7WiYSG1ulRgzhRl32pnsUU6xt6eZuY8mGWg+W
	 mXRAxG1xm1FhHOhv29phhp7yso3nfo9ZvvzPMN3mjgdjdfXXqAEZsOq/WYAMGdCFB9
	 pjC+gmaQ4QK0GI+ey40KhTCioSfiLy4bq0xCAnci97FA2LHjiB9OTTQVwie/ViKxLN
	 k+NaDMOnassTh3Lr4zGY9du3h9rNJlbieWZKs/N6E3bE6ZudH54iAmXAwucxBWHo7E
	 ao2yHlcvSwbSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCDCFC4333B;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715114541.GAZpUL5d-GJH9RQ25O@fat_crate.local>
References: <20240715114541.GAZpUL5d-GJH9RQ25O@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715114541.GAZpUL5d-GJH9RQ25O@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_core_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 8a2462df154799129d8259079ec1fecf78703189
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93196575442e13a1bc4190ecd870ceb21866013c
Message-Id: <172110129976.18508.13816059952485494743.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 13:45:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_core_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93196575442e13a1bc4190ecd870ceb21866013c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

