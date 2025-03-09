Return-Path: <linux-kernel+bounces-553324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE1A5877D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F77B188B4DB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E71F5846;
	Sun,  9 Mar 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJMVOGHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB323597C;
	Sun,  9 Mar 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741547887; cv=none; b=uwlb5LXVa+sSHKsWBpnNILn/vCRRBaSZ+L9zh4fsi5bWXnGAyAT/cVGeMyen1Kme+F3byGJqAHQ+d6KiLPxUZe6+9qPEz/f9d9w3ljOXNv2KJ/rFneWNnIqBaKEZab4bGs+7rkfqKG3J0qb1OndRXZaqJ5Y+/y4Y6cQvdzh73yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741547887; c=relaxed/simple;
	bh=/53ObuUjLlP/EM59pStyhPSx2g7tcvmB69FL+tVqXwA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qmIEKIQGUrW/ifrJKM0f+Emir4FIi137YPUVZsPFIneZRu0FB7sFp6+BvlQ+TA2eTFqYPQaiZVYDapQgoOmDQ28I1YxQO7NGmt1mTrWlrzSuBiucxeZsVeO2aGlbtiXrN4iPKSmPt30UWe89akK/dYhgnEftI43ZL8vlGpOfAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJMVOGHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F85EC4CEE3;
	Sun,  9 Mar 2025 19:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741547887;
	bh=/53ObuUjLlP/EM59pStyhPSx2g7tcvmB69FL+tVqXwA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VJMVOGHMkmJ90rZffj2mCUfsohK51mNVYq2TOe/Kr3/l0A67QHbDt09Q62dNLaIJk
	 sF6cxegknoQVOo36RMnaZ5/76egcykUzKOQc3rRYrSkEz7W2Hu4wgA6TOw2RY8k9/x
	 EG6c9Zm7+xxiJN2J6PDinZqhh8UNARDLUfrmmVpRLmgkmraWnxw2JGaUJh7Upeeneq
	 gFFYiSacesqTkNS1oblzFZZnxMRSkrkdOnAtre1AsCNDsgsOmKxZ3vBFrcLSQ3+/DR
	 w3CnYJd2xVlvy6zWSoQB7aTGZ9OnmSJ7Mp4ePATrP0b1JpNF0o+3d0jywlj8jvglrU
	 5GibKR2Z3dcTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE410380DBC0;
	Sun,  9 Mar 2025 19:18:42 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z83TQTyh4u64yFKF@kroah.com>
References: <Z83TQTyh4u64yFKF@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z83TQTyh4u64yFKF@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc6
X-PR-Tracked-Commit-Id: b13abcb7ddd8d38de769486db5bd917537b32ab1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dc1f314f854257eb64dcea604a42a55225453a9
Message-Id: <174154792118.2953179.4577195258374637866.pr-tracker-bot@kernel.org>
Date: Sun, 09 Mar 2025 19:18:41 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 9 Mar 2025 18:43:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dc1f314f854257eb64dcea604a42a55225453a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

