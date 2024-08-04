Return-Path: <linux-kernel+bounces-273937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DAE946FE5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143EC1F21378
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B7213AA3F;
	Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbNxP0LE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5D13AA2D
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790464; cv=none; b=OQnbTYj9i25wmaRk0MI6Rz/E64rnvD4yM6AIsp925W7qAXmG/g+euL6khVuSx8Adczmhy0yS27TdCIb5nv+qvnYPbNRd5HH2+wDBVPHmZIwneN0P2fVjAMbQZB+rfImgeXK5vzZlXGhXfVyMx2MbhnjTX+qhM2qARSFcru5pb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790464; c=relaxed/simple;
	bh=WaULJXaojRof+V8j7bl0GdIhwI9pkzsA9gT6qkAJ4Ds=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FZk3nOq8tCEdW/dsSMw7TXpuGHjX7YW5SHZa93qurWLaF6c5RDX08Yhd3y4Yjkqbyu2c6vXJ2GoTf4CZxldayzGXTGI2NuZduCNWJqrAteoS+azoRNr0Xmbp75AFkYyZH3pGywPcj9s4n+re1AQvwVwxjdoGfXKpM9fGSC1WaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbNxP0LE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B950EC32786;
	Sun,  4 Aug 2024 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722790464;
	bh=WaULJXaojRof+V8j7bl0GdIhwI9pkzsA9gT6qkAJ4Ds=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YbNxP0LEQhcn5EAbX7+79DNG8h9ZH5a15UaQgJuZUJBNALTiuVoR3YVmfFtj+RasK
	 axkqz5anOLbR2DIGcNuVv23dzUjcRT0QohFruO9XcxNLO34VMaXid5csao3vfQMWsR
	 +h5Kq9dE5XR9EgNWEAbSvkUsSKzIjtQiV9q6fWSAn7+gAlwm72HA4LQ8o9b8CA4Aid
	 KE5AWXcioTjk1NGl0ioezCpUTnWmkhE0NDdTPv7+A+ugJDniWoYsF2Pi+/AXzAgauW
	 mLWnPmp4t5jfyfDe6op6WKPmNizwfDZPO/Ky8dvY/YlPi5TUlZA3LEL7sBK+ZK2Xde
	 LRj47J2a4OINQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A50A2C433F2;
	Sun,  4 Aug 2024 16:54:24 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <172277654174.866296.10517632866315552419.tglx@xen13>
References: <172277654174.866296.10517632866315552419.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172277654174.866296.10517632866315552419.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-04
X-PR-Tracked-Commit-Id: 6be6cba9c4371d27f78d900ccfe34bb880d9ee20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 953f776459a83f00ac940dd67c96d226d7041550
Message-Id: <172279046467.9825.14043543540778514784.pr-tracker-bot@kernel.org>
Date: Sun, 04 Aug 2024 16:54:24 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  4 Aug 2024 15:02:51 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/953f776459a83f00ac940dd67c96d226d7041550

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

