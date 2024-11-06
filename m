Return-Path: <linux-kernel+bounces-398702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D09BF4E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81859B249ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FCB20896A;
	Wed,  6 Nov 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7zWJqWL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2E208202
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916667; cv=none; b=GPuJbiV41gRpAFrB3d3RKrviUi8SLmcbl6PDIdjEM8yWcsTIWmfj+teBdY6gz9AvKgFR24kLUm0yXA5Z4NXjjYoL0IuSGedC7nR6LPo7V5o2u3IaNlkUFL1/WF+nRFwaY+pUkg5UZM0ATl9Sy25tVZ4HUzwaa4yTFAwcLI16FHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916667; c=relaxed/simple;
	bh=nuRc1sL37u4KY7U2F+QyA0UDO8DDl+x7q5G3kz5L34E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TccMjX5ClkcQXDXOpDuYatCRkD1jUkQ6RMFe+6xwQc09YUR224esfL/6y3QslbszRSNKMJIUMLVJU0Mcr6B4mCbXRboTws+Wf6Q5tttVtXuwSqbap4CeSRgPbze2sjt0WKAQObjDhgKv9noYaY/fEJyso7kxMCbQptzRPcplV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7zWJqWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E416BC4CED0;
	Wed,  6 Nov 2024 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730916667;
	bh=nuRc1sL37u4KY7U2F+QyA0UDO8DDl+x7q5G3kz5L34E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h7zWJqWLo46YSn9mftIiLWGqo1ar/kGsgu031ijRM3rtk+XGW6WWrpSA5Y5WknLbn
	 qeQT5EMMqvsDfezCQqbgi0i5wwFgtOL4FUu9Csacn56FtwbLBLUrDLCxmo9NZsLLCP
	 laVZh4zlHoE6jEZqEFOrfbAGV8x0IRNGZuDEkdmpN4AyLVyUpoRERFb6snWe9NeFkM
	 RxGfzVlq2MHO3DpETPLmzg8rQPDk3SSd3vakXAPaH6z4jC7FGs3UpXnoL8IR8udUIb
	 cdivshImVQIzqu0sNEUfvM0qUknXoB2+RnBmqco/0U8n2IJPPJcTcItDiehz/0NUFW
	 oS1Trm0QlKzEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F273809A80;
	Wed,  6 Nov 2024 18:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] tracefs: Fix regression of setting group permissions at
 boot
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241106122250.2667681b@gandalf.local.home>
References: <20241106122250.2667681b@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241106122250.2667681b@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git tracefs-v6.12-rc6
X-PR-Tracked-Commit-Id: 8b55572e51805184353ee7d587c720a51818fb82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7758b206117dab9894f0bcb8333f8e4731c5065a
Message-Id: <173091667586.1367622.2229899800927251751.pr-tracker-bot@kernel.org>
Date: Wed, 06 Nov 2024 18:11:15 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Kalesh Singh <kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Nov 2024 12:22:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git tracefs-v6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7758b206117dab9894f0bcb8333f8e4731c5065a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

