Return-Path: <linux-kernel+bounces-446131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267899F2022
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A58166CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568B19993D;
	Sat, 14 Dec 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7bj6uDq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0115193425;
	Sat, 14 Dec 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197945; cv=none; b=CSphc3vJ/4U2aPJ3MDeobwE/AqrSHhycn4jZBf4EHLCs8TT7xmAUFRwGA0AynvA6e5ydGrUq0JOLw9OfpxpvD/TQsuJQYksYIlDw8ytsQarHIDgncETGRc0tZE7eWv4K5FoBP6Js5Ra3vftVDeKOgjmbx4Z8129WfEZ61EQXzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197945; c=relaxed/simple;
	bh=rB4PmbjB781kMTe5m3If/2B8I5tqZVX+vIzbEpHICxA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WIck81Ju6war1ybFct4/4G0wTqZ9bE+Cd213M9LHeAzJ4fU6vBCITmMJhHSzi73pXWvJzqku7yfKp1RsAq/CCIXegiQMSfwYH67pNgbB3s6jpQRcJod8WRpAsp2Wb9mL7PMOACjUAFffLQsI+MihziON0YFcXmWKOEsYsLA9pAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7bj6uDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B8AC4CED1;
	Sat, 14 Dec 2024 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734197945;
	bh=rB4PmbjB781kMTe5m3If/2B8I5tqZVX+vIzbEpHICxA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T7bj6uDqbfNPbonjmYZFa/6bDzTd5p/DA8sU7QV1NuTN08g4CQD+0wgzaFrowBPop
	 +VL94LjHT/DVGpKihSkgso+N4hszrO3PmQZn3pwXaYYpcpriShQp8xQuYPL35i7xxT
	 PXMmABpqp5I8pmrWKAgUDknrgZI+YfB26pL75HVpkfPWD2iE2GlkVhHOnEbk+BAhXd
	 WQ60atouGEQQkElkisWZbI4XNsJni4Feh4rkwq2t9TosJI1qAxHhydlKbeKZYeujv7
	 7pTg/EO+v72YdLFsAQUc2tUdoO1z/8qHrrO3WTMaPKgbGiCi+WV14IFHzjTfubXWVX
	 EloK6tGI+wGag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34AC3380A959;
	Sat, 14 Dec 2024 17:39:23 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z12XnpkeQSJZoClu@kroah.com>
References: <Z12XnpkeQSJZoClu@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z12XnpkeQSJZoClu@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc3
X-PR-Tracked-Commit-Id: 48e8a8160dba523af7074e668b2a458250838a3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3de4f6d919195678fa400c4da2bb5fda4a124632
Message-Id: <173419796185.3365831.8418692257563485289.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 17:39:21 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 15:35:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3de4f6d919195678fa400c4da2bb5fda4a124632

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

