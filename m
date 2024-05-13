Return-Path: <linux-kernel+bounces-178189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C496B8C4A38
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649011F24B26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DF8615E;
	Mon, 13 May 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwNl5YI1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405598564F;
	Mon, 13 May 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644253; cv=none; b=EDLCPNJN2+/bv/JjBUAuopNhVChOQk8+1127h9KS0kwSWE2stWm0j5tlEwfNyRsNr42pkJ+Wl77KWB4+23M0Qh6AmezdKHJnbwBEWelBm7w4EfCxeNB1pr1Nv12o5MEF3O+1rjVOK7vgmOSdV913sZlP29OzNx4e3FnkDdRTcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644253; c=relaxed/simple;
	bh=Z7PFGCr1Ay0h8R7lvDprHgkUr7Uub44rUYakE/tq+dA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TGqPAh9jmF2F3AmBugnKAmvsMAMPNhdZq8Am70wUZhZ9ugP5JmRkCNyBc1+u3diMUpT9OsZRMyzx0omjhD5mhQcYyqgMaSgqErXcj0Lrjf1qc7L7NW4m1TUHuZC6V/0sPl63O1aegJIQFNJ4e+LkWH+Htzr/4Dq2DpbkqTZskZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwNl5YI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 174D9C113CC;
	Mon, 13 May 2024 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715644253;
	bh=Z7PFGCr1Ay0h8R7lvDprHgkUr7Uub44rUYakE/tq+dA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XwNl5YI1jDbA7F4jBA3Cou/bwfxmZaLWzX9msgRPJya5Uj7SKGcCPQYE5vI2OSGnM
	 R27H84f/rXZTh5kCxpenXYgMVjDiWzMLadOpnWoiLnxvCTlzW6mG5yiK4lvj6aSuOR
	 vnTXZ76Th5r/sTYPc6tazKyyNkfLQKQDB22zYKoeJpwK2zt30bLCNH1mOdvskMIrnA
	 yoH88zxotpBoyBDSvEp1N/NL+jihKY4SfItPvZJt6mpOeDzVn5LLNSSXQf6vJ1OvQe
	 KFaQnVbFx+uatynR8nl7QlYAjnVooPS4bqBZzALhM+sCs8iEnLsLQxagMSkIMOfyz1
	 ifFtZIXHpKofw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E3B0C433E9;
	Mon, 13 May 2024 23:50:53 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkGWGbzFu3rmDElk@google.com>
References: <ZkGWGbzFu3rmDElk@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkGWGbzFu3rmDElk@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.10
X-PR-Tracked-Commit-Id: 2fbe479c0024e1c6b992184a799055e19932aa48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59729c8a76544d9d7651287a5d28c5bf7fc9fccc
Message-Id: <171564425304.32070.11371575006226893866.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 23:50:53 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 12:24:57 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59729c8a76544d9d7651287a5d28c5bf7fc9fccc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

