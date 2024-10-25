Return-Path: <linux-kernel+bounces-382360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FF59B0CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60DCB24B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B61F754F;
	Fri, 25 Oct 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smwdrrLi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E513B5AE;
	Fri, 25 Oct 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879819; cv=none; b=ZrDk96QaEoii75GZug3LjM8J1Nxk4qx1WN3s0o/ty8joYLqPEWOv+1ss4B/imCeNdkBD97/ll5B8ndpq3Tc/SbpXXPo/HhOXBz0HSxd5Jvo6IRl8yU20RFEgHb0zVRWA3ZLO1PA2Kxlqwj+K964x629ljdruaDIeFmjci9ixkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879819; c=relaxed/simple;
	bh=X/uGfnrNnL2XMfqf1OtYUTygv3WCpXEMvLl2FY2gR2k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fx+wSclcqu8IWaad2NG2r+x7Vxico6sadAQIMEFojFjuQwFYZf7tJARlzd+sogl6oee7kXx1fbpl+AcV+m/V10sREyvnqIuzC0WOLEyZzBCpGv2TnPyrmSmDpBAujJw2r/uX5X8k2WLhiq7QGzDEkrwc9WDvZ5ciyVVtexMaKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smwdrrLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ED7C4CEC3;
	Fri, 25 Oct 2024 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729879817;
	bh=X/uGfnrNnL2XMfqf1OtYUTygv3WCpXEMvLl2FY2gR2k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=smwdrrLiINkUV2/0PWYuoHgI0w2liwQtESWvee47ghc1RUX6sr8i4eR2XM30iX+Kx
	 z1kiIUI8Dqg34J6vxJ6OVb1VfDqB+KAUCxLtf7w2YyIa0of9wtlTyZJnNjpWRwqxEl
	 z30lRAgr6a9l3sFhbZaX0Dwa5vYC1wSfKL97snv0Rz0fM86ZTXP4v9gR25xJiaGxKV
	 yVdB9AmZvwPyLR5YpJkUmp3M4UVgGIcNJ9Of4SwN8MbU9RBXSbQ1xZCZvl4l6OTT1W
	 bLT/yhRNMB4msaXRjZYXv1cjUpIsYfaUZjnpJH8zHHV59e8OWW0kWt9+QF4zMJ9EhJ
	 meV8dPEvdoLbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 770E73809A8A;
	Fri, 25 Oct 2024 18:10:25 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <87bjz8tvu6.wl-tiwai@suse.de>
References: <87bjz8tvu6.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bjz8tvu6.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc5
X-PR-Tracked-Commit-Id: c9f7a144e7e3effd49303bfc58c07cc10ab2d573
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01154cc30e343952d7ab1c6b35c3577725dc5d54
Message-Id: <172987982431.2993589.15270874639840457240.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 18:10:24 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 10:45:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01154cc30e343952d7ab1c6b35c3577725dc5d54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

