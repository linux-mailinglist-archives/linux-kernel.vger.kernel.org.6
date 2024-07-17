Return-Path: <linux-kernel+bounces-255640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7493431C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CD2838B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0DB1849E7;
	Wed, 17 Jul 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/dQIXPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2706A022
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247486; cv=none; b=rOMlg++1Cr1lUvK3SwusyPHf1BzCIWqGa+/1xjCcDyCEo4Uu0e4ESAAsPeehUQususm7Iqvg1dGkE/npKjiBcBV6Aiy7WCQO2CZczO8ok8atSl2x3hNoM5Yd7YoGtCS/H87mBjAZEo3f0cLQQupddnB8GNcMiSNTqZbxPk/gPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247486; c=relaxed/simple;
	bh=99hewUQFCa+n1CuASCpxgHA6nPQjfGtYl5t5s4FBO88=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NbORlm7KPesamZ9LobJURfmmhmB/VpXhcIcvcmcnq6QIxsFixTtAAhLZZ/pn94Bb02cGmG8EldHxXTC9O2gFJBzxARKD5V9t7XZdAdWp4w1hXsF/GLqqv+8FLt3rf+xb6Jwc4P9nNaRrJrxdAeB2/9ZqYuGHDp2QCrCyJrL5eOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/dQIXPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 524C9C2BD10;
	Wed, 17 Jul 2024 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247486;
	bh=99hewUQFCa+n1CuASCpxgHA6nPQjfGtYl5t5s4FBO88=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K/dQIXPSVGZrnOGFdioB6g9LEdbvhyRSC2ZueOVWsUq33w8XRj0cW0w8Z7t2CmLIe
	 PCeOWq7AB2OYhlbl+qGCayRTAhAkj4DwU+ereaTLj+91OQvl7OWETzRcSkqTqPMjSG
	 VIM9GtkNn95mCLZN5CWOYHgFqLQ4Fj9mMt8ZhMp49Q4AcgXSu+VrK4A/CjeIndCAj4
	 gV4aycbZMrjpDmM+E2SkFh2y09fs5vaOnB3Piqwip96g8dAvix+KfrGoIIS4H1o0oy
	 /ktI25dg3NsED8ClLSKn/s0lTpsCbOTbDnwp+AuSMaQk+QEyZCx024nEhjeoD8TDcp
	 pCRRc4S3Y/dsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40B2AC433E9;
	Wed, 17 Jul 2024 20:18:06 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpTAI1mLZ1pfTnz8@debian>
References: <ZpTAI1mLZ1pfTnz8@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZpTAI1mLZ1pfTnz8@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1
X-PR-Tracked-Commit-Id: a3c10bed330b7ab401254a0c91098a03b04f1448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 586f14a6a182bbdb9404dc66464dcd8d0ac175a3
Message-Id: <172124748623.12217.7538948678125379696.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:06 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 14:22:27 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/586f14a6a182bbdb9404dc66464dcd8d0ac175a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

