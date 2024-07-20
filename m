Return-Path: <linux-kernel+bounces-257749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B9937E67
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A51C21D1E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD21E572;
	Sat, 20 Jul 2024 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hth3dMwb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E46DDDF
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433955; cv=none; b=bZoQrFLojdTjbYg5NlLXVv/P7Q81Eft1ELfYBWcTGM+kyPgEq2FzZ8GcIM9qrMXtCPtX8wk5o3uBkc6W0FCd3g6efoQazebBJQvpbPkBvi8Nlz/5EwotF6xJzUDn+JzOdPhD4O1ERloNH7ScfVS18bef/OsPypJvJQACsuxoLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433955; c=relaxed/simple;
	bh=gUG4qxLykGLWDbzULut4b9s08dcdQaEWbju1NxxTj+Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BwR6/Z5zSKdS1Z3wLI7BxqMqP9y/PDXLK+kriXCxfsGsg+UtG8lM+9EQdUSIPOYQwih6xaIv6lliga7TyS5RxPYgLTpGmXUaTuXx3zMZuWcsul7+EQRCnJBuCXq5GAIDkUZ1xDZ51oXIy4HMlwOA92U5Cx4znAtpoMijjOEa6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hth3dMwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD1CCC32782;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721433955;
	bh=gUG4qxLykGLWDbzULut4b9s08dcdQaEWbju1NxxTj+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hth3dMwboYSMToSN2eCvzD11CRpZMUFNr6yj+HiZcVItZgrgDlZs4rWvNjQr/wMRF
	 uORV+xzvW/0JEIK4tyuSma7KCE/bTIoerLtfhnL/Cf6hGAerJKm0TNk/GVL4n4Nqqq
	 hSCclKjcHzhLUPRw97CPvPtbWvVsK8jkeAScoc09TvcZrnSqQCIuhmV6upfC0w9YGF
	 F5Zwd/5XQ0Xw3iagREwPpw+TEhzO4KB9xrgQPWrtj5NIHm1ro6I1DWjKxaXvsx7OuT
	 6GJBta41yyt3KjJryvHHk4hyc6FLeAc2CigARNk4hVK7JQ6AaQ4+MZUxtaDoymyE+4
	 31Pe7ZyUvMSRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B289CC4332D;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zppbc65te9pxYeEx@kroah.com>
References: <Zppbc65te9pxYeEx@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zppbc65te9pxYeEx@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc1
X-PR-Tracked-Commit-Id: 5418e6dfc905b3ccc1e01bdad97d948697b20100
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acc5965b9ff8a1889f5b51466562896d59c6e1b9
Message-Id: <172143395572.25682.13664065509619645745.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 00:05:55 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 14:26:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acc5965b9ff8a1889f5b51466562896d59c6e1b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

