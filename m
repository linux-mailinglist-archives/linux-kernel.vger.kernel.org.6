Return-Path: <linux-kernel+bounces-576211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C0A70C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D403B436F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A022580E1;
	Tue, 25 Mar 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taNddJe+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3E1DD0F6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939674; cv=none; b=Fk8k0pDx1fb1CRVH8NXJJ2DBaoFFR6xIMze16mczNTnCDvN3pCxxKMCP3KJE97OIjvClmdA0B7oTknQ/12u4zL7iZK6fAtnUm+QoyfN0Hk7Kk27gTk+7ZXVBi4cK1vuZCZ1gFA3pktJA2X26usQ9OtFR4eHplKAMery2QDIkcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939674; c=relaxed/simple;
	bh=/1HExJHoJNml3mTtvjVeKL/OsCGNQlY8O681pHdx6F4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J77wYp6LVcunZmcjQ2y/8d/xjUUdv+71NqK1ajKAEp3EZLZe5a1WP3SxOKIdSWH9IWsd6D2Yan7eBcPtXJYYCjQccPgs2D/0eAKsJYahd9DSk65RpRDadDfVyPhS7DGIj8L8mgR8Awj+FKoenCVSObNhVYlH4sTt9YW2sb+mVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taNddJe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAD7C4CEE4;
	Tue, 25 Mar 2025 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939674;
	bh=/1HExJHoJNml3mTtvjVeKL/OsCGNQlY8O681pHdx6F4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=taNddJe+Q8O8lJMOSl+m1+LVKRDvlwyJzfj+AAOaFrLBvzDbQFA1qhhz+myEUedS8
	 zsObomku4xGoTUKDRrEkMIf/LJvZDzpBzKABFL2LCxv3b37+mqRcRtw7Hy+ENcvdRr
	 ygP8Z1J4YO7qtrAJr15WTC/N2uozLTdMqD8biJf0zxgdo4NQ4piJDP3TsahNbuYBG9
	 Hhb3zD6GcB3L5KMbKPGowZU7uMrQtooZRQ6T88D3nPai9rjjYwWCazmVxjQdHV4x8R
	 y46sfQ2bcUwIdwHfhcfdMbF2GptYnBVsHln/FVYKc7wLdNn6Eurr6yHB44LKvikySp
	 tGZofpEmMZLEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA2380DBFC;
	Tue, 25 Mar 2025 21:55:12 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250323102618.29516-1-jgross@suse.com>
References: <20250323102618.29516-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20250323102618.29516-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.15-rc1-tag
X-PR-Tracked-Commit-Id: c3164d2e0d181027da8fc94f8179d8607c3d440f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dce3ab4c57e662ae019c22e7c2f2aa887617beae
Message-Id: <174293971067.745772.18284213114381644251.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 21:55:10 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 11:26:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.15-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dce3ab4c57e662ae019c22e7c2f2aa887617beae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

