Return-Path: <linux-kernel+bounces-182748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F98C8F45
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DE128343F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6C14A9D;
	Sat, 18 May 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMYaMyjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCBFC12
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997259; cv=none; b=V3zbl/HRZz6lxuDUoOvVfmxke2XceFtGSqHEEbU2Xd32aCg8BMZcmZqpLJ5DCYO90vVhC2MIJJtxpnHQ5iZYU0xo5c/+E9XevFznU3unPbBL32/O0lg+L0SjdO2osZPmXK9ddMx8IIVuFMBqgXuHlZvVNa+cDqB5/LPaY16l4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997259; c=relaxed/simple;
	bh=Mx6HdHcC6xo7nLkrp62uo0ZFktI/0/gkHJtOspSQ1Ks=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jDFdUxV5Q21/lrMa/o6uMSr6b8wZsmdptZTA5EMKdhy+K42/9D8OoHH/EWzxaItuyQVye6x9+iGYL9ljbffJU0kQsEDfyzj1IC0XFhakAshOjMXrjSBp6YqW5ZNR2f1kFM5xE55s06BxwCt8gVWo0vFhvUByP/1yNJZ2Js+Mj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMYaMyjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CAF6C4AF0A;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997259;
	bh=Mx6HdHcC6xo7nLkrp62uo0ZFktI/0/gkHJtOspSQ1Ks=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eMYaMyjEcjNz4MzTfaet56CQElq4izAvRdZI85WwOBf0PKe+3aPGgEuWgES3d+Dzz
	 u+iH0UsslMvMWVFLrspVwW2zV1XrdNnhEsvKlIL6NAFAJ++CvTQpWXVxR97S8OFLAi
	 bK5zO7x1wQhENgNPN6YQFLORM+4+zpjW1ga+ApzJl3l8KUvHQXdnA33FZk1p+Rg62B
	 88SR4NkK6nlywsMw4zqoeZlENH4dlJNXfNQ+vGMTPkZwFPsP6Qzo5osicSYH032DSA
	 1wqnIVMZ5LbEWzDXTtGcR2A1JjKuEym/Zprh+M0XZCEn92wiUodtsmej8i4xbkBTNR
	 PxX9kfClscLbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84D8EC54BB2;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
Subject: Re: [GIT PULL] bootconfig: Updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240517091130.61db91a91838b856bb2f8c6e@kernel.org>
References: <20240517091130.61db91a91838b856bb2f8c6e@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240517091130.61db91a91838b856bb2f8c6e@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-v6.10
X-PR-Tracked-Commit-Id: ddd53363f875eb23b6754362ce0a43f2214f0a83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9d682518076b38ae76f9fe45ba4fa9e324274f7
Message-Id: <171599725954.22868.5429949245001301216.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 01:54:19 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Yuntao Wang <ytcoode@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 09:11:30 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9d682518076b38ae76f9fe45ba4fa9e324274f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

