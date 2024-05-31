Return-Path: <linux-kernel+bounces-197357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958158D69AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BA0288643
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9017E477;
	Fri, 31 May 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgZs8/rt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9452B9C2;
	Fri, 31 May 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183208; cv=none; b=DkKWIU6ukv+Urv+XH7HQdg8fD4R7b4A80hUu042NKK798UaKRoqScslhWuJu7y+jQkOfF3qRjHBswvvXFjLuhuNMLRKebrQ2obBbMrUlm4xeiX/ocROMC2CygfhpoNdoTXfNQcxeE8z7kWDuAItNr+JsYUTuVUEpQLTLDmbBNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183208; c=relaxed/simple;
	bh=rBr/FVNGqwJ2ScCPtU/jpwG67hE9JLr3aLNyHkFCW/Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=txiAJVQWJa/3jKbvD0H5kzhbDr0f0NLeqlzGg8ghrz7J8ZDVU7UHdJmfkauiA3qZ9+ODgx/Lva5hicKYSW9vYNkF1OUl3JI8X2UKivwrXA7xHwYg07XsUw43PemY3AwKZXVQTUKA+fp8c4apeKwvj6CjGJzX6xN8ZOgncPcgAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgZs8/rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8CD5C4AF0B;
	Fri, 31 May 2024 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183207;
	bh=rBr/FVNGqwJ2ScCPtU/jpwG67hE9JLr3aLNyHkFCW/Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DgZs8/rtBSH+ijAdTuC/JiPd9JwcW1oorztGSMJxqTD3jcVpMMIFfsE7Hx+/whvSg
	 XJv9GNjuf69BxG2wyfnW8zDWYuQKVZVFtlX4hD4pXlD5M6+bVgnz6V/gvff9dMhGsF
	 3dLraoFjNXQsoClh72LLo+Bjt0pa2VvxKRDqClH6Dt1MTf9rXC1/dzVqreIqQ1jLwW
	 ASdeeZJIwe2Tw94F2dw9aOuBIQuMkpAfODbePGR3Q+UcYFTFxceoF4pckU5OzHULUO
	 pQx03GYVdKyH+w3/F/wVXzw+KfzAPU83ziPC+/deMa1wnzywj6Rwtg2oMU44EnqqnB
	 1h8bbBhOMI1TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBD69DEA714;
	Fri, 31 May 2024 19:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <877cfa40td.wl-tiwai@suse.de>
References: <877cfa40td.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877cfa40td.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc2
X-PR-Tracked-Commit-Id: 310fa3ec2859f1c094e6e9b5d2e1ca51738c409a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d88cc8ecc4cf74ef5e4e4f6c9ae4f13d9b969c9
Message-Id: <171718320782.20247.7547119061633511947.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 19:20:07 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 14:34:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d88cc8ecc4cf74ef5e4e4f6c9ae4f13d9b969c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

