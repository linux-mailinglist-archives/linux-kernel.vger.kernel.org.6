Return-Path: <linux-kernel+bounces-169117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2D8BC34D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742B1281C42
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14B6F085;
	Sun,  5 May 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXjY70iO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EB6EB46
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714938237; cv=none; b=I2PRgIKl3pyOjswUaHozWcMNgRmkwymumda7odqHVnfmG6P6zZbRE7oBxydeER1KWMFxWimvzYUVe03EIMh5M+IYClJmIVSr8sffbPLSX2F0dfFPsJy1YuFz3ck8TSVxBNoX3GIoEXxj2uXwLMNGWr5wSPjBYB4fY73u/JHhGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714938237; c=relaxed/simple;
	bh=lfkAW0VDrS9BxeQbv07X0ekTExkeKvxOC1kQXpp8fAc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HMqCTwMOyK/cUpuS0Zss2LSkpczNgSyj8mHg57sNhvz8b0E3lv9+ixUyJKV+Hh177189I7De4gARRuUhDAnuJDduCAig9GVpxaNyge0+brh+ZrhRb5eWTjVnt/ZcLfr9p8BZxA74MZ+snemqrO1GaoHn21p/mlg39Uop1hO3lDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXjY70iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE92DC4AF66;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714938236;
	bh=lfkAW0VDrS9BxeQbv07X0ekTExkeKvxOC1kQXpp8fAc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qXjY70iOd//jbJoqZ7EzZwoBYUan7MUiBvVLPUUOO4jdigW+LX0fy8p4u7PnqFOxz
	 rFweaokJkDD+38To7KyF6g6Emxkp/buzUW8WO/PvMiUUOagt2JkqbV++LeGq30lksW
	 QdqrdiaRSJMTk09x9Ccb1NsHozqaMHkVLokps0iL64o+ojKeiz9v/jvFIu+x89V86H
	 U7s4hJQCuXKzHFSpq01mGX0QkVFaPEg6/YDNKIVSwHjRVNTutpK6QYBFwe1s/yrCwl
	 0gPMDOIisvvY2P/psE51Kpu+b3pr2oGDIhwTbpSf/+aA+yt8D6Rlq1LO9Vj5fGHYdf
	 w3SRrUTFAV8aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF775C43444;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjdMFHuNHvUrncEv@gmail.com>
References: <ZjdMFHuNHvUrncEv@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjdMFHuNHvUrncEv@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-05-05
X-PR-Tracked-Commit-Id: 1dd1eff161bd55968d3d46bc36def62d71fb4785
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80f8b450bfc12b1087ca67c84071d3524bedc080
Message-Id: <171493823684.6787.9032166371783880927.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 19:43:56 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 May 2024 11:06:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-05-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80f8b450bfc12b1087ca67c84071d3524bedc080

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

