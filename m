Return-Path: <linux-kernel+bounces-180201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC418C6B67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F06E1F24A68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960C15667E;
	Wed, 15 May 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrzUG1Hl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB34879B;
	Wed, 15 May 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793613; cv=none; b=FLFVh2AjfRmEHO5cQ91dnip7BG9qJdFCmY95TGjhVlfKFG6jyTRPP8yp6tyi7Ac/tzX4eJQ1Pb9rcP43J7fdLs147p+nNOiLy1wjLWCWlqg528vaebYHuU+pSY5POeagzZ+dFaCzqTRnu5HuBmd1v52H9tKKLUmMimIB1YXHl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793613; c=relaxed/simple;
	bh=qSxAAg5FxNi6q6X8jJ4oZLVTBPTDvTFixLGW0fYyDd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hNpdTcJNHY+2Jq44vTR5tw8WTlwQns7SlwetX1hOMPJT1YTMgaoE6uC0GdHVSu/zFKlXRMqTVRh+zf1k93d83GjDlU5KDSGFusy38VNGEhLW3cUgPLZSv6cM7B4isO5DGx1LEVShYvvEK92Ptm7GQjt6zjhV7zNQ/Hij5y7IJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrzUG1Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4050AC32789;
	Wed, 15 May 2024 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715793613;
	bh=qSxAAg5FxNi6q6X8jJ4oZLVTBPTDvTFixLGW0fYyDd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VrzUG1HlcDHjzViGJAtGU85vFSMNDD6GCsuyN326Rg6O95WdZ0SlF6umeCfirEWYH
	 WVm6FKO7DhmKIj+nYA77Y/EYY/4yIdihNCIB2glCSw+PspNBTUHX8ZXxqdbpIzYLZ8
	 eNiR3sV/LVjND5wO2VUhGe4+6l6g72YscyKIsIgDwuobur71eW8I9ipQ597ExEsW3E
	 W3GSSCgCCkOvWOKh0e8WxgOp1bekpp90hu1X9C4li5KjT9oM+xL8N1yxmpcdV2c9q7
	 GcgaUstoZM3P2enEcVe4I8TKXtANcXmhQ8xoRtgMk66bsKfTOMpN8un4EIJJW+pK0O
	 4FcZUbIdC1AwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 381CCC433A2;
	Wed, 15 May 2024 17:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfsr5v2b.wl-tiwai@suse.de>
References: <87zfsr5v2b.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zfsr5v2b.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc1
X-PR-Tracked-Commit-Id: d731b1ed15052580b7b2f40559021012d280f1d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33e02dc69afbd8f1b85a51d74d72f139ba4ca623
Message-Id: <171579361322.17791.6917769790291650473.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 17:20:13 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 10:38:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33e02dc69afbd8f1b85a51d74d72f139ba4ca623

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

