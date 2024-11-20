Return-Path: <linux-kernel+bounces-416312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243B9D4328
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6FB28414D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7A1C3046;
	Wed, 20 Nov 2024 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjPy5Ecb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9AE1C1F24
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134962; cv=none; b=dgSeZR0NAtu6pwOOC6yZyquhidGztU6zJvXifRGevzprShH9x1QzQsLsnguiiypOhKYbidPcRZFWbPsfve549gLmgjuhvyFFUxwOpNb5nrF7cCV3VWadVI54NO0QOYEOvv/r6rOMvs1QQxlAOr9td7iy7HoV22e6SRBYxSAjtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134962; c=relaxed/simple;
	bh=+YvuHZP0mZaSRLwFpsXizQifQHNms0D+6JQlwF7ddMw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CyWeOMaJv42ffRwf4rB2c4M+ohrDw61JKSm8awO0YxstvMMBtesR08MnMraVRoWm8gCdiiBNWeJzPfl5MjekTdOj5YkqBhnnMrp/Wy76lQOOV+Ufb1rDt56NzeH5mN0vkwp3k1sgflUrUw3HRjkKIbitQdQrBEBjf8GON8NkISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjPy5Ecb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD22C4CED0;
	Wed, 20 Nov 2024 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732134962;
	bh=+YvuHZP0mZaSRLwFpsXizQifQHNms0D+6JQlwF7ddMw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PjPy5EcbMy2MsdqH9gPA4fooRkZKyExufjOYF4fWaavo22oLbPMaWe/puQdTSV4rE
	 Vs2WHHBP9LNBJ5zzf5pGJptSB/z8p8dDILGLFZ0fE6q+qo1qWov1fZYlWZ3J3hWf2k
	 WIOD7nTFnd2HaJAs0l48F/QJcfwsF7HgCAWaFeLDIvgHJMUIo6y7QSBhXirtJ6HmvO
	 bMgVT27w9+6SYJLAj70kHzTEmx8B4mX1p8WX9/aA3I0mU+vhl07JEO624cGgwsC27K
	 NZT5IS2R0iIamJ7tJRgI2hT3DBHxQJKgiMFt+P4XlcXjzVPkRrM6xOa237DL6iGEuh
	 DaTgA2JM+OK2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C533809A80;
	Wed, 20 Nov 2024 20:36:15 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <4aa156874403b74722254e1e25ead0e5.broonie@kernel.org>
References: <4aa156874403b74722254e1e25ead0e5.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4aa156874403b74722254e1e25ead0e5.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.13
X-PR-Tracked-Commit-Id: d1f4390dd28ba110f232615dc4610ac1bb2f39f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37c7d3538af469c2ac8d2d379f699e71aa3c6f37
Message-Id: <173213497393.1342014.7241108927035551685.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 20:36:13 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 13:32:32 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37c7d3538af469c2ac8d2d379f699e71aa3c6f37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

