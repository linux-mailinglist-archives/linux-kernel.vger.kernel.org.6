Return-Path: <linux-kernel+bounces-288499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FF953ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B686C1F25B28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8757BB15;
	Thu, 15 Aug 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asxs1SxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133134545
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749910; cv=none; b=XYXZqIcQ0YeRUNvu3nTuoWGn3glavPEw+13HV9l/V6HHqoiJx4jORIq+nSBsKYy3MigM86u087587mCIXG/gU9I8grqVLF1mkrGGeGnns0OwjBh5xliMGV6Yc0KEKzdbBgPXqtlgBGpufaY3bISM1HmR3QZpu/ShPBUzO+7GTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749910; c=relaxed/simple;
	bh=HfP9LqrmwNUu42QlbUGBXUtH7y7a0zyGqWFcSAIFRRA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sWtsJSJV9z+/LrJj1DR9Cb2VL3Hgvm9vjn9o8dVHVKQlTxb1/n54PGzDqMRCRyCnrNKAjseFruMCZrsTosLwWGOa6yI34m/9oCqX5fYkIctjwUTi0sxZkZvtBYuQgmlv1Ezq2lHtHAttrJcYlpaSM3YgzkFwWbk0V6RrwaO9aKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asxs1SxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB3C32786;
	Thu, 15 Aug 2024 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723749909;
	bh=HfP9LqrmwNUu42QlbUGBXUtH7y7a0zyGqWFcSAIFRRA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=asxs1SxWaG/n/zgXE0KdNCD37MxxqG6eii8z428Mj2IcZ7W23RZhFUyZdzFH0oEHZ
	 TOOMtwE1OdKlp6ETPLJ2PvLL2mT9AiaPSoAAVUQGx7VXoURPsN8CbzXJL0cgMDhvg9
	 oK9WOg0e44jEo5QsA6aQNtg6PJN0wOsNBDR3u1h7C53PnfGpYR73yJxcw7jei5YlcY
	 uxJ6PXVXJPyUMjvSq7jbwJgGl9o/mpU6wHkq3o67niTV6ciIsZVgS251GwV1+YXE+1
	 PpMqywbD8WL7Q0RDbwO1bLx6kz1m2q0y9FO/IR4Ubrdi8MSjPCTbGLfLne3C9tAPsH
	 sopzSyAY8SPvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34292382327A;
	Thu, 15 Aug 2024 19:25:10 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <202408151107.18E1DC8CE4@keescook>
References: <202408151107.18E1DC8CE4@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202408151107.18E1DC8CE4@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.11-rc4
X-PR-Tracked-Commit-Id: fb6a421fb6153d97cf3058f9bd550b377b76a490
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e724918b3786252b985b0c2764c16a57d1937707
Message-Id: <172374990870.2990737.3187203142770805347.pr-tracker-bot@kernel.org>
Date: Thu, 15 Aug 2024 19:25:08 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Song Liu <song@kernel.org>, Thorsten Blum <thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Aug 2024 11:08:30 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e724918b3786252b985b0c2764c16a57d1937707

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

