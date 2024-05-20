Return-Path: <linux-kernel+bounces-183971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BBC8CA0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206441F21C77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867E137C5A;
	Mon, 20 May 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uyy6XQiB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE8137C38;
	Mon, 20 May 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222840; cv=none; b=ZLsk7nIwvUQTl64ETQPLyUd+aIPPtButc6O2PCNFvKN8NPtkicKGhxoDrzLv2PUXtUWO/BO5E/wptnbYrWKZPfUp9vGg2aEx0caBzxo5DCQKE5JzvwQ53inJ5u25D51NKCuIjmForg61jySr51vDtdsNNSJdOmhEVvf/zoDx0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222840; c=relaxed/simple;
	bh=bncJaobV6T5P9tfPqs/N4aWl2fN1kCAd2p1qWFETk20=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UqJ9PMLbwhz4C15uiB/zaojcnsbWLKsRvLWUsp2Ef0OpN6k/9m3BLRO0CPJ+sES6TzczQqWXUwFDA41dlmvN9smyS+SUHWPzPaSHYiRrIgotjJiwWnV8LGkFDMeztoWzdaRAfPkGJST96pYob0oH9B1hJZoJ5gPslhr/N128kFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uyy6XQiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E01EC4AF07;
	Mon, 20 May 2024 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716222840;
	bh=bncJaobV6T5P9tfPqs/N4aWl2fN1kCAd2p1qWFETk20=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uyy6XQiBnwCOcVPq36981VzljHQe7CShdiA6bmwIRbRmorPwfHwzjyXQnsZOJa/91
	 5sQlQNNnGTZLZhVEnTt7yIuJJel4FVxOd5dCfTUULCtqysr2kDJBWtCy71EcNU5QUk
	 sRlftNpfq2Gq+gIQz31N4D//PLXIFm57iHRAMYuc5qp7WOUNkZdFtrzLOKJQjDNcpW
	 2Qf1s6YOYFrSwO19jmoFh7IWH0KUumuxSdJ3wyWrvu7wLnnChzpPFkojng2REsKu8J
	 0pPzv9NB+RACebwPf6ZiHo5wt54A8pdp13xV0AwUiBhB1J1AL1wdNYnwTyzjv/ycGR
	 C7c2LtZkwHjNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 562F5C54BB1;
	Mon, 20 May 2024 16:34:00 +0000 (UTC)
Subject: Re: [GIT PULL] pin control bulk changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbKNem0KB4W9a6R7o6e7V4+eh9cLMKYV0xv5Hv3tEpysg@mail.gmail.com>
References: <CACRpkdbKNem0KB4W9a6R7o6e7V4+eh9cLMKYV0xv5Hv3tEpysg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbKNem0KB4W9a6R7o6e7V4+eh9cLMKYV0xv5Hv3tEpysg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.10-1
X-PR-Tracked-Commit-Id: 83906257f2e4441a4610f83ae24a713ba609b64a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2de68638aa7c0da594d23b1aa025fc5a801c427e
Message-Id: <171622284034.31783.13668525475084512425.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 16:34:00 +0000
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 09:55:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2de68638aa7c0da594d23b1aa025fc5a801c427e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

