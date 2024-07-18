Return-Path: <linux-kernel+bounces-256826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D819370F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23F3B2220A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114BB145A1C;
	Thu, 18 Jul 2024 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXFF+xYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EB12FB0A;
	Thu, 18 Jul 2024 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343973; cv=none; b=GnQoCQ0IAAp73H8HG2bsxtt2Tos3Grs2/IF7n5WmS1Z0nGv25AQjU5Ko4qHlCWQshJpPHgOtQG7+Ys+CD1wLXNijixThs0pxF2POv4Q371F6MmwaEXnI/Sk3GUd5CK29H4EH0VwVtVTPL9FWYEfK8IQ1ZPnXCSDh1ZUiMA0w7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343973; c=relaxed/simple;
	bh=9rB13t5Bqbf/QNbSGuPEqvSYUzBx+ABLVcrEI3smg1I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F5pJcBSddeZ/VEqKeAAC3idy6pNcuErt2OE8cmzdg2T2SPEIrRcpPT4KAs9/X9MZ18lriE1mEO45NLQU15tBP+twNVt62DT8C6h2oAijULe7ns+HU+Fsfbm1BvCx8cO3P0VFj/sMqwgBId/+WLAYe5T1S3aO5ZbEItjmA8YKvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXFF+xYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 363FDC4AF09;
	Thu, 18 Jul 2024 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721343973;
	bh=9rB13t5Bqbf/QNbSGuPEqvSYUzBx+ABLVcrEI3smg1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hXFF+xYaSRVMmsH15Zst3zkx6yIDV2ORB3/ro60y0MEVtOQ8wuG03tW7NWoFUL6Dz
	 K7TpR9rb0D23xRlkyqhX7Qi1L0HxvYjU4V4fY/2Y1W2fkv0hjrYnzGxMuwu9nRzMIM
	 QVx1vPpyBlcITmECAPYkv7xByNtFeZDRnWMctaKO/XmQ7cwwsySfmkP/30K7zZJXh2
	 7cbOo7jKx80x0V0D+pbyXChMqe5rBiEb0oqVWihfam5gYEpILiaPEHRxCwC4BMYjuY
	 hdfCFzpVPN8IUL7r+tuTsX1NmDdcT78DEvueSWbdet2MtEWMLKiPFkdtk8Q8ePc/3/
	 u4TuJGTKHZ0Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C035C433E9;
	Thu, 18 Jul 2024 23:06:13 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfqev6nr.fsf@trenco.lwn.net>
References: <87zfqev6nr.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zfqev6nr.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.11
X-PR-Tracked-Commit-Id: 702418f7559fb1828646f0b51d9ca7c8b9ee7bff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf05e93af423b225fb3e3237e7d46493c7909f2b
Message-Id: <172134397317.16085.9562344871621218181.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 23:06:13 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 13:31:20 -0600:

> git://git.lwn.net/linux.git tags/docs-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf05e93af423b225fb3e3237e7d46493c7909f2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

