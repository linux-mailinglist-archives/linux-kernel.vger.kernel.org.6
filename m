Return-Path: <linux-kernel+bounces-418903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B5E9D6709
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7EF282D70
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABD1632D9;
	Sat, 23 Nov 2024 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpvvGg8R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603281AC8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325452; cv=none; b=dO+nrXCTEtXYjo7f3lU5+SJZlVx3Z39kKey6cAjZIPQ1KMt0TGe2KtOjl0GJwXljTwa8tQ+GjmFTnd5tc1tnyOpqsjilnFFBufiG1E72ls1zBQdk5Lh6y7yc/FBS0ykb9LZ62hV19ACTxn7DkVkTFYIvca/5CjLKhYvk8dJkfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325452; c=relaxed/simple;
	bh=zgW8j0LP9yFD1oIbyjAw6VreOa93pgOcwKcNi4+1Oi0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TOIXL60rremX/CRtJiHnAk0cftJwFD3aPR1xa3yABOzlzVAdus+y6yFVlOtnoTMQA9oBAlLysa7vQHIU5NKH7oREfF46p9ImWoDZymkoLJSXvatAayMD4Xu9dVV4obClavCFqfhzuco2kQYRwMEIs209TFEehYajH/jtDPli0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpvvGg8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04A0C4CED0;
	Sat, 23 Nov 2024 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732325451;
	bh=zgW8j0LP9yFD1oIbyjAw6VreOa93pgOcwKcNi4+1Oi0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JpvvGg8RwCbRQ1QIfqk7Qb3h7qkpjU4eZ1khvDOaEOMESZw1g/JqxujSJrvFLZEb4
	 pFofdZ+9gXVtB9Fd90jiWswfxTD4i+N9o5B0tB9EXKUX/YidCpunuFptJGTCSfd/FU
	 zh7w2pL2eIe6O/v/jhj2HDpQ1q7DfaLQf7yd60ei7yU/aQAFYfSQRi5pHPleskvOkV
	 MCyZkx1WsqGO2Sz8M/5IkReA78ciyzIkuQAgFFLoWSjpSEANEYsvMXk0WquSXX8Ewa
	 UHoIpG+MSQXJm5QQpQmX2M4NzFNuW2/9/4Mab1krwEq8WlgELHQBssJnF01j3TipSO
	 ihBJ8Sn1q0WdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7D3809A00;
	Sat, 23 Nov 2024 01:31:05 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241121124131.GB7052@google.com>
References: <20241121124131.GB7052@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241121124131.GB7052@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.13
X-PR-Tracked-Commit-Id: e8501858035b1f95468da525e7357c8c33811b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93251bdf7a771c4eeb0f95fa38ded92e95154ef7
Message-Id: <173232546385.2863978.15942482500077616439.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 01:31:03 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 12:41:31 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93251bdf7a771c4eeb0f95fa38ded92e95154ef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

