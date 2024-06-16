Return-Path: <linux-kernel+bounces-216427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26C909F2D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49940282BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1083757E5;
	Sun, 16 Jun 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWMYKl7f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324705381E;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562273; cv=none; b=RRfWthCBaIHWPriMKc8CBygJRvZfIfV8ugO2gN3LHLHL5HOxXbyfK041lN9ja7Qx8CFuKFq/7Ju6ywvqKfyC2BRjN00yRWIpjJMmf7mnd/c0CknpWVfnGWQSA0a1mszxnt3PR2a1VhRjjx+v3cJlLVZ9pN1Z8iYwuaEevCvG3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562273; c=relaxed/simple;
	bh=gSgtII15n1XNHzXP7heQdKsnrj+h2JxGTFzIGgFSI8k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iwaMpRiTOVUFDwqFaNoGNZgqEr8R91SE9+YIzuADKfPWFPrfXzY84AKtCgNGxy6Zr6L98PFVh2BDUgWF/yh4Ug45q98HN4SVJ1+cHwbtE9OOXVBsb65juf/6/m63q660aQVfy7xiwbQYfZYd0lHJVvZbopxObxuzu8iXzeoDlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWMYKl7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16304C4AF51;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562273;
	bh=gSgtII15n1XNHzXP7heQdKsnrj+h2JxGTFzIGgFSI8k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jWMYKl7f5Lmifkf+tRGcE8vuXnZ9c+4q6+asFhDssz7cfcr/YBj0fF3Gmh7JfQ1i/
	 LzqZZqDoqFG3hpfqKXVjY5FXN43Q5rJ1NAiraev414HRvUxXcXw2OX6hlQvdpLU4kO
	 03OTpzUrUHx7zckrfoNArQzV0S5ro5v5+mEzie97s1bH1HAF7xOEbzAnm+43TLIjac
	 sioYzW38Uwzo/CG7+whO7ZFxUD0E+KktjoMz8vLO3FYlarhV5GRImzQ+UHAziOrPrU
	 B8EzfQrJnXxyEMXmssYDveb3P/vWUjNx5nvJtM7hKfgWbpjYAB5ibO4g7Mwo+84Z3k
	 zy7f5WP6cmrRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E0D1C43613;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm7D3-lc4t1sEinN@kroah.com>
References: <Zm7D3-lc4t1sEinN@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm7D3-lc4t1sEinN@kroah.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc4
X-PR-Tracked-Commit-Id: 22f00812862564b314784167a89f27b444f82a46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5beaa44747bddbabb338377340244f56465cd7d
Message-Id: <171856227305.1143.13135277156171537233.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 18:24:33 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 12:52:15 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5beaa44747bddbabb338377340244f56465cd7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

