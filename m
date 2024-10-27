Return-Path: <linux-kernel+bounces-383752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFE9B1FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341672816C4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9BB17A924;
	Sun, 27 Oct 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK50duMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF697E110
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055815; cv=none; b=MKR0Vld0bCMLb3wGd9NGxQlLGEHnzPemsbDlLR1cmk6c6HT+8t3fIbFU6MpbqIcWMeuJGxsaaHLWabCwYDWmxNCwEJ81Nuw2mYb6Jmo/eivkMciu2SRiSy6k4nIjY/8p/VEd4/6Dq6UMKVRLb1kTdITSV6pQZgiRngSRWGaIC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055815; c=relaxed/simple;
	bh=hhUh4j0UnfSnmGm69NIJoqxt/ncH7tuHx06Xw+0C10U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PVjpOxf6G5yO6+RenVpoGe3hUcyEt3cMPDSeGFXLFoi2qVcck4gRNWcdc467aHClQG7yj/DtiU+cMD6QpjOcr+j19YezKjViit9gS1sPzVkxUjV1nF1kiPNcWMLsIaHW0cC0gWBjUOiiSLIk3OrU9jTL4iBDt97tetT5EjXk45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK50duMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DC3C4CEC3;
	Sun, 27 Oct 2024 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730055815;
	bh=hhUh4j0UnfSnmGm69NIJoqxt/ncH7tuHx06Xw+0C10U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sK50duMctADBv2+3bSvKvh/Zor2Ey7azJSkDTdh2QGkKiQI3AfxS/orxpCxy0HuRD
	 eTaR4+5/i+XEuti9EcK67eA5qe9TrmXboI6gJLKZ0GlCZ8x1mvcYEfpEkOFsRX5W29
	 L6L5kZUC05PtgScO95H5OUIK8nmknwyo/cQaW6gGe9xcUCNnaibHeVohrjPLGE5nmv
	 dkLkdRdK6t2LCfFXHshYJGG7rlT4GmaSaGV0l4eLSRjGimQ7ZnwtVbQeGgGtuutzHh
	 0ukzDUWB+9srj52kj6pbe7CrqQ7RND9h4FDP0OE9XDggVQx4rOmR9V+HCfG9MVndZU
	 5G1+/aGrdhr8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFBE3809A8A;
	Sun, 27 Oct 2024 19:03:43 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241027105741.GAZx4cpWYuun5QaU8K@fat_crate.local>
References: <20241027105741.GAZx4cpWYuun5QaU8K@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241027105741.GAZx4cpWYuun5QaU8K@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12_rc5
X-PR-Tracked-Commit-Id: 88a921aa3c6b006160d6a46a231b8b32227e8196
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1fda89f5b23734e10c62762990120d5ae23c43
Message-Id: <173005582232.3431633.17935168800578883034.pr-tracker-bot@kernel.org>
Date: Sun, 27 Oct 2024 19:03:42 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 27 Oct 2024 11:57:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1fda89f5b23734e10c62762990120d5ae23c43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

