Return-Path: <linux-kernel+bounces-253177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E0931DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C921C21E40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75141448DF;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmRUv7ui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB7143C61
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087784; cv=none; b=NYs/IZbNu32EL3URCzoDik1heAfbiO5kBR2lL+QWZ+jwfSSsi7n9r4cGyyC0a9xS47RC2Ygh1yecaWu/u50NqdqJZq8PwveqXjEC9gzGS+sxLjBv4OTMEp1vNgnB7QKCsOlY3qIggRR4ofe00LI7D9SfY+ZeUcCtdk+m4Q0e0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087784; c=relaxed/simple;
	bh=4dQ53ThqrzNcmYwWRv/duch4tTTJC6GZ3GpllpPtY5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u3nVZWX5mNaZ5MfbEguIyXriVISlOMcquyu0UdM1sHtcfxbMJy7whp8qAnigLqAjC3F4CmF/pdf1i5UkXUTAqgbpWC9b3MNP4DkfWna4P7F7K0bX7sJqBnH+W/kHBvrkBPlNhC511+h2MkE+z6Z9LU5dtTK6Z2gsqpl0GjAzXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmRUv7ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDC0BC4AF16;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087784;
	bh=4dQ53ThqrzNcmYwWRv/duch4tTTJC6GZ3GpllpPtY5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LmRUv7ui4PszWWFPHwIliVhNIktdp2ImN3EjyelI/Hg00jOClKfOY6z1ed9EVu84n
	 w9ix5dgBS7ZrmrWksaMcTcWH9xBhAMZ7pNIrL6KYJP6ITCXJEsMWDYgzfzMxlUpyN8
	 G/iZ8Hu/DWYkpM3j2ZqAx5F2DlaqPutCg+q/5xakJENZ149MCcHWGpjukpTxR+oxc4
	 mohcjPpYeTpyW/XKefazkj8IszTyNv7gpm6OezfRavqnDsewxQZb2sopb7x2h59XVz
	 jBpxQwlTlwGuzb+6RC0VH0D6ePYciiXZSG+oo4tnmtqoPJbWbCENcH8f/qQMd0ECDp
	 xNEKDC20uvv/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBC4AC4332D;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172099001487.1942258.17671805941963584080.tglx@xen13>
References: <172099001487.1942258.17671805941963584080.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172099001487.1942258.17671805941963584080.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-07-14
X-PR-Tracked-Commit-Id: 5b5baba6222255d29626f63c41f101379ec5400b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e4b77d4eaa121bdcf8cb2b07aa4a16e7a9e7c6d
Message-Id: <172108778389.25181.9861283231004120534.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:23 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 22:50:05 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-07-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e4b77d4eaa121bdcf8cb2b07aa4a16e7a9e7c6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

