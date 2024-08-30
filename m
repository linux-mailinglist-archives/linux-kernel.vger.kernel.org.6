Return-Path: <linux-kernel+bounces-309336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A934F966906
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D791A1C2383F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478631BDAB6;
	Fri, 30 Aug 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzEt4ONz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0341BC07B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043060; cv=none; b=nrrc4381c4DKxC4P3qhTgUvDJ8M1V57jsRiXI9Lx6hvN0zP21HrExBQqx8VjlNJfLMzxfu0/mWEVSL6ApNPxxHsFHC5Tmzkoh9jMSMU24LSQqaUOJjJqGGGdaCP8DuNXmDH0VWBleZEuYfnugPh21d7V8TGSHWbmSRah4FFY8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043060; c=relaxed/simple;
	bh=x7Nwo9/SzBkpy1lULtDHM+dumOUJPEPWqgDyR4gwQBE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r3qU3fr9fJAOhuK12+3KjMA6vbjj84BKe+SNJX7KsXHAP9wXAeK/IPPdZPeBIEafCB7VEwNIN+2V7vwO6WFb0GaXNUKvl3zI3yyVProE+jimTZPxkvQzykyT/d8JaQB5A9TgSn9sg2OZ0c9gY/P9FZ511WLREDH9rhfU1Y2pfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzEt4ONz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB35C4CEC2;
	Fri, 30 Aug 2024 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043060;
	bh=x7Nwo9/SzBkpy1lULtDHM+dumOUJPEPWqgDyR4gwQBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AzEt4ONzF5lWf3Wr7DLe7amccw6MrWt994lvj97mhmJDYaN0II8qj40OL9CndJc+6
	 ZKxJPY9SqCNRBML2smIMQFZ1PjpHUyaex94DLLWmfs+uY35x+z6+KOpnukqCHn3bgC
	 dWlmgTEA/ACqfE/zBrTo3+kgxRvWiRdEWyiajZLfEsBt2Z78nAZtA735TpBbMwKhF5
	 M8i+5+fj7EyV3V4qUYVIvwNt0waKm4YAyr34KOumtKzI6TZWQnCDR0a1+1upU2tEj2
	 0DpTmAWlUYZDAKioifIGad1NJOWVvuxLPYxJdBUeOvsi1gc/NCkH8fmC3mCUp1aw9O
	 0/ggi4JcdFONA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 205493809A80;
	Fri, 30 Aug 2024 18:37:42 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZtHAoNLCzDeXh1z1@vaman>
References: <ZtHAoNLCzDeXh1z1@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZtHAoNLCzDeXh1z1@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.11-fixes
X-PR-Tracked-Commit-Id: ab8d66d132bc8f1992d3eb6cab8d32dda6733c84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d80c9903e3f6f9a99e8fd4374c2cf0745d0b708
Message-Id: <172504306212.2681732.2551327948505140302.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 18:37:42 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 18:22:48 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.11-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d80c9903e3f6f9a99e8fd4374c2cf0745d0b708

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

