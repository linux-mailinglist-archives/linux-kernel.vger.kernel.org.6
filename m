Return-Path: <linux-kernel+bounces-180345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB72D8C6D41
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5041F22ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81C13328D;
	Wed, 15 May 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc1czd5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3315B10E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805014; cv=none; b=Vjx9acg7IjOd0DwVYGaYFXrW0uwxkGJEGq7cOXuUV8BWSoyeOU5rsuPvZjzuF/WBMvaDRb/wtgbCKFKUycfryOh+cu9pGXlst/tXRp6S4r40QPN+FNFPf561pB3iEHj6Wu2mkAzNlPIgwQVyes2//W7YsXqjC+lvje8aN/Lk+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805014; c=relaxed/simple;
	bh=DZ3BE/RIybkiKYm8T63PJsTaaiBkTlq4AGG+AIS2YpI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MdgGiguC591J0JY9vyJ2iyKO+1zzD564pHUzZPdUVkcreiVKBl3lNxvHLeF0RyDTRojdKTCaKKORQ7QidhgMc6sjonqsMXEUgqi1p1RkWNqyQQfKQiFjM7tDe6D73RM4/t9cV+Ybyc109iHVYBNQIYwONKG2P1qPg4/mBsx1fs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc1czd5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8A23C116B1;
	Wed, 15 May 2024 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715805013;
	bh=DZ3BE/RIybkiKYm8T63PJsTaaiBkTlq4AGG+AIS2YpI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pc1czd5uNRdCY+6oK4f1Y8gq5w1oN1g7koiY17HJXFeu8a3XBQkPuiMK+zDvZ8rzJ
	 Y9Mer4gpy6zgCc4aT9RCDp2V98xMv30ufJlqqXgt0eBGYAzP2imR4uwxR5hLALzJSZ
	 DuebbM6aR1nC0cvdhbgvEw+GpiET30UW+SM8DguFd6btB71lpPTmgs64teYzwsb6iB
	 /vV+GjYVQdktWJ8YFGyfj5wPex5Qnoiq1bfMEQNyWBy4izpIc0PN1LB8sU3fIlBctE
	 GHgfVRuQOdflq5td3+gyyIbV25xmeHT1ZF3QsxEOL6GP/lrc58t/9IF3ISGwnENTcs
	 gb/8xstu9cFUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D6DDC43336;
	Wed, 15 May 2024 20:30:13 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkSgkFYVXTxJB9Fm@pathway.suse.cz>
References: <ZkSgkFYVXTxJB9Fm@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkSgkFYVXTxJB9Fm@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.10
X-PR-Tracked-Commit-Id: dafc2d0f1bb9bb865a8420f77de56bafd8881cc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a19264d0868dfd65d7222b37ffe41068b53d473a
Message-Id: <171580501363.10831.12449241232353363179.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 20:30:13 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 13:46:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a19264d0868dfd65d7222b37ffe41068b53d473a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

