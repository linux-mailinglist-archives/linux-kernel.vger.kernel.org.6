Return-Path: <linux-kernel+bounces-561010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96502A60C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E98C7A46CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A31DFD9A;
	Fri, 14 Mar 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGLSKGKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47D1DAC81
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942645; cv=none; b=OxtGBVvSzcYdqbCjaM91ai4OB7/X2O5PRxK+NG2ez7i0yMAr3Zu5i0dOYtJdRYORclP0APCw8eXSlN/x2Z2Brhpsp+d2HzJaF1FMgVr8LhHnyqDUg3bgxbfrAAD6BsTtlPyy5xHLXCc/xmcwCj9OyvpsgfBZWP5U7+FPYQ6//1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942645; c=relaxed/simple;
	bh=+MJQZxMv1E97Gur8vHENlU6nu0ctTvq036HNbgTS6S4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B7/Rsilwux7pWTJMLgdFSrIjH1q6z7wrGFFARt9mKI1T0CRzShzYHZBjCXDjY/ZTVMTPLxZAWuQPLuJTIv2Vd0gTw+BK5RsuXcoaOQB7D+LMzdzwD+HRATaJ9sQ6yBIMQyrKIXF7mS7vrnaCo27+XYR/WKA5zWsqA1DuY3kL/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGLSKGKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF27DC4CEF0;
	Fri, 14 Mar 2025 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741942645;
	bh=+MJQZxMv1E97Gur8vHENlU6nu0ctTvq036HNbgTS6S4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LGLSKGKOGs68klnK4TzY6gwH1i+rYimvMcc/Y+oMyRUdCS3b4m4Ekx7qGkqP8xEE1
	 T1ztpLXpvupFwS4nmYVsy269gFIqtmhSSB+qOAAJr6FFNGmT4xPn71QLolJPVK0V4l
	 RoayudF8ovfOkAPe/lZR4Nfc2CwQ4zWJsTzT2MQbc3Im8O2QRD0TAMyrNYsn6Cpwmk
	 dkp63TbJCPzus6NkoUL6Bm7avQVLKeFWXlxIMY6xeD3TbP+MGttx3WeyCGUmAB26dv
	 TNdIv94nH5ZGvnhFPsRQAnzPWvM9AciwUw7akzzNir2BkEgUvj4b00jwIj1gFEiQel
	 2+/2juAci2LFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2013806655;
	Fri, 14 Mar 2025 08:58:01 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250314082748.GI3645863@google.com>
References: <20250314082748.GI3645863@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250314082748.GI3645863@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.14
X-PR-Tracked-Commit-Id: c72e455b89f216b43cd0dbb518036ec4c98f5c46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 695caca9345a160ecd9645abab8e70cfe849e9ff
Message-Id: <174194268024.2165191.11819529894609108758.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 08:58:00 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 08:27:48 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/695caca9345a160ecd9645abab8e70cfe849e9ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

