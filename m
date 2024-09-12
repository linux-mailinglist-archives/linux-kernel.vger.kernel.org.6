Return-Path: <linux-kernel+bounces-327418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFE9775B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6797A1C24250
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A21C2DCC;
	Thu, 12 Sep 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF+sUUIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6051192D89;
	Thu, 12 Sep 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184408; cv=none; b=oGZO84/LxqLtF/6+Fuxqgv0+u3mYb2VUDXY7M79+/cxT7J3XUm0VBypc97jxqcYWwhf3K6uFxhvoKtg6FE3wNoaiu5/Wq8nlzYUatc8RO9gLdKqLs3zLp9JYrtSqNQ0LvCBi7IRzB7gROGk1vtWwTinj4y68aVKcGjPbsUc40IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184408; c=relaxed/simple;
	bh=nMZ1Qt4lTDufp4/+aSGs1d0rVvLgdokmlczcl/dS7Ks=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VV97JYQrMQyqBFV+5Dc7XwVILW+yyw2S5mm8alsIb/JuBmDn6soVC7PraZma21s7wDb/sEJwoWxgNq+U+60jtgLbFdN9xa1kY9QVpJHzWVW/8U14Ps1/5PJZgufwEZMvZB3gT6qz6LabB9dKSz64/E5AyArEC77Mnx+liLayniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF+sUUIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1BBC4CEC3;
	Thu, 12 Sep 2024 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726184408;
	bh=nMZ1Qt4lTDufp4/+aSGs1d0rVvLgdokmlczcl/dS7Ks=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QF+sUUIUPUAf4+b5qiiXkU0JxQDBJNsRrZzfat8WWUNAL5R7guUYBRIJmoVMQ1RG5
	 GiwP119puq+Egppfd6djI4tlGmJXaxt8Tg8y7kXsDoL3P/1y5ZxAcrhD5pUrPJrVqO
	 b0UsONuK2PwnNRqxYb4FTzDybQ9g3cMG+9KdJrR6GIsfilhwdMsn+bhcyx1V5liEV4
	 SnpL3tfFaDtev+r7tMVau2Jblk0r1VcnJXiKR/An/OHhIFKCHrcqsvgHMMRJOjzRd1
	 ZXI3AidFLgqtz6K3ZcnmqGiZ3lOqPsSwqJKttt4nHNimBqhMZzDkRrQovOPAoFrxeI
	 zn8oroPpfUQSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B31C43806644;
	Thu, 12 Sep 2024 23:40:10 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240912233149.1923482-1-sboyd@kernel.org>
References: <20240912233149.1923482-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240912233149.1923482-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: a4d89b11aca3ffa73e234f06685261ce85e5fb41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 196145c606d0f816fd3926483cb1ff87e09c2c0b
Message-Id: <172618440917.1758740.16559724742965535679.pr-tracker-bot@kernel.org>
Date: Thu, 12 Sep 2024 23:40:09 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 16:31:47 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/196145c606d0f816fd3926483cb1ff87e09c2c0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

