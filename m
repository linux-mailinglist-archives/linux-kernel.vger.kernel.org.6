Return-Path: <linux-kernel+bounces-574750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BFA6E97A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77136189618C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD62517B3;
	Tue, 25 Mar 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4b2wDFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D625333F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882851; cv=none; b=pkZFmAIKF6+EBebce8ped0l8x3ktQE1+W+kHDtpuYL/tvCMoig8+LWqB/pnofpbOa2xEpeOmVtylIDuIsnrskMXIfNSohmbEwV+ENqNbf14mkG6O/TNElDlyfPFm8tGVMHE97Z0xKMQHsCxmeO8aaeV3UbD1EtDoG+BiQbsMiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882851; c=relaxed/simple;
	bh=1p6GcG7sl+4kOW8ib9g+B8NAzNXsYqIPl/rI8wWkO1U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rmpRHANKfPPATHRjO2TDzWQCnj/w4ad7pVNZf8tzgSfGzNCXsItP80IlAziGvy8NsoCdfMGu2+C7edYNPeURgBOMyr7/nUhF1/BhXL2K0xpIfvqkYe2zz/hpP+fzMf5RhNVnFUJ2J9q/IApEA1E4clhz1nfyPYCNvuSjfeW9I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4b2wDFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9FEC4CEEA;
	Tue, 25 Mar 2025 06:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742882851;
	bh=1p6GcG7sl+4kOW8ib9g+B8NAzNXsYqIPl/rI8wWkO1U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h4b2wDFRwLtjmnuGJCjixidbX4iyToVFqbWl4vlLrqB0L6cFZgy5djEwXSj0m5/Xp
	 SlRdELfibizcS/paJY+tBvZwLsdkJMLPnVJ1iwtAPxJJXGJdM+W6XbvQBCjb9xx3vx
	 uxZh9u8ilss7PhevjY1pJXe2Qo2gnOyMwDYDzSne2S8JVdtl8TaJHDmpOYx+pq99vV
	 pmvLSG4LklgoBX1FeOdaLy9l8lwSvZwkYGGcVQKZ73sC4Pnm7X22dXFCvWH0b1vqy3
	 4ZHChVIKTfDTLf1Ej2nRikZuEUMpo2ztb/mUDGwU4IR0ZlwsVpS8MCbUCsSamPLtkt
	 2y+/US6Ibrw9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13C380DBCD;
	Tue, 25 Mar 2025 06:08:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96j9-AVdkmXKnId@gmail.com>
References: <Z96j9-AVdkmXKnId@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96j9-AVdkmXKnId@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2025-03-22
X-PR-Tracked-Commit-Id: ec73859d76db768da97ee799a91eb9c7d28974fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a49a879f0ac19ed0a562e220019741857b261551
Message-Id: <174288288745.109792.15726744943409074831.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 06:08:07 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 12:50:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a49a879f0ac19ed0a562e220019741857b261551

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

