Return-Path: <linux-kernel+bounces-416206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D69D420A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EE5281334
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB741BC9E2;
	Wed, 20 Nov 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnwrBMe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36A1BDA84
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127515; cv=none; b=De6VF0Q1bCj8N9yEOBJPoSaGpuvLaud/5Ol/qjQI1MdBWUCiXtNco7E/GwiA/QL9k1PiuCYF0EijCBCe0hH7vqXdxazkfZhvHMvwG+A/uB9HXCvrZoHiTWH/VIa4sHDSwfkrQEC5uMjyOucxJTQ/xi2Tlxh/lHYrxUd4xDFqYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127515; c=relaxed/simple;
	bh=cTO+yrTJ4DZzgIJulb7zY96QpbGN6A4Xb18gW59+UvE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YVIhotlABmw8kUQPdci4Dto5jB3LKiy7/FqN5p1tZXb5uEyHi+cD1QZJipdCVVRAfSwvHGRpEBHZoanPbnAz/8G3YugFo0EIOXs0fzFdw+G8ai7ieyZgEQRjgxklL3fWK3+5cCyMmcjdMgNuZnwm9bEUqT/v1pxd6x+FXQZc3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnwrBMe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A10C4CECD;
	Wed, 20 Nov 2024 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732127515;
	bh=cTO+yrTJ4DZzgIJulb7zY96QpbGN6A4Xb18gW59+UvE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EnwrBMe4WTgdCbXPgtGXAnC8WzrLcbfC3FUUJzMnPnT+HWf8AV2zJZszO36q0y4ur
	 CqYvwpTn3+uaxcApH8x4lGIlTYm74rgiA7PKgfgclglGLIHJp55OcEOFKXBAGp/ESI
	 IRXvkjvkM+/shIkY2o/gFuH0NON3X4OOXwWJ6rMZkBB+TVLptQQNg1n1m2bkH+GivB
	 62GKnqTMVYN/09KHb1OVjW7VyVvlny6F5WOkUkToZEXvqf6ZVAbN2YwqkOBmHVywxp
	 Q/IfNm0G4Cu2MZ2TZHySOOnyR1NACnDHCfjbU7Q0yJQVAPUxBSeShOij1SuknVsr4m
	 uPKvgxAhIJOvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3D3809A80;
	Wed, 20 Nov 2024 18:32:08 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZztKnBcca1OtwAcp@pathway.suse.cz>
References: <ZztKnBcca1OtwAcp@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZztKnBcca1OtwAcp@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.13
X-PR-Tracked-Commit-Id: 34767e5357fc8051b192ff3fd921ade7c1b37c46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d66d3ab139c8c195dbb603e21043b6e2d120fa3
Message-Id: <173212752673.1310468.12795539885748298591.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 18:32:06 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 15:09:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d66d3ab139c8c195dbb603e21043b6e2d120fa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

