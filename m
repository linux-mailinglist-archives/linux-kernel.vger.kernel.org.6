Return-Path: <linux-kernel+bounces-291143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93871955DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DA91F2138C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7F154C19;
	Sun, 18 Aug 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFAR39wd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87B1547DC
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724001813; cv=none; b=XwAeSsA94pOdIpCQqaHMRWIy3E7lTD/hTxFrrojWc8kB2aLaZ8jY9KkcWh9XVkIZOBsZswVas/fwvfDs6mIog+YjEiTUcKfpeCAKPKYhw3QNW6o3kkUThT1X96K5CjZ3wDNIjEobCJCAvqV3hNXjGH2/JZjFQxWuzKFD6B/AIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724001813; c=relaxed/simple;
	bh=WCi1V4G7vLzTclu6qNYIdOFl8UwMOu1Rat5qvFP7fsw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qz3q2nqwokVtcfYD1bItaZrKxVeN5Y7VWP3ca0r7TXvTkW2EGLus1qzttbUgYgTAukV6ly6zf0Sydg5z45RPksZkGB1x3g1OF8DfOjOp7t7LeIv7xbTyaqNahDzTwEm/kKxy8imsCCAj+rOlo1leTO+S+2YdwVN3u9RoE0Dus7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFAR39wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9A6C4AF0C;
	Sun, 18 Aug 2024 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724001812;
	bh=WCi1V4G7vLzTclu6qNYIdOFl8UwMOu1Rat5qvFP7fsw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RFAR39wdHK2WLwRppOeWdUsu6xYwUCzfcY6fCb1PnF5Oby8M6r3OUVEraG4uG62HF
	 fnkfftngSDgGsIwigkZq+cZtct5FdihgfNMjHNy3PWoE8R3ObvVx81DGMkTJWGURvW
	 NoPKM92JEnECySRzXXajGFLK9MqGPjDKQM5TS2eivlrjFLhAWwehKx1QSycT9OtwIr
	 J+fA552W1AQBvpIIXR+cQmjqaqNXS6+53c/khe/8AJ3Wzv2VagEMU6vW/7iSNWyhDJ
	 dFyDdFwugcw+NpWNhZAwtNxxAEb+8MCSAF8KTJQF3yk8CdZCM0snHYpwIGQyxo6nIY
	 vWJ0Lg3ri2yjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DCA38231F8;
	Sun, 18 Aug 2024 17:23:33 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsIVqh8N4QstYXVh@kroah.com>
References: <ZsIVqh8N4QstYXVh@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsIVqh8N4QstYXVh@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc4
X-PR-Tracked-Commit-Id: 2374bf7558de915edc6ec8cb10ec3291dfab9594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1bc113215ab2875ab52fbbd76a54b5583f67e61
Message-Id: <172400181178.3949564.14179506837900675378.pr-tracker-bot@kernel.org>
Date: Sun, 18 Aug 2024 17:23:31 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Aug 2024 17:39:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1bc113215ab2875ab52fbbd76a54b5583f67e61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

