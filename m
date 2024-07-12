Return-Path: <linux-kernel+bounces-250895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD1192FE39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42101C210DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163917B02C;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKJNo+9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD117839E;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800350; cv=none; b=MeChP5Y5ktq/aIdlqRPqthIodkyZqaPcYpFpkqduG0UkItXjaLBd1EXI1XFN2H8lHxvQYHwa8Mp+Lh4oYmdUniH4SNSqsu1GuOLLxYtsK8KpD5UawCSkTDaqUASe+qi073cerPEYD6XkBTfyrq+1YngOTSLeaueVNi9T1nmy3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800350; c=relaxed/simple;
	bh=K2e/z0FUveDK57CAtbFJZg9dUOn7SdN6CleNSbeSgqY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cx5m0UOs4/XI0/c6YrfX+Xeukq0tum0z3fItQE+mKaHPxnR5oF0Q1KZwbSqlv52mstK60nCy8n1TQ054TAKHorVdcLOE1536v94p+jQm8n8Wffo++eUBW1mG7vgypPt9rbcBq/2BFt9GShESV6KqQzxlxwfTykD03pvYhcBEkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKJNo+9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B7E5C4AF0B;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720800350;
	bh=K2e/z0FUveDK57CAtbFJZg9dUOn7SdN6CleNSbeSgqY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uKJNo+9d4tySZEgflUbZK/RdfTfdmtFhLnNGI8qhEmQP0ovHMIDJCSQav5QUe3eC9
	 ZbnLjC9RBBzvPGq6sPR9/ylreMMz4yP3PACXFRcbwgRU00bT7Ok1ubQDPrn3ydZKKP
	 ZJqE+f4ZC1YTZKmMp1dGm9Vd9APqOOAToLoHrl0BPrUg+lFtf0M2zM2z+38/RUFLqi
	 zYRUcV6FOqHFPxMkr2T6xEgzJrhiib1+y9JrjJ0adaozFHIxassTmE1JMED2kaViaS
	 +1e4jwmntLY3Q9V6A+TrP11wRKigTwl78+FHdlmqCB7lc6NdRBoCJuPq60pFQOqid7
	 skuXBfBpkmqPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2701C43153;
	Fri, 12 Jul 2024 16:05:49 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.10-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpEIK6JklAx8aZ08@kroah.com>
References: <ZpEIK6JklAx8aZ08@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpEIK6JklAx8aZ08@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-final
X-PR-Tracked-Commit-Id: 70c8e3944063a83b7fae1996db7971e9b858c635
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1293147aa8c79381de155ef480e5b5769725182a
Message-Id: <172080034998.10368.6931484274376268477.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 16:05:49 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 12:40:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1293147aa8c79381de155ef480e5b5769725182a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

