Return-Path: <linux-kernel+bounces-513674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEEA34D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727E0160F17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AD23F400;
	Thu, 13 Feb 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0Yqjv9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6F14AD20;
	Thu, 13 Feb 2025 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470575; cv=none; b=s/V2sjNn5H0pd7i7ZCD/FdSYyncj0SiZQVCn9dYtjhP3miJeaHV6s+laAEpzvsw6T2UfVxPL87npMjLqPqxP9g21lnbvlS8aFz48xozJNYWIu3jz9YjiQhFsoN/SNvQNlJk0ojdwHK5FsJFIfEqsJO48hUc2Z4AKyeOtj4BQz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470575; c=relaxed/simple;
	bh=VKeWINN+I2FPL3qjsLK8rBanrLL0rtiLwX+1IuvgtFM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BRnx3PG8i6UUpR1GcHfMab2+v/UkcLwMIjBE3ksPrX3tYFMoUqceu3wykPLghNZPA5e+p/LzLn3zwgtX1sgL/lsAAog6Dj39iFO2OhUJ8CZOQ86wRR9WjFgPeRXAvXJzcAZGHEOcO+RjJ8TzBS9xrZFspvFYTfPFp0To1Tn5III=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0Yqjv9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEBDC4CED1;
	Thu, 13 Feb 2025 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470574;
	bh=VKeWINN+I2FPL3qjsLK8rBanrLL0rtiLwX+1IuvgtFM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P0Yqjv9mrkHc4MhEVkzwE7gQrsKbmCi4ixzF/jYR7Y90t1p1SDXPfhrgHdt78y4hz
	 CJQ1yhHjaN5HO4uxxIWpqLfdRAv+Sr9FZL86NK45q8mVhQyYxVe/Hp2MffQhcwWt24
	 h4aLMS+s00p54Rt3PDkoWTCXtbP86SbzV3vzp+qX5OnCid99GtD/bPOwWSKD1vS6US
	 dtiEi0lFeIugBEq8JBpjDUZlI0w2kWnVcQAqciUD8SrcBrckxJTlmowY6pHFTy09Fr
	 RUJFPxJFReRzER0Rfhe54+DsF4AyzP0UKwDjCqE341rDmabtqnAPlaOex3/do6fvpt
	 L2YPsuu4SzZOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE8380CEEF;
	Thu, 13 Feb 2025 18:16:45 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.14-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250213141423-15116495@linux.intel.com>
References: <pdx86-pr-20250213141423-15116495@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250213141423-15116495@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-3
X-PR-Tracked-Commit-Id: b3e127dacad60a384c92baafdc74f1508bf7dd47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d63609e4129596cbf86d91c1fb6903273ca26269
Message-Id: <173947060379.1325136.12811767297991525959.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 18:16:43 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 14:14:23 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d63609e4129596cbf86d91c1fb6903273ca26269

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

