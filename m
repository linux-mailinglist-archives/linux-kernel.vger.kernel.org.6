Return-Path: <linux-kernel+bounces-574728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C8A6E91D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B780188BA07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F21A8F60;
	Tue, 25 Mar 2025 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG5xAqs9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941C1A0BCF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878958; cv=none; b=tJyJhfVuCdS9WBi+TdC1d6UIEeaEG2EAWTP4nROuHh6nRMtg0aQeKqcNB/1isSDODaUiIw3YP1kfS1TXQozCQhz1BbDz6QlKEOX1sDpnleUfxovIin6XJC62zCsPEqKU021f+2UJe49498D0gQG2dSd6yB4fYOC4AtpDPRso1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878958; c=relaxed/simple;
	bh=BcQKa4z+4FB2ZK0Z4pCvHypZjwwuHqQUkIXhzVgXblE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BNt8foLB1MxBZVz8FK6BrJkso4+vXUzAca5S7qWMKg2vPhPvfNbuju4aLn7oMuznD/wFWLMJgcPIBN/57O33Xrqe4xt4ebKd9jX/KuaPknzDBLERAxj6fLkwiqStIJPyUWh4cpHyAGTkvDd82x5Vc+6kwATuk8AcEjKfEU4ObSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG5xAqs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A07FC4CEE8;
	Tue, 25 Mar 2025 05:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742878958;
	bh=BcQKa4z+4FB2ZK0Z4pCvHypZjwwuHqQUkIXhzVgXblE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XG5xAqs9LaHL+YdIV/n26ufDLj8IcMbNbVAF0Zos3zPJdgUfEPXQ3q+UeRqVUU77W
	 PazXVBIl4icbL3Zi7ZxEzDcHWVmrqCgz+o1hKiJe4nKiUyqWGA9Y3Y69I/togeXBPT
	 qZdxt/NIgCCwiFhKlMrwz4NUTy7wUXFQ8KT5gWUG0oGgYwXmGpDDA675pX63iOHE+z
	 v9OFZCtRBM/t++k2bXGewzSOxqzgMgRGq1zjkWDvIDfs1FxsXcNj0wYr/hpnPHxAuE
	 Gvnhs43ByRaPJtSWIfsusHZBn1+QujpcbaiyFxOb+kjs5dUNymH00Aj7PXNERPT1KU
	 83qRQ7NPq2Ivg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6F910380DBCD;
	Tue, 25 Mar 2025 05:03:15 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z95-jK9QGbkWivvI@gmail.com>
References: <Z95-jK9QGbkWivvI@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z95-jK9QGbkWivvI@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2025-03-22
X-PR-Tracked-Commit-Id: 2cbb20b008dba39893f0e296dc8ca312f40a9a0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a658afd468b0fb55bf5f45c9788ee8dc87ba463
Message-Id: <174287899394.94045.11148349233281217457.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 05:03:13 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 10:10:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a658afd468b0fb55bf5f45c9788ee8dc87ba463

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

