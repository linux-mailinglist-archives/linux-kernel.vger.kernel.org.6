Return-Path: <linux-kernel+bounces-282335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8994E262
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA35281A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46291537CB;
	Sun, 11 Aug 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D52MnPwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107351581E2;
	Sun, 11 Aug 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723395836; cv=none; b=araF5hWBznp0YHiIjaXzelSYmdO+6Pt+nu3HsY4PHygy05pQgJn2oxiE/sUd05+/iQP5MHNjbUopTQ7CmTSvt6AHNrvTge8Y7WtXYxnapzqmKDOxQvvTW8JLfPfwh/GsBfdrpFDzOk9uUSP4OrSU1fRQUuSDKY0seE9LqWYYsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723395836; c=relaxed/simple;
	bh=SiFLm+08Jx+EL+zbgvIfRYVNynVZymmO6BsDuzrIMyU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TqjtvtHCVvsPS2HZ4JcUQI39W36IP1He5DGXWwq2yaryM5nU8EFEvWLF1P18QE8m87UqxgDrg4oj4ajm5dyx+1MLO864fRn/7o1h72Y9Gh01qJjAu7WtfZouhUMrC0fyYdadYfbDsAlsvvN81rsVr6TjVHlqL+mW0DGpLxp0N10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D52MnPwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CBFC4AF0E;
	Sun, 11 Aug 2024 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723395835;
	bh=SiFLm+08Jx+EL+zbgvIfRYVNynVZymmO6BsDuzrIMyU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D52MnPwpPEGjtRJ3P9jhxqyCqxvMVsd+ISMM4nxhgCTw9K3n8QgH3GTUAsIaM77Tc
	 Fl2mD5WdJvUVeeS4fviLN8CVnuV2YyaNZbLduBGPHZLUgvqtfIEQQ9W/nIFjQPNHhm
	 t2DsUlbA64rD1y5rUhcj7ncgv2n8JxqPGXdsPSUERGwh1ZGl460F8OFXIfwCWAuXyI
	 n6ghiaf/DKTq32L1OC5Di1F6Hvj1u0+voZ3LJpsM9a08HeQv/U9MmLQEMECysl9S7l
	 tvhcbhP6ZYVEl7WNN89DYdU2uXh8341htw/5mPnN+Vihehc5Do/gUQAHaKnWSIXVRa
	 TPcOqUzfr2ltg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A593823358;
	Sun, 11 Aug 2024 17:03:56 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zri7hMbzgp6fZeAa@kroah.com>
References: <Zri7hMbzgp6fZeAa@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zri7hMbzgp6fZeAa@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc3
X-PR-Tracked-Commit-Id: 65ba8cef0416816b912c04850fc2468329994353
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb2e5ee8e7a04be6a762b51241701b5105b82022
Message-Id: <172339583488.226577.6171358372987428329.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2024 17:03:54 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Aug 2024 15:24:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb2e5ee8e7a04be6a762b51241701b5105b82022

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

