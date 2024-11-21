Return-Path: <linux-kernel+bounces-417585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E349D5642
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E6B23AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832681DE2D3;
	Thu, 21 Nov 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWaz3sWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C01D3564
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732232413; cv=none; b=eZe1i3CqbDML1b8HdynvuT+CmYt/uvZQy+Nh4oNwHt7lz0LkX8eExGW/WBhHHHvOS98Eb4ZDclQPPigsl1UNUU4eOt3rGjYkEU8WR1MclTkjF+hlmrd6QvjrE7/UWuooGXH4YaKfZ6SQHb9cjl4LhkKlsgND477xgyOLyXjca0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732232413; c=relaxed/simple;
	bh=OEI1zGoC5H5yrTBGrw3wlLOg/qNXlU2yPu+78SxDS20=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OEzL4/Yhe5nBGDQKfLlRZWf6wwd+vSCc5QyCiJUU+L9myW2ckWFjrcqMfl2/TT1ltcB8meKnrwDyghMuAGRFscfobJR2LWqCYIDypmBy7P62FcVeOSukmh0ZZ0flHNqtiBu6jEPYUFSS1quHtVrHV2OoQBCimv2lHF2WWRIS5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWaz3sWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB2C4CECC;
	Thu, 21 Nov 2024 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732232413;
	bh=OEI1zGoC5H5yrTBGrw3wlLOg/qNXlU2yPu+78SxDS20=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PWaz3sWPZ8xqrlss4Bz/o7MimK5PueTD3VrFbhqd6TJI5yY1dNRHvll4+4tu4Fri4
	 RRqBXQlQJKC7FantAeUp2VzGq0wwX5Xnk/P9giYRuzXWiVew7xW1VNcglJQCCWXwlc
	 befJKGZww6zQpMeDqPCuNPmvb7lhtccD+wA1ivpsLTrZJGIS4FmgvlvVnSZ9LYa3On
	 QRzk2TmOo9vt8DqyJ2qs9rN5BlXXDjMKZQ7ieKdknFxLSHRvXFZTXTvIG+XeLLtlpN
	 Xv6kc6pWhYjzjn4uym4fWiFaDpiq1hk3csTCU4bmJPUKtPMc/217dvtn0WDKsPdO7c
	 x5jj1rReLNY3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3E33809A01;
	Thu, 21 Nov 2024 23:40:26 +0000 (UTC)
Subject: Re: [git pull] drm for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
References: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-11-21
X-PR-Tracked-Commit-Id: a163b895077861598be48c1cf7f4a88413c28b22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28eb75e178d389d325f1666e422bc13bbbb9804c
Message-Id: <173223242577.2158732.9039191642689505816.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 23:40:25 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 10:25:45 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-11-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28eb75e178d389d325f1666e422bc13bbbb9804c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

