Return-Path: <linux-kernel+bounces-552652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5BA57C55
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9763AE50A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D561E832B;
	Sat,  8 Mar 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2+8hwqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C3AD4B;
	Sat,  8 Mar 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454821; cv=none; b=LZ9CCRnf3l7Q3aM8icCDrUguCr/gntJ0Uypnk02Ql8b8RQ3f5EF+sR0IPDz7f7ZyMT+OYTjb6x6Uj7PH6oZT8hGOorMG1brZN5/aoiy2vNUUsuwTTyqmXSECbWDDu4+5RvEvz8i90r8GNXRnwBNEotlevyEUy5uTj11BKgDdV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454821; c=relaxed/simple;
	bh=mUoLAgB2TRlEqRgc6MjOBQVaXIMMYiv4bRRRpyakf1A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MkThbVsHo540KCXGyl9OLeAryKxjta+oOoxoWvoYTD9S3mqaYcc1IomK20Kf2/CwAEMdOywOsFIkL6eP8pGUcSBIJ/+uSAy3LQymUWqo+UTc08wAg02atbVRPgHXqI4uUNWPf6fJuJFFkA/aBPjbab4pyFtaJKh7KcIjNuyLj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2+8hwqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4414DC4CEE0;
	Sat,  8 Mar 2025 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741454820;
	bh=mUoLAgB2TRlEqRgc6MjOBQVaXIMMYiv4bRRRpyakf1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j2+8hwqfYX8qY7zNE3wo4KR4yhNHz5T0nKvxjIzXUN9hkVXCTJqmvDXcN2hIdBPSJ
	 Mz/Q7OoKc1oRyyqsdGtAiHfVQN7IV2mZuQGKndywq+jvyPW7lkHTwlKdCc+V3jBOX6
	 rbNXP/nHlnKGOUR97cDQwGv7MeaNbzUQLL/rB7H7c9VXHoVdclyUYe/vcBzztLSyxq
	 ArWuOb2X5dSMtVsfYzy1TKg/BDlSrvVhG3SZ+LXP4i9DZj2uxhBR/VOR9QfYRZNM7i
	 tF+NV5DRvDL4yCtEQ9ZMXY06iCqTXDmOfMS+3rug1o8hup9g0TT5fmrxKZDbehWEFd
	 M/q9yKsvTG7Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344CC380CFDC;
	Sat,  8 Mar 2025 17:27:35 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250308102416.3722203-1-chenhuacai@loongson.cn>
References: <20250308102416.3722203-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250308102416.3722203-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git loongarch-fixes-6.14-2
X-PR-Tracked-Commit-Id: 6bdbb73dc8d99fbb77f5db79dbb6f108708090b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e51e0ac575c2095da869ea62d406f617550e6ed
Message-Id: <174145485380.2700204.14421571196244354799.pr-tracker-bot@kernel.org>
Date: Sat, 08 Mar 2025 17:27:33 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  8 Mar 2025 18:24:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git loongarch-fixes-6.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e51e0ac575c2095da869ea62d406f617550e6ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

