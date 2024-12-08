Return-Path: <linux-kernel+bounces-436561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED09E8799
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3981E1649FD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F4192D95;
	Sun,  8 Dec 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWHi4w+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61F194091
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733688111; cv=none; b=fGGLlxBZpMpQspYILRaTwfmY2yWEOrO4DR0Ii1vVJmq/JNK9aKoaXauZFzFraVcJ7P/BFyH9oudJfM5G7fkgOhoGwXymGLenC3bVXjvv2IBwCvI7SsvurFSQN57PR/FHD+6VUh9W7E/CSpaknYgDWLbSNViq8/ekhL8V5LpZw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733688111; c=relaxed/simple;
	bh=JnjDqIS9zujo4Z3O+ngC+lmBThACvtq9dDeGzBtLYy0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D1C5Kcsq25DrK6c4id0VkUZlFtI0QLVY+eAapSnNwUYUDzTRj/elpoS2xbWz9Xo9wZYz8dStdly5F1C8dlfGwS0PE4N2mzuO7ZINSt3/sRR0onh4EauHUYLOLgbAzFt877UmDIgyULhYV4FObC3jwWIIFAY8r5VoRpLHQuQD5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWHi4w+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B82C4CEDD;
	Sun,  8 Dec 2024 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733688111;
	bh=JnjDqIS9zujo4Z3O+ngC+lmBThACvtq9dDeGzBtLYy0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mWHi4w+cEbi//APQwoTH+szoVH7tXpEqvBc+s+ndIDnufM+wXA51f0kjDkPmX+9hT
	 puAwU6dj8eHdgPJe9RoQ+TBIhjiOfpmrnxAdz/N29qV8U1dsMdfk7ZF8L36Jqsxp6F
	 adi2RrVwsHleW/3q66+EcPhHTIqt2HZxwytWk0IwL5eg92q+sAHlZajJ5fSVQ5rR1G
	 Ah7oaTVOvJXHo9EBO2esRz+5Up3X8gbohB4ECVjQqXCwBzsNy1Ha6aFvbUJNe5PjPP
	 7OicqQdiQiweh0qaXgrMqVPTBGtjkN7byYUTTK6dVuASdaG/JFOIjJZF1qOjQl0Xqa
	 JFr/wb5y7jL6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD4380A95D;
	Sun,  8 Dec 2024 20:02:08 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241208100652.GAZ1VvvJZA_sViqSL0@fat_crate.local>
References: <20241208100652.GAZ1VvvJZA_sViqSL0@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241208100652.GAZ1VvvJZA_sViqSL0@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.13_rc2
X-PR-Tracked-Commit-Id: 76031d9536a076bf023bedbdb1b4317fc801dd67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c25ca0c2e42c77e0241411d374d44c41e253b3f5
Message-Id: <173368812667.3330660.15764434682312424695.pr-tracker-bot@kernel.org>
Date: Sun, 08 Dec 2024 20:02:06 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Dec 2024 11:06:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.13_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c25ca0c2e42c77e0241411d374d44c41e253b3f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

