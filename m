Return-Path: <linux-kernel+bounces-198058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3D8D72EC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 02:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556B5281D1B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F55184F;
	Sun,  2 Jun 2024 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3k1v3Dq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603EEBE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717289051; cv=none; b=dvLmwn48yQXINDZu0e2PnrYJH/z7A+KkfiRLX/aPiQLTDO6rpLH1nt1TvBTYv7xavnt1GMnbC/5Zv/Gk4N/k/4KnEQXB4cxvmdSvu910h+l/VKKMokNhrEdQfVCZQlNCTdYp5GmsetAy/QRbhJQIBvAaApqa2FK86glHuanYBTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717289051; c=relaxed/simple;
	bh=mGw2Qsp3atamupAl7mGgIPYLQzWf1Cg+vKAzx6wkWUs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b7FzUfNly//25KIn36hzuCCb9dl+ChxrEN+1E5kAN7dh1qo09q9DMI6d62buaJv2tKZ5kfGFm/Nhf5nd+GJHATLEZ+dmecILlDuhgxLb0kQJDval3YvLmXsjouYr3riPZhf/tw9pLiwiY0FcPy9XOSo7gSVe7CwvXdzcSgMF9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3k1v3Dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E328C116B1;
	Sun,  2 Jun 2024 00:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717289050;
	bh=mGw2Qsp3atamupAl7mGgIPYLQzWf1Cg+vKAzx6wkWUs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s3k1v3Dq7rYnijxd61hoaHVOtLswxGCzBhz4h1MWen46cZbM+WXm8MKTkyH9W1LFM
	 QgXTI/pMeGG6Htm5g5oyTpL0k8/G9rIgYS9hAoUQgCV2BvhC7tro6JlSJF0SIgcxWC
	 mCcj8fspLW6nowFP9VZ3WpzvxyXqFznh62OGEyOkj0LIjBLPD947K813x1/Z1COLCb
	 BKvyWiZ17ZacWRp0vLqDNUiMd4QdYENufBvEGjE/dhZ8v9Nl4fysYkt+H2M4KdAxAC
	 nUo3CXur+dK+A3SgZvcrmVP1Ji6+sX19a2F9HZF5M+B28r2GzuUvGUnLQcq5LNnUCn
	 ky932K4JIULGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94715C4361B;
	Sun,  2 Jun 2024 00:44:10 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.10-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jzj82p3m.fsf@mail.lhotse>
References: <87jzj82p3m.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87jzj82p3m.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-2
X-PR-Tracked-Commit-Id: be2fc65d66e0406cc9d39d40becaecdf4ee765f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83814698cf48ce3aadc5d88a3f577f04482ff92a
Message-Id: <171728905060.19494.12879025475093263825.pr-tracker-bot@kernel.org>
Date: Sun, 02 Jun 2024 00:44:10 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, nathanl@linux.ibm.com, puranjay@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, samuel.holland@sifive.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 02 Jun 2024 09:57:33 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83814698cf48ce3aadc5d88a3f577f04482ff92a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

