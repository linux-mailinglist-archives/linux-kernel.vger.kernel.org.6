Return-Path: <linux-kernel+bounces-539704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCCA4A794
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11407A4F2C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95BA19007D;
	Sat,  1 Mar 2025 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebUMFEix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6A189906
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793232; cv=none; b=AD033K3om8uy8ptshWbsPmUO73Y3BQNEMAWJih7ciqEiplPICjED4qQf5VaniWV88Lk3/WmXk/Po0cPAJ+YvsKtRg1GoMvPCbZ26UcK9pTwncjnhis+W2ywPWUICjJtPE21UbODuxodJakgvG9aLKBbyBTaCER/y4tVEZNqOrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793232; c=relaxed/simple;
	bh=Xp9vgaFKzffKDdXmRXBX9WBmAIvqvV4tyzvzVVjlYtU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dJ9FvUfEYlZHLCUCJFCUPuDu1g6cevptL6QvFMPz+Q9NH6jFuWM3fTgnMUAXIh9dy5L8S6xPf2C/ey3gV+hnjehBYpUnv9Tq8x+j8+bbNSktvREp+VJZaeUgjUtnLPkcVr05zUSzCHDI9cypyyKpXION587AK67BaDXl9gdW6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebUMFEix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC991C4CEE5;
	Sat,  1 Mar 2025 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793231;
	bh=Xp9vgaFKzffKDdXmRXBX9WBmAIvqvV4tyzvzVVjlYtU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ebUMFEixXpNgtpjhGC5sqcm6wDASp3c+Y3XPAxIzcU/vBsslsCAfomA+3MK+eRyaq
	 DMlhtul0rWKEZTovsJO/Cnwq1UE9y+Dh3pEQCpV9FY2CZqPslpO9eIOQdj7sARrpI3
	 oZMnX2Vry5RJCLO8Jf0p2uqqwmtXV46XfRwLwGenXXRI9UYsEIF7BrP1lYiKAyAao8
	 HUBlclcqJ2lQ/+bMv5YKABxCX8I+zGv9vek0mtq+jiDmn52N5hwcWXCFbrOblQmCTg
	 o80MotJrmobAsfwxWkM2X1JqoreKAsMZth3VeJhiu335KF5GcWmrSGrTt5O+C7+iA7
	 oaFY9W4M/aDyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD2380CFF1;
	Sat,  1 Mar 2025 01:41:05 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8IMgei8ctaN_H3R@gmail.com>
References: <Z8IMgei8ctaN_H3R@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8IMgei8ctaN_H3R@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-02-28
X-PR-Tracked-Commit-Id: 82c387ef7568c0d96a918a5a78d9cad6256cfa15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d203484f2556f47a435cda36ceb9dd83adc9056e
Message-Id: <174079326382.2333772.1412860002261203334.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 01:41:03 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 20:20:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d203484f2556f47a435cda36ceb9dd83adc9056e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

