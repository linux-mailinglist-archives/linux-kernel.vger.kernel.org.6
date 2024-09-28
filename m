Return-Path: <linux-kernel+bounces-342578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F6E98908D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B51F22451
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952B15FD16;
	Sat, 28 Sep 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGTqli07"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223315B10E
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541909; cv=none; b=iYGwL0ANRKvBVTRhY/HvRoT/s3E2deDxRnefDOH5PSSQje/0BKKP9d9/xPF8/v+BYfSYQToY4/ydxq4xYdV8ieneXBAWyQz6JDsfUrYFbW8n4Fc9UqMlS9nN9F0LZBL50/rjCd1lwsoyu88uN7tMO3HphjvsjMxR/bgzs+E1uD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541909; c=relaxed/simple;
	bh=x3/7eRtcjfaX1v6knyhjD77xA6AShBFl/LoZXlJgSmI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Enm9pcwvbuTGOZiE26o5DH2hwcf+CO5ypJ5JW/6k0LxD6FqDWeEswFWxEPe5sjX+R1uACNSz+smdKN3MDCoLA+3FA6kT+px2+ruzcSY2YUJJi1lo7Umm5HSuHycDtp0mOVoY/JxmO/aStaun4Ub/idoiCTt5Vk/pbjvC+yLBbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGTqli07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE4C4CEC7;
	Sat, 28 Sep 2024 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727541909;
	bh=x3/7eRtcjfaX1v6knyhjD77xA6AShBFl/LoZXlJgSmI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FGTqli07lZ7bLOq4T2AUQnwWi813nEtvpSSvCnkfK4wP8Hx7Wyl1jJkcKNJyyYIwA
	 nIEGSsVKFkVvoZAyQLPouQEbVRufAArNkvs46058v6oi6lfy8IqEOZIciY6chAUPNn
	 KuvH8xshUZyPJQ0D+Q3jTVR7fOHo4dFgzC5CQ0M27c5W923aZYcV2I2+B/dnqfiYZV
	 noJrjaEtrmyRFUlo1/SydUW1sNkUIzWqa+/O8IdbGvRIwCCA1G4EHrrjRKytkljxXi
	 EIdz5Tc7ajwGjhTAJykh3Z7E5ynb/VPCoP09QArE2322HaGQSKnQJ/OR6RluySk6k1
	 7ik4nbKMX2BqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FD43809A80;
	Sat, 28 Sep 2024 16:45:13 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyzGT9vTmFUBK51bJAT-fEsKMkfScQZCCEcHCX7Lq553w@mail.gmail.com>
References: <CAPM=9tyzGT9vTmFUBK51bJAT-fEsKMkfScQZCCEcHCX7Lq553w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyzGT9vTmFUBK51bJAT-fEsKMkfScQZCCEcHCX7Lq553w@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-09-28
X-PR-Tracked-Commit-Id: e7268dd9bb9953a9eb0df9948abf5195bf474538
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 994aeacbb3c039b4f3e02e76e6d39407920e76c6
Message-Id: <172754191163.2302262.7896837503794633461.pr-tracker-bot@kernel.org>
Date: Sat, 28 Sep 2024 16:45:11 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Sep 2024 09:39:41 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-09-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/994aeacbb3c039b4f3e02e76e6d39407920e76c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

