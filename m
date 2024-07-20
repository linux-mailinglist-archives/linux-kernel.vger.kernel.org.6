Return-Path: <linux-kernel+bounces-258050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C29382B6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FAF1C2189E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3717C77;
	Sat, 20 Jul 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIhpMpTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EE323D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721504126; cv=none; b=ct2z4t/53f/ThN8hlAzhYZpamaBEqfBwLs6OggLl+sAJbOT43VEnJOnod9LgfKJm+N+i4onwuhEXsOWp8xQU4u2vz40MMqAGjnksEO4Q+wgrUGA5XjlFiOVIMgTQApDUIg4NeSnRFNGWB1aOlMKfn5ixhZ2aVMi6phib8uexq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721504126; c=relaxed/simple;
	bh=1EwOUjEtCNUQhL/HcjAOPAG22BX43JFXbF8ZQfjGbpo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LmJvaBpte8qZGp0yiMw0W/ZXFGaRKr/Na/d1DLEeFLwkoBGCVHrBLSJCKYMN6Yn0Mz0/spDO9DhoNldoQEhpMVG9l5LVUGjW1Lo0wx+52qo/Cmrvs6xDQaJ1RHH1L5kL24qOazNxJnD+GnA1DsAzKaLALA/JMAKSmik8DIHs/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIhpMpTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3DA2C2BD10;
	Sat, 20 Jul 2024 19:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721504126;
	bh=1EwOUjEtCNUQhL/HcjAOPAG22BX43JFXbF8ZQfjGbpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qIhpMpTLOrkb7AD9az/C0e0ULqqzHnPBPR5u5uY3xqLSbz0rVHaef41VnmS3zcAhu
	 sJhFxwVzkUtnkG/GaXY/CVQG0ucyl+w83QKpdDQZXnDMwuZ1REvllCGucWR1js8bmJ
	 Ez5KoqB7vBg7n2145FiVDZRwJKR/7nzA9jNypFYsMwRLo9paqA0Ek/Onlxi+k7hQlj
	 suZ9hr1yp+1j6f49wKp0M49s0T7A1rkUXERCC0yZ25LraECvruek3TbgY30BQWrqm8
	 3UC+GJtjEuZJiomdgigohRpuWqHDA7jmxvXTgl6b3ovTbWW3KesrI1jVll3Grp2OCo
	 egSqgWwyyRt0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98AA6C4332D;
	Sat, 20 Jul 2024 19:35:26 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240720143826.00dec422@xps-13>
References: <20240720143826.00dec422@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240720143826.00dec422@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.11
X-PR-Tracked-Commit-Id: 78a0b13f5744bd270d0c2391973605d9960a402a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c43a20e4a520b37c2ef6d4f422de989992c9129f
Message-Id: <172150412661.5535.15231472848376953595.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 19:35:26 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jul 2024 14:38:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c43a20e4a520b37c2ef6d4f422de989992c9129f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

