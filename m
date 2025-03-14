Return-Path: <linux-kernel+bounces-562150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F6FA61D80
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D366A1891322
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E691DF242;
	Fri, 14 Mar 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quEb3+yB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E102045A0;
	Fri, 14 Mar 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986214; cv=none; b=nsdBBNOEjVeDngiFcKvqumYLG5xWguif1z6ZOe/TnanamJ1re4XunSxyFOOFUcDmdURWW6JJ08ETQDir60gh63ZUMVwpKHeSf9N8QK/bB2S/piD32odb9122YvUD1fO1aI2psM14WEFJWDIHrMr9TWaEWloUPHi/Ipa5oA6R27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986214; c=relaxed/simple;
	bh=yJHFMTAilbi86HEst/yzU7PRvTxrR7wmyXkCLUlclbI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l8s7LdwUfIsafDGWCgOIdxmm3pWnwoqltbjaWEIHuOmO9bvoKXjvh9uDNYhv6ycJShgi1Wm8hFMdCBUEXcpzglxPMX97vLA2ilmqGLo1+CMptnW8DV8zleNFjASg2hBbi+fy1Syj4nQLugyFWxWyx8UEna8HKfPIMmZR27nWJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quEb3+yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47EDC4CEE3;
	Fri, 14 Mar 2025 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741986213;
	bh=yJHFMTAilbi86HEst/yzU7PRvTxrR7wmyXkCLUlclbI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=quEb3+yBGFNDF9my4F18iHmeTYQ/aeU46V5ZFstMGeqcxNDIqLHqiAyZNoa+vmo93
	 lXlIY5Wmt95LErTpirUeCf2xv5ZQj45xo/PYZ+EwM/85isOnwcrHrkLbMRJrGXgD6z
	 ncm8zTFwwWp75LM7Zil0om4diVmu9lVaszIPXFkU24Y7trfUQZV3jr8aADOULfc3AI
	 /UFyaNpIerr3lOUFMaZXp22yqiiVQzxrdHe4Fxi6HlIt/g9PuSN2skuTqDSJIbSb+L
	 fkKEMce9tamZz0V0AgS258dyQ+Ou4z/ig7oQqawwVRsNKQ7Gm3DbTdzGAGkzezOR9q
	 bKjSlurFeNJbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A4380CEE2;
	Fri, 14 Mar 2025 21:04:09 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.14-5
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250314162743-238386141@linux.intel.com>
References: <pdx86-pr-20250314162743-238386141@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250314162743-238386141@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-5
X-PR-Tracked-Commit-Id: 03fc0a2dc9f8c292fad8a1bcfb6d1f0dec1824be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83158b21ae9a1a5c8285c3d542981bae914e26b6
Message-Id: <174198624842.2382486.12003644343280253154.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 21:04:08 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 16:27:43 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83158b21ae9a1a5c8285c3d542981bae914e26b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

