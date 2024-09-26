Return-Path: <linux-kernel+bounces-340823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD3987843
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA281F21F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332315B12A;
	Thu, 26 Sep 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRA4H2l7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C4136337;
	Thu, 26 Sep 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371551; cv=none; b=rogJpqAWZQpcetuzXASngGwyxfC0oE5gIQ7ikOyFW3h07mDCqrwGQ3yh/A8bPpDSAWErLtQVVHQphcSJN8JSmg1VmC5sL/zIAFcrIwAlBYZ0I6z5WdYuZGoytDEZySBwLrUVifbiKsbu+q6F9LPUit0vBCJGotS0WPM3iynudL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371551; c=relaxed/simple;
	bh=f4gtQfanYdW7sPgtxmdTtFGLXRYwLmBah6379auMRjw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oCeRKYr4jQs+5ahUTfDTQFuMAqbNG0iWKORtVk53cPghN5j+5pR2GxdTdnthbqFw7vMFJt7ZAsTjJxxeUCXrQM4MON+xpC2hCJpLWfm+UI/v3XxZaHYsBr2aYnqVfFEWihfpK5Ug5o+73GHdUTJ/OG85FuhICph5IY23FMyi1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRA4H2l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E1C4CEC5;
	Thu, 26 Sep 2024 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371551;
	bh=f4gtQfanYdW7sPgtxmdTtFGLXRYwLmBah6379auMRjw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mRA4H2l76NVdETIc9JCV/QMwpBkjTsYogAEAaOBvAYSh4lh5Sw64iCxbCE3EwufPd
	 fBzE7mTmNyRZ1/61AkWPhxL09jJ+E31TkMb2VJz/BvzweuDwXzIslTOGIeTZ5MlQYr
	 FQ01v9IsZ7RVMkkO2BqrrPLSOlYuB0p1xm/VWgXTQyihat/dHuSg0Hoxvwifp/1Xi4
	 7OIhAngEl9cEAClDXVl0KhWZgesQgMjmvNXfPutWK+SCtm/w+kOrdwyCuH893HMeez
	 x7bNvXDE5TINZzCNJwjXLLEwNR4tk+cDq/hkFB6VjL0bk55CKyRHS22GFnT2zydKa0
	 c7Fg8wVEOTcYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F823809A8F;
	Thu, 26 Sep 2024 17:25:55 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvU2EO4wb7RCUSSW@kroah.com>
References: <ZvU2EO4wb7RCUSSW@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvU2EO4wb7RCUSSW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.12-rc1
X-PR-Tracked-Commit-Id: b4fdf9b1cd8b21a6569290a06b2a7df0eb071d6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b707512b8b07396f8982103a84285a165a1bd94c
Message-Id: <172737155398.1334950.16925023234015373681.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 17:25:53 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 12:23:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b707512b8b07396f8982103a84285a165a1bd94c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

