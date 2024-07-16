Return-Path: <linux-kernel+bounces-254328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3573C9331D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A07B20A84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE7D1A2C1B;
	Tue, 16 Jul 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCgfxJQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42774D8A3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157945; cv=none; b=PuUtKLEJPfQABvhQIAA+XuQi6WW1UVKzM5Ir4h/pq4XZUukVM3RF57qR93nprnRn27iBGYdlsRSfemSUzA6YkHW9fcsKVxWbnJp8hzpjMme17QskHUr88mFx6OMvRFReeEHh7GXnF3ifm6QbwpcpoItayClRmVM3en1KRE2HGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157945; c=relaxed/simple;
	bh=wawwoVnqXSTkbxDGnOxhcF25rvPRt4nf5m6BFiizgwM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MZCcldRl01ogOOj8+Bd6P6M7WT87Tq5OTplOfj1AdmMfFayMDfMHZGfhS7ka2WUI5kGSuUFV6fb61FDHWNmkFiqmTuFDOAjUXJF7hj9977A7ybK5Uual0OcneicMO8wh/BH6udXdVYP+CeIL8L4Nfd2IrGqvn93scnG+/bFqiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCgfxJQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CF9BC4AF0E;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721157945;
	bh=wawwoVnqXSTkbxDGnOxhcF25rvPRt4nf5m6BFiizgwM=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=lCgfxJQntHOlbBqJULBUjhY/QKpiQE+4rpcGGqq6mgsmRr1w4QEeh87InOxNPVYf4
	 UCdsmlXT+8mbMl3tN45dOkJ8YkbyjfrU9VqKOEOt57zeMmntKC/BDD4up9z/zgNAAJ
	 evVOEybtzr8k917RQU/Vj1jvZ9DfW1hjIolbi9c+/+syrTTyumTdtnTwTQ+oXByI4j
	 ZN5rMXhyHTQ10FNz+FEHbCxA4bZmjdC/sozJwIRQ14C+H3PlHrNXRmFrjZ3sGvhx/e
	 CvSZFRyuxSmJb5zb/XGy1IWR3aeJoi3p9nkUgzvhT1H9eKSSG9+svL9zt2Gr8WI2g4
	 4rhzegm2KvXZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87463C43443;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Subject: Re: [GIT PULL 3/4] soc: defconfig updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <e94c0a1a-6e04-4ecb-8985-779c53fd7fc8@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com> <e94c0a1a-6e04-4ecb-8985-779c53fd7fc8@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <e94c0a1a-6e04-4ecb-8985-779c53fd7fc8@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.11
X-PR-Tracked-Commit-Id: 05a01ce77349f60b8f8d8b09df4e02a99d1f16df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9a4cd9c3397109c2799cb765ab0d3959831a248
Message-Id: <172115794554.10577.5758621467230822605.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 19:25:45 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 23:11:35 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9a4cd9c3397109c2799cb765ab0d3959831a248

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

