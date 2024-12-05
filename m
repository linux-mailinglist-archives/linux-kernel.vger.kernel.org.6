Return-Path: <linux-kernel+bounces-433870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F819E5E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233A728753C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874E7227B8F;
	Thu,  5 Dec 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLhVPVX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FD229B04
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422890; cv=none; b=TpZetoZQ875f4h31AHsjqrTaO1TVn39wp6QfPiqaYi1PKFMdcTEEs5AN+CUe03uNlhJUtgKDxgODMBgEK3bNz6pJG6zKy/dazNxnV+SDVmcURt1sSinVo+2Ex0bY1Q2opnVIWXZyy5fjoYjU3IPGyxs5tegHIY8J7sb21p4T1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422890; c=relaxed/simple;
	bh=UXIJiCsC8Z4R/CWdY5NKGti0bbTEAfi54D0DmbVIUgQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C0WMLfauk22CG0k7EeP7WfNMCzvWsYHq6XudpV/6Laww3TGBLBHM9lBixCrHtttP5R0v7mYZoM8gJuqFgphO65XTdEjG1rgFqF7CqWkknjvRc5qWkCzaZPN9kvZILRro6LljC2P0kIQYgc1kvJUjEjSyf6cqMDAIxEcnUhWW4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLhVPVX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09A5C4CEDD;
	Thu,  5 Dec 2024 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733422889;
	bh=UXIJiCsC8Z4R/CWdY5NKGti0bbTEAfi54D0DmbVIUgQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jLhVPVX5IzamBgXtx35n7Kphj3w/x38tgWHxXtPG6Nqta7RSbgwx1eEPkS511W0kE
	 bfHacOhXl6l3uoHJjQBLnDTu3VJJ8yIe5DLl9wHiI5qGAmuiQjsuRoN+R0vAYk83wS
	 3qS1kxqzvE2pO2E4SyAxZmSLk5hPNsnAR8FJFO85E4CqJzmnNUyDi/etHZf5uovUGL
	 a3eYkAMXQmbTOvLSayVgKdHP2v4lwqyuUDtLCsUGNUrmWbx5N4CI2Y3a9lzDbj2EzH
	 WJHlESyPcjLya/fnowxGj+5xu5CIW6m4VchhrnVDLCSK2rQ5Yv2ZH8q1/msA8j9dVY
	 SOuIHICMzBfvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0058380A951;
	Thu,  5 Dec 2024 18:21:45 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <hpj2hhd5dyxo76p7d6a2dcwxzskcliqq3o5iwdygsvjfqadwii@xccheb7kfxu2>
References: <hpj2hhd5dyxo76p7d6a2dcwxzskcliqq3o5iwdygsvjfqadwii@xccheb7kfxu2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <hpj2hhd5dyxo76p7d6a2dcwxzskcliqq3o5iwdygsvjfqadwii@xccheb7kfxu2>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024120501
X-PR-Tracked-Commit-Id: 8d355b56f29533e0b0db0d9a2de8bdc05ab27375
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a770b49b1bf00fca5473cb386eaf36d21d17d4b
Message-Id: <173342290430.2016621.11193344301021841783.pr-tracker-bot@kernel.org>
Date: Thu, 05 Dec 2024 18:21:44 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Dec 2024 11:26:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024120501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a770b49b1bf00fca5473cb386eaf36d21d17d4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

