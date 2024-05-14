Return-Path: <linux-kernel+bounces-179210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB08C5D61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01053B20940
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E0181CF2;
	Tue, 14 May 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBvR8s0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDBE181BBB;
	Tue, 14 May 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724021; cv=none; b=Q4heyWH7vSLEkuz9Wgd6cT0LwR4DVtkSUafkiRpeTaYa6QLjaj70C+3gQJ7a+hjRN7mTlGr2fuUbdIjnmSNxnKQCriutwkSaJl6bFXf/Mkl0GtwZaCWRvzC7Fn7i9iizUlqAcWbKW0C9RV78hiY9ra0S4c2cZ5x7heGHj0mPCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724021; c=relaxed/simple;
	bh=RgAVT9b0FGE2pjgzTSzULhoTV8L95uztNagoVglzXbI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ycsm2jWlsbfwjyyDPue2Nol8yVRoYFHBQCA5ZYuFyKxjznvzTppamPzFm3AxEMjd3VOv7o4lD5doxP6EyMAcKZrVa9S7UkEuAudxANqPUoAV3kvVQz3rs54iPQDt6R34hBkxpujr5DfgSj2X1CjmzYM/mrXXQLvi+8LNWqkq1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBvR8s0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22326C32786;
	Tue, 14 May 2024 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715724021;
	bh=RgAVT9b0FGE2pjgzTSzULhoTV8L95uztNagoVglzXbI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eBvR8s0rzNfEYqhJrxQJJgEtWLTVv4glgsL1gY9l/C2lLXDgD6Nln85FwRPT46eku
	 Oi578rqVYpYUQCZg56BwDvvc2DddUJeN6zWjzFF8XYnX6Suur+qNrkqvwz0BMm600x
	 uODRsHh1c0FIXoqNSWiiIG6xKsf3wKODMc8Pa78vRRaj27yel0/mN/tdQzC8jvVGpP
	 1Hm4rnB2wXZDngAM+ofdXVhuqychTUGEzSeIyCJ7xDu+dxfB+sT1Owqo9i7UDhf9Ss
	 Y1mTRIjlgBUikr6/GKI3oEkeuIJe6pyLIPWhEB+LB8jpvon0t08drF4CYNJmFX2Ax2
	 RqJ6PkJuNU6fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18891C1614E;
	Tue, 14 May 2024 22:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] hte: Changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240514064812.183839-1-dipenp@nvidia.com>
References: <20240514064812.183839-1-dipenp@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240514064812.183839-1-dipenp@nvidia.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.10-rc1
X-PR-Tracked-Commit-Id: 297f26dbf870d4f19591b74a0ab535c327917b81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00fddaf58854717a075f3690c828b61290701e7e
Message-Id: <171572402109.23495.10986002603633790584.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 22:00:21 +0000
To: Dipen Patel <dipenp@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, dipenp@nvidia.com, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, timestamp@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 23:48:12 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00fddaf58854717a075f3690c828b61290701e7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

