Return-Path: <linux-kernel+bounces-562111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D7FA61C45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16F217937D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CFE20551F;
	Fri, 14 Mar 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfhJeYSY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2F207E0E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983208; cv=none; b=rMIXGySedLfDBieE5bJJj1ZfN7G9oLxP/GdSpZkBbKgxaS9n/nteclNdl0rkRu5XCoP6GNxfQdUrh3mKLwmKCUtrJ2ri36WK4mNzob0i4AKEy1sNvShb1xClEv0ns79LDA32xvI0ZnUxp2rOgVaZKviVbzRQ7HPxXESJFg2AD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983208; c=relaxed/simple;
	bh=vbkbqCIra52WvEhCrwswMNlS492HQB/xwI2Q3+FunK8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f3cXti2o+xc10SzZV5iJ1rYOiCvMNeRIbjhWhz97xukEMwP+pFBEsUWv7JbFZbBV9L9wipDDdeDAObUc2DbxFXksP3g1NY+XNpHbaloWuL1Ida01DbTNxqHJSvbOL+TATvguJB4G8d/B4e7SLjQDcvLsaLvstJPa5FMbrIDsgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfhJeYSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5ACC4CEE9;
	Fri, 14 Mar 2025 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983208;
	bh=vbkbqCIra52WvEhCrwswMNlS492HQB/xwI2Q3+FunK8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kfhJeYSYFsezK6Bm9TVA/h1P5l/2SkIzKuJwreCqMH/zwkHE0uFs/GqLdNO2mDxfe
	 yvRDzuWzPsqpM6uuif00PWHVot1UHqZYCEYcHB/r62RYKCqhNpUMr1TT0FhPzAGM4T
	 wJqvJaDGzI9c8QpvpgLQFUV4mytPMwCpmoVErFwdzvINs/KT+KCQMbdQanpwbHdnaf
	 itP63AY/qrPCCmGp69izOQiJPvD+Oywb9hWXx2r5Dq+fimaKNqwkDb+c9lLZB2tNcg
	 fo0wudbQMf4LJZ0ZbqNLOg+6inbzMFmECcD8XzKNaizL5nu/kmYfbZDUHJE8H5YNLx
	 NS5q9aALHc9jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02E380CEE2;
	Fri, 14 Mar 2025 20:14:03 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9PywlnGNS7ctnh_@gmail.com>
References: <Z9PywlnGNS7ctnh_@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9PywlnGNS7ctnh_@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-14
X-PR-Tracked-Commit-Id: f3fa0e40df175acd60b71036b9a1fd62310aec03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a22ea738f4539afc13aa34a34a631e5aae96bcf8
Message-Id: <174198324266.2369576.9966772282043066230.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 20:14:02 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 10:11:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a22ea738f4539afc13aa34a34a631e5aae96bcf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

