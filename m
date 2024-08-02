Return-Path: <linux-kernel+bounces-273136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF79464DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13271F22158
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF374040;
	Fri,  2 Aug 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unArz0Vm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D64E6E611
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632989; cv=none; b=evRlCdRlyhYVnpvaeHehob+BY5Vugb4exM3jV0RvzzdeUO7Oi6u56JUPyNoYhH9/h3m/CD6WgqQhAjDVY/ufEfJU+e0/4Aw/9SMR0FhhaOfWVoTddePKfjNsd/SCoqnCmEYdwVDaKMnnBNWKIGpYvgBFy/QJJiJvVSbhLkCeMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632989; c=relaxed/simple;
	bh=rpfVg03BDtltKHEoezKcr9Yx8KqzFJuGxtw1wYwO5jY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RjLiKWeARzmHxBSTqezFDUkXVmrgwV3OL9o1BqQkD5xr9QSrK3LIKDgsD+tGtFM5NF7bJ86MJmAlSMCDXH3ol/P71ydRXYk1IAVMY2iMbwQWs6R6PfC+hTwAn4npoav/gTYVK90gcaAGmpGinISbmepseK4Bkd5TrHfYAdpg9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unArz0Vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6CF9C32782;
	Fri,  2 Aug 2024 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722632988;
	bh=rpfVg03BDtltKHEoezKcr9Yx8KqzFJuGxtw1wYwO5jY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=unArz0Vml0tl3esYh4a1eAahOk3rIVBHY2entwOQQISPsPl8tU6AZuMTQSwY/8hRu
	 SO39J9x2MiJS+Y0YHwNCXQkU/V0z1ZA4VQIRf1NeCKolTf8xT1oKivE/ZTAqI7Ygtp
	 XEa9f0/3T7f1HDOS9NFfYec2GhagxsK7wMUntQF0F5MbQQ2G85fSoWtGX0Yp3TM9dS
	 gdLZEai79rvwAt0pODEEQq+neuDjPq/tMV8LHYNkxUOd/MvTnflP4IKiA3xIJXA8YY
	 WAyeJ0uUrT2GfaFUdT8hTdh6qQJEWoxIdBkYDqwbsmbF3t7hY67Is+2QI1Me7nuzP+
	 Dx1iGxpE3eNQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD259D0C60C;
	Fri,  2 Aug 2024 21:09:48 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zq0bVlue7gHx6oaz@arm.com>
References: <Zq0bVlue7gHx6oaz@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Zq0bVlue7gHx6oaz@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: cfb00a35786414e7c0e6226b277d9f09657eae74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 041b1061d89203e933cb385d70d0e85f90a08417
Message-Id: <172263298869.11924.3681404810017354264.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 21:09:48 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Aug 2024 18:45:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/041b1061d89203e933cb385d70d0e85f90a08417

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

