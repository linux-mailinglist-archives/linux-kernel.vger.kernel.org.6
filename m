Return-Path: <linux-kernel+bounces-400771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C449C1212
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08631F22E18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC4218D8C;
	Thu,  7 Nov 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHFoHFqn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C219580F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020274; cv=none; b=kUsrtXLCHbde7rplmpyvo6xZNSQdDH5yr6dIR+8U6j5kHKzYK3yhHnrS04QW0FcsRTk7dmIsCqk8ymfX6W2LTVzeWWYe6JNk6m8zznNuPmkwOSuTOMoV8nN1Kz1ag8QcKdS7+yCf/2HmfOrIPkIN+4+WnfyQWfeT6mZj1XVIFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020274; c=relaxed/simple;
	bh=JaH/xVl5ust5d8YKGxyZvBkuaU1LQRGlXSDob/TtjEI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e+jbGuFxbfiuMnQHhGmtnJ0bSNYAw1/kI2/wqUgCf3tg8l1fnYyknR4+NAZRk33WoMW+fwbe4nc5LXH1FvgPGuNZ7DBh71E+ZEBNqNJt23psgQzLRtHxvaJlmbrP+tFoobMDmT5qUBsGKQDppZ4YEbhbRUqFUxYhnn3BbqgRz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHFoHFqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBD8C4CECC;
	Thu,  7 Nov 2024 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731020274;
	bh=JaH/xVl5ust5d8YKGxyZvBkuaU1LQRGlXSDob/TtjEI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gHFoHFqnK55T1EwVct/VxcVOUxQ8kUXZ0+e7YP5Vd877QhJO6HxnMSJRTWDtNEhQJ
	 rnbN4Jem60ZPw2HqlmDp+Lf4TU5z9vvlDguC1uOXZ9m7+TREQbaEXALCPyDlPdBILt
	 LYiz1UlEKi2HcAWksSNwGOnKs+h4L2seVYYS7o4sXP8VDNcM4rkdaReE3u9IDSLrka
	 U1LkZMSoJ9W3AlLVxFkAif0oZKt3zIQryxdrtCybh6NyW6TiMdKtx8f27XBseuW68y
	 7epPWbQrhP9LzZIFVQSh4d/eS8XC0XLMfjN9H4enRIb+LyUMBWKOrjqFXCgOSn9yxH
	 EZ4T3v+kflalw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710073809A80;
	Thu,  7 Nov 2024 22:58:04 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <940f0c26c3b12338363be9f68d1a444d.broonie@kernel.org>
References: <940f0c26c3b12338363be9f68d1a444d.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <940f0c26c3b12338363be9f68d1a444d.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.12-rc6
X-PR-Tracked-Commit-Id: 5e53e4a66bc7430dd2d11c18a86410e3a38d2940
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b85bb4bc043d703c6d8bb35080b7753a1dd8021
Message-Id: <173102028298.2124702.2737646938711854447.pr-tracker-bot@kernel.org>
Date: Thu, 07 Nov 2024 22:58:02 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 07 Nov 2024 22:21:33 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b85bb4bc043d703c6d8bb35080b7753a1dd8021

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

