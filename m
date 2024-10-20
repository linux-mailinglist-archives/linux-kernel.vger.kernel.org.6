Return-Path: <linux-kernel+bounces-373372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74D9A55F0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC993B22C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF410194AEF;
	Sun, 20 Oct 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnMKJ2vx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03527B64A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451536; cv=none; b=I7nkBl//2Tj4TJZ6YmObeQbnA6om5mv5Uw8yONy4LEZD6dgXOzgFhQqneAPX4UHxbxyOYoioFyKP570P5X1pZzKc83uhPgUh5QEu5nnYveyRVf08TQn1O+QDbFgkb9n8XLel92VGbeX1JXEQanTTJOJGEUrqxZontNa217pyRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451536; c=relaxed/simple;
	bh=gn+1A9Rw3cMyIwfsi6G6Z2rukd8IhTCYjZqddk9wZoA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DUKBgRfn+mzRaDvTlf1uijQbBqo5oYA1lGt7jf3Az3DDNH1lfCrE5T136Vnb2TnuHG2oeARIyz8NCsja+Kj6WsIhK7YtL47+KVbPav2gMrh6pt0yIz5/mRDDqJd2JXBsPt7czLL5r4iKHIOEH6n9klqnrIpRELOAh9SUe+PbmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnMKJ2vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94454C4CEC6;
	Sun, 20 Oct 2024 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729451535;
	bh=gn+1A9Rw3cMyIwfsi6G6Z2rukd8IhTCYjZqddk9wZoA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NnMKJ2vxHWZa7+3Hwt1I7h5jb/mocM1sdSZEHDTzxVYtVz7IMTdvXzm13mEDEH4tJ
	 hpA4igUjFTxHEVQA/zbd2IuqgCzpMZteRZCrMgEjs1uQyBHc+IOoChDW8iZJ8bH7mC
	 jdEDA/QyZsbzQgYZxS1s6ebgu4iABbh7VuvkxvMj89Tt1S/dzSiVq6OGmjvPvUEs9Z
	 GQnBUEmEWQbrlPVoc50RpMcizk594vnhE6xbu4QYmYGu/UOQHM3YXl70kYDCfxuCSi
	 40OZRmx2JViI0XtFpOLbTn2Zie85vzmXUZfzwbd0zTEdFzIN5XTk35LzgCe1aq+bdi
	 E42K4Dg9j7Uxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB63805CC0;
	Sun, 20 Oct 2024 19:12:22 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241020100533.24289-1-jgross@suse.com>
References: <20241020100533.24289-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241020100533.24289-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc4-tag
X-PR-Tracked-Commit-Id: 0fd2a743301b6b5eec0f407080f89bed98384836
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5ee44c8297803efd36cd0c773d72687afdd7500
Message-Id: <172945154126.3627590.5231704990925009776.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 19:12:21 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Oct 2024 12:05:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12a-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5ee44c8297803efd36cd0c773d72687afdd7500

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

