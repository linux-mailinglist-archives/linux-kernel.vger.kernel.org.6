Return-Path: <linux-kernel+bounces-197356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA48D69AD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A56CB27965
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1F17E478;
	Fri, 31 May 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIxb6XOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6617E44C;
	Fri, 31 May 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183208; cv=none; b=ot+Jie1Ey+J+KSaeFPVA6mMd+Bnm7yUKD7LYPsr6aADePNGTYLnBxce3GlG+GvUjxHw5JH6OSfjAeB16egXl4M2Cw4tIDlfH0FNokBVVOWgS9qeKn8Vu0h3Scb2bsgJbAEGiHJipezXo+N+5C96ECWRWda9e4UILrQXKsgvZCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183208; c=relaxed/simple;
	bh=J8FQo1tD2MtenJNJs241o4Pw54sYknqOQ8u6QGHLPbc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nAd2w8va/tEol/c5+jVnNdTte5No8lkVcEalQFm4479xp3sW/JEX/mEYKGqz7a/iBJ+qvQ59pycOmAEUvBMoxGAGI1jQ1fgpLK1uujrGA4ZoioWMAoeoJdHsNMCvvTQ7EXiBYyLrvyAYpOUx97BekC0tsS8cQQCfm6u7i7G3N5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIxb6XOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA146C4AF08;
	Fri, 31 May 2024 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183207;
	bh=J8FQo1tD2MtenJNJs241o4Pw54sYknqOQ8u6QGHLPbc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JIxb6XOn8Nh8DOUTyiujsF7VcT7DgTU5APRirkjUTzoMTz0MWAM31X3ABTX8HTaYB
	 rLjr8BVZupaWpCwGtjZ4samtknWT9QDIyArhZKF//hPeNQarkMRFIcAAR9MjJ35mQK
	 o47OeRYyYn9GGptwMJwEa3k/ipK+eU/6shU2Ps9JHzUBguR+/koGyU0i3rYES1imfg
	 /vToNDnIbnaoKKWQf/7IcTKA0jT36bUphWtihHwWXJhk2W8A6JzBnNb2699ZOM30tQ
	 t+epdVUPjQtsRjETiLBwMQH3/vbjE8O+yiQTyA7MYuIMwUAUbmb9z41AOCqRfA3sZi
	 fV+GzhOPtl8Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0C6ECF21D8;
	Fri, 31 May 2024 19:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.10-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <470d8b3d-1c9a-475e-a6fb-4fcc4b9ef98e@redhat.com>
References: <470d8b3d-1c9a-475e-a6fb-4fcc4b9ef98e@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <470d8b3d-1c9a-475e-a6fb-4fcc4b9ef98e@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-2
X-PR-Tracked-Commit-Id: 3050052613790e75b5e4a8536930426b0a8b0774
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87895a6402604f7a2b55a62e8afd7889b8ec72e4
Message-Id: <171718320771.20247.4683747140139024139.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 19:20:07 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 May 2024 20:30:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87895a6402604f7a2b55a62e8afd7889b8ec72e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

