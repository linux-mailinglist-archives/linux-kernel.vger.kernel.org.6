Return-Path: <linux-kernel+bounces-574624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C2A6E7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6433BA85E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97618DB36;
	Tue, 25 Mar 2025 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCbkvVtA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC47149E16
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863514; cv=none; b=R/StYhGS2z9xQtioM12HUuEDavEoZdCD++Oh04h7wfI76pc+5eqyBYQ3g7DYz3Zx346hXHFaFDGFg+WbpFcMM7RJnor3fZQfwwXVyVbWgFyazZGI8GNl1fHVIiucakqTEcBWXZPygdjkUvneQxW+BxUJg1EhebgjtsF0yrVLg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863514; c=relaxed/simple;
	bh=KhAdGUuGs0lk9/Jk8wd/fcrKz4B9uGkOCdO4asbOg50=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K2hMjGg5ZUdp2mWpIoNmfnDU6S0QdZFms0UwvsidFaLDvNHPznVwPXKrqZ9FSy2++bwrSPoPz40ieIX5h9tGfCTANBLKsm3Xyd4MoaVdh2xr+gyGLgoUCDVwbhKlBsNXMqyAs24diSYTJvFeSBNnIaFjDxQFpZO3/ftal3os4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCbkvVtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD26C4CEE4;
	Tue, 25 Mar 2025 00:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863514;
	bh=KhAdGUuGs0lk9/Jk8wd/fcrKz4B9uGkOCdO4asbOg50=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CCbkvVtALMnFN18EYblMe4MAev2KPY6kNIPoZFiCnbVjJHMo8Q3Y4PSuG7Fd+LyAN
	 BnNN4XybymvtVgifuBZFW6z23f7k9YlgqXVl4Gr4vYJWksxIbZBm8/ehESyR2kpkff
	 ieMnzwwjj2Lm0B8Ss/MxUzWxHDOpVtFWUCFHb/au+uOJrKoWGJ6N/M/6Az9QY2tQeY
	 kHbS6s/bhVJkYd5JulOZ276gLR1VQ7E/dg0bAnk9JoabcyH4vdUlvOSKhlajKJpD7d
	 BJuahFM3r5XHD98YCVyYnWdCiYZORHoQ/b4UHJnYQ7I0iHUSvs7NucyTNL1RdVpw+A
	 zZhroitHDfwCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B7C380664F;
	Tue, 25 Mar 2025 00:45:51 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z999bMA5tftvV28a@slm.duckdns.org>
References: <Z999bMA5tftvV28a@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z999bMA5tftvV28a@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.15
X-PR-Tracked-Commit-Id: e4855fc90e52efef7e3926205c8dc53ce39b6138
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcb044256d3f5d9f5bb61d1eac6492f77883bd60
Message-Id: <174286354991.36585.16490071332003105018.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:49 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 17:18:04 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcb044256d3f5d9f5bb61d1eac6492f77883bd60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

