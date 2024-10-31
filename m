Return-Path: <linux-kernel+bounces-391426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656479B8693
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB921C221FF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB651E47A0;
	Thu, 31 Oct 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLwGor32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0F1E2609;
	Thu, 31 Oct 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415802; cv=none; b=rYfJMp0mfR8hO65Ob8Byk19m5ExbrohzSv7BqPTlH4SdK43/T+m8UsASa287IsQIfMjPPZ4Zegv+JMPdFo8461nNBEJQk7fFfWSYjP7aDMO6wQe2oVlRKuYeKLgKYE4WcCQIgwHtSA6b5OLUwJOX8ZGkv/ZtQDRBhf8KHkEKTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415802; c=relaxed/simple;
	bh=2rUfUBn+uYHR56KeONuS8QIVGQCHI2ASS1aihF/lJWc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kYqn9i5dYdluHBEeElFavleiKwBNJws71ytb5o11SL+RYWD/3fxKU4MSXB1RewM2ordOn/VqD/cmkNc4xO4YCaqSy53mJD2xA/eSkrWDv/9+Nep8k5T7abFIfUbVC+wxAokdZRU750hGff8Urk5eMG+F3cw2MmNuKDdeLJcu7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLwGor32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD5C4CEC3;
	Thu, 31 Oct 2024 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730415802;
	bh=2rUfUBn+uYHR56KeONuS8QIVGQCHI2ASS1aihF/lJWc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hLwGor325ZzCx+y1HvgeWaYyayb6fVNvs9+kNxKgPsNkN8ANg1VUsNCqMPG+8dkQm
	 4a3RETLKK/ipL0Ch7hQKzew4yLdfSa2SpDspq5H4HO3TJekkXRQA4gVMG2UoTThPPi
	 S4qYgJSH+2GJiP17TlA4oxxPTBLTToXCFu8rtfwl9+6bbXP7ZTMGm2leESwH8wQSTp
	 I75BejdD+pkwpckllr7HpYqoM9JkBiaeqyvCr07Mu391m9pOl87N1P/9oa8/WEkHww
	 d4w8Ps1z+6trpJqgjjsdQNacCtXl9/HdiruWLI2I3ufBWqKB5u7HRMmUdqWtiieybv
	 TlYFco6tQNx1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F15380AC02;
	Thu, 31 Oct 2024 23:03:31 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ldy4wr5x.wl-tiwai@suse.de>
References: <87ldy4wr5x.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ldy4wr5x.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc6
X-PR-Tracked-Commit-Id: e49370d769e71456db3fbd982e95bab8c69f73e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15cb732c16edd39ce00ce655710e34cc82bbcf2c
Message-Id: <173041580991.2114557.18322611029599317227.pr-tracker-bot@kernel.org>
Date: Thu, 31 Oct 2024 23:03:29 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Oct 2024 10:35:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15cb732c16edd39ce00ce655710e34cc82bbcf2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

