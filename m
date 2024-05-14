Return-Path: <linux-kernel+bounces-178266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4F8C4B48
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDF1285D27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646161D54D;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0cJv00R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDAA125C9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655089; cv=none; b=hEesLTkjdOOUCb1ten+U0KxL1J2GsZu7PzZ9uxrIUZrZVlgVZSAkXb+2pyF8d2/N28qIVjUd+4BxXEMTTB1HRrQAFnI918g8aghB32y7+i85K8t5IMZD7Pr/8QveZLwl551IHRklE63RX4QqU+HWFthNYK1qPC4VWtYt7mS/rQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655089; c=relaxed/simple;
	bh=wK+byRRwyNS8nPFgeAsbbWGWdV2xzsqWp6p5PLKJOfY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b3c0S1qgueahiAMsg6c+O86IWH1zW7WDUJQowWdLC+xZXRnVIgG+lO/SHZqTaYFRfvrW3wbje8t2s7XCz/8MOefagMBeEQz4+SDuj8cpRsMaY+Bo9T0B3vcs2jJ+v6+HzagirB03KGodJlofp5oksV24U24MDXvgsZE6WvfU+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0cJv00R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B3A2C4AF18;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655089;
	bh=wK+byRRwyNS8nPFgeAsbbWGWdV2xzsqWp6p5PLKJOfY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p0cJv00R++sWbn3VBuicTTMkSivL5KcnEH0SKuOOFVWkqdTLPvyI2JAf+GtBCkDca
	 vg9SvtPj0A05oEIXrukwGSEKrQHUCj2If1NIRJvW4XBK9UV1fJV0syyh0hBXBkVktF
	 m1AvcY8Ug/nkAL0mota+na37BOUJsGcOheXP6kpbt0nq3w3v/RbxSReyTq/IpIPGhs
	 uaXiRCtO507tdDbx5DJ571Mhtpr228jf/zZzX4iBAJ7/yctHlAobJZj64T8QUERBez
	 FhRc4a0Are4QXvzOi/vIsTPuyfDvPZkgrKCZf3Qbx1N1QiNsjSIuAgzh837X8bUq0h
	 HVEX0KADxctbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7278FC433F2;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkG4cMe1TFI5w7sc@gmail.com>
References: <ZkG4cMe1TFI5w7sc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkG4cMe1TFI5w7sc@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-05-13
X-PR-Tracked-Commit-Id: a0025f587c685e5ff842fb0194036f2ca0b6eaf4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d8e0d52a2a4c4ab87da01cb17f15f1ec6cee826
Message-Id: <171565508946.649.8394511625777216558.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 08:51:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d8e0d52a2a4c4ab87da01cb17f15f1ec6cee826

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

