Return-Path: <linux-kernel+bounces-253178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6B931DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A73282B99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BD145B22;
	Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtCSxmYh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216B143C6A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087784; cv=none; b=G9BQCyalT0bXZ7wM8v6XANRgpoa1f76G4c4SYx08VGH6iuKoTBS1Ta+TmVU4MSL1UoXPCOYLYheVe9wxDKHdt/JuwndJpn7oZSja0/AvAPCq6K9sfsF4insFHg2PtO6jQzjb8zdjTevpsJ2XwNKZOfGHG7yZrnGgl1Oa1b487PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087784; c=relaxed/simple;
	bh=OoexJxNjOp9zy54OvCN+rIC5DfbFZ03rAMiEu3Yyzyg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fd9v2mXwzgS9tJuHhuZifDKL81rt/Piwn7vkbeI3TCSpc9tRaNMDGT0R3Rs+6xySqj6I5BOXw4nx1Gc0WmfUOhqIprCOuX4C1NMCdQe0OlqnlUrdyN4xOX9PiU2mGHBFvxrAkyOymzIRMZCK3JHvHUAwCkTpg7afLMqMd8UWc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtCSxmYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0666EC4AF0C;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087784;
	bh=OoexJxNjOp9zy54OvCN+rIC5DfbFZ03rAMiEu3Yyzyg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PtCSxmYhv+5wEbJ4cTEt7qo86qM/7RjZKhrG9WKchZmz5TXfa0g9K+cK9aMZea8/v
	 KpTQCnn8mwJmSDkalDtG1zMbeLEwRYM3YZ4zK8HoHhOJerVQoUUaOEKfeSRIsy4Ohw
	 DnY4+PJz0siwXQKaEgQ88ZERow2Vhw2XWtzGqH/LRcUefAXoAGGqKqdAQuOVlaCnmK
	 qAjWnbg1A4CC6pi7jtx3AsoWvpNfYyXerCvoEBLEJwhDfw5Ry6OhJvI1ptpDSkUKPL
	 uQMR0yw0YA1PgcuOEiqyKwEcVRpY1Q2qpJisi5CSe2XDrEta2MwwEDtSZ1B+vqC/ut
	 s0paoeJhqzLWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F26F5C43443;
	Mon, 15 Jul 2024 23:56:23 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172099001823.1942258.3381470277418419084.tglx@xen13>
References: <172099001487.1942258.17671805941963584080.tglx@xen13> <172099001823.1942258.3381470277418419084.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172099001823.1942258.3381470277418419084.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-07-14
X-PR-Tracked-Commit-Id: 77aeb1b685f9db73d276bad4bb30d48505a6fd23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eff0491e74c4df69bbe43555243ecec85577823
Message-Id: <172108778398.25181.15637315172011165528.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:23 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 22:50:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-07-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eff0491e74c4df69bbe43555243ecec85577823

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

