Return-Path: <linux-kernel+bounces-577449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B80FA71D27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83E716D136
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674721ABDB;
	Wed, 26 Mar 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDlCGfDn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2621ABAE;
	Wed, 26 Mar 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010186; cv=none; b=UMmsvlrA4cS82e1E44qNwv0ASrwrZY0yFJumJvgelWvpziyiPX85vPJiCggqYGnqJnOg+yQ9G+7x1uKzJgTO7SKU7+dWohq6SsIpm6vKRdeApoeXJahyyf/9/gjVZZ0lrzXRCFbV2A/SP80oJPphEQ2KQJhjJSx86nFuG/hrGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010186; c=relaxed/simple;
	bh=IZgxGOD0PVdxLU4ns682Sx5UWYGs/cjQ1y1YiAW9Me8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lXMOxn/cDhXGhGR/uaiTRheiAKzgYALaVuo1Rx73HMpD28XIKK4Wxsqve/jrlFeR8ArJMtu+oK/kDjrdU129IZU+omuzaX3o+a/17AFUgSRG0WC2Ko6zeVJ67/4DRCgzkYdlwgeIt5JwOjKKnHphP61JdINRAHwAMdSk7/0xCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDlCGfDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D2C4CEE9;
	Wed, 26 Mar 2025 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743010185;
	bh=IZgxGOD0PVdxLU4ns682Sx5UWYGs/cjQ1y1YiAW9Me8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gDlCGfDn1V42sbreu2GXiwAxA62YenbTWuLYkpKqzDk7dI7+hrkx9O/7wQYy71oQf
	 ahYUmsQYbjFBUnZ+KOhlaDP0CdxO2LFGAJ5czSENtWMmHyUm1l6v/5K6IsOzCa9cZH
	 MvaUF3Ac4V9uRlJvsGHB9cG4a0AsXc4XCjmgKvcDqDMcC8NXEYa4degAoWcSrltHAp
	 Je+VHfdjnDO9TXB0DA5bj2sX2W2zVVIi8XN3xGOClXo6wfnhm1O+OWgi2rPdBdjhgH
	 rRfFqeEKi9FNjMvFRiFcd9E+3vdtviOyraX8f37Unn+yMMLuwH60vRm9MuQcq8JGAD
	 xyRx+Chamsj5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7133A3810902;
	Wed, 26 Mar 2025 17:30:23 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.15-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250326155934-163925309@linux.intel.com>
References: <pdx86-pr-20250326155934-163925309@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250326155934-163925309@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.15-1
X-PR-Tracked-Commit-Id: 2c30357e755b087217c7643fda2b8aea6d6deda4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb1ceb29b27cda91af35851ebab01f298d82162e
Message-Id: <174301022219.1396023.14089344726135477669.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 17:30:22 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Mar 2025 15:59:34 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb1ceb29b27cda91af35851ebab01f298d82162e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

