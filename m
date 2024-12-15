Return-Path: <linux-kernel+bounces-446522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBFC9F2569
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281D518855FF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADEF1BB6BA;
	Sun, 15 Dec 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRHE7p9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003241B87EF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734288321; cv=none; b=YaoWm/nZn2NO1c2z0CkpV5LfKPv6BDSnVUPmjCxNgDDSMDPeAtjK3CFm1vafe+Ai/EhwGr0b2W6v/AU9KJWu2DJeQdqCh4Qq3+ScryQfjjtKAfemWas9Q4eAMxKAKbkWbub2Mt+i7JbykJM2yAwWpsY+cEE04NkzdXv4a6Q4ekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734288321; c=relaxed/simple;
	bh=8qBEBaXP3nqLuEraqUIGu0IqWKGhkQ1+cuScby5D4l0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BAUrhSovF/nWV1DWNi9r41AXfmDY0yoHl+O0x7XK9OLZZkxDK5bebPel01UzInBI2e6QQ4y4eW+N66uDyBhNNycIaJK2QhYQOzwxm3nb0Fn7eq8Ntbn1o+jrNLfr281zJAuG6QlaDh/Oj+Rq6KnAsLSbje3txy8h+wUUt4h4//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRHE7p9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB3DC4CEDD;
	Sun, 15 Dec 2024 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734288320;
	bh=8qBEBaXP3nqLuEraqUIGu0IqWKGhkQ1+cuScby5D4l0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GRHE7p9WvVOa2aCmeHdc3Gs0Ite9RwdTCYCrKDXkLvV/jor9gnvp/6K7XTP2b+y1t
	 nHiLxguZpGNMYrs8Y90j4yAhCrJDkU4iotybDovaQ5VJHAMfatBAdFo4K47Xhqahn0
	 xE5ZjrkWfrycQHAWmSxmQDjd0L/TM0eiptCkPC7n0v8YHGBX6VW7UXpB+SW9JfopXQ
	 LiqLDqcf50ZgftAYAlAUqndZk3pvikCqKpPZMNY01BkjoRJusRbmuF8t9MjvffSPcj
	 M1ZcDlUIMov8cfr7t2YezjXLCZBSTqy/W0dJvLW4U1OELQqHX0KyLzlZonuK9mmM7O
	 nypAK5O/djuiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6A3806656;
	Sun, 15 Dec 2024 18:45:38 +0000 (UTC)
Subject: Re: Re: [GIT PULL] sched/urgent for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241214180537.GA10560@noisy.programming.kicks-ass.net>
References: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
 <Z13BzesSJDSuSXRc@lappy> <20241214180537.GA10560@noisy.programming.kicks-ass.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241214180537.GA10560@noisy.programming.kicks-ass.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
X-PR-Tracked-Commit-Id: c7f7e9c73178e0e342486fd31e7f363ef60e3f83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acd855a949fc168f5cefe643ed4875a052b66060
Message-Id: <173428833753.3562041.13490292888493948320.pr-tracker-bot@kernel.org>
Date: Sun, 15 Dec 2024 18:45:37 +0000
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 19:05:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acd855a949fc168f5cefe643ed4875a052b66060

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

