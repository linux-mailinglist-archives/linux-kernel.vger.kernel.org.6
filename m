Return-Path: <linux-kernel+bounces-435712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF269E7B51
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E94618879F0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82915212FB5;
	Fri,  6 Dec 2024 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj8xPExI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A9212FAC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522456; cv=none; b=i/1Jdu6PZhcCaCWM2tETqZ+FyjGU7r3bqkCKmJwXD2IgS/HPdJ7qWqevhOfIqH/4hu2Se4LYoC8kKJUnxXcmtbmbUuzSpUNl/MlT8W5ZRScXgG4nC53TkDXnhmSbGPNHfCXFj2iUyEklHtpWIshXGHK9t5gCB5d04Hi03ZssygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522456; c=relaxed/simple;
	bh=t/6GEzQk8jo4ExFTy0KZr9Z+7vMsm9jKpU2nCTRdKZ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LkgdPtxGsZKizmuCvJvsJJNJLuj9g/iF+IKDufRiNsTJrAB0VAZXuLPL0t/8MKrf9zP/abVye1myLxhf33Y4VfdpoFCuNCnrgEAK2hcxrk+b0otHikSfTy9k89gqKryGipsb0YQkUxa51pxQnrBcA04Xfo06kjKjUnw1kIE0mDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj8xPExI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6217C4CED1;
	Fri,  6 Dec 2024 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733522456;
	bh=t/6GEzQk8jo4ExFTy0KZr9Z+7vMsm9jKpU2nCTRdKZ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mj8xPExIQ0lpSzBkPF6xTzhSVCWdwyUmwBDtbtvs/zZI+bl5PwCBnDwOmFb+4u2+U
	 m3SsN121xZLNkAgCjlxEg2wlPJXGCqAqYeCjZtMj6qMiym0O2aprd9ryxmwnAHgasS
	 miPRHjp5+6y8vUYdrRqCGnXMJB5UTFCf2X25waQLlheiR148dCMfVbzEHjoI52CA3z
	 EMlbfWvtdLuTKmHX9cLB0Pwd5OJvtZdW54WJEKmFuzDURjtGFb/Uo+TBFLcVCV/DNv
	 Lped7mNBehxciDz7hH18OArMYgpmd/jY+YjR/uxgSqxxO1dqI56nqlCwBW1ZYt62Jo
	 x921MXOsoPsNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC16E380A95C;
	Fri,  6 Dec 2024 22:01:12 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z1NCFeR4iBm5Bxqg@arm.com>
References: <Z1NCFeR4iBm5Bxqg@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Z1NCFeR4iBm5Bxqg@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: d60624f72d15862a96965b945f6ddfee9a1359e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3ddc438a29f78f0642bfcf84407c236a0b2bdc7
Message-Id: <173352247159.2810195.14014493447586884302.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 22:01:11 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Dec 2024 18:27:33 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3ddc438a29f78f0642bfcf84407c236a0b2bdc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

