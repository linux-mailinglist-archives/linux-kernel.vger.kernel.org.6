Return-Path: <linux-kernel+bounces-361875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C02599AE36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799C01C25876
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ADF1D175B;
	Fri, 11 Oct 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAAYxKv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D471D1721
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683082; cv=none; b=oYTdbmvMTj1v4yYG3QM7Z5zFYWQ+YVmruAK1jT+PA1O6PeseCaLVZc+UIhnngWG91Kox7lbRaNxd+TlBh8Z1DBQCx7Kf8G7w4KyizQq3IFgt6jwsV8Osoxi1OOaQQJJ52vz/eJJy3C5JMy9i4nQBZPmLYZW0Y2wtQmNpB+ILPbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683082; c=relaxed/simple;
	bh=lyE3IdLoFf6GehAflP7TZsS18klwfqRvgYqcD7Rf8Zc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OhfQalprWJEs6WaT72W/wI1dbYLNsP1Yh+8n0zYXsN5VaL8phIWaF2CvFOADwvmZvjp2UtemcsmXjWNotKka7cFFlOZoPogZltizbP+TOlaqu/KQj/+gOLNElpKzWvxoDCy6DCXY0Cc5JgvcMuJTshXrf3y7GdDWlMa/JUrqGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAAYxKv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B2BC4CEC3;
	Fri, 11 Oct 2024 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683081;
	bh=lyE3IdLoFf6GehAflP7TZsS18klwfqRvgYqcD7Rf8Zc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SAAYxKv72iVULX4VtGFuI3aorGuCI7MpN5fbkFtsFQ+OaMJh8VCnaiRj5IXPLYCxP
	 N36xM1phH6y4xR4cbgi+sAy7zUtwFYztFROoJl+2Nnn4uyMcF/fPYbVGhzrdfW/DDi
	 8j4Ry7ecAbIfbtAQNelfjGX4ipsSy8FC5la/tQUbp5W7AoUeonwa4P0RBXqjQg7Lvz
	 NKwxE+5HP0ciML2icAGjXfKuSOLWem/kCO4gJp+7PuFCPu1s+BozJRoEbbEliHdEE+
	 6aZeV2ulFhxrDzH/SzsFGRTWyN5CR5SdJN59EszQOrEIgdXL8gZ/NlfzbrG9Q9jTD3
	 3ysdDl7TILyYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0BE38363CB;
	Fri, 11 Oct 2024 21:44:47 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241011122752.13233-1-jgross@suse.com>
References: <20241011122752.13233-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20241011122752.13233-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc3-tag
X-PR-Tracked-Commit-Id: bf56c410162dbf2e27906acbdcd904cbbfdba302
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d947d6848a790616d6d2ca64097b6e818ffe3017
Message-Id: <172868308617.3005321.8107316848439661327.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 21:44:46 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 14:27:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d947d6848a790616d6d2ca64097b6e818ffe3017

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

