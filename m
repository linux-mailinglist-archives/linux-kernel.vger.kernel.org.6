Return-Path: <linux-kernel+bounces-342152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ADB988B06
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC9A1F2415C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D461C32E3;
	Fri, 27 Sep 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgehpmYV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEC1C2DD1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467234; cv=none; b=n9it+ptR7dZhOT3Wu2nV0wuaFcDWxuq5iwcLpDKfebAesW/lDq4oReP01beBvQXIKnYId+OrCOpTc0Lxup3jYx4O64zXk/gQ03hg9ohAuOaqtF32uaW9ubR/ypavnMoiBOYy51Eks+bHV8/DvCaBqLd3e0L+T8z390sNsfLq7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467234; c=relaxed/simple;
	bh=YJ9F80sAsIr33/PSUGQudPVJdjIJZBKx+I+tMgKicH4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j5r5CGqhuU1K2Wsv1t74Eyj//3MLeQI+aiwy0ptT44Yq2CSWtdzdMKw6VXjRwytX6axBvpQIHkUXhbIjsk/fj0D6eSsCD63QYBJCmdw4pMX7m3PmyXcG+K/mHG05NBmg9NxHTgYCAIX3gzhO3vWqGZC5g/Z42WsYOWtDYfuTTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgehpmYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5576BC4CEC9;
	Fri, 27 Sep 2024 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467234;
	bh=YJ9F80sAsIr33/PSUGQudPVJdjIJZBKx+I+tMgKicH4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CgehpmYV2zK0R96MRxF7gTLU8wYSvOToefcd+YGstBXR/vpmPZJBtKN98YFD/5G+L
	 PJdQH1WlldkUqWfX7qD0zxHhQUqmtp6Nmoxaaf9bqb4em5mCvYys+GTTTeJaGBMPdz
	 Y2n12o/sdjDcLs17YbDhiVmSod+//WSQSycRnZ+UewnaysjAhTXcWj/4/7WXQ7ngP+
	 jakahdUlll+CRF8X0bBBFWbukptpWnTXBtjvThbDapymxhhb6bFQ1w+SE5nRePAf1n
	 SVHcKP0J1UMBLxSJBxHK01CHlrG+Zes1UCjpZ3Z5Cx4fV10+d/Z411sx9x4XqstYyN
	 QIaFGJtq3/jvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341FE3809A80;
	Fri, 27 Sep 2024 20:00:38 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240927174507.1795312-1-Jason@zx2c4.com>
References: <20240916121358.3666562-1-Jason@zx2c4.com> <20240927174507.1795312-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240927174507.1795312-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus
X-PR-Tracked-Commit-Id: 9805f39d423a30a7189158905ec3d71774fe98a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34e1a5d43c5deec563b94f3330b690dde9d1de53
Message-Id: <172746723765.2065768.7835929926067276816.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:00:37 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 19:45:07 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34e1a5d43c5deec563b94f3330b690dde9d1de53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

