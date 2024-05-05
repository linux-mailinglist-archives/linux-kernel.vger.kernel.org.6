Return-Path: <linux-kernel+bounces-169075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570C8BC2BC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B784B1F21181
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973966EB40;
	Sun,  5 May 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD1g322X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B556CDCA
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714929180; cv=none; b=lIF88epkdblFEsm2VD7iu+H5fDRI99uWzlfah9Ah4HPWuBH2DXMswm2Hjqj2fgdrgnLQQ1ea1MOQxRidhaRXcXK+yw1rgEFoi7/zEEiAARTAFDeuGwvAMH4q6nxkV5KVrQEMeBs+exGn85SN8/jhhI3AW9hbZvqwUjElV2IHldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714929180; c=relaxed/simple;
	bh=821xWeVPcbUpyphv+upxJ6iZRhImGsgNhOxE4x9Dg20=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uSwUrpJq5spPdRMtEDo7gjAx24B6Cj/kOMUv1X7z83Kh4hPcO4DzVeyWZ33R6RGRJcDiKo5pIavq8GuEcB3qu6Eb0dwqyOAsWP6jFhUYvfEGuOOqubsd5DjlNkSuizdd+ZLj8/mrmGyfpkD70REvN/4ckm/6YY19P3KE1FvFQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD1g322X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B361FC4AF66;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714929180;
	bh=821xWeVPcbUpyphv+upxJ6iZRhImGsgNhOxE4x9Dg20=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YD1g322XthBJZ3pSjS40E1hxr+Mv1RajOnWzO60owDCJ+RjQA29S1uqN0b6XpX9S4
	 S5VgQ53qhaEbQBSqHfJzTIuP39mSF71NfXmAi9YCTHWt/FkGrvSX6b/5p4XgbkJ+5u
	 qJ4843qyggzHjVIABlz2QmwW6FCWsyrxfOtHPtzRNlO58aEylkgv4KmzlkqSiwqfQN
	 JvztCVV6h7MFbbFYDWRfZt3PGbLWyOboNnWqYve5TmT4mgqtRqbEgAI50itJVh3xVX
	 XbCl7jXahnlnhJjxVae2hE691bGJ+fcRZwaFKq122SQ/zLeSxZJ5ehDib3jQW4+xWF
	 BJDYUogY+Zq3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6F66C43444;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240504221917.4917a9eac7ab8cc90a0af5a1@kernel.org>
References: <20240504221917.4917a9eac7ab8cc90a0af5a1@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240504221917.4917a9eac7ab8cc90a0af5a1@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.9-rc6
X-PR-Tracked-Commit-Id: dce3696271af7765f04428ec31b1b87dc7d016c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c17a1cd90a5d385a7138c030e815e3effc45677
Message-Id: <171492918067.31500.9821332375965510322.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 17:13:00 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LuMingYin <lumingyindetect@126.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 May 2024 22:19:17 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c17a1cd90a5d385a7138c030e815e3effc45677

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

