Return-Path: <linux-kernel+bounces-416429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45C9D44AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01452281A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028541BC9ED;
	Wed, 20 Nov 2024 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5czxUKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E431C8788;
	Wed, 20 Nov 2024 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146610; cv=none; b=TZ/ae3chvLnJW81k0IqYnI7t0g+LoPt7kW8H/pPWrYridO/EuNYt/G6Shut3X0+mIuT+WyIdOZoPyE8URW6av4k3hH199IbBnV9OExecbSJJQTr0qbvUuwPrXliM/zFOpgO04PHNSlisT9foK905u1RHo1JRfrO6cTU1JkUpPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146610; c=relaxed/simple;
	bh=K0kp5tuf+SSXDFO60de17alvWz9vZ9z4wreFG2rIQ8U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CAY0m/HHPbU+L6xQTZ+yWAIOYqWbBihu0i7PYQHPvuzH47zKDkZ8I71+rXKivJIs/hKFPv5UFu8M5+C20FIwiaLdi1JhP+QLPV18Dfkd1DI/G8NR6heSO4rHEGkE1lORY7c01iojBGhSrJzPBfMocqH6Mj0f682amdUhAxCiG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5czxUKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3228FC4CECE;
	Wed, 20 Nov 2024 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732146610;
	bh=K0kp5tuf+SSXDFO60de17alvWz9vZ9z4wreFG2rIQ8U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L5czxUKUUcd3GweV91+TAWRp1vWiS5zqyynUN6TjbTw+n12jH6rF/B7cVhiNAGFzC
	 nxTkRG3djaNHI5Kh8SgPxHLg0X35Sja49/EQyc0QCLK+abHciPM37ffLR7a9b2PdhS
	 Cna5hsnplt55CjAWpPlR6yaDtbhewYDeIgrZs2b4sEqsSFqwkV73exXQfQ6HKguE6E
	 9pijnHbNI5qwWlJAdVj29iTr9cqDWNb29TSu8Ku/8lN2JvDF7C0pAXnwE6HC9O4J5Y
	 Wz1vZaFLeZ1GQL6gGySPNe43HPRf9idlGnpnkvXGwV8zGxcTheiLLp9ssb7zt33+wQ
	 HN//T3Fsqx/5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1B9B13809A81;
	Wed, 20 Nov 2024 23:50:23 +0000 (UTC)
Subject: Re: [GIT PULL 1/4] soc: devicetree updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <8fa23f93-385f-4996-8298-2271d259b352@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com> <8fa23f93-385f-4996-8298-2271d259b352@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <8fa23f93-385f-4996-8298-2271d259b352@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.13
X-PR-Tracked-Commit-Id: 9f5cbdaae5f760c218c82e0a5e0f9c58bac56f0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c39d5ab450f7181775957000f4aff33bfef9f7b
Message-Id: <173214662175.1393168.2564138699259242655.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 23:50:21 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Nov 2024 23:59:30 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c39d5ab450f7181775957000f4aff33bfef9f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

