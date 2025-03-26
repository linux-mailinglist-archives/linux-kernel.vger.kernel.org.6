Return-Path: <linux-kernel+bounces-576469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C5A70FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355223B7176
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E017A2EB;
	Wed, 26 Mar 2025 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dng+DyKs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B61714B4;
	Wed, 26 Mar 2025 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961564; cv=none; b=ab4B+B+lPlD5U5INhWyursz69KaHD8jtZbacs+5RSuNHJ5zypxslPx5kpg6XAMvYLOdKpF6BCoiuVcq9q+0YNoaoAbVvMogI0TApzCWFT1ZdE9jqEEMuSeKYALku80OouLMrey5B7PIVS3afohS4YY3AAENc9mtviHcrpBx2byc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961564; c=relaxed/simple;
	bh=x7VLkZ0m23iu8P69SXcVZ9LmGu1WH0kX/ucTnrxYnkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kFGDnvkZcNNgn2vkqS89ZCLw6EUSELjgFaE8mrLNcd0CE1ma/trvkr/I1INoanzF6ORURLxKb6NM2BhMxsIW5aUZx40OgrQ4CE3fnSWt1KYgyQG2AMdrrmnHunaSzuE7ISIH9Rw3x016B1lc55IPjhtrK3fwNtrYp/t94+cdJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dng+DyKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54C2C4CEEE;
	Wed, 26 Mar 2025 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742961563;
	bh=x7VLkZ0m23iu8P69SXcVZ9LmGu1WH0kX/ucTnrxYnkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dng+DyKs9xAm9bmF8fLCsBRECqa/hpHqmZwa4M2q3qd1WWUiyK6md987Rf/X/EMhh
	 DTyHRe5eZdaHHE6k7NP8GmU24kcYTPs8UGQJ160Jp8fm+gYl/oiZiVToOMB06pZ1HK
	 AxVXcPftfPJh0A2G5dV37PMOqzHpK7LaEC/BIny4PCqIOqCIQLQuO1YADxGknkTQrP
	 oydElxB88c9H9aTYwkL4B3oezJefJMVm+DxhSvfWUryVLpIXBr1PlUSwxsJeWBLTod
	 5oM5+gvdBUU2pVLLoPefAwCkCn96lt4P1XmLtm9LaiZxxg39vSywGQ97Dr9SqpfzB3
	 /T74MyjIhwEzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C29380DBFD;
	Wed, 26 Mar 2025 04:00:01 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250324231510.2019037-1-linux@roeck-us.net>
References: <20250324231510.2019037-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250324231510.2019037-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.15
X-PR-Tracked-Commit-Id: 2115cbeec8a3ccc69e3b7ecdf97b4472b0829cfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c07666e29be2487b99bbc1fbc109b5cdb57d1713
Message-Id: <174296160012.837738.8606001820641122186.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 04:00:00 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 16:15:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c07666e29be2487b99bbc1fbc109b5cdb57d1713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

