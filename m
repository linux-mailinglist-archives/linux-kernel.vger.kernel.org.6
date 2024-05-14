Return-Path: <linux-kernel+bounces-178985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B08C5A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E4D1C21539
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B518133B;
	Tue, 14 May 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsCMBE6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2062180A72
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706187; cv=none; b=V/uFLVC1KUpgEvyjRsX7zN2bxBjzmJOW4LtapbSZLeiFFTPbZrMgn3troo3oKi9vL/fS+fUIvtSbYgVVC54t0vl18UnJpW6dQ0grgX33WZwWdIphXhzGtQ+ZqhJW5q7UPv1GZMyUUdrwf7UX2u+N98+XoGfXP6FF7MqqhhWoZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706187; c=relaxed/simple;
	bh=XZ8Q9khtBL8ZL4VJFdAPvZb6DhjdHFjCgKjn8RyMaXU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nIZSDcF2yuiVXT1PwTpJ5HJeycZC/rJWGwXlHms+3hgVudFaTHnGRp7bhhZSdt5fxQwLLmPIt69aNG1dZrowX6Z1L4XdFjySRW8oJChrSya0muJSOXFLu4r9ivTrUW60NYaa8qxDXJxufiJ3/7KzF4QSN4wN6x+brpQAMu4VCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsCMBE6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 942B3C4AF10;
	Tue, 14 May 2024 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706187;
	bh=XZ8Q9khtBL8ZL4VJFdAPvZb6DhjdHFjCgKjn8RyMaXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EsCMBE6cpxNh4Fvrx9j1sOuj9Zb0sxfpb5GPH8/vLxMvWRQHnCYCteFtJK6Jq8O0p
	 3uownThXxnxNTPr6wq1Dzxan74KzoUPVWWuQ7a3ps4m7fzObJ37h31XvbXcY0cDHjL
	 Ttw4bkdq8qNtva8aS3p09hMdnQfcxfxRghnwS6Bevmd8OKIsbxCUF3+Xy62LxokeKG
	 NXjpjfczWpgYTVcqrxZvK2bu+oervw2LZ15DbHTgEcbtdiyI7wvGqVIh/1ZdFebPeg
	 a+U3zDBT7+HliPkT+aIRoeXP34rY1v6zsxCIGJR7qxEkXufVrCjXPwVC1/nr6VSm1k
	 16eyJLQTkQJLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D0C2C43339;
	Tue, 14 May 2024 17:03:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513195935.GAZkJxJwqejWsDqPN3@fat_crate.local>
References: <20240513195935.GAZkJxJwqejWsDqPN3@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513195935.GAZkJxJwqejWsDqPN3@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_sev_for_v6.10_rc1
X-PR-Tracked-Commit-Id: e2f4c8c319abd1afbedb7a31877cb569265db1b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 964bbdfdf01d9b365809726313da967cb1dafb96
Message-Id: <171570618747.7410.11069690216025046856.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:07 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 21:59:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_sev_for_v6.10_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/964bbdfdf01d9b365809726313da967cb1dafb96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

