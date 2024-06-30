Return-Path: <linux-kernel+bounces-235261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC6291D283
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0597B1F2139E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93E1552E2;
	Sun, 30 Jun 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/XEU+WK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F820153BE3
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719762363; cv=none; b=u6NNfjSHGP2Xl5CvsH0uIzUaUXP5xKdhVFTgcZPVRx4qGqcF0d9D58k42EwL997YQpqHANht9TjTsaUxQap1FdSEsORit4NBEs8e06hGBjvGENrC0wBYpwPSeT0zutT55ykWoKWmZcP3MnFmH9ypNaro4ViHNiWoJ3EgQLho1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719762363; c=relaxed/simple;
	bh=r0V4YGx3aV6xyGcZAzMSf+QYnOk/BPBUDekGetk+gKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TZZ8+L1knxp6bEz5KgF9k0yz9s3QCL3retgmsoba2OOdNSEhhKRsYI+Kyiuqlv6vE3rCDTElNkENq/Jt97RTpblzQZI+M1Q92JCQo5gZpRN9hzACkkwVRqKuv8MhWerVXWuHjmYUZ+yFdG4v8wMTyCD8MW8XejCU3VzCEZCdhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/XEU+WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 312A3C4AF0A;
	Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719762363;
	bh=r0V4YGx3aV6xyGcZAzMSf+QYnOk/BPBUDekGetk+gKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c/XEU+WKVZksfO2MIEoMk/NSY4hhb5F3Xv3GTbCJNFKanOdwx/Fd2RreyX8j7sr+Y
	 FHvz5TO+AirsfWviSxT9+qQAkdag/Cz33rgG65NAYOc51rozODVLlYmvQsFK5jyVoK
	 2XhDgzeZ0uEuo/IxGYYGAvvXRFwCHkIRw8zpvUmvvnyjR7uJT/xbSwgiGlDRSTHOjH
	 EyZx6zb2SNRPHrjdTlW7x+qT6s0eM/WnvnfQkageVuLHGPi1nd0XOT/Wyx8HGCzIaR
	 XTnHblDpnuDJY3MVV/aoI9AQkbKi561xA4OIg98VfxnTBfRsmDD9aV1CIqwYRBEn05
	 CTfENCsf36zJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C9BC433A2;
	Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240630082512.GAZoEWaIpE4ma790Gd@fat_crate.local>
References: <20240630082512.GAZoEWaIpE4ma790Gd@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240630082512.GAZoEWaIpE4ma790Gd@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.10_rc6
X-PR-Tracked-Commit-Id: 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e41216009143efa48dcf11bc096d4f8ee1c0f12
Message-Id: <171976236309.1786.15713562377791592754.pr-tracker-bot@kernel.org>
Date: Sun, 30 Jun 2024 15:46:03 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Jun 2024 10:25:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.10_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e41216009143efa48dcf11bc096d4f8ee1c0f12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

