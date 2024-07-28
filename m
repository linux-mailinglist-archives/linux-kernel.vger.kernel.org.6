Return-Path: <linux-kernel+bounces-264872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2696B93E980
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5C41F21015
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6597603A;
	Sun, 28 Jul 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEp0DWyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1958203
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722200536; cv=none; b=VL77HxWtqRuqiozsSGuKK1ANkdLl+R/jJ9tDGeXBkJZIHahcjuceiXn4BB/m6XPzSvLcR88ytH175/l8y1MKNhLKWUCfoE8qQhcjltBKLcy2MbYOI2tqTZKZ4JtdW3B7Sz4anQ1sjykJsd3kY9n+ek13E26F5h4VffpPSFM4xlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722200536; c=relaxed/simple;
	bh=RNpn3G8zVlMkxWCpXLTYBpMBKGrgyR2rlTLGWZYMHK4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JKg7hLe4zUG1K9e6RFupBd7BOI1AhMT6HeMRJXzKZdmsMdVS0Nmk9pfJvHQTTfn2SryI+vdxyr8D9WsQdnd2S9mJw7YcgO+plN8mULufCXGQu8FMW72FiF6jkuVe1YZYqfbj1l9GY9AxapNBBM+eJLNjeJv63OtLoRGm1qaAOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEp0DWyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF7F0C116B1;
	Sun, 28 Jul 2024 21:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722200536;
	bh=RNpn3G8zVlMkxWCpXLTYBpMBKGrgyR2rlTLGWZYMHK4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kEp0DWyPMRTn7gyhfQFO+sfoMbcLYOuflHDassJs86od5M1Xi6m/HKiL/1TWkV9qi
	 +Qj+47T+FlnTO9xoo4TGo9DvL426y/WLxAABZ1dWZ2QiSF74bFNO7QgRq/j2DqGKRt
	 +F9y9tnv4X4yRqIpYj8PUp7bUW0UIj4FP9DGQW5mhjfPqynFHVhKRKXP9CcFAOZ9Wn
	 QP2dPwojt9529ikKBO99OlomMmbyOO9+v+tzHoqo/iRVxNgMD2vqGpT5I/Sjb/EZpD
	 MAvGZO5Bcv54/ljDUI8DduwZFtQsMkPRS804gOqqlL7QXTx1bBB5e6uMQY0KKOiPtX
	 Omg3tEo/lGdpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E71A0C4332C;
	Sun, 28 Jul 2024 21:02:15 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at>
References: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.11-rc1
X-PR-Tracked-Commit-Id: 054fd15984454f031611d6c63675fc578aad0cb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92a286e90203ce3e6c3a6d945fa36da419c3671f
Message-Id: <172220053593.30183.4770887148877294609.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jul 2024 21:02:15 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 22:58:34 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92a286e90203ce3e6c3a6d945fa36da419c3671f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

