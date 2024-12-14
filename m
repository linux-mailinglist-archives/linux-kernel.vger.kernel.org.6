Return-Path: <linux-kernel+bounces-446133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2579F2026
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C19B7A06BC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6523C1ABEAC;
	Sat, 14 Dec 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM0yazMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B21AAE09;
	Sat, 14 Dec 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197954; cv=none; b=sbLogWo6PYi0LPy/eQVAXVwdLWvdkv4R/M2h4PTQHsIBAgMBrKUJSaNj7qwS8GTT6uX2UMbqRTbHk+1XKzP0u9IBGB6ynz5sAgaaa4jeid9gH4O/d2ZlDB+co14PSUGXzSU/72ie0J1IZsYAUb9prhLUkWpZs2KEydj5jMwkw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197954; c=relaxed/simple;
	bh=YlKdGFCuxkTKEznSyOnTXhse/BA5r8x2BxfKABvGqkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nG8CRcjgcn5xGGB0jA52xNsnGrlFFt+rtEkNPLRX20A19/RpeQ4NZW0nsTjrWujm0gE/+O60c7N+DWHsifb04z2qOnAHHp0ML7kwTOre1yQr8paiVmvdktt9NNO6wv6wAE6x1b7adJLD0APdzJVqQEnjdd9qH77SB2YVYsJ+LWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM0yazMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5359AC4CEDD;
	Sat, 14 Dec 2024 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734197954;
	bh=YlKdGFCuxkTKEznSyOnTXhse/BA5r8x2BxfKABvGqkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EM0yazMFfub0q5ec0v7ePVkXmUfcpNI3ToqktZDf2iQr5HAft3GaEY8vznHvgwEw+
	 aYG5lnfMdhVFQ5j+fKsV2H3Jy7bSxpyifi/dT+LoijfGglgJmx99yW1Vscgl2j911k
	 HkiLrOThTuQu89pktDX3Je9W9OJdg1yEXkAEmJiwgm9wTNzv01DkMt821wi24Bf1UX
	 kpPQ++v2So594Z/SXXMyxmqYljLMAF1f8Ins7BWyXcldoTE1w5h3XA2bcI9R/0YjKn
	 7l1bKij/UJvFw0rTY+3N22kNGrUMIFCxyOd5azmaqyQuQVzmDIOwjz5tZhrQZMJICy
	 HeJ85pApBKvVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7E380A959;
	Sat, 14 Dec 2024 17:39:32 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z12X4vb79DECg-w2@kroah.com>
References: <Z12X4vb79DECg-w2@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z12X4vb79DECg-w2@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.13-rc3
X-PR-Tracked-Commit-Id: 33ead7e538183b1348ba60af90027240a10de751
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0e3919a2df29b373b19a8fbd6e4c4c38fc10d87
Message-Id: <173419797087.3365831.3743055221898422166.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 17:39:30 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 15:36:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0e3919a2df29b373b19a8fbd6e4c4c38fc10d87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

