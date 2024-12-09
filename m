Return-Path: <linux-kernel+bounces-438201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3A59E9E2D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B1C163D4D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC2175D2D;
	Mon,  9 Dec 2024 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWdWoOFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5F7080B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769500; cv=none; b=nYWUqHFIkt+MKUMDMHmkj9vPtfOaDgoYYrlv3V9J2P/E0J60r6v6BzQeCgS/EZc0uV6EhfHBFrt5BUUe+dwhwn5MnYz3a2Yyb6+Ykyb95Xqz4j0Pxw2z5EO0y2OkIM7cIqcCbgU8fRCtfvy9CIM8xTlSrFHL38Lo7/VGeEc2i0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769500; c=relaxed/simple;
	bh=9RWfczj3XL0AgQTYSOVsbgWWUCqAtAOVi6U3a9CT+pg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dEPEUtRCHSjSPnuEPUmtiNUiM3YQ3eQ8jAzEuY1djBg3hxgMrVPJg1FUFQDacce1FvEW+WXHWaiEQif4RkFAuU9+3Eh83xtca4LlkAe7Lzw5fUYDXGVXFfbBdeWMo5H4vOcFDNYT1IL7+Mt3NbjXOHvK5CTi5rPKr7UPxzjtGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWdWoOFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0E2C4CED1;
	Mon,  9 Dec 2024 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733769499;
	bh=9RWfczj3XL0AgQTYSOVsbgWWUCqAtAOVi6U3a9CT+pg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XWdWoOFxdqxcE4zjtq+VD3ephW1sweWo4w4umDx2gc1JlpeZaTxo6nMSUn0eUa/57
	 YRy+BxFqmoVpj37ifp76GNkHC5BpF2FdhWjctn+OcQBTcb7rQMZswzU/r9/IWFnLcs
	 BAG6RyGzsbqjEXg9F/FJ9qCmhokkdd03VsYVmDzolSuU1qFGYR+bb5wgq+mYGc2yjQ
	 HhhzBRRI8wEVCoBk0fqCUAgjCxSqAgP8Q/MniEFQbJQWyvpT6zLSvymDD0CFrLFW4+
	 6Flq1ucRLaoUtm31tBCIDpmH2GlKaJRScS6/ppdrjhXpmsGaNx86m5QW6NodPwinuR
	 pz9vjv7NqdiYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3403E380A95E;
	Mon,  9 Dec 2024 18:38:36 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
References: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.13_rc3
X-PR-Tracked-Commit-Id: 82f9cc094975240885c93effbca7f4603f5de1bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df9e2102de839c587eb50b2a5d1d19b07a6caaf5
Message-Id: <173376951487.149590.4646236202029322876.pr-tracker-bot@kernel.org>
Date: Mon, 09 Dec 2024 18:38:34 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Dec 2024 10:48:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.13_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df9e2102de839c587eb50b2a5d1d19b07a6caaf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

