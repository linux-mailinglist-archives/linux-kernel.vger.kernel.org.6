Return-Path: <linux-kernel+bounces-239740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632CD9264BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D331C20BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A00181BA2;
	Wed,  3 Jul 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2ILu5na"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B591DFD1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020032; cv=none; b=J6JEpxGcAvwTgrdh1suxmESFAxKsvR9J6OJ2NaePVw1ta2ZikyJ3g/Xq3rljFqCu26w/Gv31s9mhnef2J0V4LkhImR85jPJo+EdQEn5Dayo7a2Lf4iT1ASd/TFiJXj3d7URovqVT4sVx8SW+cwA7+fftTMSldKe5IY2ZE3hmBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020032; c=relaxed/simple;
	bh=xtGOv3aLPxhCFBBgjG8W2YL0406yrQb1O+g/7yh26xo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLUABFtiwkSKQN6ZqK4JZAJ2MHO0JMmkLbfwnjy4MCedVfkyAXAIiKe2qOtAFpbkWwSIEKPHTtbNlOZTu9t48sV6n3lbcDjt3e8nu1Cbd44a62g1ZNKI743XzcADaZEVO1CAuonpAGc6CzTXMVusXUTUwI2JJg8Vn3APu21dPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2ILu5na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04CECC2BD10;
	Wed,  3 Jul 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720020032;
	bh=xtGOv3aLPxhCFBBgjG8W2YL0406yrQb1O+g/7yh26xo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E2ILu5na/wnXEIrEcGPXe5Sd/TA92rwP6CHMdGuSGJXoEM2ed1XSizW2GaQV7ZYV/
	 imSUydgHNPonVKNwmygh9AQKCEzYkU0UXZmOn7izgNUQFqEINCnNOqD2THWdX0o2oT
	 5AT4iek4EfYj0+4vSQ7JxfFJFDr6e23LyaRwOBgv/sSp29QHvfLNlEuH0IYR8aAXmo
	 AecGG8K39Qoo5l4Ek4xMPmxBQcDnnFNJPpoVCeEy55iNKudN53kSFyX9ffjwwDhaYW
	 BaAXOjOpmFZSoQY7qy2Fpk96mfhysTnwiB3sO8xzIhullmPyXRL4rKwEcTVFVAm0vc
	 uK39T8C+yVWxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E17BBC43446;
	Wed,  3 Jul 2024 15:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant sanity check in
 sanity_check_inode()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172002003192.26849.9405957512997166573.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:20:31 +0000
References: <20240606095551.4089055-1-chao@kernel.org>
In-Reply-To: <20240606095551.4089055-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  6 Jun 2024 17:55:51 +0800 you wrote:
> Commit f240d3aaf5a1 ("f2fs: do more sanity check on inode") missed
> to remove redundant sanity check on flexible_inline_xattr flag, fix
> it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/inode.c | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove redundant sanity check in sanity_check_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/388a2a0640e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



