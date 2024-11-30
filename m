Return-Path: <linux-kernel+bounces-426488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35979DF3CE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E534B22205
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829601AB6DA;
	Sat, 30 Nov 2024 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnw2j2yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596B1AAE32
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733008533; cv=none; b=U/9DgsPgmaYvw5n+134Imw9NfcFn64qltAGz7q5xmIU+KKaFgFHbCQ11DWbMi3PZHCV6k2EyE8Gvpc/pbt7j020ZPnRka2GFSVyLU+8vzb3axDhhehn/L+rnsJPI/hhUlp/Q6xyVuz9XRVLTHqwxcgWfvZiCW45rxT8uQa2Zywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733008533; c=relaxed/simple;
	bh=tnxuqblEJMiJaspyoXmZVWsww50YIhEz90c+Q197mmg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ci30JZccmRXkZAazjWepBuGjIvoLT3S213vNpjFO47oyMDfJ4ja81pUi+koAOsfRq7PcgOO4nPCoeWPHnHKLH5cfPXh4BpTT2I+q9kIw/OkFurSKRONDaUbjS7bxjg9/Syh0IXdJNToW/Jso4tv3brs2LxwL0Kl1fvcfGlzv54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnw2j2yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B812BC4CED3;
	Sat, 30 Nov 2024 23:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733008533;
	bh=tnxuqblEJMiJaspyoXmZVWsww50YIhEz90c+Q197mmg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cnw2j2yz5gV5hcgUp3hmclJNhO8xrxVDFcWaco7qvnPqjUAz1/61WDllXE9BUUTqJ
	 FtDsmVkt38HbkpsbMQmqXxmvkhMptjaOg2YVkcTpmc5bCI0P4tdCTl1vT4NhS9/Xei
	 GIqOqHGkb4VP1uFNaAq0HHGE9Kc59cTLTz0MTFVoivZhxyuPOvearEqmzI5vzHeKGP
	 tiEuPCR1QJJxj2DhDWOSXpaxQbInxi6MFhFrF+Eh1YHG/vB3arFSGFLygKbwn4By4c
	 DXCnT2Bh5zF4hK0EVLylysE42sEp0sLoQNRO0srN/zdZU5x0kzS3HCQzTGDAIYxEYm
	 gYqaXR/ZJS2TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE215380A944;
	Sat, 30 Nov 2024 23:15:48 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0osmEaBnjdHS3Q0@arm.com>
References: <Z0osmEaBnjdHS3Q0@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0osmEaBnjdHS3Q0@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: dfdf714fed559c09021df1d2a4bb64c0ad5f53bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50ee4a6fe3529fc98820f466ec6000aa333a4539
Message-Id: <173300854719.2503582.3539406702952422848.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 23:15:47 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 21:05:28 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50ee4a6fe3529fc98820f466ec6000aa333a4539

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

