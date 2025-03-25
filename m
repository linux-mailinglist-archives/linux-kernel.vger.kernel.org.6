Return-Path: <linux-kernel+bounces-576171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4951AA70BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9626A1793AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474DD269B1E;
	Tue, 25 Mar 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkKc1d/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3C269B11
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937479; cv=none; b=g+YMhZxGOjasph6suQvK47GVs32HFwoN5+YSZfs2Z8Ci6+0AMpwjXwXPeeCf5IiiBaqTAHXNLFPocnv9F2aJeSBkIaDeVQPgBhNkmWiC1SfRjAzXoP3aDgqeF9ExKTcle/KKFAiOIkbP9j4sYiI/BJITfyYGQkO4ELONF/lQm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937479; c=relaxed/simple;
	bh=f/qLl44N3j0AX0JzE6mTioWl6p9L/UzMiTSUgPq8eQ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VJrebmG4J6rAwcqC+AFggRl93AWgCOIe5MMIIeh2D7bem0bR8nDz0Qu69Dt6aUKZ3IeRmmomevry7dmv5e5Wt9DbbHU4OetHW5hVo5KQNmVkI92nAaOL1rkFuPIgubdi5tUE5Vhl+wnmL4oac0slP65JPGGWi2euML6hFLsGDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkKc1d/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F12FC4CEE4;
	Tue, 25 Mar 2025 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937479;
	bh=f/qLl44N3j0AX0JzE6mTioWl6p9L/UzMiTSUgPq8eQ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CkKc1d/ehrmwEtJc+s/ZzppZNmu9ElwXpg44UZobRaya0ClvkKA4kpcAFuUCcBd7p
	 EvVuJE9E9dzeo2SXEXQSDfl481PQB5lhTZYGlbEiwKGZg4KG5SxPDnVum1Cs6KoTpx
	 Erp8Qs048mMoztXldETjyl4L0I2Uv+KK2Q6AiyKwPq15L51YAMUuzrZtzf1Rr5ujar
	 GOZIJ1J/rmL6niKXd97G+GBkqED+ntpazeLAnHuCVqaFFrYtyhdbb+2Tpu7+gdTpxH
	 /Xie7Xc5+/d47fAaryTDnuYx9CU7FB8UqmLJoyDkaYbJU8TOGZrYMwWesYFZmytk/u
	 dwOUvFxwyNioA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE43B380DBFC;
	Tue, 25 Mar 2025 21:18:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325171320.GAZ-LkMAFoSM7ZhDqq@fat_crate.local>
References: <20250325171320.GAZ-LkMAFoSM7ZhDqq@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250325171320.GAZ-LkMAFoSM7ZhDqq@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.15
X-PR-Tracked-Commit-Id: 823beb31e55673bf2fd21374e095eec73a761ee7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2899aa3973efa3b0a7005cb7fb60475ea0c3b8a0
Message-Id: <174293751518.732113.2128225767932545522.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 21:18:35 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 18:13:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2899aa3973efa3b0a7005cb7fb60475ea0c3b8a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

