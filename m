Return-Path: <linux-kernel+bounces-315822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C26796C75A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9564CB228F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8501E7659;
	Wed,  4 Sep 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCKJaFh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8CF1E633F;
	Wed,  4 Sep 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477408; cv=none; b=b6a7bsCQC6x8I3HCVScaDm44iu8NG7WMf9WPUd8Q/UT1ALdC3d0FnDHEsv5Lw6tJGl2I/rQ5952UtiA3+OXZxZro89AocJv9sCBUx005I7yJ2hotXBc8a+NUwgRytW8+mcKFAY/8WmcLEfky+hdNx5qwOsLV0U7SDtIQm/boBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477408; c=relaxed/simple;
	bh=tqn7Dk7wV47Rcnp6pq6TqA7exKgVRLsmQ+/qr0ny9ok=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NmdGJ7SfrOTP/9/ybdyjelwJRmMUcNzH8klR2UqBCXrMgC5V1sC6fkDuCQzspMSL9yXeS3ltRG6CoA7eHQqa/1ihg0FH4GJnCPKt+Y6Z1qW+rLOiALhNDfZB5V/bPlsPe0WBPywlauN1FRRwxpzsMbMBI8F+MD/zd4lCyW+2gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCKJaFh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE6C4CEC2;
	Wed,  4 Sep 2024 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725477408;
	bh=tqn7Dk7wV47Rcnp6pq6TqA7exKgVRLsmQ+/qr0ny9ok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KCKJaFh9VXKeAPQNCBL4Yvm5KT0ltaWh8e74oruWFjZiK8hbJaJalcBFYNxzLoWgg
	 q8uAul36RkoFiwIhkKrQNv5rVtAM3afoNctxF6RS6yDqQRe02bE0o8gpUV1bMYquzI
	 9FTZ05glLQwsGi40NC4kDkX6blgb7/g5ibvfGpbQRGwCdcWJtv5EI79WHFIPmWW/I/
	 p4mC2ILTdxWjM/I1QDH8MAh60Qn5KkHIuCXqURZKkynAJsMe8DwLUZDhoID5rs/rAK
	 C+a4k512JKmgS4yMZdSAVR8v+iJOGSI0jwtq0gSuhRDIVEr0S5KGtBMSRspUyxteKb
	 STKr0F+0b2aUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340153822D30;
	Wed,  4 Sep 2024 19:16:50 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240904190308.226166-1-linux@roeck-us.net>
References: <20240904190308.226166-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240904190308.226166-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc7
X-PR-Tracked-Commit-Id: a54da9df75cd1b4b5028f6c60f9a211532680585
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14a244a9095e9034339c1c9a7b435f238f7d49df
Message-Id: <172547740889.1139567.12745287904506464387.pr-tracker-bot@kernel.org>
Date: Wed, 04 Sep 2024 19:16:48 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Sep 2024 12:03:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14a244a9095e9034339c1c9a7b435f238f7d49df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

