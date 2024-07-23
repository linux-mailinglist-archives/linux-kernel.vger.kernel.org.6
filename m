Return-Path: <linux-kernel+bounces-260223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B493A4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D276C284A71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDD15886A;
	Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF3cZDA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E215821D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754290; cv=none; b=qY4wXV540T46mH3pBn6phBNlRvKISI6m3Xh8Yr6mftn7ekVveA4H21LCcqWs/aw8S7YDDw7gqIwJ3Mgg2Laa7nX6StQ5MTOG7hON+z8G2Bw4jErvK1e5Vb0InOcUPZW3kqy15ZQbGod9yv7NfeCSsMWMN3+eILCS/FPXzZmm4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754290; c=relaxed/simple;
	bh=EfSwU4whmIpoGEjMJ8f3BodWFe1IbVd+vfgUwLqupYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GryPCJWJBiRiEuGF1eDyRLFdda5PjUG2WHXwNZB+Uk52twuQBpzWdlqshSrE+9+pcMyPKM33qCHm9FmvJe+wg4zFEBhP04vOK7OI454frgTgwfc3xk/aC+SyAKVJNwFrtvz/Z1JgSGU8T9/sb53WygiE0DOJrdR2O4kFKMjgJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF3cZDA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 107B6C4AF11;
	Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721754290;
	bh=EfSwU4whmIpoGEjMJ8f3BodWFe1IbVd+vfgUwLqupYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GF3cZDA0YIGjVwKORn7FHtIshnnWy6IGmnPoUWHI9pp9RUGLTAadtmTeQyBBd3ZaH
	 9K7803rBf+NMcVjIP5H39J7fSlqjQ+YdZfPrzYhawTbUIBhJj0zKeUkNERkIaSXk/r
	 04SM7Fn8N4TNiSJdyEjdBRF2CLM818UfTjD6Nt7UTF8r0n/cK189Ea18g8wTpZJuAV
	 0OzSOYHZUeQS8VHAXHmtxpwMM+0poNrE1DRCoK6QldxjdKg/GiEWKUcBEtGHeQ6GeQ
	 NINFrpTxLJLoLsIZsnmLRDjKKsIx5KY2K1c2cxN/yi0gWkGBsHePg3VHO4CbyoGC2Q
	 4qW+R8d3B9M6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07079C43443;
	Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
Subject: Re: [GIT PULL] PCMCIA improvements for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zp8zOSU5FFgf16pr@shine.dominikbrodowski.net>
References: <Zp8zOSU5FFgf16pr@shine.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zp8zOSU5FFgf16pr@shine.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.11-rc1
X-PR-Tracked-Commit-Id: 0630e3bc0e91b57288921df2927859b23184ca45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71bed1ec0fa73da529a23336352b859eab12ae8f
Message-Id: <172175429002.5236.4522843491438559116.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 17:04:50 +0000
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 06:36:09 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71bed1ec0fa73da529a23336352b859eab12ae8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

