Return-Path: <linux-kernel+bounces-446645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3659F2780
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FF6164F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429468BE8;
	Mon, 16 Dec 2024 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULKbmjkB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCC610B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734307999; cv=none; b=kdNfgxy+C0dYgBy75Xk76sBHQoua4M7xBFWLgol1pCZIWbrtmfWXEBE24+1j8Dj7aWMFiBTAiDi+7Gm6YEH37wl/DyO5KBpyXHLZHVC4IhUdmKFNxEJzpescm+dEnD52N9TvlTUdLTZUyQSmvjnkFvT4//NEBvnoS8ABQ7oyoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734307999; c=relaxed/simple;
	bh=RJn+IaEoZC/3M/1x8cN0HA9p6PgrEofdWoaZqmOjDQ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cgpYOGz16NcBZo0VJVMJXKhPTRQp+jhHYVv+EAU/tBpock8qLBdyTBTlx7+ArrL/2FSd9i7VeMAvMsiFW0XaRFbl7M+QP6UlufuTgirMKJuG2MDJj5Rvr12CGXf2YM6wNgfYp+lQGMhOrYe8/+8dE+DJ/qmU9N7Z2aKddlS7BoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULKbmjkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF67C4CECE;
	Mon, 16 Dec 2024 00:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734307999;
	bh=RJn+IaEoZC/3M/1x8cN0HA9p6PgrEofdWoaZqmOjDQ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ULKbmjkB3WD6u4oneyslm7dBim0OC8NiwaXXjL2G8EIvoUZ87HjoNCWYSGFWRjoeB
	 5BLW4rU/aGcT9u0+9Jy0Xolx8qrQ8o+r8sYh3LhISoLNWVvBQMWFRsaF7caALxyAct
	 lo75952skZAyq30RuW615zx94v5XKVF92+yb5v5S0hLJTU5mYL2c76XxVMQkBoHhFD
	 RL2R8WwM/W4kY0dh0rpkZd5CNAlKBkHu8aD45Ih8YfGEzFXUOTpD1qWfklJC4OfzCt
	 cBUUzWQjPHjRk2cU33Q2Y7UjT8CoTA/VAw7CESwqPeIyUj69ueRwiiYRodyXtWfZsN
	 rP03SSXSuiYuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342883806656;
	Mon, 16 Dec 2024 00:13:37 +0000 (UTC)
Subject: Re: [GIT PULL] ARC fixes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <c7e0d492-c7a2-4266-904c-9b247a41fa20@kernel.org>
References: <c7e0d492-c7a2-4266-904c-9b247a41fa20@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <c7e0d492-c7a2-4266-904c-9b247a41fa20@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.13-fixes
X-PR-Tracked-Commit-Id: 824927e88456331c7a999fdf5d9d27923b619590
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42a19aa1707cce382bc5e534e2e36024c3611674
Message-Id: <173430801590.3608335.14502846064962338951.pr-tracker-bot@kernel.org>
Date: Mon, 16 Dec 2024 00:13:35 +0000
To: Vineet Gupta <vgupta@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>, Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Leon Romanovsky <leon@kernel.org>, lukas Bulwahn <lukas.bulwahn@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Dec 2024 12:49:55 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.13-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42a19aa1707cce382bc5e534e2e36024c3611674

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

