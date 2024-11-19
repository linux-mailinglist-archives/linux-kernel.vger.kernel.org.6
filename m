Return-Path: <linux-kernel+bounces-414871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C99D2EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C43B33B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FE1D4337;
	Tue, 19 Nov 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc7EkPRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E081D4177
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043192; cv=none; b=MhgcTveJG3YiMYpJ6Y7bK2Sz5s3k5kFlgQw0KKhDQe/sy/MCN6sfyOxgcMRheZX9yPv4C5zQURLD4hYr5RSgYs2uRme8MjBMEhDXjDPGQyb8UxWAlBh2FskW9K28YC2yfw8/0t1FF2AGeCA99jwefe5J746R+Z9xwLJyNO8j2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043192; c=relaxed/simple;
	bh=lpdrBFNHBscTRcFU2m7jXDDjMI7HczLnT+pYVHHxN+c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U8pnGaJIZz9DrFLcADBqp4mNv3gwhYW83i02lPtSXjcYy/2WfN/DgbgpqT9t3v8mqJevfJl3GpY0NHivUkAftRPWXun71LZdqaSV1cwZvqG5dLrikpVHMhTL36FdbSXMMrv1mpgainQdcKgTCWp2oT9xP58LOrJE8M5ar5eNJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc7EkPRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A8AC4CED8;
	Tue, 19 Nov 2024 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043192;
	bh=lpdrBFNHBscTRcFU2m7jXDDjMI7HczLnT+pYVHHxN+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qc7EkPRHWhEPrhgmndKpl8QNPD+dHqugPNMOAEdwyWJT2MIkO1oVTPLfP5e2BsJOl
	 N3L2hxtGlPOQP3LCBkmNdMRLl8u9sg7unUDCJJ/Ccub5/WbbISacG+OaV2rIq5hJfh
	 igIqJP969RjJVvMFb/7sSHfSYpRQm3JdMGmB3BZeESmEghH16DA/XqXOJSQ3QTz3/q
	 1l6KSLmK9wLpzqtGp+zMFs3vd5zU1KeOo3oDkHLj2Bs2xAu03sGaOHVCipn4BsDveU
	 k3O6j3+OWkU+WFC32osEeQ5ghssbsJIQbAzFM13XFXErgc0REAEbqEeCWbVLx+1gh/
	 71yLc4IJg7eEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BBD3809A80;
	Tue, 19 Nov 2024 19:06:45 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118020939.641511-1-Jason@zx2c4.com>
References: <20241118020939.641511-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118020939.641511-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.13-rc1-for-linus
X-PR-Tracked-Commit-Id: d18c13697b4dcbf6a8f06c3d8e564c4f5ad1477c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a7fa81137fabb5d86be5825e03d28c371d178d6
Message-Id: <173204320367.653509.11547839676398066779.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:06:43 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 03:09:39 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.13-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a7fa81137fabb5d86be5825e03d28c371d178d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

