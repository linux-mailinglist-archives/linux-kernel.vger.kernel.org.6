Return-Path: <linux-kernel+bounces-206761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA12900D63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAC21C21959
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830F155333;
	Fri,  7 Jun 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6Uo8pwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646D14F9E9;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795025; cv=none; b=GCj6DbmLp4kRlVj9iWXcVl6p/+AhC3kxFfci7QGOCh3fzCTQZB3v3PdC7+LIgJTM0m5k30kgHBtuL6q7N4EwSxff4ndQ+i9HS2MNcpRFNxrAmBpMJAee7d7ShyCrVwF+sJs2CGpodHRoGPSkVMc6r1UKarAinvkvec8m9OZvhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795025; c=relaxed/simple;
	bh=EurF0UTqSFTEccNjhsWI1h4cOIjF1It4g9Y3ENyS0Yw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tzXDlu3ZeDu1gyAfaP+YYJgYnGrSWeccbeBbdlqxE3hacgj34kKHQd6TMklkEmcjlnoFK2rmS33n01OEmg53Mvj1H2Nk6Hkjn4NTsqApi3GVSajqQpGmZkrqH2HMynKF/2nvPESfOSmFmR4QszlqcfMVykuACEqS4a+wzMQW4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6Uo8pwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF12C4AF07;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717795025;
	bh=EurF0UTqSFTEccNjhsWI1h4cOIjF1It4g9Y3ENyS0Yw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B6Uo8pwzaN53fqoyAzUS2qkH+OLBGPbM+0p5WqN3oo7Tckq68eZwNtsyIgaZdD2DK
	 i4MOsxM5OR0VDxGT7/cphURNAJiopjZP+Ld0l1/bqEv/3965fXNLs9RE58HIFp1DLN
	 XTJA7KM6OaPSjSSt/wEdOgU/ZKvp6CSbj2hPE2Wes1u21hvGh9M549IlPBaOg4HBGP
	 FV9rULbX+RiOZw4WCTdse8kmTmM8oqxXuzjtlVc2Jfu9kjgAuEJ0qdeL2s9yzD4bUm
	 2fSaSK3apUYOxk1U9qmuhg6IjGFa1vFblkjxbfRzIn86RCKVGjYnQDVu9TGXKUz1Mr
	 oMytVabNj/j4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99099CF3BA4;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.10-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <6d69dc47-67e5-468b-aa7c-879bbad7ef77@redhat.com>
References: <6d69dc47-67e5-468b-aa7c-879bbad7ef77@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6d69dc47-67e5-468b-aa7c-879bbad7ef77@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-3
X-PR-Tracked-Commit-Id: 77f1972bdcf7513293e8bbe376b9fe837310ee9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96e09b8f81668278e2bb70db4cbf80d7549bf7a1
Message-Id: <171779502561.6230.17938769860834270055.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 21:17:05 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Jun 2024 11:22:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96e09b8f81668278e2bb70db4cbf80d7549bf7a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

