Return-Path: <linux-kernel+bounces-234998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132E991CE20
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391081C2102E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985D132118;
	Sat, 29 Jun 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqk4PNfU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42B85285;
	Sat, 29 Jun 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719678663; cv=none; b=RRainelXdKvGBa+QSBSVyj8mvQw6gkc+1lhB31qChc3Ja02u0bgQDrlOkebTlF46ayhx/LqY0XaSlau36Hm3ujG3lhNVT0Zs+mDJLSbWOO9dj6GkMh089KwVodUJHdTYwWAHd3dPjJ/sHbQRBbTVp4EI9KV4xOWM0Jd9z4jY6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719678663; c=relaxed/simple;
	bh=7320p/u2bJSjFBzxKJjXMngqhhW8m2CZf+d0e3p9cbk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KMgP1LjVHehp5uK3ArOVu+juAcbE9qbdcL/kGHQcXR8itbHLncMiwxCdeGcLwF9kIje8tAnOl8MiM2Nb+rUBKjQBKHr085bYt6jZ4cOYALju67qYS3jDMwXIbeUP5I71lYo561wMHZfYM3VTnWd8YzIgmEF3lWV8ltFLuso4vtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqk4PNfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62131C4AF0E;
	Sat, 29 Jun 2024 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719678663;
	bh=7320p/u2bJSjFBzxKJjXMngqhhW8m2CZf+d0e3p9cbk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Sqk4PNfUibRMl0in1KvWktFKtRNXIxZiGWlF1HN92hmEoCoxdPHjKGW85ijOyTcBC
	 W5XACRSEwYs3vI2UG8Q+RL9DNGunJ0/Xl8OqCKUhdf8stf6DqzZwaevVd5zU9ROu6Z
	 k+FDuB3bwngXYEbHWMIfSjL2cBadEZWjkD1wOxo/0ICCQGzG6Rmj/mZYkrJBdyAZqV
	 32Jro8IXIOXoOTSceIDbevujEPhcyhYHnNUHbO4uB8/+O4ZuVcwvYYetXJZThxQj5T
	 XRO0oIW0HZytEcMq4G5vofqWmhqodsObXUjFeETWmCD/yagtbqL4qgTSAZHgekQ6jD
	 F4CmMj5ZB3jbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5955DC433E9;
	Sat, 29 Jun 2024 16:31:03 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.10-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <e472b2cb-a6bc-4959-9b3d-540930f8118a@redhat.com>
References: <e472b2cb-a6bc-4959-9b3d-540930f8118a@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e472b2cb-a6bc-4959-9b3d-540930f8118a@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-4
X-PR-Tracked-Commit-Id: 7add1ee34692aabd146b86a8e88abad843ed6659
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 921863fd9fe2a7d43437607fedfc7d1780e54acd
Message-Id: <171967866336.13026.10694295368478062686.pr-tracker-bot@kernel.org>
Date: Sat, 29 Jun 2024 16:31:03 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Jun 2024 13:07:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/921863fd9fe2a7d43437607fedfc7d1780e54acd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

