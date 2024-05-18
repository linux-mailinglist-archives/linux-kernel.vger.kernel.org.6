Return-Path: <linux-kernel+bounces-182927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2488C91D0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05711B21258
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95A5380F;
	Sat, 18 May 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa/zj6gn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D464C3D0
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716055621; cv=none; b=kX6EJBgLLiK6wUs16SSMfrDL98zREK6dmkyxc5oy8L3uazyVfaM7DU7F4IE91DQJZ80qWIVzSJ+I6y4yHPmygrGJgfETKnrMqoDMgkfF7qp66Po2Fe8ZZ9opXWKji/gcn7hpoGyTRVWU7U+JGdE4zvjL+OAGabOP4P4gFXWuKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716055621; c=relaxed/simple;
	bh=Mc9+Oq63ll6NhxvNPkRMg7O5UDgNttsShplBW5RJ0sQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jRG5C+L0/R3YVZClXjBEO8q4Ke9XhiBbtCTf5FW5GaqpKAdDLBD9Pz7+LdkLKi4jOpKGqcx+KDr7KDC2yAkExSzGer9KezpFBboUsMu4XtnQ9vJnWCvtRSqhpiU/fgg8ARhMuBGKjA9mFyrqBVlhEQnlp9ChlBspr8ALo8/ulLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa/zj6gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99AD6C32786;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716055621;
	bh=Mc9+Oq63ll6NhxvNPkRMg7O5UDgNttsShplBW5RJ0sQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oa/zj6gnWjswUZ41JAs5Bqe8ye2ak4n3Y5CjI8IKuUlNy1j5jmX1mzdg2DlCJ0JwB
	 yjZESzd7BunHTd2T1SEzvlU7MKAJOs19VIN5J6S7Ew2fL7BVh59Guwy45IdxI3lS59
	 IL8BqOVppbPQICNRnUdqxDK1tRMw5lcDpgcC5y5vnMnxMKlk26P4uakn/k6XKvbTFD
	 Q8ZPDhTow8+IdcMl9g+suYIuY0HgxJUcLAqO64/DAExcSyYO+MQhyAnGvZiPlrLDyq
	 NxPHg9HpJYGNHeChi2u5gLSgxVIyr42v2La4nVUQkAj8sP93cCIkJyu+X+CwezGHON
	 MhLOQGP+gm6hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91B01C43336;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240517150315.2213425-1-Jason@zx2c4.com>
References: <20240517150315.2213425-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240517150315.2213425-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.10-rc1-for-linus
X-PR-Tracked-Commit-Id: 7b1bcd6b50a615671d4dcb0ad0378a2660a1a368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0cd69b8cca6a5096463644d6dacc9f991bfa521
Message-Id: <171605562159.7011.14292727494862318524.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 18:07:01 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 17:03:15 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.10-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0cd69b8cca6a5096463644d6dacc9f991bfa521

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

