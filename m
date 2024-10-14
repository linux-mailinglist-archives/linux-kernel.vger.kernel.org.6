Return-Path: <linux-kernel+bounces-364636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F76C99D742
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24209284107
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6A1CDA08;
	Mon, 14 Oct 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSN1BIuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCF1CCB23
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933780; cv=none; b=DFCPKkSa1fO8iNeyozy5JXA1MhKvyU97LlX13OXTgCpNy18p4thw4fn4HfZ1VKRWhiHRkXvWAKXoiF3X8WI6DmGeQSN/KgSR1hijljoiwQIdPMWUBl1L7/37g7xAEl5O2S6b8gO0CP7DIzW0YfNo8yMDDQf/VUODQcpeT08Emug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933780; c=relaxed/simple;
	bh=giUBMqMhM85p1VFJtS/IemvmIo6qlEbJRvocNKG4rfI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oO68/9mP5rrt7Mvx01lBbcvgIgBNaW81EyG0++Xh8i+NiehjfBA9NMn5LlI5xLJttBGANgre0M4hcqXxJHfsrAAmdDr3glKttJJT7wGLCiarCU9TROOh3o5cmfJQA63norRmFzp/tML3gQt+5bwP0VmYcJmhgkdGjqBM3xhUP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSN1BIuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF26BC4CEC3;
	Mon, 14 Oct 2024 19:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933779;
	bh=giUBMqMhM85p1VFJtS/IemvmIo6qlEbJRvocNKG4rfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tSN1BIuKZAkZA5H1YVMqw+tZi1Qvft6dkpwjj9HArLxJfOJb1TfMPn5q5xIW99UA3
	 YzyXNHtmYCOoJU0SoVKZKwAjxqnM41TmpmS5JR59NkZtGhGuvSqVX8i8oeUf3+IW2g
	 vmy4MLzwfZ9rrXBo4NW63lY4TgtQQdCkNTIXAAAxmB3wOa6p6xErjY2fMVq/ADeF0K
	 iKAY5LzyL9wObzYH342XRNZDsci5veWVFZABpsSQxeUqqvrJAf3Xn/hCyWvkCEzfxR
	 JJr6M0/v4UeshApCcaKGhZi6dQ/00AeJqiiB0IThwcqYHZu+sVITLZbspTMEpMpM7Y
	 +XKBuoMq4I78g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAD3822E4C;
	Mon, 14 Oct 2024 19:23:06 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zw1MHWwr3fRgJpLr@google.com>
References: <Zw1MHWwr3fRgJpLr@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <Zw1MHWwr3fRgJpLr@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-6.12-rc4
X-PR-Tracked-Commit-Id: 332fade75d0ecd88cd19556fce0f9cc8322de434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eca631b8fe808748d7585059c4307005ca5c5820
Message-Id: <172893378472.615880.2394948685073284795.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 19:23:04 +0000
To: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 14 Oct 2024 16:51:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eca631b8fe808748d7585059c4307005ca5c5820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

