Return-Path: <linux-kernel+bounces-372217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F39A45C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC3CB22D92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019C2205E34;
	Fri, 18 Oct 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ5nihnD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E7205ADC;
	Fri, 18 Oct 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275730; cv=none; b=jzvvUrxMTS5p4waIGGyvPrEOpS5QLwffKnjVN11cxdrDa1s5/dmCD0YZk6K9bjKGjGjpgMF50hRLhdKiT+PacK/o/fOemNvvoSbH/MoApWBH4Yk2AyN4cccEZkFmatyFklVrJMW3+BbC3Jb/SSgb1huqoT8mXrcJQF4TNkOwLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275730; c=relaxed/simple;
	bh=OCOVdu7IkkF5oFfnrzsgleln9v1MF8uKuXEpphFMpxE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aJqdWp791rW7VY7PxOh2ABxxxyXgZj8HwY/1vXm/JdadY/ziP0kWHzkC9bvP1w9XR+881TPkFhc3Nx6N06uMFnTwHadM0zbU6njX5C12gUHG3E1tJWclzhAoB1emKz9qKI/KkmoS2YsrZVArKStOm19rjpOBZRW/YaLFVj2IR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ5nihnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23232C4CED1;
	Fri, 18 Oct 2024 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729275730;
	bh=OCOVdu7IkkF5oFfnrzsgleln9v1MF8uKuXEpphFMpxE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BQ5nihnDFPWitXLI8iqx6k5QIDeFYxU1AihGAg4uldXfk1QaqjbEmD2lZvr6/GPbi
	 CxLNttvLIU2XuwvPaH52nPkN1HrPR0ZDj5aGFasPL6HwBFHecQs0we4O2b3uC+v1Qe
	 ntq0TDtUhoz3H2BVTHJhaGtTdDJ8BKvZx/xf6qBtGBm9mYCTH952LRttK0hBQDCk0U
	 LGgLT4tUzszA10kFHnZHSuuzAKQwpNRZr2OT41xJmUUbIccZLiGPozR1c7hOIwZUST
	 8SFdaSAD54w5+22lFWf7c23y+MtOd8QuUzgMnvXRE4lh0Eho00SqDgSed478fKEInO
	 XMfyDPjr/U79g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD473805CC0;
	Fri, 18 Oct 2024 18:22:16 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241018150531.122425-1-linux@roeck-us.net>
References: <20241018150531.122425-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241018150531.122425-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12-rc4
X-PR-Tracked-Commit-Id: eabb03810194b75417b09cff8a526d26939736ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b3a0ef6ae54948d71e93f94e3deee81f9a8b971
Message-Id: <172927573559.3196569.4372969529929526825.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 18:22:15 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 08:05:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b3a0ef6ae54948d71e93f94e3deee81f9a8b971

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

