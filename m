Return-Path: <linux-kernel+bounces-170243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823908BD402
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4DE285BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2BE157A47;
	Mon,  6 May 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+gjYRxN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11C157470
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017507; cv=none; b=mZTr5h0EqlSiv2qjNT58We/dK2UHMI4/aqqiyxM5t4SLKzTbFANfI1YuxqAFu+P/rV7gHS4yYlS6hvm6YimBnwxjfNBxJNPwccoBtfV95EhbFJZgco8u//40CRIbnXi2SVWfS8VaQ1ftqIN5oFQk9rRFSZ4fuOxv0XeJcwm1JXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017507; c=relaxed/simple;
	bh=PnsqiOzBcBR0g3vt00cRfUbAyXXrJM7jL41nxu4/Y0Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FW/vlW7ByUWG0c5MLz70/wGV7QcuClYaGmB1+QbLiPsY+PHVR03DSOqZY3GxbQLPSRD10YQ7m0EnBxXgdz8ZK7T8I+hlwBo7ev8SsRiBT85fJELEQhVLMNbok2NBpZyGALtMImdBtQDMLeQx7APWwNIGv9+vYIeX8jzOyo1CEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+gjYRxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFAADC116B1;
	Mon,  6 May 2024 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715017506;
	bh=PnsqiOzBcBR0g3vt00cRfUbAyXXrJM7jL41nxu4/Y0Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t+gjYRxNsEkrUT0CG69o4paFt7mlQEVEfX46IGPIUuNLthBHlsGhDVLlhQY7H/S76
	 ucE/3FEg2A2kfzjYw5kGFd3xGRp+hmXps1Mhit+Ghes6/r7GBDSq2v2EjdLY5z0/bR
	 c7vu6R1br+iboU5Lrt44CUC443LVUD/7vEmNcAYBFs6B8iIh/Fm3BqYkVMwvehJKMu
	 /FCbMveMtpvtdeHMOO6btIf8+A4aCjtjNR7sRwR/FJkjHeaBSKYD88lDMPnHNzD8a4
	 bPNQuOodty+s1w1GGBKTOYjtm7BNOpKxvQhLERUg/tD9schZAwyWqQ5g30bXeri0wm
	 vZ1hemeyKYgHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E830C43333;
	Mon,  6 May 2024 17:45:06 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for 6.10-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjiWVdJPyFiN0oYe@black.fi.intel.com>
References: <ZjiWVdJPyFiN0oYe@black.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjiWVdJPyFiN0oYe@black.fi.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.10-1
X-PR-Tracked-Commit-Id: 93ee235f55d3e1c881e766a320cedcad0b9aca42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c73677ca411d3dbfe585dcbf389b3cd83e0e3530
Message-Id: <171501750664.5526.13640264160376348084.pr-tracker-bot@kernel.org>
Date: Mon, 06 May 2024 17:45:06 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 6 May 2024 11:35:33 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c73677ca411d3dbfe585dcbf389b3cd83e0e3530

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

