Return-Path: <linux-kernel+bounces-445321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A2C9F1498
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BBE280F55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2F1DFE29;
	Fri, 13 Dec 2024 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYSLMFHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957C18452C;
	Fri, 13 Dec 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112858; cv=none; b=Obmk1E9fK7TQ0mmqS66WQlP9xA6TAYLKRtSF9y/YiQm0f3l3kQYAy5RWRmlKDJ2q/xu0gesUJ0naSYLdnLvR92GAoWS6Woipxrw3ft51xsPecVab+Apu3hxCKlgbxMrosVkhjEwsCmNMPUdD6pADEwKAPjvbNZKgZ8havktXeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112858; c=relaxed/simple;
	bh=n432vGCw+mpXR6B24VngbtiaEmGygxO4G0vPALlZRBk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ldZtsau4PDRMGJZQss1c8TrU251DWIbKKQHHNi1H/To7NLDDf+pdsV2FWuhcgCzJwYg4mkCtMKMrqEWKv7DJrQ1NnoEzFzEArSVwlt4OMU09aCbvamZYq8GC02B2mu1h2U+on9YdfHBEkTS1BzqNk3EdMu3G2630i3Gb6CKkvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYSLMFHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428EC4CED0;
	Fri, 13 Dec 2024 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112858;
	bh=n432vGCw+mpXR6B24VngbtiaEmGygxO4G0vPALlZRBk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qYSLMFHrGMDnJxPKXiEU6VtrwEwM2PdghbhgO4a1qSfPQASkyC8ujIgvcnMAbJyix
	 fdkWH0l5x780DR6aqlE6Pmnl5gLbcBTiApBiHLy1xlx88n4a+pT171DQfptjRMjeZd
	 IaoZCFIq3I6l+UkCgpMKypow2H3OuV+lKcOlYMnmlSCytTjQDQUgRYQbQKzKNZUL3B
	 o+Kwah+kQhCBxXSS/7N26LJNssYb8vUcFODG/p8b4T4QjP0ZbMgN5ihXZQ2+i8qZ7x
	 4QSignDJVsY6/OzXoCi1aWoHSHCQ/ORPTI47BsH+QU2zKY75bT4tFA6j9uUiWXiXhS
	 Ugc57ehaqFEEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34BB4380A959;
	Fri, 13 Dec 2024 18:01:16 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <87pllvyko5.wl-tiwai@suse.de>
References: <87pllvyko5.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pllvyko5.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc3
X-PR-Tracked-Commit-Id: 7b26bc6582b13a52a42a4a9765e8f30d58a81198
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de20dc2b9604f5130f62d19905cbfae7453fae80
Message-Id: <173411287470.3118228.2183933896673848263.pr-tracker-bot@kernel.org>
Date: Fri, 13 Dec 2024 18:01:14 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 10:52:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de20dc2b9604f5130f62d19905cbfae7453fae80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

