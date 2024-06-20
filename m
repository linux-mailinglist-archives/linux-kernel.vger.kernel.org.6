Return-Path: <linux-kernel+bounces-223413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293B91129C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4856EB27642
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B21BA073;
	Thu, 20 Jun 2024 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG/7peWs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FA156256;
	Thu, 20 Jun 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913008; cv=none; b=nu5/C2MDJdsfjY9Og906PUHI5bRIqZPFd4+eOr/Hwm7BYbIkVm5gjg5HaJW00JBbMEJBuGa2yMnWgemHe2qu0MLt43MOdkijkdbmKoh5bXsAouSZVckbfrlaOzkky+rouHrZP7W3GlssCXjAkLvfhjj40bj4RMRgBbulh0V/+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913008; c=relaxed/simple;
	bh=cqaHQJ/bDLwzr7N3x3FQyJiJw1p7zFcv38LHOowa4tQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uxkyDBXtrapmunUgxFc7ot3aObn9FNFC4w7uqtUUH2zbdGB3H7+YFsX4Nsokb6q+/12RIPCftuGpoNugVgnvwcfrTd+jWX2Tm+bEiCGhooPAN0xkr8rezWNeXYh5+2Lvylng1RglLW+TBTlSX6zz9W4Q2IxkTYjT7HeJMx62N7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG/7peWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 381F1C4AF09;
	Thu, 20 Jun 2024 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913008;
	bh=cqaHQJ/bDLwzr7N3x3FQyJiJw1p7zFcv38LHOowa4tQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uG/7peWsk6S8xx48NOuyzMIfNKioRCcH+X9SLL+cQe96hLMPJsnUsCmXitJqW5kib
	 csNXqO71rTif4SXi2ydGDHi456+dQUOrDVwUl+4Rb3HCt4jGViPIf5EYs72BkGuyFu
	 G98jY2YEOnroFXIUql951AZL4Q3GRoRWxoBTiNTMKwkyBQgdwRZEp/vsjfVEzRjV3B
	 0v/2KHY2/2hLVwzUh7GK4bYLT9Lvxyt/cc8vu4Znioxjh2aRxlOSYy7YYxFhX1DixK
	 ZFDXMIjid+i6voZ+2CfSPxsHPS6mv+45iQDYVnb1MmlKCJ+YHNTu3s+hC877PRS4DV
	 WrPqyMSd233Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27AB7CF3B9A;
	Thu, 20 Jun 2024 19:50:08 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jzij21nc.wl-tiwai@suse.de>
References: <87jzij21nc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jzij21nc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc5
X-PR-Tracked-Commit-Id: 9b1effff19cdf2230d3ecb07ff4038a0da32e9cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 042742a1ff1f37ca88c303a9e61afc8c56b23657
Message-Id: <171891300814.2247.12326381694846789482.pr-tracker-bot@kernel.org>
Date: Thu, 20 Jun 2024 19:50:08 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Jun 2024 15:18:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/042742a1ff1f37ca88c303a9e61afc8c56b23657

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

