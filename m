Return-Path: <linux-kernel+bounces-221542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FF590F52C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3812F281959
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08609156673;
	Wed, 19 Jun 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7U8PGUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB215625A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818434; cv=none; b=BH2+r9p4QAGs4nhGYUrbhG/FUJCUGU1a9IlyIVutkHkwsRXxD783Buw0x/GUHrHomNUJbDKTblqjDZIaQY4zk2DmRpb3REPGKSfqEweLCGMDYKjJLciCmlLfna8gziHLMWksX7DmkbEPal+IocLMJyfr/Ls7uYsAuSIdp35akYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818434; c=relaxed/simple;
	bh=fEZsIdrFC4uvZ6HrucSI6XY5KxbYHrStEpvlT3uZ/yQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TPmfIAbEG/Ca7F5zSCpBh4KUXUDwe8OHlZ10uHsW+cghXpceaqbszEjfkFeDbd/IdX5QA0jc8tC6NLkzsR6mN2Z7Z/uktkGCmAx4P6XVrxQz4PgC3NoDAFyXp9uGpTXrj86jR3fcsw7Mq00e/qr2058cItjBzpeO+cUY+5YcqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7U8PGUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28181C4AF0A;
	Wed, 19 Jun 2024 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818434;
	bh=fEZsIdrFC4uvZ6HrucSI6XY5KxbYHrStEpvlT3uZ/yQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I7U8PGUa8C0HnrGtS5e9P6B+1mTTAnY7C0uZkR/XMpC5mgw3tZdxIs/M9ef0anpHr
	 JjnCdNwcXOxmGujdWBNQd44+alIBw60Pc0mbkNfyXUB01e3QiJ9vKsXgp9j8CW2cSd
	 fiZPKMsrz01/033WyQAXhDJ5J1oJiSqoQKrf6rWGxboe95xNw8cuL1g/8hYu8KXXos
	 U8et9Rs0UJHigd2IEjPIMCR0rsMe9hs4lfS4zhV6Q8TlJUSxxMCyrC5rxdMyFhzaDo
	 t/wO176at7MIQYtPKG6FvpA45OJTKGRYD5ddFOV1DM3d2UM0E6E6QuY4Yp2xR8dEx4
	 Bd5mHim6pSJIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14F39CF3BB0;
	Wed, 19 Jun 2024 17:33:54 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240619232107.bbb51e397b9896454a2c66a3@kernel.org>
References: <20240619232107.bbb51e397b9896454a2c66a3@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240619232107.bbb51e397b9896454a2c66a3@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.10-rc4
X-PR-Tracked-Commit-Id: 3572bd5689b0812b161b40279e39ca5b66d73e88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5b3efbe1ab1793bb49ae07d56d0973267e65112
Message-Id: <171881843407.4952.6760418881633072656.pr-tracker-bot@kernel.org>
Date: Wed, 19 Jun 2024 17:33:54 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Jun 2024 23:21:07 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5b3efbe1ab1793bb49ae07d56d0973267e65112

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

