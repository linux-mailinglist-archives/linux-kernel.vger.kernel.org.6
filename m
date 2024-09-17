Return-Path: <linux-kernel+bounces-331754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D046697B0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860891F25ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85F1898E5;
	Tue, 17 Sep 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCZLiG/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68E16B75B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580396; cv=none; b=UOYKoMC23GX2+QDvu0qJSR1STnrNZhOkA9nm78IXj7wtzfA+xl4xpHL/Fhtnv/FWHPk2TPdeErUJSptffZrEooQzu4YrJVCybNse/ZkXy7g/l9D8e7/wgEo6znHmvIHSklOVjbOWOs1e0xMjjHSDHSY2azHBVMB7GJakyXztem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580396; c=relaxed/simple;
	bh=mnPpghEbXMERTdqYCFuynhN+nvJLsaYy/YDxiimqFr4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=elPyM3qE/doYFZnkZz7lG1MWqQOruQYSI4KZ8UJGqcbiUvLBkxxc+r5cOW/q9SxbS98LxzqpwGJ8vJYFw4TRifLdVNabZgB7OJOqgbSACGubomWulovmVljnlZTutuTtpwoUEiwDC+EGHmzdAX/ivjLbO1FfgR0LLU7/sbJTQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCZLiG/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F58C4CED2;
	Tue, 17 Sep 2024 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580396;
	bh=mnPpghEbXMERTdqYCFuynhN+nvJLsaYy/YDxiimqFr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FCZLiG/VM7K/3fMfIuqIC7szPXeBifdvl9A+fKYs4ToRty7xzmPiIUJosQ8MgK5M9
	 F33KMCFYvfbXy5+uGBSrh9ukq8RTtjmGimnpvgOaCdE8cnbi+TAvhUEteTyyYnF+nf
	 RK/GfOFMnDg/Mb2UQ75mp/9hgVeU9AWPxUZKMWBjvnPZmVJ9n/lP6o99i+8UgwEIZq
	 y6rXrTSran41WMW/q4q9xayRg/UTZbfG0IcZUBXtf8rL5f+mqVIJiXoI4K6v4Kz0Cn
	 lIdiqad71eZl+2CHpazNUb0Z7jLqBPdJdWoyy4ON1ghwYh/0rWUO3EKz9bG8ms7tbJ
	 cH3XQEss4m1TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD053809A80;
	Tue, 17 Sep 2024 13:39:58 +0000 (UTC)
Subject: Re: [GIT pull] x86/cleanups for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656198437.2471820.9809446814731986690.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656198437.2471820.9809446814731986690.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656198437.2471820.9809446814731986690.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-09-17
X-PR-Tracked-Commit-Id: a678164aadbf68d80f7ab79b8bd5cfe3711e42fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0279aa780df4362f218b5645c07e5265859937f6
Message-Id: <172658039759.145065.6389616341318970893.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:39:57 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:07 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0279aa780df4362f218b5645c07e5265859937f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

