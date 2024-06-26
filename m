Return-Path: <linux-kernel+bounces-231580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD5919A74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D84283050
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154E194099;
	Wed, 26 Jun 2024 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgwTLANI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA2161314
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440065; cv=none; b=eD6flruRZGvCRZQ1T9wjIbmk2fck9lCgNsWZkHyqD2cM6eCHLVMv0VTy8+Zmb12BXFGlE7LJS8DpblpBNSY5tDEHVXEM9818+8H43x9KSiZg8MzD6M9QYskEwiScktcAhF52+JWdoncIkb2TVAjtaSEWlmNUHOdyq11NES2DAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440065; c=relaxed/simple;
	bh=6s2E0GaolNLpXDkGCIhVj0toHG7NKGqpNfxdfhJcGd8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kZORPsjoadL55y4yGw1TwY6RFkj2eFcZ6bq4XU+69SkFYmBZ6cafI1Hvx1FOjIq4j/W+SSiHXIYEUxICNqvCwfHLsLxpXPpU7SoNu7l1GY7hmyL9Z6vGsJZI4M9tw8fsGAWJsZ+ejPuioczAM16ZCywIdPiof40rvPGh8AAp0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgwTLANI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 862A2C116B1;
	Wed, 26 Jun 2024 22:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719440064;
	bh=6s2E0GaolNLpXDkGCIhVj0toHG7NKGqpNfxdfhJcGd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sgwTLANIqme1Y3yoyqbLflaMF99Don1uOaSTAmGWZzVL83886wC1kZVkIHSPIBByR
	 PtwHIwzX/0NDgq4i7TsFvd5am36ein3npGl3wEUhxBup7y0X9EgZmh0S1jGY/PTqJo
	 fYT8KXm1CBtG6rfZEnNXJiXN7TrQvtL3/XCEFATPTC4GoEAcpWGzKqAhOC3iccevC6
	 Zz86MQT2rL7BnQdyS2FVik5Ip730Qp0mGTvryaTx2HvKxAk8M3scSLt+usx1eQChK8
	 DnLmnh8noZR3RgPG8yliWwdQ7CZp++3DKQumIqbvkbp5F0j4JbX2zt63ih4iuNy8be
	 kGSurBty/w0OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A4CFC433A2;
	Wed, 26 Jun 2024 22:14:24 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Fixes for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZnyH-lGLwc37I0xK@slm.duckdns.org>
References: <ZnyH-lGLwc37I0xK@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZnyH-lGLwc37I0xK@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10-rc5-fixes
X-PR-Tracked-Commit-Id: 231035f18d6b80e5c28732a20872398116a54ecd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24ca36a562d63f1bff04c3f11236f52969c67717
Message-Id: <171944006449.24000.16689854744141936435.pr-tracker-bot@kernel.org>
Date: Wed, 26 Jun 2024 22:14:24 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Jun 2024 11:28:26 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24ca36a562d63f1bff04c3f11236f52969c67717

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

