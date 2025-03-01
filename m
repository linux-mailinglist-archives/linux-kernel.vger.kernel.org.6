Return-Path: <linux-kernel+bounces-539703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C829BA4A793
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53EF3AE4A9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4215D5B6;
	Sat,  1 Mar 2025 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSAooOFG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CD1531E3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793230; cv=none; b=CGdmsy+PuZR06yy3QGxkn6UJHuC7TbCS+nPVug14FfYIHdf3pC3632r7ww4OB/YFFgK7m+UWmFlxJIVa27BDbkLacLFXCG1gEgCApvzN+jaReKFVFFKD/H7TUYIRK1ztElNdhgguSeYZwwSXy4L/7mDMmENKQAqrXAs6xzowUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793230; c=relaxed/simple;
	bh=d6MZB37R5MX/vucnwX88ApvghDpUpdxDIIUcE95hDQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cFbPgV4BCmIw3yVz3OtvJ5cB67G5MjAxstOg0xoMqGzFhTp7a+wgZnhbkUa2zEKHLhtcjF4YS3mwhzaUtvWRlgul1PevwLbSoRw2bFZnUlzSz7RHC5hWfqN2iT1SASLeptErM3zXmnNEpEcCuCOd0rU2y0s8/X2xk6N7TNLysPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSAooOFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4A0C4CED6;
	Sat,  1 Mar 2025 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793230;
	bh=d6MZB37R5MX/vucnwX88ApvghDpUpdxDIIUcE95hDQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BSAooOFGAl6QvnocrvONWR70m19ywfTz+GiVFgzJYtyWo100GJUi2DEG+0QGAQOB5
	 evN/zX3LmdFNyjYGQ58rcjuDFZfj2PD55uVg7rhwKtw4Jvu3iJg9HIiKGTRSLjblwc
	 71ssHqZ849EmRLN3mgyGc3z2BIyf1kWJxhYioaXGiLTHkKbhJSPoH9W1jsgA7dbYLr
	 WtJ2EJk4tqgy4LvbWbiQjYuL5PgoNUTThRON1WudUl5BzB9SUIC7zpkOVv6AVQnq5j
	 k7uS6HoXRpmo4PvMQ3myaUI7+Ese7jn1w6jDcAqjgycBRGWlgoDGFDmFf0/ch0sPeS
	 NiMSqMIS2x09w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC7A380CFF1;
	Sat,  1 Mar 2025 01:41:03 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8ILr7mcMg6x46nA@gmail.com>
References: <Z8ILr7mcMg6x46nA@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8ILr7mcMg6x46nA@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-02-28
X-PR-Tracked-Commit-Id: f8c857238a392f21d5726d07966f6061007c8d4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 766331f2860b08695418109582c94e98cc3528fe
Message-Id: <174079326232.2333772.7045704586751247530.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 01:41:02 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 20:17:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/766331f2860b08695418109582c94e98cc3528fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

