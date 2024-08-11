Return-Path: <linux-kernel+bounces-282337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72F94E264
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F090B213F1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718615AD9B;
	Sun, 11 Aug 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf7+D1u5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE5158539
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723395854; cv=none; b=Shuey0x/ct6r4ufWgJ38N+g0FwyseV2ouZ96LZLyDlwL8GwuhaDeX+Q5C1p0NpxSHwhQfRmgPIgK3mR2T34t+w/gNudNvbftu6veWrUr2zjWVl2D61DnTTkHYnD13BGhqU/sxw3tWB0Cv33Cl1kP2gNyZJvCCosbIrXvuTAic4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723395854; c=relaxed/simple;
	bh=82b0v6y1XWiVYqQrJMWSXKUeQ3BeZm+lLBgL/J60aFs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JKH1wDhzGJV1gK+YNvTBpWUWMJPzMlidrrkh1i3VBwpwn7EG94blsU+khL1MrUWTV3cW3Nn3wvnI4Al1SqEawHFIvg9OaEDJOXaIsd2d93RaaVaAZ5UpHJM17TxzgHWBGvs5kufK42MBCP/Qzfcr2srRkkahVxD+Wm87ZcBsQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf7+D1u5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF678C32786;
	Sun, 11 Aug 2024 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723395854;
	bh=82b0v6y1XWiVYqQrJMWSXKUeQ3BeZm+lLBgL/J60aFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hf7+D1u5SvXaCqUnZp/RPgbYfy26rVN7Ue4MsJguFFTXoLqWfcBC+y1ni4T1aOobz
	 3o8BsAH2W/CeOFjsjpsZnZCdCZWfrlOIuquwR3+hTcqsWlzBQN9uPyLh8u61FojgS4
	 OgMgCx1JSy7KNEV2EzghYiHU4YFh1pHaxg+qwmX7fZaj4vPnIr7WVzWS3NGPhJBv4c
	 RddthZt86NKa/wjEjvTnx7jjxhjRyIJ2PMgdsiDrKGTPQGypZFrxhu6tgB/I9sjkRY
	 tGvz/wbsIy52iBsrMGjaGYsdIU3jYY1SiNZ5FDAHyWmpg4SllpGc+18KMKzLgPKfSM
	 vP4MGNKav9g3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AFB3823358;
	Sun, 11 Aug 2024 17:04:14 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zri7SXl7mFsto0MJ@kroah.com>
References: <Zri7SXl7mFsto0MJ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zri7SXl7mFsto0MJ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.11-rc3
X-PR-Tracked-Commit-Id: 15fffc6a5624b13b428bb1c6e9088e32a55eb82c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84e6da575215154cf6aa1e17661989d3b37bb3c1
Message-Id: <172339585275.226577.17928171501426441385.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2024 17:04:12 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Aug 2024 15:23:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84e6da575215154cf6aa1e17661989d3b37bb3c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

