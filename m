Return-Path: <linux-kernel+bounces-411195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37CF9CF474
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702721F2AA58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B41E1303;
	Fri, 15 Nov 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq733BX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1791E105A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697158; cv=none; b=mJ1eYPq6KecxFZcH84YyQ7xAhGTK760aQ9x6sx43bhq/W6GzueUTjErNLdGgnJNVljvjKZVNi9Ekbf9MNTQDArbTDPnUVg+gfB81xzt8FzBpCo9gfINoQnYUoHMYOPhDsBJvuEzQqDT42JuOfN2b7p8E4i0pQn8tolW7crYLMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697158; c=relaxed/simple;
	bh=3uX7BHrGL8pl+e/tNbQk7Rhg3vGVq9H1/aK8RFVh1jU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sk+2B2/RIGeFKHbJV2jm/2//nOGduTBg7Ym8wdJzehZOet1ju1mf8K2kcIgRPQ97rjhEWAsw1NkxKPA6sgaRFZGFklfKtui4x37TOtHrlHcSTfzYfz1D4ZxuVVl1dhwZI2VBlA70I1QwmtxqwRnEzbEudMMl3JmXOPtWKXbSdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq733BX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBFDC4CED0;
	Fri, 15 Nov 2024 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731697157;
	bh=3uX7BHrGL8pl+e/tNbQk7Rhg3vGVq9H1/aK8RFVh1jU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Iq733BX8EL4TtzMgpCiB2KXUed17bd/ArH5iSj1f+u5uHKsM7wGh1MZZ/AJ5YllHs
	 RNHMqiigUlCNehHaUdxT+wI5FM8JNPwJRU34e+v4KTyIeXD0E+njBjowNejl+zZgLN
	 Le1W6l2FsBk0bDHMgIzYNlHvREBBzg6cppR99TSp3V++IufZYUM9a8SvfH3VyfBcMU
	 hUcEhS938lO6YSjhd5OwVq3bBD4TAN+tklTtmmuugU+PGdmKWhgxR9kgYeKQz0NDb5
	 uNVntzMoUouSc9a200eu5F4ZLT8UtOiVIhuv/bW5cBJTOknYzsBU71qZH74QGRlp6r
	 af/e4vEG2kG9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8C3809A80;
	Fri, 15 Nov 2024 18:59:29 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: One more fix for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzanxsRGoDnxxa2x@slm.duckdns.org>
References: <ZzanxsRGoDnxxa2x@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzanxsRGoDnxxa2x@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc7-fixes-2
X-PR-Tracked-Commit-Id: a4af89cc50f3c1035c1e0dfb50948a23107f3e95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d79944b0948c3a5e80229606e36281d6ef746b21
Message-Id: <173169716809.2685462.1833837309174246633.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 18:59:28 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Nov 2024 15:45:42 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc7-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d79944b0948c3a5e80229606e36281d6ef746b21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

