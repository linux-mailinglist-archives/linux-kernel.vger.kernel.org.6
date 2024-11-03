Return-Path: <linux-kernel+bounces-393915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2CB9BA767
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BE2281F4A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8558C18B49D;
	Sun,  3 Nov 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8YSkwGi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252218B486
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658563; cv=none; b=FCXMwMcqt0o1mGOrQr64XoBWtVs51BafEZGUWhqiIH4gF+yrDm1OLvlN7O+NYMuHm3jl0dbv2vHGdaxV1rdpkJ02cxGhpx3JWXogXu05itujHvHssaHljWB8mT7p3hjm/JQ3qZ0jc0laLaEkNSIrOwOHMF95EY4x52n2cuiC5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658563; c=relaxed/simple;
	bh=j8F0xvU+aSc0k8h7H0Hfh5lhRwrDTQ5027L+BNmMtSI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IeJh/xysNiqmNjzmScP1CB86dqmCk7KBzPw5bYg57zt1MPg9tztzHB4TVod5Xm5840PTn9I+NJ3eQq6ISVBtEj8YjWwmJPYHaU6eMrkTEwFCodr169qBeG4jpUTSmjkB90rc1Fp69N2fS7ZHuCnFRYvCuAasKZUr/UCYu5lwM6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8YSkwGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AEAC4CECD;
	Sun,  3 Nov 2024 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730658562;
	bh=j8F0xvU+aSc0k8h7H0Hfh5lhRwrDTQ5027L+BNmMtSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R8YSkwGiuApHCYNz62zbIQCG6QY7jI7OT24hxSUTPy/sN6b7ORvX5kWLsX/CaGF4d
	 R0BC+7zq9+/XzUqXIZ1nv7XD+HLU0Ss9T/lPpR2qggPI4tqZvVRxOxJtpvU4136Ra7
	 vkcrd+B4/hoRTZUi5LtCQR13JthlJHFS8wjpDoczPj93MU7pVXAnEll7gkPB51Wn27
	 8rh5O29bqIUpM/comAPBVMyMpCPwwOOfAuZ9uKyPJnNIHlX7ugGghRy0bRl+hFmUir
	 cgXxhV2z08oGm+Z4iXH993c5+lYPnFMRwd3qDgbNZH9zHdufubEJGTdl63wHzQm0Ly
	 K17900WQLEQhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3A38363C3;
	Sun,  3 Nov 2024 18:29:32 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <173062983173.1467946.7303190211154698526.tglx@xen13>
References: <173062982864.1467946.2540622433845043721.tglx@xen13> <173062983173.1467946.7303190211154698526.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173062983173.1467946.7303190211154698526.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-11-03
X-PR-Tracked-Commit-Id: 69d5e722be949a1e2409c3f2865ba6020c279db6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33e83ffe4c57132c73b7d3fb7919006c5296c496
Message-Id: <173065857079.3226528.8459134675274461100.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 18:29:30 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  3 Nov 2024 11:31:02 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33e83ffe4c57132c73b7d3fb7919006c5296c496

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

