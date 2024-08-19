Return-Path: <linux-kernel+bounces-292689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AE29572FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DB9282A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA4189F43;
	Mon, 19 Aug 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efjMBf4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC9189F3B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091550; cv=none; b=BxbkIL6XaS1D68vefor96ngbWnQMIPvS7DOY7ywrQCsHhERhG7WvHYdJpmQ7bQTEMkIfJ5nAL40bsFDE8hmE7xku0kq0tEQMfdaXYqtS6zL389e5mitw0SxUbfeS69YWEY3hWrML1HfrJUsvVmGVlt1xamQ/n4Inw6SVHErTWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091550; c=relaxed/simple;
	bh=fWEEVsRP6TZzjl4u0/OTgx0TqJkpp0thw/xKgRqcVcs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cbtvbSb+VBG/+TvU3riIaHZ93y2ITjo0LmRBVsY3viBUixnTP4A0lcRvBIb+ujcYHc8XrYCcIA4hIcvdMZ8KTg7CNH7LYrtqrtI6m426+yoXrA0FlonwcdhLAAXvlrjYUgpS7cHSrWNjja6t8Mj+D7K5F0AeAL/nOB9Mb0Rkvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efjMBf4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC103C32782;
	Mon, 19 Aug 2024 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091550;
	bh=fWEEVsRP6TZzjl4u0/OTgx0TqJkpp0thw/xKgRqcVcs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=efjMBf4HTnyebAdYZRBagX+L92i+bT6l5jfQZeqquj9hiXu4hLjleYRYMB/XM4KnI
	 8EtufmD9tATzK5Mwv8xt0D0Aq74bMP3KJBKtRWzZRELEKPQTihyuj9PrUIfBJt9dlN
	 bPlW6I6n9qTCJJHE/iB9w1j0A/SOIpzqiN9c98rDUtuxGC3GlTvfRpM5XudDTt5vhQ
	 bL/UV6f9aKj79NPO2DhrIFWJi0osfmipdoZOkLb7nf/bUUaxCRGjI0GTwqV97ELg5K
	 JmEhqfUJMNMYo972a9ifCE2RKUwjHed46OHxcZV3LBV4oZKEzDKJTEvd2+ZNUoCglR
	 xLOYC/fNk8HiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FFF3823097;
	Mon, 19 Aug 2024 18:19:11 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2408191951550.12664@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2408191951550.12664@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2408191951550.12664@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024081901
X-PR-Tracked-Commit-Id: 1b8f9c1fb464968a5b18d3acc1da8c00bad24fad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e4436539ae182dc86d57d13849862bcafaa4709
Message-Id: <172409155011.615352.10384375902820152528.pr-tracker-bot@kernel.org>
Date: Mon, 19 Aug 2024 18:19:10 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 19 Aug 2024 19:57:27 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024081901

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e4436539ae182dc86d57d13849862bcafaa4709

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

