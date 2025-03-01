Return-Path: <linux-kernel+bounces-539647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC6A4A6DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36EF1890D02
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8356A935;
	Sat,  1 Mar 2025 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VloO8QNo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BEF9461
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787718; cv=none; b=tz91i6AMO731OnFN6BhromtT8IQnkAmYE6cYR1ME8ttfA7KJd3uQoCvZudsPT29/FQufcoKQmXr2jOBEqUM81UuvzziqwPpbMMno4qyPSRxwYT60w3lZML9RbyDBuLBlnM/nKSV/Iy85clkOqAShTDTXPBeA+M+skR4HExGGeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787718; c=relaxed/simple;
	bh=mr1gPYYlHKMF8UVtoL5fkbVcwQAjHPCuRzk3gD3W0j4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ijk7ylRt/Yg08o52sCcwzqKyP+ZDL6gGjCEcvnMUVqxZu1shdTEIQev/dPAqF7vtODi9z5nS0KySmT02RDxh/bhZ+AX0ZR3et1g+kXew019qZhmDQm52uRt3HpB25sIP0xPb+p4myR4cTaQHV2SEbeLx4gjpot/oV7jX/5rELBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VloO8QNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D768C4CED6;
	Sat,  1 Mar 2025 00:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740787717;
	bh=mr1gPYYlHKMF8UVtoL5fkbVcwQAjHPCuRzk3gD3W0j4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VloO8QNo3lIKu8vYAZ2obWDMKvpPFi8Qgqi9I9Cj6gpSZw9C8ksCKYOZEbq9OPnyb
	 whQDyCMcqhq/BHWnXr/aC0SZkzPbXoOYePdwldtxugcstG9l9DVI+OqiCFUsYvbEYL
	 5pNq2gHe29YV4hBHlMxuRlSGMmCgUCtKKw+Zee0DtRcNGGhm4psJsALWZqmAr4tM5/
	 DK0eWgkzMOFQO1umjvgEBuHByGzKxuwX/Hw5DaFY0HSC9hqCYxz8nRCVblY5h8oZZL
	 xrI3vudjXu41hWQwvV454H9lIm5ymnBolFL8lJSzB4O5WY/E+FXusHW67UfILKu617
	 r/0x/6FjojEFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBB380CFF1;
	Sat,  1 Mar 2025 00:09:10 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250228120918.5a050257@gandalf.local.home>
References: <20250228120918.5a050257@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250228120918.5a050257@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.14-rc4
X-PR-Tracked-Commit-Id: a1a7eb89ca0b89dc1c326eeee2596f263291aca3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c44ddaf7df3a06391684dde65083a092e06052b
Message-Id: <174078774961.2315171.5128848197703722872.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 00:09:09 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Heiko Carstens <hca@linux.ibm.com>, Nikolay Kuratov <kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 12:09:18 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c44ddaf7df3a06391684dde65083a092e06052b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

