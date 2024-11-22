Return-Path: <linux-kernel+bounces-418810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B69D65CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2765B22A62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0481BC06C;
	Fri, 22 Nov 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ97xoxE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE91C8FD6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314750; cv=none; b=lbH0OnVn5vxp4MnShkq+WE5vkWMaEBEsHLn8WyjbusaVTzR83U0xipePMg4ovNPDqxMfQhAWfuJL5k/ciDv9hZiNElM8CtqQcIVUah4oiUV5Y8ae8OPUrd3eFuI8QdZbOLEdrA5qYT4h2keN6QpasevwKUBhr/rq0dN5IE8U+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314750; c=relaxed/simple;
	bh=YPwtqhG4V89MxkNk1jOipgu9bAVHnpZZc6ZXx3C4WIM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bBL3k69KGeZbINDqe1wc/Ho1Lo4KAOovrXdBDI9E+MJzTWOX0g1imGKc5XqVfFAkiNAb8vUDATC4Bx4ZJJ0kN4A2KNyyw3FADx0QHTHDJkDk6qjgBw4bKcz8bNMQLY+JVOwIoI3iw0CjOBtfITU9kDYuwbzyal/Cl+EHuP7SOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ97xoxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD02CC4CED0;
	Fri, 22 Nov 2024 22:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314749;
	bh=YPwtqhG4V89MxkNk1jOipgu9bAVHnpZZc6ZXx3C4WIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WZ97xoxE+Xn/ux+TcWdOOnmJ+m2DBeUWJPw9KCddbuuKlgK5c9MTEuKYM6j8TzqQ9
	 1tcsqu9YGqjhjac5Wl0wkr6AA9wqoXUmH6/iMAllqbJhEumrYADIj99sJVAE68Mw51
	 7vuhIW5cHgRW6Sv6xQ7PshoJuMcvYv197IpBBkGLUxxYLT2UIDkWY53CHOdBJZoKVB
	 6+xd/Rx58m5p8Vudo2z6pjy+ZgKL5hSRenBEoxum9WXzvMD4CpJgr4Ip31BSAtolzN
	 pG6UfQp62JYHbcUaTAJo6RVAt86MjN0nK5U8P/4d2c3LMZrae0MlBKNmsL6qehutSi
	 YGUZPn65w3fhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA23809A00;
	Fri, 22 Nov 2024 22:32:43 +0000 (UTC)
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241120154833.4f6a9c4b@gandalf.local.home>
References: <20241120154833.4f6a9c4b@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241120154833.4f6a9c4b@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.13
X-PR-Tracked-Commit-Id: 537affea1672a841cd5b87b208c193a3a542c7cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1db825805d48cee6826b7dc082a04112c1f0c8d
Message-Id: <173231476168.2827182.13024399563341494994.pr-tracker-bot@kernel.org>
Date: Fri, 22 Nov 2024 22:32:41 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Julia Lawall <Julia.Lawall@inria.fr>, Petr Pavlu <petr.pavlu@suse.com>, Thorsten Blum <thorsten.blum@linux.dev>, liujing <liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Nov 2024 15:48:33 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1db825805d48cee6826b7dc082a04112c1f0c8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

