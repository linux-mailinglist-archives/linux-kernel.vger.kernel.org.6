Return-Path: <linux-kernel+bounces-422976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0A9DA0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4C428358C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066EB6A8D2;
	Wed, 27 Nov 2024 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKhvJ40O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6544E208C4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732675275; cv=none; b=YYzFwFSo7ADeVuV90KZvkdqowW0ZjXXz9fxffVoVNkQQpxizG5SZNbzX4aHfI5b9x3qmXPuX6BHoDXmXijP7MRgWavlsnma7ixnMK4sURgIRpyKneYo5/vgMZEfbVkU7l2XvGPTrHXRTg3j/u+iCjRyKHVCow+Uat75FQvxB5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732675275; c=relaxed/simple;
	bh=sGDXrdkKsA4QYkMI9B33r7r5wmx1Iolb1chqpojlP3A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K0clb8/SO9eTaGgqSwrP+HiQMpSz0dFeJznQ+EJjt9ICvfHcHh8b77gvdPiaGQqQGVSdwUewRroNftvFKkHesD3hWDvCJOWdayJoT/gGSqh7uptVHkGDV9cmdPHY5CJU4VXOdpcEJFJf/W6OP4K8QukP0HH084pZQwL2UlvqK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKhvJ40O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094E5C4CECF;
	Wed, 27 Nov 2024 02:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732675275;
	bh=sGDXrdkKsA4QYkMI9B33r7r5wmx1Iolb1chqpojlP3A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XKhvJ40Ok6UlYkENIOM/t950s/uceSUR7qoRXzyUpDWtLTDnZ+gPYeZLp3RLO0U9O
	 xCYZF/LtH7/XZlWKP5POcBoe9QzO5/McyYLohQy4lvMD9774Y3Yi5Ox/UJ9LxlXLvw
	 c3TERN+pNE1hT5V4iQWuhHjiwa23tlggC8Bbc5fZ13VvZwTSTXNW/DmBKVyAy6dZTc
	 X14B5bUAELtgpUheIiG0ncHLH+Z3YyRxEPpbQx/rFrTin857x85M0lcZUqDxx6liBJ
	 DYk2Ds4t2UpDd/K8/DP9wNnCjLMqZZoUFMuBXR/IrLTaCDpJyydYVIJWqwnr++lmbm
	 ug41Cnqcmo9Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ED93809A00;
	Wed, 27 Nov 2024 02:41:29 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241125222007aae382d8@mail.local>
References: <20241125222007aae382d8@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <20241125222007aae382d8@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.13
X-PR-Tracked-Commit-Id: 6cf7b65f7029914dc0cd7db86fac9ee5159008c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750909d55a9dd555e28148739d3e8ef17a0b8ee5
Message-Id: <173267528778.617991.13066537461235051032.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 02:41:27 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 23:20:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750909d55a9dd555e28148739d3e8ef17a0b8ee5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

