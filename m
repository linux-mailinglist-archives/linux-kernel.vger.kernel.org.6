Return-Path: <linux-kernel+bounces-320332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D499708F5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A981C20DF1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB35158A36;
	Sun,  8 Sep 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjSyMmG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7C1C01
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816679; cv=none; b=NlNUMOpI1GKZbpLXWgjLLGm7R9aM4pVkymC2FPibwj597LeCuVqTL+P1OWZJxx0Lszah9MobbuU6k2IDXY1hggE2XDU6JuIndlysnmDHetW5yoYMzbhA8Oxtv3PkImA8ivcdMaOfaZ+wdLt1HxhpaaPAl3I+Hd0z5WQpMtbrOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816679; c=relaxed/simple;
	bh=e0tEGkEymG5RUbw7XUBxSyrsxkisv0ZvAwk0FCrFR8g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iFXKQE2eRi2ETi93imdwYenS5s9nBqXNHoxdMjIZbXrd1oYpIFPTMnkFB1pIcMvXFv/CgYTydnxLES4S+8yZXy3QRQoPQzPKPRUQXur74GEyRiOmY15GuxBNaArCdCJBZNv5UsZ1fsFZp5CEruh4UpwzlYrGSWrZ2wacvACHZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjSyMmG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF54C4CEC3;
	Sun,  8 Sep 2024 17:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725816678;
	bh=e0tEGkEymG5RUbw7XUBxSyrsxkisv0ZvAwk0FCrFR8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sjSyMmG+c9AD8aK7bzaySvtRuTCdpVPx8p55j+lDaVHGARH2LBF9Wv5Eq/gPha1g/
	 4Ey9ZbyI4MhUDaxsufAOwK045xwQWrTYKicpHJZmWxWFHYeayk3B46jED+bolTx5P+
	 /riG3Cgcdt9dbpCm4TZA35iPSV9/4+zfLVf1mchv7xMv3Krls9zucNIb8Qd5YEqaSI
	 /W9AECDalDIzAUSDvegS1aMRqoL6Dua8yGTUBLxXq9wpgCDDn+lptSZFTygsMxqd/l
	 wCMVJTj3zKlt8Ot59DPWbtZyDix73qobjK8c7IdNWT9IDfMj0iSZ9BFiOdW2/WsIMp
	 CZxuUF+wFBdpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A53805D82;
	Sun,  8 Sep 2024 17:31:20 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240908090759.GAZt1pb1NBL9QiXEq7@fat_crate.local>
References: <20240908090759.GAZt1pb1NBL9QiXEq7@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240908090759.GAZt1pb1NBL9QiXEq7@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.11_rc7
X-PR-Tracked-Commit-Id: 2ab9d830262c132ab5db2f571003d80850d56b2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e20398877b6216023ac311053baf2f50965cbf27
Message-Id: <172581667952.2929521.14599999722941605264.pr-tracker-bot@kernel.org>
Date: Sun, 08 Sep 2024 17:31:19 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Sep 2024 11:07:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.11_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e20398877b6216023ac311053baf2f50965cbf27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

