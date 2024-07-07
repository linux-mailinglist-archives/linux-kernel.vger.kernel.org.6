Return-Path: <linux-kernel+bounces-243697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484B5929955
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C65B20C88
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D656D1B4;
	Sun,  7 Jul 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7+Z35fM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CE59164;
	Sun,  7 Jul 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720377261; cv=none; b=KOSSmFzjRDvUdCluyOnK+nAAwe0AQFs+m2gnnBZytlDsgJdCgY35ZwhQA79inE/JNpC4JPZZGZ2ipQkHbG5HkORe04fcH2WvcOjkwmClDjiQYZh8oCIz1VjtdWzQvjLPxTsDBp5ypvePSjEEFdpF5eMR1xGvkQXAYwTRyKGJDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720377261; c=relaxed/simple;
	bh=JTSa5mFBL+BMfTzTfJo1lGxlWb/zd28qrg6k03GtIaw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=byqHHDBNMPC01bvt+Z8z7HiyxsrTzZs3CMPef7nF4SukFpLP2+QOdu6mD9g9gZArcjZVAz1cJP+y3z60DoBwSCUdAjmbd5nX5ojCCUJBCbdLJ7plVxyu2c+mkNOcry1Fm91DibKE8kwY3Gfd6iN6XzM1oAfOYphJMAqGU1DKkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7+Z35fM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88841C3277B;
	Sun,  7 Jul 2024 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720377261;
	bh=JTSa5mFBL+BMfTzTfJo1lGxlWb/zd28qrg6k03GtIaw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y7+Z35fMxlI8LWx9CHXVO4pACafXEK+8oNpcHMRPL7+Gy9iZv5UoUqwoXX+XkRzP6
	 DNRaxMIr6ths+PxPaxY62idnh7PzRZC+0s7ztThB6JYJ1DyMpiamHpeBRNss6iQxlB
	 vJ4MtbwNVXo54/Z21mjkf5K2Ta09kS0xpucISt7xySuDcIdJ//cy/QvpJHHO/2nu0/
	 fQkOaNjzWTZhKmVjcypUE8gnybljSu4m4nbVsKq4giygPDY7zljcc1D6cqH4TPsnop
	 Padx1JdRikMu30qkVjykslphtJHsZybyutOI/cg/0NQLBq0UQ6XtEtsm+Gn0QVXpuH
	 yjwiHbq+dHpNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D152C43446;
	Sun,  7 Jul 2024 18:34:21 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240707175558.480229-1-sboyd@kernel.org>
References: <20240707175558.480229-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240707175558.480229-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 10f84de27bd05bd2648512975d085dbe0a1e71c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a4bd506ddad75f1f2711cfbcf7551a5504e3f1e
Message-Id: <172037726150.23051.8895242735887367178.pr-tracker-bot@kernel.org>
Date: Sun, 07 Jul 2024 18:34:21 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  7 Jul 2024 10:55:58 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a4bd506ddad75f1f2711cfbcf7551a5504e3f1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

