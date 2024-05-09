Return-Path: <linux-kernel+bounces-174737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADD88C1425
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0289B215B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACB1405CF;
	Thu,  9 May 2024 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzHnwQva"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F83D3A0;
	Thu,  9 May 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276058; cv=none; b=cJuMVlAvCh5gos2RjYyrvqNYZqdGvTqLAlmCKKaM/EavpaYyfEyiVpXc3ewTjgGaWA98IdfJZPVJH3Kcd43/C+p9N280VWlQp51vgRlAaCAOLPbRK+GFDMNpPAEhMPKt4mDhqVY3APa+GdlJ517GRodpCkM7yZeNhfE8UNOQxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276058; c=relaxed/simple;
	bh=eoKngYpbI+PkUyY1i4HW7U4O2KGKR81l4swcFIme62s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cfCRRPGXWR9IkFEk+mEWFHzv080vR7C7UZgmSyh3A1zcSArB+uSf/kbgdSrIKQbnMfVvNYPyGP2YgcqnQJ4c4KRZ5WpApIZDdSkh4W1kmmCDLo8/qq8I0NsdrEQJPixD5qMPquqbnG+zQbzr8Sl9GuTyZ6FneoIfBI85YaCciwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzHnwQva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7E3DC116B1;
	Thu,  9 May 2024 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715276057;
	bh=eoKngYpbI+PkUyY1i4HW7U4O2KGKR81l4swcFIme62s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rzHnwQvaMpjtEJyZFR5mxKVozPaSLir1rhDExliSVcEDJ1Q9NiOdf8gMsRBpLIB/c
	 hcWw4MgSjUglKA+Sj66UOVLhEDF5FsouqhSdwn3bfjsQqnoaIxl9YBkh89PlNpbw7L
	 3yQ5MPNm64O4w5XWpKiPgA7vXdh5M5VBFPdoMDMpMCz5/sly6p79N+MUFrdyv72PRD
	 T6wX4is++zAl2JgMebrjQ9Rvls3Vx8B1McSjkTPxb4tYNNNnXTLKjRPSVOY3ItJP8m
	 MojCLhJi71vuZvfuKBBiplnrJQQEp9+WccGyrPhno9TenYAyujW7V3CphMqA5vA5wX
	 y88gqjIhCHWrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFDDBE7C0E0;
	Thu,  9 May 2024 17:34:17 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.9-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240509164316.3876202-1-linux@roeck-us.net>
References: <20240509164316.3876202-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240509164316.3876202-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.9-rc8
X-PR-Tracked-Commit-Id: 26e8383b116d0dbe74e28f86646563ab46d66d83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 448b3fe5a0eab5b625a7e15c67c7972169e47ff8
Message-Id: <171527605784.13125.4987694295697550875.pr-tracker-bot@kernel.org>
Date: Thu, 09 May 2024 17:34:17 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 May 2024 09:43:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.9-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/448b3fe5a0eab5b625a7e15c67c7972169e47ff8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

