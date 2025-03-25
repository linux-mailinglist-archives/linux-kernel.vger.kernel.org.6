Return-Path: <linux-kernel+bounces-574748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB8A6E97D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8243A1256
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AD12528F5;
	Tue, 25 Mar 2025 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtboSrP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1825C2528E3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882848; cv=none; b=t+hX3M/oIhZXp3uU+22ruap1jD6fv3BPzeENNiqDUpDtAC8zD/UJguUwDlJsbJ8KUSy/LNvbyVHaL4qAzGmLgMXgYPFi2ppb3ogxBqSgwIO2M8PXeyJRgfxAVIWUC0967VdFVWCjqACkn5Dg/usBWqX8wRf0sz+S4sv4WatMipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882848; c=relaxed/simple;
	bh=Vf714o4bnFBKz4rlWW6FzKeFafpPcO+2hCxe5NQbCBA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l5jQvl9aGT0Ecj84jPVhFkrbmCVp7nrB1uDpLOt5oYnTwpWNcttd0OAgV5VQxKB1XHd100BqaoCUYqpHf2e1OshjI1YTGIz0ry7UdI1y8sfKPvKo2zOJPkehdhtzXW2DAfEQSp8hvTzSSNMCh2cFQD6XKLLmWIHpxJjt+F0oL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtboSrP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E728DC4CEE8;
	Tue, 25 Mar 2025 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742882848;
	bh=Vf714o4bnFBKz4rlWW6FzKeFafpPcO+2hCxe5NQbCBA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MtboSrP/yygeGJXRyY/4zAaT/0GUqE1Sha6jDt3cNe4zP7YVWqVZUvoZMPEXhbVSU
	 +4jjqdEGnRvuoiQ+G+PmdIUNAVqotujzthttnezhTshE132sYy2+ezlveK0tHwT+PH
	 nLIM2Q++oo7PfBDcsSDPfvhNO57aek6nHpI0VSVTjE6wBI/3fNFKRITdJPlxxrYCB0
	 qO8RMXwpQYlwOmqnHMN2DGrIcMbybkvHxt3Fs+4Uaoek2kU2rp5zef1LxLjbnI0g0H
	 MfQIQE0QZKixz6lMPA8EBWC5l17dbGCWBKf7PpysFpIu89cu/84WFbjZuCu3a/NN7a
	 0b/NEoKYvFBpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA2380DBCD;
	Tue, 25 Mar 2025 06:08:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96iDEs6-HZ7UVa8@gmail.com>
References: <Z96iDEs6-HZ7UVa8@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96iDEs6-HZ7UVa8@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2025-03-22
X-PR-Tracked-Commit-Id: b25eb5f5e419b81f124d5ba2abaaacf1948fb97e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b58386a9bd79222b69890141b9f9cb30a7423d8a
Message-Id: <174288288404.109792.12934477827590449918.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 06:08:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 12:42:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b58386a9bd79222b69890141b9f9cb30a7423d8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

