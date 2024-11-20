Return-Path: <linux-kernel+bounces-416392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29339D4434
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E0B281FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD01CCB5C;
	Wed, 20 Nov 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii6OohFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93F1CC15E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143375; cv=none; b=sofsvpdYfwZyOzqXf2mpKsHjWIn4VyAEZJkDy+NnVYD3WbwX20Mgjnv4HaUGvzz0EJmuZGHpuFfLMIkYDns3fPPO3BfvCYfhJ8yLNMsfD0vE27Fe86pQg3QcMb6gzPD6IGgvH87A7X1jEEzC4J1P7g8omKogQTJLvRg/A2hanxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143375; c=relaxed/simple;
	bh=ITGtP0bgQi1EjiOSR11RqZZHjLzF86NMgPtvaU35aNM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QXiog3ooEwWwbnOTCExQ11uPwZHfiFoHfqOKy5seNjv4XEK8YVYk37Dg7kuWExM5IJJ967MWh1Z9XIKMxwQcRLAMdjaEwJNoXDQr/gL4Ug1psTxQNxmti0uc7n1odG9mekAZk369TG/DkXi9bPefxpo8LSG6LPjb0n773PbgXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii6OohFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E579FC4CECD;
	Wed, 20 Nov 2024 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143374;
	bh=ITGtP0bgQi1EjiOSR11RqZZHjLzF86NMgPtvaU35aNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ii6OohFIyEgpQQt5JYACKkBB8xBl8ux4TEcv097dyEqu9wfbP93E+SKrd9YDA5PN6
	 vhf+2lzle8MNzljMWANARtjKLHj2JulnI8pEfPvhh4R1nvKuOpFcSOTEvGpWguidgl
	 4YVdbSSY2LTdBbXneyraj5yXhWTpI3wz3BDgm59fNsKKfCRSZnj4pY2h4ErWRn+veN
	 fHDEz3vj3s39W8u5FgBLfNKavn3cdPDfiKSBs33HmlbWvEtoTJXmAP8C4dewXsvHsD
	 xluSaNqzwhYE1yfUTH2DIHBR2SJ/i3pheQ7+XwMCRkSmiAvnivjrTSavzsgdABId6v
	 tMEEjAINDDIew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECC3809A80;
	Wed, 20 Nov 2024 22:56:27 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp update for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202411190902.3C7A23F38@keescook>
References: <202411190902.3C7A23F38@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202411190902.3C7A23F38@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.13-rc1
X-PR-Tracked-Commit-Id: 8cf8dfceebdaf282da8a836b2bb578808a12698c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df66aeadd8f8445a1a73c39f5ec62c61c89f7e9a
Message-Id: <173214338659.1377324.6971585765197463687.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 22:56:26 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 09:02:29 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df66aeadd8f8445a1a73c39f5ec62c61c89f7e9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

