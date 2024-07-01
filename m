Return-Path: <linux-kernel+bounces-236686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A591E5C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D841B274B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A216DC1E;
	Mon,  1 Jul 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5xo4s4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14416EB5B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852587; cv=none; b=Q8ch77uShe9jfJ/i7RsvEzXZDyHuqBpRm+8WVgkcdtPJQwgXE7Re+Q0en4Osf0OjmwBYgYq3I728J2oQc4YPyTVsK3amN97SWnxgrlJYLzPq+okI80c40UYZUtgavlvquKiKiqZRSp1UzU5K/CjI3v3eMY3QDMGz1bBKpvzCg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852587; c=relaxed/simple;
	bh=O/Fx59KKWQq4w70OHI+2UVJgAFT9uV3AZwTLWCcQIDk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ur3wvjZHBr3KL7z2rZ+F4qQbyF1qvzQcQVuYaDXQ8dyaeXJzkhbtJKldt5QPZ3CJpykTFpmRkfzktaHlHydLRsdnBe32vAs1FZX/nPeDDAfnqX06mqo17Pqk0nbNZeRA/yqrc8Rn11Hkdd93Y/T/suu5x2BxBft/89E/hfoPnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5xo4s4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E38DC32781;
	Mon,  1 Jul 2024 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852586;
	bh=O/Fx59KKWQq4w70OHI+2UVJgAFT9uV3AZwTLWCcQIDk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b5xo4s4ubpV8v5JKDsZ7nSweOBtKpnSck5C8SUbX1Zgdeth1arvHl7b2ePdkvi4Pj
	 XEqmq5beM4l/GJa2BepyB/b+Z+yozogQndcmYx4O5kCSlAVOfmPDqNu0Zpwh6Pd2vB
	 FuMJmWU1a7XMi7+mDvrNe1XXod2y2QyS4MEcdYFKI/DMDM7hyE4rdg28YAHoZ4Bkhr
	 bz0Lts7Pnb1kqmyADjPsToZL/1tMZq+Mdk9PaVxuutRHOB8gl0cOiI4vhBMabSggiZ
	 /W8V0Gx/m029MrICrPWBi2nK8y4Z0vgumHadbx3rIisW7MtxY3RLvVEN58tz5UODr/
	 Oomtx6J2R81/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CDC8C43446;
	Mon,  1 Jul 2024 16:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240701140851.307df5e3@xps-13>
References: <20240701140851.307df5e3@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240701140851.307df5e3@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.10-rc7
X-PR-Tracked-Commit-Id: b27d8946b5edd9827ee3c2f9ea1dd30022fb1ebe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90f4ad03439f061fa6930b8b16ba67f7ce63e708
Message-Id: <171985258657.24381.14936268763509158549.pr-tracker-bot@kernel.org>
Date: Mon, 01 Jul 2024 16:49:46 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Jul 2024 14:08:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90f4ad03439f061fa6930b8b16ba67f7ce63e708

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

