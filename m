Return-Path: <linux-kernel+bounces-416328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE59D4355
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DAC1F2181E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908E1C7B8D;
	Wed, 20 Nov 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZQf8Bm4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405C156872
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136435; cv=none; b=ZOFaLq2KH1VPeNybk/VG4N2Y60Ka3YkCGos+CwhR4q99TYSNs7JwLnCb92aMO99xKI1gPArmif2NE04Npl0z7QAa1w3rSls0lYb1xtKIUpvtWkCEb88HFO+6ZLzTamqiwQKrFzJ18GnDEZmzI4sj25pzok/vF7MP5BNDi6+JoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136435; c=relaxed/simple;
	bh=Xcp8hR0TvzLB7Vd+Xg8zH61dAhtydXvxCoHg4fwPZD4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JYKlb/bEadwLCdJ8bA6L3wx+08+BTusnZhVgpV+d+Q+bBAFSWJQkk7PysMRV7Pmxbk8ulKL4We/GBmfCbClV5mna6d2AoOdMgzhvy8b/esaYVpcz/8UaXL/9H/ZEgVrqW4erTjy3p7ammdL/zVD2tUENKmuXKwNaxUkIvEAFXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZQf8Bm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1090C4CED3;
	Wed, 20 Nov 2024 21:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732136434;
	bh=Xcp8hR0TvzLB7Vd+Xg8zH61dAhtydXvxCoHg4fwPZD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cZQf8Bm4P3trmV69vmhO7ysYYyUUktDGyFXZf3gbPEFtwzsALu5ArJu4JySnR0xq1
	 UCTSJAbO/aS/2KN4tZOT1/PFrWyGMT7C2l49IxE4po1/6mWgZT1dB04+qhT4mn4qeT
	 6s0c0aU2hgPWo3J7KZnQY84vUiHhBD0dv+S0fYq0Eu/d3nhOzgzurPOjlbdnoEBxqy
	 +jiRObBqalLT1Wt2gPKBaMM5z047H6YCRFdqpQGYHn3+ci99Js+ArnWOi+ABcULvA6
	 kdypJuv/QelBjHYJOsepT1hsohA/8iHWvMQ81R5Vt5ZXrmtLmq2PlCfSSH4WZhpMgo
	 zu9U5RN/pmVZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EDC583809A80;
	Wed, 20 Nov 2024 21:00:46 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for 6.13-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZytWhTAeAIrzEyb9@black.fi.intel.com>
References: <ZytWhTAeAIrzEyb9@black.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZytWhTAeAIrzEyb9@black.fi.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.13-1
X-PR-Tracked-Commit-Id: 0b028ff7e70ecbe5240ad92e36a664af5cf7f382
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80db457e8d28d24ca7e19fbd2d5050f7298803d6
Message-Id: <173213644560.1349927.6497928532645585880.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 21:00:45 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Nov 2024 13:44:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80db457e8d28d24ca7e19fbd2d5050f7298803d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

