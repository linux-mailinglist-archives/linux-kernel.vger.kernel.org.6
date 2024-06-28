Return-Path: <linux-kernel+bounces-234697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A129091C993
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D86028483D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C69824A3;
	Fri, 28 Jun 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLSjtmRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AA824BF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719616793; cv=none; b=oBV0pRg0Qa/n2w6jCwQIZW/E/8Ud2AI5x7V+oa/G98xAtkhgFofivBLMgKOskUHd943GAwbPFu9vThd+GbwWFpQRu+RoSMzHkmLhdAZEzjkqzWgYyr42PTsfM1OEe2UNRANL/Pibkrbbzqaa90idQZp8J3HdvJRRQgwATv2JpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719616793; c=relaxed/simple;
	bh=MyYr8UFSnXMeTPZ1ZFeahSP3SxF+ndWN/V7gPiIojKE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i5AXrEDSMT+n1vAsrownWrnZFvvSlHKAl/hILgtQBzgwIes+Nsd0fgnrh39SYx4rAU3hNmmxIjq7DxzUfh1ceFm1Ch1Eh8Vsy7tSUD0JwG4rlSudlzRBWfMD64Yoezxtei+Q3+iq/nqL5zZvePFJMAQlANroOZh4ESCq5i6UDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLSjtmRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3174C32781;
	Fri, 28 Jun 2024 23:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719616793;
	bh=MyYr8UFSnXMeTPZ1ZFeahSP3SxF+ndWN/V7gPiIojKE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sLSjtmRx8oPB31Md/Ytrt2MaF0ixyE7brgg9JY2WbX8/MMy125BNukV8emnLdTEJi
	 5DsrNGIL2XCiNURQkwsxkMvvZSqF7pkz2MXAp9NxWdlMnzfv/qqUkDwVSNCuJiUcVV
	 I9OtZVCnT/GAsftIZeQ+JYCWewtBJ+l58tBxon+aB1pX5nnLa5etFpaPdq6YsWBP95
	 RrqUBSgaQOT06xTC3GMYoYKkaUaUyi3d1+blOMpxCuk88AM2tvPBCcfMNbx5oDkCzt
	 H/Is46I0hO8jDtiqUsXYtSejy2xhE2gdF0MaFcGbDYNVXybtIpzLxHZlZozN163+98
	 gb4pciWZq1quQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9C62C433E9;
	Fri, 28 Jun 2024 23:19:52 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <202406280915.FFE303A3@keescook>
References: <202406280915.FFE303A3@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202406280915.FFE303A3@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc6
X-PR-Tracked-Commit-Id: 1c07c9be87dd3dd0634033bf08728b32465f08fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b75f94727023c9d362eb875609dcc71a88a67480
Message-Id: <171961679295.11498.908706138604255161.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 23:19:52 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, Yuntao Liu <liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 09:17:14 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b75f94727023c9d362eb875609dcc71a88a67480

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

