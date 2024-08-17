Return-Path: <linux-kernel+bounces-290461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9284A955414
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8D2849A8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557A33EC;
	Sat, 17 Aug 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sw7BzBVp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1F2107
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853720; cv=none; b=dfG5Sy1JT9W42eriSZNGgxRxbdV1v/TmIbB+cu9PJbxHL0UoOPSVuijM/ESUpkWuN9FxA7cgY/ZUi+r4cI6vGQneS/m56wztySufuGzduze1w4MLhBanVsLllpjOR/paQWQAjW2pohIZAmXkT6dMMQvw67VvtrSlxkNlMlFnCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853720; c=relaxed/simple;
	bh=zvzQx+m9h4p2UAlZng4i11hJCOar5FSNrTKPqNizy+4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sX3lhoRlv94LZvBhH79Kv+7IrD2u5eet0uuC87NOgpHuh/5mk/zI/uugmczgOJ7aI45BniW9h1f8Vi0y7PYwvFE2Qht5qMP3lbJOaJ+Bm4Ro0CtEGN+JERMf++qSazuFudnzzuPQLinYgxIP3k2Y4QGdNdNDrC8hCyayACaoXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sw7BzBVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293E9C4AF09;
	Sat, 17 Aug 2024 00:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723853720;
	bh=zvzQx+m9h4p2UAlZng4i11hJCOar5FSNrTKPqNizy+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sw7BzBVpiCUm2P7ZgBId+z4eNbEbtdFHbkPfi6oQRljrCXtapXmvUzHrsVGLdh8e/
	 OD92WaJzTeUJCmEVSagw+TDfcKROUrdSheoRq3BON3Jk+tz7x6Tn+zdI9p+G8K9j7C
	 tRKVqKfMnfiabbT8yHfvrHxpVbUq+jLvag3/vBcaXjNCdTuuDUD0YCtRtwSnkEquVl
	 tk8YMeyq8m3fRoQy+KH3C5SwZXzbdKpjCd/sQFn0ko6H8MlhlOxzT2/AP2e+fM0YzD
	 Y8c2jRWOg6esuDg8kEXUB4j9dcDZeLu7Zr3N9Tsww2j+pGD/VRSDKzJhHnMTxCPWyB
	 vMew51J7Qvmqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0CC38231F8;
	Sat, 17 Aug 2024 00:15:20 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zr_Uvf970W3ceqgU@arm.com>
References: <Zr_Uvf970W3ceqgU@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Zr_Uvf970W3ceqgU@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: f75c235565f90c4a17b125e47f1c68ef6b8c2bce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2cdb13a34d950e61e3b53af0c5f9eb828710beb
Message-Id: <172385371929.3661883.5966912164235048668.pr-tracker-bot@kernel.org>
Date: Sat, 17 Aug 2024 00:15:19 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 23:37:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2cdb13a34d950e61e3b53af0c5f9eb828710beb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

