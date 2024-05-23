Return-Path: <linux-kernel+bounces-187951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB088CDB30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F9F281E88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B384D1C;
	Thu, 23 May 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnZuKG/j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30541401F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494570; cv=none; b=IVZxGKfHbRQpyyq+pUiXjH13JUgn3GdXxiN3OvszRJb80SiTAcEOAhyni7+K5O17tHC/+ByVb14v8MIWxWgSKGydDY5eiwiYYGzwS1uartYJrBqj2xG9Hn76xEdvPTjOqjw6dGUw9B/nK3PPphRhAhV3oWjNdtNJKSvw1gL+6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494570; c=relaxed/simple;
	bh=oKg/CE/t5mVRloCdW3LYl6Wb6OvND2d2m7eLdYwDksg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GaraRcxH6pBaTMJyFTg4s18u5vI6eMChw4/DZCPHCaf05vox4j/lZCBifGI2yy9WLvtNxbnAd1KKwDAjJ5IJY3O/REGWA3NksXWEbmbaZnaGGr4Qx+glfsIssJIevVKBvgQl6ohyNhbZ/yAg9+4orhsyaqgauKEB0ZHLhH8kafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnZuKG/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC09FC2BD10;
	Thu, 23 May 2024 20:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716494569;
	bh=oKg/CE/t5mVRloCdW3LYl6Wb6OvND2d2m7eLdYwDksg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OnZuKG/jp6ER7sHdxhIFd95EFRqFsOA1ZBx8cRTGtHSVz8BKwAyeDzdc5eO75z/2o
	 DQO9DzCKxPmBic+iYWdW6kOQg5pPAx257P8goI8uTZCJo+XPtN9DZlTTHIqqwDdtj4
	 iiw1PjUvHKLgGE5XuFX+aZmSWEeA8UD8OF+80NpT3+pNOO9XRGsvfv4aYXEaXY0XBC
	 fdux62aAn6XXQbdo8D/4uo3e6cfeTyKK6s9TUhmX0dD77rLVCHnJQgk62nP224wxRv
	 sBxoCJa+CpJs46ubsA5kmyHoYG8N7OYBzhkC2wqOslCyyjqtqymjVFd6WlLmjScgr/
	 YFh/k/iV7mbVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2003C43617;
	Thu, 23 May 2024 20:02:49 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/treewide: Remove second parameter of
 __assign_str()
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240523103204.7c50b070@gandalf.local.home>
References: <20240523103204.7c50b070@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240523103204.7c50b070@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-assign-str-v6.10
X-PR-Tracked-Commit-Id: 2c92ca849fcc6ee7d0c358e9959abc9f58661aea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6a326d694e77fd1d90ae40ad3c73a6af0eb1b8d
Message-Id: <171649456978.26887.11003166543235930589.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 20:02:49 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 10:32:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-assign-str-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6a326d694e77fd1d90ae40ad3c73a6af0eb1b8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

