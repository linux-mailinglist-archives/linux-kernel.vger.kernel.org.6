Return-Path: <linux-kernel+bounces-403320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEAA9C3418
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA971C2085C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980913A24D;
	Sun, 10 Nov 2024 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFW9PAMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2813DB9F;
	Sun, 10 Nov 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731260640; cv=none; b=QdieJB6VwV9oW2jW3ucOPqLgMy+tnHp+iSilDl//k7qrXCuKQe6J+bEo6hkK93E5yZ4DMA7fPDwrXHuCrKttAI9zuiCmN2Un5veRh4MWdUVPEjPclKrzEHJoAQPIvM14hgAFqiZ7CXYQu3ku/9Os2n0kjwq8iR7rn2RjitzvdSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731260640; c=relaxed/simple;
	bh=sZgvyoITE3G8wI7xBTLGz24Wjd2k+RnOY8KVDWfTZrI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WSSkrlQsDw/F+yZz3P5wd6YjIw4jfxhnM1A1lhLcWH3Azzpi5K7pZMt3doX+o6rupHGbhDHfKwnMmwQC1+nAboxO4/Mvtf6NbISCsW12NRHONJT/mfNmXizOo8W5xl67oVjxxBMfKx9Lz+0z5c7mEihbjAHDfQSqsnW3404eMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFW9PAMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A8C4CED8;
	Sun, 10 Nov 2024 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731260640;
	bh=sZgvyoITE3G8wI7xBTLGz24Wjd2k+RnOY8KVDWfTZrI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VFW9PAMO5ZVXi4tkEaxN+XdlE6p7YJiV3gPOhyCzRwfk4mm50q+igaWEfPKbyJX8q
	 tWBXWJcw4pqBTGv695tcnS7QA26qazaP9OVnJvKbR+5BxPnj/jxOBMiCGnprMQxEjo
	 WYIujuaqwRLOmHnaSjx/xF9NlGFzyG8qkqAkyYeiO5WTX7vTHaMAKGveUykXPtlxIJ
	 khIhDwqaC9iN/OTEGOHmWOePI8liXe+ePVq1tsqVcMjoF999I8Jvw19j/fJDqizT9q
	 ++XSkaKmqK+oUCP1sYc2KUzkYsm+p3u40n+15Q8/wOUt9N1xun1RR/0g+gWM3O0E/o
	 /irMwYnc/ZmaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF33809A80;
	Sun, 10 Nov 2024 17:44:11 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzBTSKyx1daFpdky@kroah.com>
References: <ZzBTSKyx1daFpdky@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzBTSKyx1daFpdky@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.12-rc7
X-PR-Tracked-Commit-Id: 807babf69027b4f1c55e72b06879658e83830880
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 023d4fc00fdeac9c73b6c1da2d720eade48db020
Message-Id: <173126065010.3189816.4544027297694888543.pr-tracker-bot@kernel.org>
Date: Sun, 10 Nov 2024 17:44:10 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Nov 2024 07:31:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/023d4fc00fdeac9c73b6c1da2d720eade48db020

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

