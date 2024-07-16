Return-Path: <linux-kernel+bounces-253207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0F931E29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BCB282235
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6B1E529;
	Tue, 16 Jul 2024 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTAMQgke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABA1CD24;
	Tue, 16 Jul 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091116; cv=none; b=u9rmB+ozfvMPBF/cU1nP/uI5izsGUxcW2iAvAr4JXnUfi9+As+2KqNEOKvD4nzOZLD6F035HBKGJsI6ao1BmmqDRCyDIL0Kah/Gi3L8OVV9wWK5uCWECINPFTMDXyFhVRbfnyjMBjzuAquVV3/QsJbgoRWwfIFv/wC0n7n/vnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091116; c=relaxed/simple;
	bh=o1fWuHaPEjXYs1Ccf2hkVSPL8P3qFvdSsUaQiw87IW8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=soFi8EtcNeh/L0Op4jUGYDrcrFsmPw7z+yGJA7VRu2uX8iqsK1b1yLN+TxMiG83oGCUyM8bApL/NmmqWyzJKa7N/D6DIxZOwUUsUR9lRFtDmSS5Is/CElmVle3gosriUvFLK7zxK+Qba2apfNS605URlLlX9zNytndx5aAXfLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTAMQgke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AE20C4AF11;
	Tue, 16 Jul 2024 00:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091116;
	bh=o1fWuHaPEjXYs1Ccf2hkVSPL8P3qFvdSsUaQiw87IW8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RTAMQgkeUswsdSx69rnQgJLKLFKUqnUElcCTEsoPsWfTB8xTlrb97Z7A9xVPyUWG1
	 ahKSPwt8vQrHe+9NvgYWHh8rAnAIAO3UiSpXa5jiFgFxkr5VmNIWF9zqCQ9ZCxaBm4
	 utouXNHmjZ5IewKsR6G8x57orGrP/QH8lV8PmyjLuvD4j4OH9u182cxTBFdA1v19vD
	 NfM5h+qB5fW4jm7Q1RNToGAoI//6uxK/u1bzawETtGlueo2w5jGiQx4ocHHthbuPE/
	 hQFMd6nAix+Xe0MHiwwENGO51+VpzrO6hRh4t5v3rqcsXm3GKgzxZ5qbLuacCgcXPQ
	 sXXyoYX2lM9IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32217C43443;
	Tue, 16 Jul 2024 00:51:56 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715001709.2985905-1-linux@roeck-us.net>
References: <20240715001709.2985905-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715001709.2985905-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11
X-PR-Tracked-Commit-Id: 1ea3fd1eb9869fcdcbc9c68f9728bfc47b9503f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 500a711df663adccb30fd3508960ff90c73f1cd4
Message-Id: <172109111619.26590.2517070296944987372.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:51:56 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 17:17:09 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/500a711df663adccb30fd3508960ff90c73f1cd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

