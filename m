Return-Path: <linux-kernel+bounces-551640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C6A56F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B803A96E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6162405FC;
	Fri,  7 Mar 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCkpBP9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750821ADD1;
	Fri,  7 Mar 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368692; cv=none; b=fNcHU6XZGicNKiLEm7B/HYXQ1QfIsjm5089uDR+bar/BWqdUkU9aX1Tvp+9bTpf7Pg35Jb65N4Wp7sEm5tGJK0PgaVqGbzZx2QgM4Otyv+ux8Vqi62Eoy1nQyFZyObLbjVTPQFq2WXBPtctsXr3L8pNhIbPNxnUFhqKo/0epuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368692; c=relaxed/simple;
	bh=qw3mwNGmk6KcI2pY8/aDI7mU/5wFA8Rs6ZuWfbSBj7w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sCIW8xaJTOlhnwtCpqAlED7F9zDM6FOa9VfQ6iWzcxvf0hVol0fXJjzhrcGcM9rILYWiupJd7/Up1RkDWsrfc3ZJFn+H4wnmqJIpDs2uCZOGJcX/ZfEZvOcHgpslbwmswXtEWW3xzZ1krBQPMNEyg2InaN/ozRsTC5l0FVnkHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCkpBP9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF8FC4CED1;
	Fri,  7 Mar 2025 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741368692;
	bh=qw3mwNGmk6KcI2pY8/aDI7mU/5wFA8Rs6ZuWfbSBj7w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SCkpBP9SToBZ7q1k2N9DffZQqGzrGpJjhIyU8O1GKeihdXLFRsqkQZOHJw00DH/Hm
	 YVbLzoK0f07fLz+bIF/oToLX7Rs6WQ6SvMk+Q//RnrQNNfAyPQ/YKWxmNuBRMORBa/
	 UJ1ggQmKezAscRZTgnCFqHpR61Qx+7d4nLY3bGuF6gngBT9oqC7J+qF+8GJkvyX43X
	 Ujj7eHJjIDhEWi2c8ZqckD4c3T7YtP1JuVBZ0ca6f5svqrq0NndSOaqLHDwx5vxBbi
	 2VLbyFhVD+0H9YwywQ5kVkmiAbDRzntT2ffhiGPTjc6ZxaHZUEt+fX0KwlgvZ0rSSw
	 DRMQYP7mTXfJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA71380CFD7;
	Fri,  7 Mar 2025 17:32:06 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <878qphjl4m.wl-tiwai@suse.de>
References: <878qphjl4m.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <878qphjl4m.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc6
X-PR-Tracked-Commit-Id: 8463d2adbe1901247937fcdfe4b525130f6db10b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a405b36a6418e9a9e07314c90c14ebe370ed79b
Message-Id: <174136872531.2423139.3578759195315149109.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 17:32:05 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 07 Mar 2025 09:33:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a405b36a6418e9a9e07314c90c14ebe370ed79b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

