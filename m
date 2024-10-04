Return-Path: <linux-kernel+bounces-351316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19441990FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A991C22FDD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01C1D90A1;
	Fri,  4 Oct 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omvFkXDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412B1D8A13
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069444; cv=none; b=G/EPNojk855cZYo+MDaWcfo6j1QDw0+FKrRhBQyEOgSYgcrLEEX/AGYxPPpTlqpxl/tZYt5BbLx+5LXGjGEBPrtF4SVXgnmbIortwkKkKlCATO7utEQgK0t2RLggQh0qF8fXDPAbIdFa8eBzegAU1qvdTvmnhNAKb09tcnR+YVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069444; c=relaxed/simple;
	bh=3J6W1sccZ61Wpg6i3FTyZRBP1ouENJqUr+hv/9G0Q40=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SY77jIP5dJ83Cag53AqGyZZQWWbt5WpWCWmDwKi59cnNCyuVk4Um5VFoF3zGJMMRu1yDXUIp9l/01ltH8WtVMMVNHtZ5LWvhZQArHp08rtA4YjIjdnEXTPx5zs3tCazTseW4cadbW1s9DTQacK3JlBMDIL3hZKe4yGPicdJ8j4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omvFkXDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19C1C4CEC6;
	Fri,  4 Oct 2024 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069443;
	bh=3J6W1sccZ61Wpg6i3FTyZRBP1ouENJqUr+hv/9G0Q40=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=omvFkXDvtp8HVt6d9WTZSSk4MHi7nqVUsvRaINGdqIlNB265DuHaeU2/r26TlKTnp
	 /qjDnF2fzPsx5ACqyu4B8Xrspbq/RjfggYyrC5iJs8ZTl88/YnZE8geYgzVIT1XO7v
	 Ecod/0RvzBaqHk20vVDerXRBW3M5zmyuYnP3eFNDgPvaTWVFYBMjWbI4OyMwt2sBxe
	 3AgkFAiJxiVYHEXTKpcwHDGFk++ODZHXxfnMqF6hNS1kjMR3p6bcq7nnojItkXCFda
	 RTJqANaybCSbAURDvCdpnFtV9YOJlryOzZ2JPUQQmqR3oe+lthjZbBZL8n8YFOewLj
	 ynzxO9pD/6Wqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6D339F76FF;
	Fri,  4 Oct 2024 19:17:28 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <f26fdcde-b8fd-4d63-b113-d6d39ab3bf15@suse.cz>
References: <f26fdcde-b8fd-4d63-b113-d6d39ab3bf15@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <f26fdcde-b8fd-4d63-b113-d6d39ab3bf15@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12-rc1
X-PR-Tracked-Commit-Id: cac39b0706f186ce01b9dd1c3802846528d1bbca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6785e0ccfdfc3d87aa8f1287a49cf8cae111d5f
Message-Id: <172806944737.2711222.18442235358249726700.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 19:17:27 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 15:55:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6785e0ccfdfc3d87aa8f1287a49cf8cae111d5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

