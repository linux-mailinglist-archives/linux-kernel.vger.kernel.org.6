Return-Path: <linux-kernel+bounces-373374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65709A55F2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5151F223D9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4619919645D;
	Sun, 20 Oct 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6uHc4m+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F1198837
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451539; cv=none; b=NkNkZa0URmX17m6fA6rBqxnlv7fCVManQZXL9RBh6rQR5f/+jO/AJ242uR3AAeAhccfSsff8HfzHBXFgaJ8knG/Tfa1hDfupi+YpjYgDsfMiSyBxqHLIAaVIPiF4jjYjq+8jAk3Z/pB3RP32MYJOju1hGARjRTX1GQ9WhK9mtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451539; c=relaxed/simple;
	bh=Tnjcs6N+7pTf1EGlSSH9QelF/fsJnsB6qw4YpUMeCoc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lr6uDMrycIcZpWVt+MYnvWJC1isLP5SxWHzlH2JWuNCXNKINsXcnMoZMSpuajcDNMwvtHF/l4VKKLqDaBlS6pO6W6GicPpalkxx1IrbpwR5/GVoAWU4t/SqzUkQAG6I2I3rCztnUUo63dvRvU3CYhWcd1I7nO38N7gUTupVDSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6uHc4m+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12428C4CEE5;
	Sun, 20 Oct 2024 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729451539;
	bh=Tnjcs6N+7pTf1EGlSSH9QelF/fsJnsB6qw4YpUMeCoc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V6uHc4m+8O5VKpl0jO5R1HXigbXzwgNzuiT9REi5Iy6mCUJvnkW1V3MxBHFmMRl8t
	 cWh7yQS62gTbG8DT3EL6P78/gIYCfLVv+43G2ZnL8GqPxrcbKpRmk0X/iNcU/WMxpQ
	 dmoOx0oV8RbSQ2WqKiyTFuecGWJZvyxdF35aKCIzr0bx1h4nb/kW1/5xl20+n/EYXt
	 5u9ETAx8V0IafaIwl4auXZDmE+OAqnwPcHrSNYXNmqXWKXJLBoM/6L3BT3BVXgIfs2
	 eMZZ9cns8QS8Ii6FTki2X8fFWlwIBUcA9Hllr6s8K/a0PXNPv1V/v+Ehif7c/ZgVAB
	 UqkXEBDguRolg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D953805CC0;
	Sun, 20 Oct 2024 19:12:26 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241020112110.GAZxTnpjXjwKgF12oZ@fat_crate.local>
References: <20241020112110.GAZxTnpjXjwKgF12oZ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241020112110.GAZxTnpjXjwKgF12oZ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.12_rc4
X-PR-Tracked-Commit-Id: d038109ac1c6bf619473dda03a16a6de58170f7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 949c9ef59be74a0439e57629b72ac972c0f47136
Message-Id: <172945154467.3627590.6311732227435230190.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 19:12:24 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Oct 2024 13:21:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.12_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/949c9ef59be74a0439e57629b72ac972c0f47136

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

