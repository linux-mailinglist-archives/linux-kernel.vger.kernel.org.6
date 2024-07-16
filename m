Return-Path: <linux-kernel+bounces-254327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58209331D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D5F1F26DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA071A2C14;
	Tue, 16 Jul 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htk/vrQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A81A08BE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157945; cv=none; b=jO5K4mOVCfZeXSdUoQveP6CgzYg1yNtHHAiqy9Czd3MI8zQypxv3NehMWKX6l0GryEVHB/5NaMdKOLw7f/PKtzUFQpZCX+os1ECkda/Hag9f6luMtUjkyTGq/6hrR2DG0vKrPXsFuG2Lszlrooq5bHPZ5Riy+kAc8NRlMRblias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157945; c=relaxed/simple;
	bh=PFockgK6LED3OxYKEWejo70KiPY5/dREDV0K2aRfOew=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qwJ0H0ec0mNTPCELn8VJDPE5O/3zXU9mY80ZdwtxxBeHUrOiX1ra4LNfhNqADvCu17c+bI+5xAyFeA3c7T323J6BGtkMLEnST0mAEeGA+aCrCNbmPY5tM7sr1GCom4jJ86FRKfkzNXWMkGwC2RrmuUMN8NCNAvP6DCeuAWAGqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htk/vrQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85F9DC4AF10;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721157945;
	bh=PFockgK6LED3OxYKEWejo70KiPY5/dREDV0K2aRfOew=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=Htk/vrQ2UXJOoBtWg/kOyJFz7EcQnYJsTQeDlOzs84lm287lEcCT6YcxZpSvgfFs0
	 L7s8d/w5aUOwuKsd5zHmTzyZwI8KRHXGwRYOB9ybYfRTovFcs9nJ3yFS+EIUR0IOVN
	 t/C/XTQK00rBsf+vSmO0KUbGkfCIPLioj8G50TJA08Zi28L9jKPIb1V+6qZEupvI5s
	 Gcsj5Q5UuCI7ojrSkJBfzhzLnpnIURt2bGbpNN9fCA8f7DO1RAEOx9LC9Vvohp4D0+
	 89IkC0fIO4XjI0plstKBph0VrS2TCk5QIFx/13j77/T1dt5b9VQfIvOlpFBcTkrTzz
	 3aYgPq/0FG/Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BA16C43445;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Subject: Re: [GIT PULL 2/4] soc: dt updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <b55b7bb8-97b6-4d25-9592-8213ecfe7b6c@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com> <b55b7bb8-97b6-4d25-9592-8213ecfe7b6c@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <b55b7bb8-97b6-4d25-9592-8213ecfe7b6c@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.11
X-PR-Tracked-Commit-Id: 48d2245586452b8279a854970ce82f43477669d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3950967f6e6b74a3606739ec50ed19f3398c7d8
Message-Id: <172115794543.10577.16476440873208181519.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 19:25:45 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 23:10:48 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3950967f6e6b74a3606739ec50ed19f3398c7d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

