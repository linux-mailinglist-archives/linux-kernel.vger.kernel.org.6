Return-Path: <linux-kernel+bounces-331756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA497B0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762E31C23E19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE8188A25;
	Tue, 17 Sep 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNKFB0rH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715018B49A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580400; cv=none; b=a3u1CNcmtwjGMV9jnMbSpJo4YpUAzNAogQLcsVnH/pdad5KuQy8jaLp/RahmigwKhKC5fAxpa8SUFa1/d7Mzzhn8sTIVgX+CZIbLY0ltGBxLzrURvvcleSq3+JAw/nlZkmROJNoZCnvM3pTw4tQjhZxcRoGJHb8pkIZK/ekT2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580400; c=relaxed/simple;
	bh=3z7OuCNIFdMhDKO6GUbYhzHzOyd/wszFVm3Wy6KCuzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ehBIh4+FANegk9T1KZwYAZW/XGw+2BzuDdckODFumUJ4F+4PmxX1eym5E2VUcaH+hWGBJqklLM9NdU5f1D6v+ac5CZ4/v25yYHg00EEOctKCaInjKB6BxgK/AEnx8RAC196lskLT/qFFBqjOtVWXdBj+f/uOlGL8CYehWC98tEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNKFB0rH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43765C4CEC5;
	Tue, 17 Sep 2024 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580399;
	bh=3z7OuCNIFdMhDKO6GUbYhzHzOyd/wszFVm3Wy6KCuzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LNKFB0rHbJVkLryDXDNkbISKNV/9FOeY/+DLbbvKcTZ6nPMJO0hXfLyiLrkCgKj5E
	 Vf5qSWKleJYPP3zQ632pr6wsjypk0GAw3Gzz9BOb7YwT2DyY+sqcpaCU785N2GMLL3
	 pal9Lz4MSfupaj7kEmWf08sXLjZ0LgxiYF1EeUJUPATuiaOh36rc4Ttysw8L2qbhNS
	 I1MW19utxqHelzjY5S0Nna1m7REz3Wnps0lB7OAW9RzdJOJqaPKkX2RbIA1zPxw5Qh
	 cBnPJlHR3+JnuDgC8MGkbm4aMftuz0ttJn+nFa0R6Hh3m8lTEimbQ9p2Sd2FxOloDf
	 TQdJbQPsuU2Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348443809A80;
	Tue, 17 Sep 2024 13:40:02 +0000 (UTC)
Subject: Re: [GIT pull] x86/fred for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656198906.2471820.7237893424649453751.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656198906.2471820.7237893424649453751.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656198906.2471820.7237893424649453751.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fred-2024-09-17
X-PR-Tracked-Commit-Id: fe85ee391966c4cf3bfe1c405314e894c951f521
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b136021126b99072da705f693a8be07c6285e47c
Message-Id: <172658040072.145065.4828864636776098280.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:40:00 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fred-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b136021126b99072da705f693a8be07c6285e47c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

