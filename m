Return-Path: <linux-kernel+bounces-415037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E99D30F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21443B236F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5D1D6DB3;
	Tue, 19 Nov 2024 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXAfpLM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09641D63F8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059214; cv=none; b=Xpom5C7PSf/jxOIJ2cdk3P9dfDRdw/VKsfrbDjceiHu4WtXjq37yCSVVAoBdsUI9jJeq7zajL9bmTczzdm4VuDcypqRo1a2TzP0/K9E2veB4C6uy+4WXChrO+wNv6hXJ7hFt/HtW8ocOY00Nc+IFQtjvM8hvGtTgRDPhfBpkS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059214; c=relaxed/simple;
	bh=rU014RmXK9P5+MNHTwXQpHOWOLLUYk4GzggekyRISW0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=li6YnaDGxbGsTCSk9PghGOXNrtYOHQNflgjHQe8y5DtXOblXTFYO+X1wn2BbwJrIr4J9YOi9OkkqgicKI/v4ZB548MbmVs6Lc2tRO8VM1g/Ai6yb5x1ybnQR++lh6pQI7l9sdUjV7nX9LivSl6fkyBWVFn+KpTP2Eb5kalj80eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXAfpLM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24F8C4CECF;
	Tue, 19 Nov 2024 23:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059213;
	bh=rU014RmXK9P5+MNHTwXQpHOWOLLUYk4GzggekyRISW0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DXAfpLM4vCRUR9tU7IAKw0oR24rvAJKiyWNC1/YISlcCgTMIodAjZ9oyqoNWez0rT
	 Ko2/7y7dJ0sQitr1V9+4i7YE48OrQe4lvXFUFr5EnwVZJt9d6x1BLPeFbxFriauscT
	 pKob3WAFsES1N2M5carKraZmen/+GcaeTxEvKTxV3+HkUIVJcjQ98XwPIEDW44oRbt
	 jVRnCSAu3lw8Ckgb9D/GbFUCDvui7d1MMfwJGcWzJdvY3/TpnYDH5oBJbPWOJ9jLe0
	 I1+xCRULuduyM3RKZuWe3ijyYgdcgXuMoiYxpljSi5+zXF3w1vpNq56Jg+q/iAK+pK
	 Dx1/Fh/xmMEmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE53809A80;
	Tue, 19 Nov 2024 23:33:46 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zzt_or2E2KEypfbi@gmail.com>
References: <Zzt_or2E2KEypfbi@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zzt_or2E2KEypfbi@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-11-18
X-PR-Tracked-Commit-Id: 771d271b2b908cf660d6789bb4355ed553250edc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f020399e4f1c690ce87b4c472f75b1fc89e07d5
Message-Id: <173205922522.720598.9650170802705539668.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 23:33:45 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 18:55:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f020399e4f1c690ce87b4c472f75b1fc89e07d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

