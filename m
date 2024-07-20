Return-Path: <linux-kernel+bounces-258045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB05593828A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AA7B20E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6042147C8B;
	Sat, 20 Jul 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJee950b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15614882E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721500956; cv=none; b=bw0eA8UdQvNSLjw5eaRjde8wyd/czyGLE6XdwTDEXElo3XV1cCHmAFeu9xWwNMzuZRTXT5ehj2I9gImoYOX0JeorhbUEAAE/Yl7Sv19oLTc4kUriFMMCIZ7Ml+7REkmhlT4G9+VqwYFtnKJyYt1/HPK4IamKwyBUTQtPQwDVjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721500956; c=relaxed/simple;
	bh=0qS+mgQOXg+Z2gP25RjRdOmCzDK9tZmNo9qnHqk2Wlk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SzghnD67ZeQQMJQxvzGHDWJtD63HMMEyi7+Mwi4WGTwszh8R43Iv0U69PmE/bxoaN+xSHBPNwkZsXnSQ1lHoRRw57hHke5JQhnN/9Wl4+HUoGEshwhMYHnD2K0BAGOjO16uQ9zPaNKelh9sowcCTLY4jNnpMOpjnY2quoJT1+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJee950b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AF00C2BD10;
	Sat, 20 Jul 2024 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721500955;
	bh=0qS+mgQOXg+Z2gP25RjRdOmCzDK9tZmNo9qnHqk2Wlk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rJee950bLgrmXenzINyqIH7pB6rWygnI+vm+4ldaUh6Ek+hQ5fklGWhDj4JLb3Gmo
	 1Jfo2rDTBP1cRi3uncjJ4G5+j3yEUw7hRcaIshBkNWGJUpEj3Z6loeaHLPZcq1uQSz
	 aQyM3DWGLci8SgiP1vkhR/LKJ+Jc/QV0X+Yxr6a8ppyuG7tuDJW6pCcsmR5X10xLnM
	 UZzLTWO/WNLTAPFC48oHNzK0T7g5ZKZg6AhG0nlJCMnUvPKRFNE7d6E297NAkfxwO8
	 wNZ8yciSB2dKOwVkfQ7zm0TuDN23Jqq0q41hdNFL9qlcXIp1SJhb4FHeVHZAX3hieU
	 3igm4SGftHGAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 631A6C4332C;
	Sat, 20 Jul 2024 18:42:35 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240720084730.GA59546@workstation.local>
References: <20240720084730.GA59546@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240720084730.GA59546@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.11
X-PR-Tracked-Commit-Id: 06dcc4c9baa9e92896f00d02ffa760c0988b4371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8326f5e1a47b1a657524678cb62b264a84fbea7e
Message-Id: <172150095540.10199.10734219679678362953.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 18:42:35 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jul 2024 17:47:30 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8326f5e1a47b1a657524678cb62b264a84fbea7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

