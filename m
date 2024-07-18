Return-Path: <linux-kernel+bounces-255859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D89345C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338DA283554
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218B4086A;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRAoK5gu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4781878
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266038; cv=none; b=tz0L7o3OK1BgS5c5zl29f94ixeUOJMLHRC3xfjDt6PGBx/ZiotB3iLW+b7NOQtYSZBd8qy22/6EOMf6RLtYdF2giGepEeYL99E/cwD0O9n/xqkOlmmwHsiv37Qf/anolI0sEaYMA/mLUfbwX/tcrsuUpljhOWvjNDeliEGVAkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266038; c=relaxed/simple;
	bh=qaSSkWGIMHCMN5LowT9mD15W+cG8ANfhE7Ppsv+Nmkc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dHZNcADfEH2Com9b+oKH2DsfV1F7bolXYKbRMC3VmUpIEjIWDRNJlzIHEl9IWK+cuzZAzv8IK1Xsr1ea0X8f2t/T4O5B6pQVTeR5/1KqgBsCncEFhYXMgrtkArIw+j510J2FoTqT1bwpD0kp5zC7FqvCaLCSZ3M3cM6r+CvU1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRAoK5gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BABB2C4AF09;
	Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266038;
	bh=qaSSkWGIMHCMN5LowT9mD15W+cG8ANfhE7Ppsv+Nmkc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MRAoK5guUUzMx38qB17APBOL5lPomwpBujmtt6lJCc4Tt5+e8iirpP4OvwkX3dSjG
	 cJ+YkPc6yOCsnLGSOwudakY4LkyPKacmd8FAzdorR0ec+oKhH2WBE9I2A0KYT5F5Rg
	 /QYrLMxUb/uuuczKXtMQz05XWLA4YNs+CGCMREB/jwCiqs/5+AvQLIHrNMnXPwLu/v
	 9ieTc7w2CtQdlOdvlOVHtLSacnYW1cmt+N42ZI24A8n2icsGibQkp+YVsKfaTBM/qt
	 Pou0SQZvpCw2vnsJoKan2QEFXwdWnwfOugI8vTZOINoYdcIKhLdylRGRUYG0i1mY20
	 SXHWT5gJi1LMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B309AC4332D;
	Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpZ1dVeLWUbAd89V@mail.minyard.net>
References: <ZpZ1dVeLWUbAd89V@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpZ1dVeLWUbAd89V@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.11-1
X-PR-Tracked-Commit-Id: 19a01155ddfe525e3a4e7cef734f18cce640b1ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 221fd1e154ee533c529280bd3866570c086ec792
Message-Id: <172126603872.24030.3733568210930373986.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:18 +0000
To: Corey Minyard <corey@minyard.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 08:28:21 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/221fd1e154ee533c529280bd3866570c086ec792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

