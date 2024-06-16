Return-Path: <linux-kernel+bounces-216423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD51C909F28
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46309282BE5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EA61FF8;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGYSye5z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD905339B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562273; cv=none; b=rPcSJ/Mb+2zTlSv26oM/IuX+K6gIcVij2ppdWIm9aVgRq/tv3sexEZczlmtfiDshkMt2oq6hu+UWqFcJ4+oMaxLVgTK4QZURPkjn/D/2meoLmewMLOeLKLksSYnxBDgJ51bLLZzj+fMmBVXfye+l/Y87yLJzvUXzrfJKkyB3t60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562273; c=relaxed/simple;
	bh=0virJS/UkMx9u9W4yJtku+949G0YUsKBA2fYrlgymNE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IgBJcKbmY/AQbI6FotjwLYEuyVzqdNa9hMDRFdcLlB292PPO/pGoJW4TXtq8CztP8cOBG+L6sFcLxdDfMjXJ33isHnvGVB5Wz3awM/4zZRbGV7lBOIfJZfO+XRA49GsR1JIFQxWNxLTeTYhNQGPrl0Euf+gONev+1m6ErVt1eao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGYSye5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF46C4AF1D;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562272;
	bh=0virJS/UkMx9u9W4yJtku+949G0YUsKBA2fYrlgymNE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SGYSye5zwl73ifGmFx9MUL2Tyd56Ychew+4uRJIDVTz4rPm8faLbSVZjXdTe76uSR
	 OMWuf1szyxmsCaKDUT7RDp8Z3Hq2DNUWWuKB5iqlz1eJ7C3R8mBGYWBKKUzon3CFGq
	 4Dx8/Q/gm9jRhPzdfBqvdwInzI1Tk90vlPEO+xl6AK3QWLdCuDR58JEOYsRC4hEzb4
	 g9dXk6zRcQoPQXzJdKch1azeY7ZDZgs6nbAwCNAf5mDVgFt4UB8554J8RB40Zk1YXD
	 D8dXtSIRg87nN6nNluNC6Npo/DQhf+nhVpDExIdtzoJggJSN0Re3CuJorXEjBUzoFw
	 RtXVg6JIDDGyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C07ABC43612;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm7DgsGWt90hFznF@kroah.com>
References: <Zm7DgsGWt90hFznF@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm7DgsGWt90hFznF@kroah.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc4
X-PR-Tracked-Commit-Id: 7da9dfdd5a3dbfd3d2450d9c6a3d1d699d625c43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33f855cbb7fae085273083f44ecde6e8e96dc7d2
Message-Id: <171856227278.1143.15719227857488105957.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 18:24:32 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 12:50:42 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33f855cbb7fae085273083f44ecde6e8e96dc7d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

