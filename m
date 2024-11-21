Return-Path: <linux-kernel+bounces-417310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C59D5255
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2483B27414
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98171C4A37;
	Thu, 21 Nov 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqnk2ce/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9401C242C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212324; cv=none; b=SldefpIzBiRB0aqwmMpSgUjJAqtCtcM3dtwSjG8WemtntVuv8+Gztt6zeroWUfyojnU0mPjbV4w1gTOnkn0VKMKwBqLI3mlzQZArIqeYXKMzvK6juJn9HAPRG89IPryjWMXaRc0IoU0Losd0LOw6vMukKMApHCswmU5Iy4GIjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212324; c=relaxed/simple;
	bh=x145maFELT1xf0Ew8K5/LYapqSlmFJ+ICIPNKO2PBlM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JK/X9EsHna0hYXCbts7VquvXYbggUG2vVFq3/wcxPUX0zuheyGq2UhtcQSpZK/UzBjXeunGFKDMqV/9HLLh2+tUj2hWZNkHshvjCAwiQ2yiQBWnLojhh6TNnMImToiCnlsHeV3ZWCH3hn91ROxg9MSj9cgaJrFgOcKVYir0a3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqnk2ce/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72E2C4CECC;
	Thu, 21 Nov 2024 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212323;
	bh=x145maFELT1xf0Ew8K5/LYapqSlmFJ+ICIPNKO2PBlM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jqnk2ce/zLS+TaUGfg/ult9SIGpmvi4JXi0jMy9QJUFvtq8zx0xc46/ZJTiyQyVC2
	 JwzQoitjKignRfB4RzJRmg6cPGITdz7ApZ/knMgTsImTD2Wuq4H6Ooox1hClFUch3K
	 y2K6rDnB7sBaGD8g6x29FMrxLNlCLbND2yLe8uk3ITMkvtWBou8ETkkicURPnbBQL6
	 oDCZQI0kEBq6GcnC7Qcvl9Gj0MqwKcSd++TwSpTgytpht79kOO4I9iKPG947ixzuM2
	 RWvkb06qdud9+Tg9Uey+QbqOyWtDdyPBZI4DvMDYXSzQ5dGvMVX0UzLGo7PK0B2y+f
	 07nwEIVp0VM4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE863809A00;
	Thu, 21 Nov 2024 18:05:36 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <9c4c2b58-be98-42c6-8ae6-582c60bc9f7b@oracle.com>
References: <9c4c2b58-be98-42c6-8ae6-582c60bc9f7b@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9c4c2b58-be98-42c6-8ae6-582c60bc9f7b@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.13
X-PR-Tracked-Commit-Id: a174706ba4dad895c40b1d2277bade16dfacdcd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc39fb56917bb3cb53e99560ca3612a84456ada2
Message-Id: <173221233541.2032550.17743406020495170747.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 18:05:35 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 10:08:53 -0600:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc39fb56917bb3cb53e99560ca3612a84456ada2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

