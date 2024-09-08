Return-Path: <linux-kernel+bounces-320326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74609708E3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28CD1C20C03
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E845535D8;
	Sun,  8 Sep 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcREh1zr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005717624C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725815845; cv=none; b=ghewuyZC5REvgmm/Whf0rTK7Dt8o4MTW8KM6es2C2WzRHp7csCx+b2ZvF/c371hIF3puV5qcmFm05pShCyZ7LEA5hh1cSBO+cjZZxSHBdAZJj46yqqS4lnPOdMYniGFiAA4NA7an0MnfXpwZNv4/zI0FhowkgMgy+V04NECLrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725815845; c=relaxed/simple;
	bh=GDCED7EW+Rha9jRUxO+jdSWh++/5SYMI+BM3kMTCBGs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fIll02i5dwgwOsfveX7zDyuwEf4UyHQudGZ+BMvf2+oeAOZhjvKQw4/EVmQhIlaegTl00JY6eVEqw6XYF7KtSCy90cHnuQL1rDXtf6c8oFGkvmSQw/k3iBO74CKXlICr6ZOKurfkbTJudKdPSbSITt7vbrGZtPWlBj4CICZPaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcREh1zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726F2C4CEC3;
	Sun,  8 Sep 2024 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725815845;
	bh=GDCED7EW+Rha9jRUxO+jdSWh++/5SYMI+BM3kMTCBGs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KcREh1zrF4Wcdq/JAT1pVdCEEyzXdUFvcUZautMal9uFo9HfePKznvDtyw/DzhM8B
	 5/RIxXh2jL6wEby3zvq9tfkOr8tRHk/CaLMwCYEz75IOEFYzhPG+Xhf5AldfZK//bW
	 XgM3RzA1pO/lrzEt3eXh4N0gv1R1Etvhqstwx8VuuWcodBmTMsgW1jEIRnaf/V18rP
	 sLQ5LwQNpSGnwzlZeBtCKvZkaXz+vt+tyY4TeUAQyn7CjU1ecVlPFJ7Tle9Nsh7MTZ
	 is3O2BhrSk/TnheuO5WC3i2m4cU7Y5iq53wTSqbhb8NyqhkHsQlyZippcChhUb9RNn
	 CHcURyFFuWJ4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F13805D82;
	Sun,  8 Sep 2024 17:17:27 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zt1XCZ_1hdVsi5mJ@kroah.com>
References: <Zt1XCZ_1hdVsi5mJ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zt1XCZ_1hdVsi5mJ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc7
X-PR-Tracked-Commit-Id: 48b9a8dabcc3cf5f961b2ebcd8933bf9204babb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dadc1be8fc5355034a8515e021ed557acf5fd17
Message-Id: <172581584637.2926424.9373598374037504015.pr-tracker-bot@kernel.org>
Date: Sun, 08 Sep 2024 17:17:26 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Sep 2024 09:49:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dadc1be8fc5355034a8515e021ed557acf5fd17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

