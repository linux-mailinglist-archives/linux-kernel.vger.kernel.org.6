Return-Path: <linux-kernel+bounces-226246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F8913C04
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99FB1F227A2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2991836ED;
	Sun, 23 Jun 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN/orPvM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF01836CB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155601; cv=none; b=H//M8cf6EYVXpo1MnZbHPMkGVrLEO/1y5xLiOio02yvE6vJYBllZPIgZeHCboUFCKiYK05y+Xrkgwdiqzpla9I1E2bA+pfA+vGMQH6qSYdCIP54ngtmqcIzgeCIFLsjS90Bzvpy5T5AVfJDztljhocsHVowZ8GcS3OONUTlIMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155601; c=relaxed/simple;
	bh=nZvyJQtxUOPSaXDm4Z9HFDJIVb8+fYS2zr3rvAFEea0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r1h6llUGKrxSUJ0FVK1cp4DU3CBRJ7dZrqZyGaFCidHT18CmaCnha5PcJPngS2DCvn4YTogP1J44c9PgpMQqW0Ue1TMIi0FdXyJ0ZWEs9h5EuWpZVCoytGPPkUyYbgXkZutDj/h3XPIx0OVOZk+t4z05r3GvpHm/ts9Waa19afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN/orPvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 197CBC4AF0A;
	Sun, 23 Jun 2024 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719155601;
	bh=nZvyJQtxUOPSaXDm4Z9HFDJIVb8+fYS2zr3rvAFEea0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lN/orPvMmxZJCPfXYDZuhG/4yXclOj6RSLKNntkTpjd/0OOMFktuzfopE7IX1wY7B
	 /E1KxXeRE2WfpXsPTuSr56V3aHk8VbYZ3IVd5FCf2s2qu0dyP4zpYEUeuym+o4GJur
	 0lr6IBO2nTqoqnKSTEkODAXS0USncfg65Cb3CnhizYTiFWp0Ik1Fgm33ogIQu1a351
	 aveYjsvaCD2x3Hp5iipHXCEevxXnYVKVXSjCrp4XT5KgWUA1+uGzg5Bz5XdrE4Tdnk
	 ivM5zyifrwOBEgYWXoDHyCaN6GY+652PziX7Pk4N6ZJcmZrNxELQOVCKMhXXe2ZVX5
	 w2UkP3Zj6HYSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C956C43140;
	Sun, 23 Jun 2024 15:13:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240623082310.GAZnfbbi9ZV1nEpkpE@fat_crate.local>
References: <20240623082310.GAZnfbbi9ZV1nEpkpE@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240623082310.GAZnfbbi9ZV1nEpkpE@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.10_rc5
X-PR-Tracked-Commit-Id: 739c9765793e5794578a64aab293c58607f1826a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9e6612d61de48dce0d838333b7a27583e0f5e2c
Message-Id: <171915560104.3671.17772557021090668794.pr-tracker-bot@kernel.org>
Date: Sun, 23 Jun 2024 15:13:21 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Jun 2024 10:23:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.10_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9e6612d61de48dce0d838333b7a27583e0f5e2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

