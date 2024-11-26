Return-Path: <linux-kernel+bounces-422821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6D9D9EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4A42844C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B71DF253;
	Tue, 26 Nov 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6bFpvBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C817C219;
	Tue, 26 Nov 2024 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655056; cv=none; b=iduDG0FUoZnJm3nAj6Qbw4SYvoqTx19E3nAZnO7xpdLYJKQ043fCM7D16JCfKPwJtrHxvtgbjRTEcpovMCZuwQOyCr6LwO3KkKdsa9+5MNMuuSAGJRHQSzhiNUXSL7hsujsyuk1wu1SZ3bd8RPCAm5Ek6j0AB76eOXJsleFGMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655056; c=relaxed/simple;
	bh=rSQ3XEbR1a1eGjdhWTe/Wr+JiqnLiObYGRzJCmGyEfo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZPF80EBB0vsvUAb+GSTy97ocFb6NZMhlea6nFipEBC0L9rSsT/jrOZ2oPbsTLghnfThYgRSjnQ18yOZSz5clSEt7Bgt85lCXGlVH4z12yn6UVxEZjfYXAg0+ZULljzBnSgobF0Fb5ZrNTKMDUul0BFjDQuTrfvrqNCOi8f2l8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6bFpvBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C867CC4CECF;
	Tue, 26 Nov 2024 21:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732655055;
	bh=rSQ3XEbR1a1eGjdhWTe/Wr+JiqnLiObYGRzJCmGyEfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a6bFpvBdeMNEAdw+JOSh24hXkzsK82wzUzTlpOusWwsdezSlioO1+hTtFoH1RUiw8
	 qIzZxuu3ljyoLelejUSDg11MDhE4H8hafLwB+jeVjkc9Xa30PSYj1kTUcP7zVJxaGu
	 2ijqcgSKUiLJWVxBZzno/RAPPtqvaZ290M4ksrSIBqeYBlxyBJSnIoasH+P+Awm5QP
	 exAULxACy2FdFnO6W4LdvzLJRSVJNJYtlfzsjw58jPHh2Qdt8eA56elPKCya7dkwQz
	 2UMOIyqlq7fmUIfJ/FkQCHX45Z7OM1p4CMPmmQu0Kv5WcbLcNN81zRw8LHXI/vvDTT
	 XEmHTwgRgoweQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB74E3809A00;
	Tue, 26 Nov 2024 21:04:29 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241125102057.1505150-1-agruenba@redhat.com>
References: <20241125102057.1505150-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20241125102057.1505150-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.13
X-PR-Tracked-Commit-Id: ffd1cf0443a208b80e40100ed02892d2ec74c7e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff2a7a064a69069554564f52b6a84fc8a8c7d688
Message-Id: <173265506847.539328.1286045712414734548.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:04:28 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 11:20:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff2a7a064a69069554564f52b6a84fc8a8c7d688

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

