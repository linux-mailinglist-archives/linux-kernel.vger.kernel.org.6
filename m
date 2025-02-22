Return-Path: <linux-kernel+bounces-527453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6580CA40B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4371B164EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3002135D3;
	Sat, 22 Feb 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ers+cAcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001720FAA8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252168; cv=none; b=cYNbpi1NheroWA7sSpbnTIkkaob4szwHVCpSGyOD7fd7EAnUCK78UdLaaYysx7ySTQUtgNycyvtrl/iipFpINwdB3zu9dk7Y2NprhtgO1guYYpSUw6Uwp7Rq8Uz1PAqvIgpA6uaDFULGWR//B6xkWVfL45uJPk3Dd/fqhchk09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252168; c=relaxed/simple;
	bh=cc5dlFW9kq+u6eVTJycKEHlgZyRSvgrfoxIUiin9Lyo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qWGIrOkAoXgVm0diDwhcyv1mqL9znKeT3DedB40B/T1bUSwjHlUsmRjV0CCsktOrVA+3nkjPa5Jlff60iOHLIXlXNmPdsn/tL8Z+oY6YUqX4O46qYQB6TJENiad89gbargkYBtiALKmYKBKT2qqYKa89yYYZ0e7OttYx6vcQvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ers+cAcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF9BC4CEE4;
	Sat, 22 Feb 2025 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740252168;
	bh=cc5dlFW9kq+u6eVTJycKEHlgZyRSvgrfoxIUiin9Lyo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ers+cAcVOevsCPcWraAufNTOhV34507JAUNLiuK65K4SdzJ9zZqm7xmGqWWbz8Qkd
	 zLG7d92KtIcpPXR4u4MSHpj8MHjL4nA9Hwwc0YcEXYjZiIqDjhBBCRYM1PRNQzCaWW
	 q7A8hM2OB/5XKonlv42SNMjjXZTGFgMons7I0vvuBsDOLmZxKS2guyY7o/40+LE6UG
	 5cwNx3b4kEreaAaof0fKNT8qYNVi1aDkNHqQpOf/Ec0EIVwlN7e0SS6OuLPPsPFIaX
	 XoZ96ih+AqOQAI78mEOMQfx7jmIcXP+CMVlPgZdDrVDLWQQ2T5TKCs9BDHjWyx2pAt
	 J+9CMuYmy8FqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA5380CEF9;
	Sat, 22 Feb 2025 19:23:20 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7nYl38LL0fvgPql@gmail.com>
References: <Z7nYl38LL0fvgPql@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7nYl38LL0fvgPql@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-02-22
X-PR-Tracked-Commit-Id: dc0a241ceaf3b7df6f1a7658b020c92682b75bfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b82c18bf98ff4b5e01a6c36649eafa2c7a4e476
Message-Id: <174025219931.2429034.2404203401975695040.pr-tracker-bot@kernel.org>
Date: Sat, 22 Feb 2025 19:23:19 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Feb 2025 15:00:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b82c18bf98ff4b5e01a6c36649eafa2c7a4e476

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

