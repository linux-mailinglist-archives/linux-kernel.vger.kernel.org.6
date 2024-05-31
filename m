Return-Path: <linux-kernel+bounces-197601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBED8D6CEF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D811C22E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250D130A53;
	Fri, 31 May 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZOx0FlB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D9136663;
	Fri, 31 May 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198817; cv=none; b=IzB6MZPKB1D2dKAH+I9ivk+FXXABc6PIt+pQZ4ELsafQheE9h/wrUnuyrLFYVF+8w60DiU6yEfdeoeNKKe1/y0l2juAAuc+BUPDvFQf5XghhTxqpNIUXeKq+EI/Ko9Lcq2T30vD+FbtjwmlEX/zB9uFXn697H2mowsMzONvkZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198817; c=relaxed/simple;
	bh=xIDzeLVTCI5nCMCZrK9bk8Kr3OQ8KQXddkPsrCXfeKU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k545Nt6FQ9t1nonEZiqnPNUjhKE++8xHxH3fWcLwGcS9hynGC87ezmcfQnZXAaZbtFrgBQBvmHayvELgBzkweD67jeMowpVBcLfOK6Z30wjHfjrN31Ur074ku9VWscXmwX3frU5BNf0G8iVXPcO6Ie2v8144Kp50j4QA5VUMZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZOx0FlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 219A9C4AF0B;
	Fri, 31 May 2024 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717198817;
	bh=xIDzeLVTCI5nCMCZrK9bk8Kr3OQ8KQXddkPsrCXfeKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SZOx0FlBDlLaMWkgUZw8MoM/QeZfDQvwdcqC4Gcm8G+zD36z76LiSAyooLC7rVMPJ
	 XsP3jDK3GWRxB1b6SnOe4/F4tlJeueoU+YSzMAiunUk+PSlqOxyfGoVnaRMmtmcUQl
	 9RP0T2blCC5pj7kYangVGbXC2mYDNhXIhgaXQa9QLqXXt0kzqrbQbifYKko3oVYVCb
	 iBWeIhuxzR3qat+ru+ufssySCMghbzzheQpwd4X8Rzs2vTJw6Wo3Q8GlfY54Wp6dE6
	 3YVhxPp4L0M6XXrLf4Vpi9bZF0NoPcuVZ6ngtNFKWdVvdk36bRY+e3cN9z8lOHKZXb
	 Fp71HGbeHmsow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 173D2C4361B;
	Fri, 31 May 2024 23:40:17 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240531211836.1399346-1-linux@roeck-us.net>
References: <20240531211836.1399346-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240531211836.1399346-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.10-rc2
X-PR-Tracked-Commit-Id: 52a2c70c3ec555e670a34dd1ab958986451d2dd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b907b83aecac3804e9b0ab2589578e3ba1c9f4a
Message-Id: <171719881708.1891.1540200161083627040.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 23:40:17 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 14:18:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b907b83aecac3804e9b0ab2589578e3ba1c9f4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

