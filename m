Return-Path: <linux-kernel+bounces-260408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6BE93A889
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE771C22B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13371448D8;
	Tue, 23 Jul 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpM94WJf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD3142631;
	Tue, 23 Jul 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768992; cv=none; b=Q3g6pNUIA2ZYHayPvKFn7IMfX5r+EJZzTb4R2JK9exfQSWMHb2xoKs2W9QTroFpW4s3YizJStEV91pLOgvY2Q67dP3w/yQpBRHALGOOsizOOahTvz+yHAhZskpG/vLYNMivuxE7/IRGyzw8OgwiN1euQAuXbSz/PsIYNEFE8p2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768992; c=relaxed/simple;
	bh=lJf4e3hZjtbHq26AEoXgnFRh6mnGD37feRCfXDNhXTs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KUuwFaw/NCOST3r77OenTynaA9EJxQmSx5iMIPNIRQ2OwXKM5VVQnWo4iWIvOksAFJt53iDi+wA7i4ed1L6fE8ZiH8l4/lC/pGTdA6nsz7aXVLlJV6238gy4OEiLbtk6G9oJsEf2qVGhKKiiagx5quxUGbZxn0uu5+Z5JSeceCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpM94WJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 220E1C4AF09;
	Tue, 23 Jul 2024 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721768992;
	bh=lJf4e3hZjtbHq26AEoXgnFRh6mnGD37feRCfXDNhXTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZpM94WJfzdVczlBGnq/4zw0q5eSE0iOh7trwkPG7EROePGbdYQmL368mpmNb/4ZdQ
	 K66LMMH0iYJHIjk+Dkn7NzbMQS4D22pu2I8kiFqHNVvNDwEE97OS880W81wrOezbv9
	 w/I1aFuBogbA+fRSKo43PCh3PwwUEqnNyxE2SRHg9CSSk6MeHxPgrWaq4J9UVpwK5T
	 0tIKRjoPiRxTEkR416ZdMKanLyr9fhhOI0HK3rhiU27wnbe9VwKgpVpPtSmC6zD8To
	 N4l+tN/1uBdE4IFd2RWUAByu6ozMmYZL8rQB76dyDjGmQkY5eXRC8M4cQzRwieOkjk
	 DY1WXpXwb/fSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EBABC4332C;
	Tue, 23 Jul 2024 21:09:52 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240723172048.3684527-1-andersson@kernel.org>
References: <20240723172048.3684527-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240723172048.3684527-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.11
X-PR-Tracked-Commit-Id: 718a7ad700b1ea86ae5a3ee636a275f98ba8ef86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58bffbac533d4526cb4922b8563d1963a90729be
Message-Id: <172176899204.17734.13871767708309990374.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 21:09:52 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Maina <quic_rmaina@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 10:20:47 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58bffbac533d4526cb4922b8563d1963a90729be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

