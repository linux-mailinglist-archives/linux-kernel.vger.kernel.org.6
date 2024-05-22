Return-Path: <linux-kernel+bounces-186594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B58CC60D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF73286043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F8146D52;
	Wed, 22 May 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb2OMm3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A321465BD
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401120; cv=none; b=s0Jg6cxSHnatu+hZBzBbpGTa0yeljgvqceFMqpkmgXsmiRkH+m++sFvOgMKMe8xvHdURBer4ZmcDZDj5Bxn78h53Rl+1r4DBRDMWXVWWoh0mz+V9we+C+KPdk4eS3aLyOQnUgHx9fHOJ9Rea8z+YbCAzWDUOf+Yv8m8hFd/SRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401120; c=relaxed/simple;
	bh=eFsafoJL80C4MIkp1b+NKFcZyfQbXlmmbJA0s8k+rOY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q0rp4FxDq58sipf9p+LeMTlaUBnRYkHHyIiVY+Jino3HXHRWklS6S9szsap1aGpoe2dIzHkG4SlVgwDU4O5FZySydaCAkRZfGNrg6DqqnM5RsonwRjR75yyPmDpoZucPvwVejoW0o7HOE3ZQlMVF3TZkP76O7ON1NMZ2wzHXCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb2OMm3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB396C32782;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716401120;
	bh=eFsafoJL80C4MIkp1b+NKFcZyfQbXlmmbJA0s8k+rOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qb2OMm3J13HYO1ZewGMdCeS6N0f4zcgoA9mR4uBoil/0VOJzHBtVKt6Xpb2cz7roU
	 xtmUquDdl1nUCuV/317fU9s69i+FAkNdL7rKpqla/VTkaxFUcksv43UxoOrX8b38aA
	 3/MY5r1GTiTm2QeEWN0FktgJ/wk71V7FmHd9y33NZdv8NVcwBzr4sPKTaJfFW+YihP
	 1gV1HeWXA5FksvQzmGeAWPg1gHfjnrrmlXKUS1b7mKUllL/GttythUK4EGFegXZ/fP
	 5pb5cNoBxpcjGYv+3yVO5+lZ+cEJBBOoYGoxrVC+AnZV3BbTvE2aV2C6tAxyz5K011
	 dGP1sZJYlhIpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2167C43619;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
References: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-mw1
X-PR-Tracked-Commit-Id: 92cce91949a497a8a4615f9ba5813b03f7a1f1d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bfbc914d9433d8ac2763a9ce99ce7721ee5c8e0
Message-Id: <171640112072.25247.2091425943706526372.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 18:05:20 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 09:13:28 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bfbc914d9433d8ac2763a9ce99ce7721ee5c8e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

