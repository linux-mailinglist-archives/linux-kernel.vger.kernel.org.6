Return-Path: <linux-kernel+bounces-562148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B581A61D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6F4883E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0081C6FE8;
	Fri, 14 Mar 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKhJfZG8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491619883C;
	Fri, 14 Mar 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986210; cv=none; b=YAo75hMt4Rvyk69UnQfuxSfxrZkFqAW7d/a51f6mvMwbmHeGV7XCS7QMGFufU1B42hgzftv/tnyaAWsnTL3ltsqVgNk2zDgB6vbe6cz8/H/Kj4s+nICPEMwZurPCe/WR92uTjhm7+De6sJbh1SyPvCypmVyL6l9tCjGQJ5AaMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986210; c=relaxed/simple;
	bh=nj/t+gJCLAEsHwBXChnTzx8UzU1uWvfbymY8QKB1bV4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ruWqwqBzPeW+dPBc7QTWu9iFPfVYWH1qmAjbiB2QJ9qXx3x6P8ZOX85og662YgnWgcc1QcGPeJf1UVGdBcmPgsii/7fgXtrtvY9nfmg9lZrVfdv2/ao8Txa4kIbrYUyx7YuoyXC9mvP78sHEoAAotF95thCUxgltfsPun5orr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKhJfZG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6265AC4CEE3;
	Fri, 14 Mar 2025 21:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741986210;
	bh=nj/t+gJCLAEsHwBXChnTzx8UzU1uWvfbymY8QKB1bV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vKhJfZG8kzj65TjbKhqNxTKRmKIk/sAF0mkOJ9gAATSoikJZTauF4A5oi2W0WyrTL
	 kWiMw1N+hb+fvXly4Tp7UdBFb+EIRCrYEnvZNkPgmoNBN3hA8OpfjjZHYlZRGuvoq5
	 ofaoTV2UmNaaAkHvrBoXWAKT5mriTKy+45F7zgAcKH6PH59rSPHVXdtW6emtVnwizS
	 20/fFYDD4kqkOSY2MabbU9KqverjDuTy6M+0MGM4+ZkR9PZyeIo/2r0ahI5pgPNYkL
	 aVHiQKi/HdSvfoo2Gs/WtrSczGzz1mfceiPi3bFD2IGju40W9BuWFFzYt6aNzCKY6t
	 Uswzi8ANDpKjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F86380CEE2;
	Fri, 14 Mar 2025 21:04:06 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfho7x4u.wl-tiwai@suse.de>
References: <87zfho7x4u.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zfho7x4u.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc7
X-PR-Tracked-Commit-Id: de69d56daac6d9b98fa384184078751db1288144
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1144bc7cbb91f688a216fdf02ae25050b839c4a
Message-Id: <174198624513.2382486.16376891881447933072.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 21:04:05 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 10:57:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1144bc7cbb91f688a216fdf02ae25050b839c4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

