Return-Path: <linux-kernel+bounces-393956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D49BA7EE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69730B20D63
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73318BBAC;
	Sun,  3 Nov 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfSS5cKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0731632E0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665533; cv=none; b=sJzxS91PY7Dn66SV7EMvtsYzxZu7wCbEMg273uo1/IP96DfelGskN00BvA62W7gUX7A0zBNze+6k2xyoyvCsTezFj+YlORo9mNzkNjEzb3Gdg5awpIUINBO8jJP1jyD/JXi1gftXsKqRgI5BWkmpHk7orapfkJ+adsaNsuI018I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665533; c=relaxed/simple;
	bh=qibV2FfX2NxmtqUMQlNm4CsNKit4BcvW08MXGBpspWw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g1Hsb1lZlkz4Bcr27JrRhssaCCz72FZCVNw0UiMJ1Jbz0d0mjcDGj0Ddu4PLPeJhs+DgKY6K1830pDuKe1bOzvkvUjkSjN6lHb1EK9CZewJtrasBsw4nSIJb5YABHUvxiHKeU25aNO8yh/tpwKBsdjWMbnPnrx2hgDRdSlsEmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfSS5cKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27F5C4CECE;
	Sun,  3 Nov 2024 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730665533;
	bh=qibV2FfX2NxmtqUMQlNm4CsNKit4BcvW08MXGBpspWw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nfSS5cKONuYDNOJL2q+u8FrgLdG3292I/xFA3xUtQ8tgUF1I3TO+cCXaKd6ilTZW0
	 xVM/49L3bS8DHaIli1CA5cAtMTjfZcJ5yPo2QE/b+EuQNkgSF1IpFBDJJNrBNocCqJ
	 YN+nYTDfweuKNhCkA5dM3eaHS0IwCrxIyLDdNei+NxDYPtoU4zbozb5giBr1sijvA3
	 IpDjFQ+TsUc7xonyas1q5KyDElNp44JX9Zx4nwJkNgTePFR0DbKePcEi5nIIqSAARA
	 VlJkZDwXjKGET6Bvv8B/DKrWLy8nwCfQXAMgb10y9Hs4UXXL36Uc2yejR9+XFVit77
	 asecHtSqSggDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7638363C3;
	Sun,  3 Nov 2024 20:25:42 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZyelnAdQbssRy9zg@vaman>
References: <ZyelnAdQbssRy9zg@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZyelnAdQbssRy9zg@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.12
X-PR-Tracked-Commit-Id: d35f40642904b017d1301340734b91aef69d1c0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8529dcb1218ce176d5e84168568f69e1d9de109
Message-Id: <173066554122.3246815.8159883600401176126.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 20:25:41 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Nov 2024 22:02:28 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8529dcb1218ce176d5e84168568f69e1d9de109

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

