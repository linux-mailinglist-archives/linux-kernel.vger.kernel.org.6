Return-Path: <linux-kernel+bounces-436560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2DE9E8798
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D501885B97
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83014192D79;
	Sun,  8 Dec 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRQ/WrfA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5B191F75
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733688110; cv=none; b=f/TeMGOCpxPSQ0V5TkLsV7aGIfqfumyn8IIP5ry4+eFbhmdnkl/8DZhgDwwN8PYY1xJIpSPPY2IBkpApQZ2gi/5/qITXgcBZkCkYObrpebk0MIVnbBuhHzxpgFCEvNM9pkXUYqpe6YwxR3P6Xjwq0VoGT4nWL8mQdPDc+Z0mnmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733688110; c=relaxed/simple;
	bh=gS+WqtAYKMg2QzPldLt3QrsQtRTl58Lk5F8+iKF44Ec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jSnLtd9IQrEOyJ6ec1PTPSlN/UUpjPRg6mAzDpLINKkbS+RGE0slXEaXA4RU4ysZoATYGqm0kN69jqonCRPjxOY5PLODfKLua+lHwmjC6/12fcB8Dhtxm9OESgG/tg4y3zVYaTHSal6ybhhWblnvELIfsr88Rr5WqPwT/aTPA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRQ/WrfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552F8C4CEE1;
	Sun,  8 Dec 2024 20:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733688109;
	bh=gS+WqtAYKMg2QzPldLt3QrsQtRTl58Lk5F8+iKF44Ec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eRQ/WrfAekdx2ybW9YugAwWVv4yf0O4pApvr1JN8oY4EmHLgsqWdyb6nE9XNr4Tzd
	 Cyo7pCY6LK58HIcckSGoJobXSQno5v3Uod+zfiz5JFmhGTR6rWdF9gHSFYBGipY4t0
	 rUUjS1vFtVTT8tWskLfaVq/IQXlvbfleO32wxXEWqMVtJqGjFBziWrQakjOaL2J/Dn
	 +EKHER2lhjVEWt++qHkDk/3F6PRvtFp7Lwop/bucDl3I4/DTxcADB9csQbybSp5uk3
	 fRVHHnIrxOZQFehYohiwmF+pBaPx3nCtiZQzMF91LxfZfl4o54n+rLrI0QfCWugnri
	 l8f+3kMOKL5QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB8F380A95D;
	Sun,  8 Dec 2024 20:02:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241208094608.GAZ1Vq4FKYipqWZ5Th@fat_crate.local>
References: <20241208094608.GAZ1Vq4FKYipqWZ5Th@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241208094608.GAZ1Vq4FKYipqWZ5Th@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.13_rc2
X-PR-Tracked-Commit-Id: 492077668fb453b8b16c842fcf3fafc2ebc190e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84262262177b98cf4e57e8c010119576d3c6bc2b
Message-Id: <173368812452.3330660.3454563346095277361.pr-tracker-bot@kernel.org>
Date: Sun, 08 Dec 2024 20:02:04 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Dec 2024 10:46:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.13_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84262262177b98cf4e57e8c010119576d3c6bc2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

