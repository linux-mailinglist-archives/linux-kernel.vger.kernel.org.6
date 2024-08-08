Return-Path: <linux-kernel+bounces-280126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8ED94C61D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CF51F21E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30215B149;
	Thu,  8 Aug 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjX9UV9B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312E15ADB1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150792; cv=none; b=CjmMIZxpFImJED9QnCrq8poYKg+unBgQmYkBTEs5uM6jBXe7fETlnBv82MClJDHYeHGnVLOehRfTER9shhjrNV79rCT4BIybeknp8knS/1uwNhjMS7h5izu4ELtl2nKW0xqW2cx51O/1fQkvh5lpsMdP7qEWJzly8UQZ3SLePCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150792; c=relaxed/simple;
	bh=Lhv5tJfS0Lf29+d+OG2c7oPaXtHXDiQrcS2YW2V4UNw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GI78PeeCu1YbiQYsZWdNlbcWvu199qx+LIdeWo1+M3o+NJTAUM9Ann4d9H+nJhQlveKV3vYxi+jKu7tr/Cd6LAViMDErB03CCJmK1UXT+jtfcKS91/xAsUWFW6kesEiUG5nT8jW+BK1hWaojka79JLqT2+yDaSdDcayEKulp85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjX9UV9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF121C4AF0E;
	Thu,  8 Aug 2024 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150791;
	bh=Lhv5tJfS0Lf29+d+OG2c7oPaXtHXDiQrcS2YW2V4UNw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TjX9UV9B6OoCIeKyRhiJF7KfBnLJTvVfN55s6XuuuHkrP8LkEODAjfMVny5eh2iZt
	 fJGDKzsJLWXWuuGZC+6AVoJD3KqMZr6ZRblx+9oOXca+flMTAq35wPX6R4juOLsMvr
	 k1jO2Yc5j3U+mggPgN0Ca76B/NFg8ZBExtrhAv9J/RP59ugGH8QrWdXhd54OvB+RNn
	 WSoc1UykcEQhpDA21F9JMHoWqh/PFIv8pGR6EsGh2eVPGVbcVw8gzuADMLTof7x3yM
	 cdVDUI8Zw1mRSUinPf8ryAfCKAxuEiUjtA7ghHSx7ZsTW9jaTwXbB/AkdvJTdLZbxD
	 vHsCs6G7n4nvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB65E3810938;
	Thu,  8 Aug 2024 20:59:51 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240808122108.6bf9b799@gandalf.local.home>
References: <20240808122108.6bf9b799@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240808122108.6bf9b799@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc2
X-PR-Tracked-Commit-Id: 0b6743bd60a56a701070b89fb80c327a44b7b3e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9466b6ae6befa87b27cc13ee7263e01b9c48efc0
Message-Id: <172315079044.3297575.10156205841503539507.pr-tracker-bot@kernel.org>
Date: Thu, 08 Aug 2024 20:59:50 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Jianhui Zhou <912460177@qq.com>, Mathias Krause <minipli@grsecurity.net>, Petr Pavlu <petr.pavlu@suse.com>, Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 8 Aug 2024 12:21:08 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9466b6ae6befa87b27cc13ee7263e01b9c48efc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

