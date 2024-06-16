Return-Path: <linux-kernel+bounces-216425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B37909F2A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ACF282C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F3069D3C;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQGk+MbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9054907;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562273; cv=none; b=WwSE/t2zB4rUpPEPj1WcG4644kUDq5rpKsiaFCy+6lyfoNZ6GwTRdZKXCJxOxpwRWv8dhsvwfH8kMtWRomuIFQeh6m5jCTvrAtZlfHuRKl1FhOvqAg1lXJvmXaOKmQLg0BqJySP2fNPDUGP6E9fQ09phgzQq07MGWz6yZcVEvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562273; c=relaxed/simple;
	bh=yg4o6sJcvUm7bnCNsYd9rZwixTzhDrhPIlkXUjskAlQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RR8D8Tl26MfmXmtpTu00SFys6tZYj1DtqVwDMTqZySIvPugNZMBHpvu8iXnYSFYq4CC7MwKQynxrKTvhYBn2IPvv6WkFqvM3YLP/C/LDlVzhCVlveL2XcV49ILkLuarb48oOP8h9kIgz6iqn/iwNnYHA2qS+nVyVoQC0cD3IAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQGk+MbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9796C4AF48;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562272;
	bh=yg4o6sJcvUm7bnCNsYd9rZwixTzhDrhPIlkXUjskAlQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TQGk+MbPy8cZNTDHWvswvJuyum8WtaFTQkAeQWKdIkC/xkwlidAT+XjyUGb8OYh+w
	 S7DNY2wS3nly6ox6dOCocPO4K/aC9fqkBwgtT0Kk6a8I0vWgE5M1coaegNL0TniLzZ
	 IP5P5hYpx/yhL/2eJT2TR+QT5c7/Hap96GOvte+4/p7vozzmWSSjPCi1C6olwSRjTB
	 PfOqUD4s9MIaJhm6Pu3bf1JfsuoTBKQIe3skpJcGnGIlxnPDmaInraepcWA/CrSqiO
	 7p1GshoJm0igyxforIR1A19L3tycym3N4cYTB8zQb1trAyl0QmpVavuFr0u6UgIJij
	 ZGQTxTFhstUEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0D8FC43616;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm7DsDUAGWwEE6Lf@kroah.com>
References: <Zm7DsDUAGWwEE6Lf@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm7DsDUAGWwEE6Lf@kroah.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.10-rc4
X-PR-Tracked-Commit-Id: c3552ab19aeb8101b751e7c7ad45deab9e1134e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3e6dc4ff03d976d1b427e7e45fe4a7bc330c5e0
Message-Id: <171856227291.1143.16140259900617921475.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 18:24:32 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 12:51:28 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3e6dc4ff03d976d1b427e7e45fe4a7bc330c5e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

