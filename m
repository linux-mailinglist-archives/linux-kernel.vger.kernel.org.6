Return-Path: <linux-kernel+bounces-331436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568697ACE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F071C23976
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5F315B98F;
	Tue, 17 Sep 2024 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+jX+2yh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C515B552
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562234; cv=none; b=ZoIeDRDRvuHAxXeVr0G+XEdx0L617BSuOEI8tVmW93/li67KCg/UDPpOol4CKjEI5wXDkQuC6YiKawq0sG2Yborl0c1ASCmvjl6PiP/pFu6S3UKdKJkKA2Ha2pY+0h1suFxBRIS7I+jR3vgpCISR2l36kuIBZcJHgSZgdiJHIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562234; c=relaxed/simple;
	bh=VY8CiyaBs3IFydejs0PA3CchP18s32MoxhPJpzu6VTI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RjsOgXxl0RZIvS7TiuR1teTIRtEV+viNOe2V8bsfUqZ+NOL2XAjaLT/xqRucfRdAHTYr+XSFy8LUuRZ9JxzUOY+8bocOKsHgbd5+NCm1oqh3RWMDCVrwBQzFOz5BS34oy49Ep1n+v9ONmjLN48DHPJzEiz3C4x6BM9M9Eaxv6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+jX+2yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4EBC4CEC6;
	Tue, 17 Sep 2024 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726562234;
	bh=VY8CiyaBs3IFydejs0PA3CchP18s32MoxhPJpzu6VTI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t+jX+2yhipW45eZJwAglQf6jVWBlObVYVvzaXgRdy7+uRH2tYKaMXu4jPiIPpW6WY
	 tqTKU8L5fSujXqt/ZPpr6RwZt/oCi+az1R222cjT39/p3WJ5LgwLQG27Tdsfsq2nDO
	 n77P9lgBqrXMQxRJKV/U1aQXMzXWbNCuIg2e6vWneabEWg0d5zSbBs0+YRzeneMFo5
	 gx1A6GWahVx5Nwg/eYPLXmA1hxsJckW8o1KCPQN4ffqcSJNLmg1bMfKIaQhhoBWdI9
	 WiFrJfH6fsgTtfUXMEXpxJlXBPgkcaEU2FLVVAEL9HZT5FXi14q+aRtNFbIXHINFwa
	 sNN9g6GGiNAOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FE53809A80;
	Tue, 17 Sep 2024 08:37:17 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuRRTbapH0DCj334@pathway.suse.cz>
References: <ZuRRTbapH0DCj334@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZuRRTbapH0DCj334@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.12
X-PR-Tracked-Commit-Id: daeed1595b4ddf314bad8ee40b2662e03fd012dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c903327d3295b135eb8c81ebe0b68c1837718eb8
Message-Id: <172656223611.49587.4470274337090130342.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 08:37:16 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:50:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c903327d3295b135eb8c81ebe0b68c1837718eb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

