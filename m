Return-Path: <linux-kernel+bounces-519997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4DA3A47D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C94D7A4920
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41EB26FDAA;
	Tue, 18 Feb 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8gqtht1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE91246348;
	Tue, 18 Feb 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900506; cv=none; b=m7U69WfJuCNOLgm8tOFK3WUWKZYrkKbFPtO0UeX3QKjQLbZvygxqJUUZZ2jdBsf0WVyXqJ6bcCURPITwip3ATAdbgRvO/+I72MVuyYJGXP9BxHn9jihpiYMXORWHbNhdmKRDsvMtsD+/4JAjotA9EhR6xCzkFFo5NA/r3YJppxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900506; c=relaxed/simple;
	bh=C2z/kdIlboJJr3csVRvaHezYh78r7gHfkrMTfeZM1kw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XsMAqvp1LU3dbj24mUwY0ZxCRHCBpJSkDorn/8qQGDO/TBxEDfkXTmywanQiwckJjqiBkhJVnToNO19bfE0Nn1450hl6TNghkASj0eCn6L7f3w3hxevKOTBwwGXesJOPIzul+uOB3GaMkDx3r/vNU+WfBIg5U24XmI4i1lSqIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8gqtht1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1CC4CEE2;
	Tue, 18 Feb 2025 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900505;
	bh=C2z/kdIlboJJr3csVRvaHezYh78r7gHfkrMTfeZM1kw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h8gqtht1e3FwLRccIOHU71Ty8kY8XLrnoxnTRMQkO5nhRSXgm8tl1zdHU4hlp4jQP
	 PYfyTrT8OeM90VuF4fogtEzAXEp0OVNd2KEZ+8JoJ2q16SDMOOk5RHdkfLZusGfYqk
	 7BbNB2WN3NYQBEpIVUFygaA1m+SyE0LNhTYkym6IMC3Sf9d+5GztHHv/7OJDPmO7ly
	 rN3wgQeSlEO7UsGB16LT1CuPnMRDrCPMVtByKNPWB1V4roT/Ae0oyngqVO9qIqCi6u
	 hpO0KBuKTOr3HhTMiZ5eB49c6butNbl7zHCT80q/3UZwZxoqYeoVqFQxfmFDvpZkFE
	 diJzQbEVKCUDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FD6380AAE9;
	Tue, 18 Feb 2025 17:42:17 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jz9n5w0u.wl-tiwai@suse.de>
References: <87jz9n5w0u.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jz9n5w0u.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc4
X-PR-Tracked-Commit-Id: e77aa4b2eaa7fb31b2a7a50214ecb946b2a8b0f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
Message-Id: <173990053592.4164673.2846170891019501927.pr-tracker-bot@kernel.org>
Date: Tue, 18 Feb 2025 17:42:15 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Feb 2025 12:31:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6537cfb395f352782918d8ee7b7f10ba2cc3cbf2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

