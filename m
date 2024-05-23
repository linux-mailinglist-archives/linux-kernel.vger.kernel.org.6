Return-Path: <linux-kernel+bounces-187986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319AC8CDB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632A51C20F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF384FD6;
	Thu, 23 May 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDx6Bw/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8A84FC5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497361; cv=none; b=sCB/rQJzyVGdAsNZAQiULIk1ykqp+99TPGG7KPzy/X72o97nZggrSxKiF0Ch54itWxlME16xupn2AsXpqOCVTNNwhdPDiUxJW8rlnwa3sUQcP7xeYdIKS8LCKDaxPtIVPjDboVhwNwk4+A4zAPjkip84sAzDyziTLbKnjtG7sfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497361; c=relaxed/simple;
	bh=LOPULbERcuNf8rFFdJbq/B8rQvADBwtRdmVfX6wLTec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E3yYIEaNNaYiQLxn+tY1Ug0joXesWW4rq2QhdSLpXWurF9N7b5IfTt3lDrRmcUGT2mpL3nw1AHm+cT4b7tpegwSKWXfc1uZh4QCbXULTyaSvwJwkSha41YKb1XP15Hzo1fqJG+4sicIIjgmtVCFqgKqJ5JR3xNOg0D7qh0iiB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDx6Bw/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03CDEC32782;
	Thu, 23 May 2024 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716497361;
	bh=LOPULbERcuNf8rFFdJbq/B8rQvADBwtRdmVfX6wLTec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sDx6Bw/sXPpfheXobJl4HbsCDKFPSvCXRtsC0Tws1wegBeSJZvPwfC5m5Iyx+kSIb
	 2AfcZ6Clf6evfOkh0aMTP3jd++IOpH5g2YviMpQAqfyU6zuD2uag6oa20/ecfbcmEH
	 MWDN6OXq1LrkWvL9ynmBmfRqHqXM8B0uELiNe/fecIP4+wPtw0lfMvfMXtDMSNBvXI
	 ESGWVT5QqpdqfYi9KTs7a9D4JehHnWe6erKRUcENDvyKHR4EER4Bs91XMS8gFTJ3bF
	 9OzLnRoMBC/3Gnb89hxw5SzA55ZmkqUXZjUnlw+vsOKbNrfNrvHGxuDBQr2sR44stb
	 0pyj9a8REAzYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED42BC43617;
	Thu, 23 May 2024 20:49:20 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.10-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <e6c886a96dc7945fa3a03d37d73a9392.broonie@kernel.org>
References: <e6c886a96dc7945fa3a03d37d73a9392.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e6c886a96dc7945fa3a03d37d73a9392.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-merge-window
X-PR-Tracked-Commit-Id: 74b38cd77d3eb63c6d0ad9cf2ae59812ae54d3ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2c80ecdb48aab735d770685207df96b8d0c0112
Message-Id: <171649736096.28255.11535405514953106370.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 20:49:20 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 12:48:24 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2c80ecdb48aab735d770685207df96b8d0c0112

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

