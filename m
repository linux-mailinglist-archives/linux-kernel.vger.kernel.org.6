Return-Path: <linux-kernel+bounces-414944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71E9D2F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C75CB27107
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3FC1D3634;
	Tue, 19 Nov 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3SR3grP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899881D3566
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048522; cv=none; b=HcK7jiCpMDPhDQJcFql18dqlQYPqDQlfaQD9PZthm/1Gvm6M3RdzCtJRbZ9E/G0NWZruA27teFNHN1fwnESGNyeYptusT06pKz66vr3Ff7bb7M8b8uqEsKKA2Hb+QuCxF33/kvye/vFQz1LPAzYQ9atDW54wtkKYj4j6E8Tky/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048522; c=relaxed/simple;
	bh=3h0t1tr6YRoEyY+obzReAExjjjk5C0OWcaz9SqSWtWU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E9k7rVxg7P7t3SuykTD6Ec/tEfQk+arL52+Jj9aLXCYzuz/eCeF7Yd8/E2JsN5fbqOoo81lYlxOUZBZuGXE1OrYWCXVvCpPYwOG7GCMcEujNd6OTv3u9kCZbWPg+ZAVGtCAQyEo04Waet2zg0z0UzqdrIhUo9FHjqmfYxFzkUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3SR3grP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6728DC4CECF;
	Tue, 19 Nov 2024 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048522;
	bh=3h0t1tr6YRoEyY+obzReAExjjjk5C0OWcaz9SqSWtWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U3SR3grPSd7wup0ps9xBBZxC3dL+in0YONrbsdDPF5ASM6IbAvPZLBOuqr5ucPaKx
	 4ZC8ZK7g//UUeceKsZjAig4VyCXJjn4U2m9k1gqdLnyJ2JlkaFyKf4n0BT57K4/YCx
	 Qmc050tVTr1scmlnZe4Wphk611TBQFHlcTprI3VPw97zl63XTwdr4aAFxxZ+XXGjvr
	 r7KeUwBg5RAIQ7dF3bHw6hsEcaFo2737ZUq+KJJwDhTjFCUb4Np3nKYZEHvksYPUOK
	 /ap3Z4ogCLKhI912ZjAc6Kqr38FufpcuWpaURlM/tg5QLSssuScc2PIFw1Kn44mIJh
	 zGDjXAJFPqpQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE13809A80;
	Tue, 19 Nov 2024 20:35:35 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118130110.GAZzs6lqpsvuNu9vvz@fat_crate.local>
References: <20241118130110.GAZzs6lqpsvuNu9vvz@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118130110.GAZzs6lqpsvuNu9vvz@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.13
X-PR-Tracked-Commit-Id: 612c2addff367ee461dc99ffca2bc786f105d2ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1f2ffe207a23b52d58923b1b34c2fd3d1b30494
Message-Id: <173204853379.680579.18036227447877939648.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 20:35:33 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 14:01:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1f2ffe207a23b52d58923b1b34c2fd3d1b30494

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

