Return-Path: <linux-kernel+bounces-253313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736C931F68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B40281F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B81CFBE;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL8pL+Um"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A218C22
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101300; cv=none; b=m4Vz4miGj+4m0WbH5a4YhqYeAarmdZCWOPxt/yaBq6H4vkPlhAZqpnYP2w+y61cQDcYjGw/0vVLbR1CtsJzkpEGA6IyFd6Ed73ODFCZmqk2famIadKzv/afoSoQnDoFFGmuXHa/5RyQCXGaXR6tLdmkBWdCHfnPg4K9RXDbwgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101300; c=relaxed/simple;
	bh=4b+Uwdt0t6E8TVGi5+4T7CzisAPMDN7I2W7J8UYdsFw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eMnDiIaeu8zYcqqVDSnnsNvywbEPY0bserYYqJxOkpCN6FsiZf4rjZ9i9ewjXQqFGZZuzzVFk7rbiUnmnBMdRm7a3qH6TzbOOhXvyEdLViqDk8L2yIWzRj5WN/n8U1DfqQv3UQpv4uM/ALA2Ehjq+YEUlx0Nph2cyR1SB4NAWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL8pL+Um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBADCC4AF0E;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101300;
	bh=4b+Uwdt0t6E8TVGi5+4T7CzisAPMDN7I2W7J8UYdsFw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SL8pL+UmGI2OKztL773/thTrk0HH/e6H/sxM+njlU3uneKqzr56cZhHlicAgc9zbg
	 V38oktzITA0MfVTEUKTjPD/3FjkTMpEH6aNb5eBdjTKRYBO6m4i4oF10lhJzltn58r
	 Gc3UwAMClVJz76xiGKT93NlD+Fg9Y6uOAMnsBC+Ojy1G5qqFZ9ILNZL0y6HBIesOsI
	 FeilAFCIj8g74zNfTx6/ITz4Wd1KQgpNw6H7NPzBSOGVhx5g101d0DKWeNoOx5Y/Ka
	 7QGFvoAzmBVre5/3Dq+Zq1rJsgZmWTB/BpBZh9rPx9lxzuvmxTrY6gDOsRGnu/0w28
	 Mj0AzajiPW5iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1CC1C43443;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715124929.GAZpUa2Uq4bwobX420@fat_crate.local>
References: <20240715124929.GAZpUa2Uq4bwobX420@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715124929.GAZpUa2Uq4bwobX420@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_build_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 469169803d52a5d8f0dc781090638e851a7d22b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d86d352411dab9bf9312c9eb4b2d4020195be45
Message-Id: <172110129992.18508.2509418136307792220.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 14:49:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_build_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d86d352411dab9bf9312c9eb4b2d4020195be45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

