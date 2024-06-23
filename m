Return-Path: <linux-kernel+bounces-226239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7826913BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75B91C219DC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6D181D09;
	Sun, 23 Jun 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxKXHz+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69689181CE2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155593; cv=none; b=ZrprRFGqs/WK/wWhgn7X94kSPuqwCBTmT5vJEZQ6NIrsuYnMThEjxYb8XxlSSiH+dVdR6AsCj/lw9f44ZEmNulWyNzOPnfrvezbrIwquEuJIEayMfnlVB/Vu7Ob7DYyCZ0sCw7FAmskxaZDPEPsh0jI2nT8496qXCl4mb9jxI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155593; c=relaxed/simple;
	bh=Ke4YKwdn6+bRr5Uztay6lsCSs0HoDUzhjUCLkp0Hsw8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c5Bk979knaASG3Sy9Jm9ioGFUNRAzXPSxZ9d/XVzkr2Ytqq904S0QAs+XZzNdhb/rrHh1FYXPGsHgDYWCFAp1NMIu0Ghvb7lu7xTDUoE0ARiXWINmdlipg+iAqhEi+30T9LI/e57JD1YtbCrG1A2yGJsbkvpCXQ4YmQUaXtlEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxKXHz+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48940C4AF07;
	Sun, 23 Jun 2024 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719155593;
	bh=Ke4YKwdn6+bRr5Uztay6lsCSs0HoDUzhjUCLkp0Hsw8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GxKXHz+2TPyYGc5aK1IG1M0x6S1fZkTwDELur1ORYikmLbRPD4gqWqQ4I4nKVNKH8
	 7uW03/mfUitB2+SxROe7VgYb3U8q3CU2FzBja3pHTzIe44dYY446dL/CYDo7KWBYHG
	 AQ+XnADIqBskU3gQyb7UtyQHLovYk3+1mvNnCYI4pfMTMQbQqQ1+5YMvg0bpqMz4Q4
	 ymxyE3HC/kus/rZzbG768zBRDIbUozMWjStPa6k06HHwj8NZArEYBPPEOy9sNmp74r
	 lG6MxeUFbJMAuv6rI6CikEKGhGWyue2KvVhXTFhqWaHrx0v6Obf+cp5m8VCiIqQJMu
	 o0qXjheWtJnsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BE07E7C4CA;
	Sun, 23 Jun 2024 15:13:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.10-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sex4csyn.fsf@mail.lhotse>
References: <87sex4csyn.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87sex4csyn.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-3
X-PR-Tracked-Commit-Id: a986fa57fd81a1430e00b3c6cf8a325d6f894a63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1505b5cd0426bbddbbc99f10e3ae0b52aaa1d1f
Message-Id: <171915559323.3671.17650010826239532705.pr-tracker-bot@kernel.org>
Date: Sun, 23 Jun 2024 15:13:13 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Jun 2024 12:07:28 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1505b5cd0426bbddbbc99f10e3ae0b52aaa1d1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

