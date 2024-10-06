Return-Path: <linux-kernel+bounces-352548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91068992093
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA6281D15
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630CB18A94F;
	Sun,  6 Oct 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbbGu2ey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2E18A937;
	Sun,  6 Oct 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728242028; cv=none; b=pmLusO/CIUwXBsYziC6PuqrnRawcKqHRz54+lX3C/TLImUyGGP3hHQUABrA56yxin6ft86dpX5SGKzwyzNtZ5I1z03YfDIx1s6GxNHPpvGjWVlPcGLI4s/J1zAcXtIXsJ4hYt8/dRcH3MDXGcNJLhBmke0/LOdSS07ZTQ8DrU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728242028; c=relaxed/simple;
	bh=lArEfHJFfJVK6czFtt7tEikH6dpuNhOqvVQUcT+ZJbM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RcpO6CTN+giuZeRSwfDKMpQdgj92q4Hxeh7tvGEl3d4PjoP5QouPcmQAiREYhJUFxWSopLsX3PDF/cHIjuE5ugirbH25kZL9pFm/2or6plWC5zwPvVo16WKCah4PG4gjR4tsPpDPr3XDaKscUIQSCInU4TEfJkeq7NOvll0DezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbbGu2ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4978BC4CED0;
	Sun,  6 Oct 2024 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728242028;
	bh=lArEfHJFfJVK6czFtt7tEikH6dpuNhOqvVQUcT+ZJbM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bbbGu2eyP2Lr2j9DAS0hQm6dfWnETpAbCANBRdzDCsBxbL32uBFGxIhXR4bb4yBJB
	 Z380HQAn/8noch1zwveqAftxDRNkvzoIRoL7oLLSRwHNIYFqJcsmK5EPm/KHixF8kI
	 f1Xi7PtQaZ4QUM28q3TFbpLzsznK/4U8d2UXys1/BO0PsD65Vpsu4jnMRAsrJewlaL
	 Sr1cTjHL9hlFzH1H+HYGJ2p98FU0QPQBb0TqRjlePKHOLCcPgUA672PP53tTCOHb6f
	 Di/8T1E6khJvL8jJMdyFvASOIfRDnHSoVtEmglwMEhMYdan/syjtDMqH8bzCczD302
	 0wtSMqu/kz+vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710C23806656;
	Sun,  6 Oct 2024 19:13:53 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.12-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <280a792b-ec54-419d-8cca-17b020a38d3f@redhat.com>
References: <280a792b-ec54-419d-8cca-17b020a38d3f@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <280a792b-ec54-419d-8cca-17b020a38d3f@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-2
X-PR-Tracked-Commit-Id: 2fae3129c0c08e72b1fe93e61fd8fd203252094a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8d9f2c7aa599dcebab63400f7eaa767629faf04
Message-Id: <172824203202.3486601.2934138592877255821.pr-tracker-bot@kernel.org>
Date: Sun, 06 Oct 2024 19:13:52 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 6 Oct 2024 13:07:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8d9f2c7aa599dcebab63400f7eaa767629faf04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

