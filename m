Return-Path: <linux-kernel+bounces-273936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9DC946FE4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6111C209E9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05113A244;
	Sun,  4 Aug 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEmdMGDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE41386D7
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790460; cv=none; b=hXymVjbkix/edMgKvCWXBZI2J0IjnwXjo7NHR+1LZIh0Elc3NvFfILjTkwmnoBpVdkcvNigHHOg06PzIi0iHpWNQnJcv16GT0yRccY8LyRBFlsWuMsexQCo1/F6XMprWpgiOBSibg4MZF2jauxTJWTdVI3/R+zQsxZZ2UJ52ARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790460; c=relaxed/simple;
	bh=MFGn9/chjTtNlaDsVVCOECMN4S9AN12oLVjVzKRI1Us=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JfWO41XZUxw2QUXDhpUY8b/o14jrmfModyJDZHo0cDRvr3OPdB8as2dmEVEfBnFEDQDvEOS0spwImUvH4J5YYpd18pqRKOIYRAREL8xY+8+ZyTLXa32BAAb5DZUWDUV/ceO87P43oFt8XCwlqBQtdBqqmkCuDzmJ9tQzswX9EsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEmdMGDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC15C4AF13;
	Sun,  4 Aug 2024 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722790459;
	bh=MFGn9/chjTtNlaDsVVCOECMN4S9AN12oLVjVzKRI1Us=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tEmdMGDGC3qH2scWqP75z4C6jDbzRMSvBszwdI8LCILLnWVtZEXCCDNLrdSGYgobe
	 EXUBm78pXS0pEEdYivvNx6M+D2ol1jUmQNXicmJ3MTcs7olsFqmEcUQ0dSG9XbUWe+
	 zUwlZXKewzOPXKHHTEC1PfZjBX1S0SLRkrBoFHGH2Cg+ykWzJ0dUnmtWpkLc1PTmu7
	 BQIBRb8E61EEl9HeUJCqSIgAuPMfdCry61Xw/k2+TGuOjWmCwENZWKDSlcuxh+4f/8
	 DsOBsAYSWR3Oc80RCR9eoG0Fm4/zZarT5gso64I6g1RqC4nvBagEF8fB+NUyomazXM
	 h0JbqDRTWzARA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A57DC4332C;
	Sun,  4 Aug 2024 16:54:19 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <172277654327.866296.9693656850505128683.tglx@xen13>
References: <172277654174.866296.10517632866315552419.tglx@xen13> <172277654327.866296.9693656850505128683.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172277654327.866296.9693656850505128683.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-08-04
X-PR-Tracked-Commit-Id: 224fa3552029a3d14bec7acf72ded8171d551b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bc70ad12097c19cd6c687bc5b12c31da14b63f7
Message-Id: <172279045942.9825.11152893206428580081.pr-tracker-bot@kernel.org>
Date: Sun, 04 Aug 2024 16:54:19 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  4 Aug 2024 15:02:53 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bc70ad12097c19cd6c687bc5b12c31da14b63f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

