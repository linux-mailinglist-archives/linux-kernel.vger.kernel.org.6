Return-Path: <linux-kernel+bounces-416430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9B9D44AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09A01F22811
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7061C9B8E;
	Wed, 20 Nov 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6izKz6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BE21C9B67;
	Wed, 20 Nov 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146612; cv=none; b=TvCwsblyuRlhJAKQJnQZh6+Mad8fC8RBcFGppMIhH39tDy46S4ZMBV5g11obHKifnaSXILX5hC3XaxVVQcg85SqCHZgvcFiJqw4uYzCgzB5QLSS5yJ5O539ewTjXX3610M1kL1tPbT6LLgwrYZK3SXpev5Sm8LliLxffAFKsMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146612; c=relaxed/simple;
	bh=HQ5A1yokKPCHV5kFD004ybZN4KKPgyiDvQvKow7LwEM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WYy8mA0fe22t77YPKwVNSl8lar/I2TsgRfWZ4wfKdxLpR3rn/F1cO8pONwLhD0hqO7dHfR/OvU/Ol4J9xYuD9EnAC18mQHsmaBvuNjdqTTZG3kEYN6i6id98XY9PHjlMpKOq46rEesbrsfwaLQvLZ7vgBA+Ra/Clvl+H0TDdK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6izKz6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7A4C4CECD;
	Wed, 20 Nov 2024 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732146611;
	bh=HQ5A1yokKPCHV5kFD004ybZN4KKPgyiDvQvKow7LwEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V6izKz6M/8jvz7usGh9IMmiBql2nzbS28yC3Lkg319TrcyimDKrtLIKbAMdcKZ3xB
	 wEt8vIjJ6ssWHcjp6W5JkKsZCxG/RichdyXdOlcjW1a1JuFQdKGQrjkXgojpUi1alC
	 hV0p+0mtsNsv2BaCt3jj9WOhC3dwEnwOw3sdiTTN4Dz2bjmDCnF77r2oqs1XZ0Zy+n
	 8yh1wpGga3nfbHdwVEFMKbJkQj4HO+UyDXxc7OvLdt8EPdDsCZsp3P8zzP0oM+XGUM
	 hJxMVmLRhMxHN+K9j4GIZdb1qyGVA/aBAz+qQb/T6xEo4ThJI0Hg8o9OEm06jfAY1S
	 auWo76uSEvi9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5193809A80;
	Wed, 20 Nov 2024 23:50:24 +0000 (UTC)
Subject: Re: [GIT PULL 2/4] soc: driver updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <0fe1a527-1c58-4ae5-963a-3becfb8ba28a@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com> <0fe1a527-1c58-4ae5-963a-3becfb8ba28a@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <0fe1a527-1c58-4ae5-963a-3becfb8ba28a@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.13
X-PR-Tracked-Commit-Id: b77587ac51d2fe4b9d5751662ddc083d19153662
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14d0e1a09fe97a7524ff36baa695900cb0c10c23
Message-Id: <173214662369.1393168.4637739267331948761.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 23:50:23 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 00:01:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14d0e1a09fe97a7524ff36baa695900cb0c10c23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

