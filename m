Return-Path: <linux-kernel+bounces-374944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0B9A724A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81430B23187
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4371FA27D;
	Mon, 21 Oct 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL//4TkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5661FA274
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535257; cv=none; b=tJ+1yXe3fq3zVTyQ9kADdDg4pYI80QGUaH876EZchU6lTLvgu0VL7Ojn0Kpo1T5yUT2YctCKiSAlcGNtFpfUY8OG+Tpl73oCuR5zdTSpbX9sVKL+3FYuA6/7TTWMpN2CczT1yMYLbVN91a9Z8V070qE7os37puM+cXCkH9duxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535257; c=relaxed/simple;
	bh=8AAw+Mmuhbsvo80+NODCaVjv2c0MTkp1/O5eE10j9V0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TDkY9TQ1CRvcXou2rOXtGiXEpITJ7UIso75KY29MgSgCWGVgAFw/owrj9+b2L1oKZwTCXUfGqMzFAneKAa+kfmKntO4ZQdxkFlOk95iCtpHFDUKjqooqrlMkmVaAGtrijSZbKaTlqAWo228d7cdtmrl36bKh4u0/x03pw0YREZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL//4TkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E177C4CEC3;
	Mon, 21 Oct 2024 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729535257;
	bh=8AAw+Mmuhbsvo80+NODCaVjv2c0MTkp1/O5eE10j9V0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WL//4TkYu9WL9sc0tIANauRGEQUGAhEfXOxvllyQf6zr6GNyVTnG4Ppe4jwiynXTq
	 89gf76sabk+e7JKWFx2P+USQE7SjM1YeFDSUdmfNlksh/3psbKi7sSVGyat9lQTxAZ
	 cxZZqOWoz0J9yFDNX7vY1iQfVyZAhJCOr+HZHS7mI+xPDb5thZmVw02bG1pLv7zuEX
	 HQkWL6vZ033DyWuEmfPYJQaeF2/TWshZ7v+Pge0X1+SU9YSjS2SlIHopZOj0QvgTrp
	 cQMOR6zUQNThV9Z7pabIQLYxW3OYa++P8fSouud1AEgX2jRW56srLq0W/yUD0+l2Ba
	 aWO74LGB87NGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7143C3809A8A;
	Mon, 21 Oct 2024 18:27:44 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241021235534.e5e55cffca4113ff0081e99b@kernel.org>
References: <20241021235534.e5e55cffca4113ff0081e99b@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241021235534.e5e55cffca4113ff0081e99b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.12-rc4
X-PR-Tracked-Commit-Id: 373b9338c9722a368925d83bc622c596896b328e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1bc09d7bfcbe90c6df3a630ec1fb0fcd4799236
Message-Id: <172953526324.401524.17046928838832439511.pr-tracker-bot@kernel.org>
Date: Mon, 21 Oct 2024 18:27:43 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Qiao Ma <mqaio@linux.alibaba.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 21 Oct 2024 23:55:34 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1bc09d7bfcbe90c6df3a630ec1fb0fcd4799236

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

