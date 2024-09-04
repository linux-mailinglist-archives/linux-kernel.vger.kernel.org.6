Return-Path: <linux-kernel+bounces-315551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D396C416
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4146B27183
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427931DFE1C;
	Wed,  4 Sep 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBj6AlS1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E961CEE89;
	Wed,  4 Sep 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467146; cv=none; b=bBCt9t2ZnaHQfuOVQmt7lpOxtmVufuOS0j48WCsfGyI06hBv3RPAnEp3krDWvLcY39C3wmPcbbVpBxtTp5p/kOoY3df5CPMTRJ1P08xxYHOobG67qsp1KY2lgOD7Xi7lMXfbI9NfuwIrfIskvE6+ixYgoC4JZe8eWtKRuVYshG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467146; c=relaxed/simple;
	bh=gIYjTNc7eswIUDU04rhveE8Ewd6vxACHegXfnPvoeYs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EBM5HykGOXM46Sg3pWc29LQvBPvNKdfObpPd7aGPyMZ413xVUtJ+djX41W4iED90D6/+5VBgi39b6aUOBWhC3Q89JtT8YPAFJPqC0xY8VqRssTrH2MaqgwnHldI6fll0a58QxEB4iHZ5WQbqS0cTCAo0ICNMw62yQXNLMSwIIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBj6AlS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9B7C4CEC2;
	Wed,  4 Sep 2024 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725467146;
	bh=gIYjTNc7eswIUDU04rhveE8Ewd6vxACHegXfnPvoeYs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WBj6AlS1erIkbGm5nT9ZxaaOflWSm/VZXTZFFuhgEm+1ATs3wHVcT8+W5SiOfXI1V
	 Lw0yGF6/GjIMpM38rjSN5zAYZi+YMuIW8Q6yWyNzFYY2U9eXAeKLTSlq8K3im7YiVU
	 IBkiMxI4Wdn/TOl63r3dqNlzPD68dxUitQEClUsE9Qqbp5k9RCq3Y+Mqrj7j+W6G19
	 GFU4HWkDIRjGv5vqmUUsqmD25o09HGmFaHpQolTwN2Y2u3fJoLgTaxeQLMOIODmNri
	 Q52fP0Jygw/7EDWmepuXKtoEPWbTjPZN444sYH9CpXqY1txsIlDoYOxa2a5mk3hv7P
	 +A7pj4Hg2ZnsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F1B3822D30;
	Wed,  4 Sep 2024 16:25:48 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fix for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZtgkFznSCnkAREgA@p100>
References: <ZtgkFznSCnkAREgA@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZtgkFznSCnkAREgA@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.11-rc7
X-PR-Tracked-Commit-Id: 213aa670153ed675a007c1f35c5db544b0fefc94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 962da4d1be82889af5b9cc0f718e5eccfd93cd2d
Message-Id: <172546714675.1088236.5769185238439618869.pr-tracker-bot@kernel.org>
Date: Wed, 04 Sep 2024 16:25:46 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 4 Sep 2024 11:10:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/962da4d1be82889af5b9cc0f718e5eccfd93cd2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

