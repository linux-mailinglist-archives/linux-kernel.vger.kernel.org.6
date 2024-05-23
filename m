Return-Path: <linux-kernel+bounces-187928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572CF8CDADC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6361F214AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE784D26;
	Thu, 23 May 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj4QI1p8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81784D1C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492487; cv=none; b=tSel55KEubop3MGBVpbausQI81MzVhl05s/shCKA8vpC3LLqzHOZ2DT4Yv6ida1v+iFjoobmAk6tw7rdwBOHvkG20JO9Fa2oXa+EVQraD76xVs7LALlibjLU/AVWxuchMwjLiBaNGqUuq4E/BwtjILzsnAqeQQnStBRpBsZA6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492487; c=relaxed/simple;
	bh=gAhU3SuoHOC/MWsC2OumWhGpqSzC+l/wnu6l27xFAhI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=erKQy96YEjHkvx7l87jFOfWy38PIX5pQBwCAA57WdVzbYYmdaTLv8Qh+PcLYBeeIUVKF5XjzArmN6OLJvVPsFcIAW4/uLXBrt+nYC3ri4ecUT5pwXhX5g6rt+RqEXxeOJ1xtDuEK2kQouFBdZnoixhevPfIx4xl5+mDW2+kHjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj4QI1p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4AAEC2BD10;
	Thu, 23 May 2024 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716492486;
	bh=gAhU3SuoHOC/MWsC2OumWhGpqSzC+l/wnu6l27xFAhI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Nj4QI1p8uZYZtoL0g3054nBaNPN0NekWIQq7ctnfkTRTPY8oSXfyB7psaeQzgKVZF
	 xxGnT/wyIHV2xn8xNy7gP/58+rqn26e+R9xH1Jui5c96jMcfSgT/qPIQmvxqxmCfQi
	 Zqsieg1qtza/+C4C/XU1Jl6GSMEjmDQsARiP7adoA7t7HMNXVg9nX/o+BXYRtSN9p8
	 Svs5xm/3SYblBbHu8vlwrtaKBK3sktAdo/dl6W4Qarsn0HHqTeyceoPanXPFQq/ofG
	 levE6FGLC7duygCsYWtsGJ5qM6y021f+5/BWCRy+d7nRV8WZLeA8JnhI6JxSiAbFFt
	 CYO/iCT+fI98Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9AB2C43617;
	Thu, 23 May 2024 19:28:06 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240523102010.GA9168@willie-the-truck>
References: <20240523102010.GA9168@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240523102010.GA9168@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: e92bee9f861b466c676f0200be3e46af7bc4ac6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b7ced108e93b837f152841ac1f0bf45ed2a6b21
Message-Id: <171649248682.6115.17789616490170790174.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 19:28:06 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 11:20:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b7ced108e93b837f152841ac1f0bf45ed2a6b21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

