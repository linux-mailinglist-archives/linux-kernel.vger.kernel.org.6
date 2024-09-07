Return-Path: <linux-kernel+bounces-319906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FC97039A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F828354B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E211165F02;
	Sat,  7 Sep 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AafO9SQD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16B14EC5D;
	Sat,  7 Sep 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734170; cv=none; b=eAOrXzZ/ep8UulRvX8Sffdy+b+7eOb9uYPU5UW364LuBlIXGURhuLChPrF8lTrguSpaNoXEsa59VtbbOXq2BeyKEI6PcLb7cp2evz9xQLANvTGoT9ATGO+/WnP7ErRv4ZdT9iRTxEqz8U7HhWLfnQqZFstoKwpcLzXCzj+8wO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734170; c=relaxed/simple;
	bh=opUstN2oV1FfjFZjTh58BEl6/xVM27C4vqDk8iSsfPs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qhHOb5eip3JbIte7hmzjrPx1hKBBNJdURisUREK/BmMUtYO3JXeW1Y7utS0swYYLJ2PbD8Wp4Q2ZYkJBTUJ6FVssQBK6h683l/RdDGpFSQkxJzc5+TfA75ajcTE6Jjp7qbHf9z9nGksTytmMdc/KyeuUjiNEOqpbkTNjmXAneMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AafO9SQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55378C4CEC2;
	Sat,  7 Sep 2024 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725734170;
	bh=opUstN2oV1FfjFZjTh58BEl6/xVM27C4vqDk8iSsfPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AafO9SQDD12p8OzLd3Up9nP/C7tKZnAEHx4A7cqw3EsrV3zPxAhCt/8WYVi3Bp28P
	 HU3MtrHAg4uyS3Ij3k+SUArYIP0iFz84/lcvuwW8LG1lpqcgBbgpEb6Nioxri9PGzD
	 HLwYlVmBVh4LY1njgApOkldi0BugoNDvpBppD769S0XbNMiRJzgMEoOtC6Ro2rX2UP
	 Ib1MLZkpoyRQzA/4SBtPJ27auX6NeXY1rYwY0EvXd34Mi0OxmaJvakC9idNE9fcM8p
	 852ha4AT7DgerKUh9jbQ00d9pQRHswU/Vp48jiEgPgEl/nqMN1W9cA+UEi6Gij5tkJ
	 EdoE6BLPXoWoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 887983805D82;
	Sat,  7 Sep 2024 18:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240907182551.128901-1-sboyd@kernel.org>
References: <20240907182551.128901-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240907182551.128901-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 71c03a8cb213d267853e0d9f520c972480960544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1f2d51b711a3b7f1ae1b46701c769c1d580fa7f
Message-Id: <172573417137.2736849.13075149320237398415.pr-tracker-bot@kernel.org>
Date: Sat, 07 Sep 2024 18:36:11 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  7 Sep 2024 11:25:48 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1f2d51b711a3b7f1ae1b46701c769c1d580fa7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

