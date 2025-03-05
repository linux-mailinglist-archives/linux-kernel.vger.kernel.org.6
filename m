Return-Path: <linux-kernel+bounces-547425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B5A5074A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E7175165
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEC252915;
	Wed,  5 Mar 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s55jNMP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609032505B8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197317; cv=none; b=n6Tptfn2yOQhLxeR3CRBXl1Q9beKlbeHjPEYvPanKZbCQQ6urdxhwRJOg5FAeQcIqyXAgnVHXGY79NbCQVfKtI1yh/Az5HRq48A7M4eXCSuWzRHpE97pmIDr50VvjtVX9fUQp0FdWWiIeZ+w6eXr5VML8zb+6h71eo6MELvxe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197317; c=relaxed/simple;
	bh=PitLcp5xxnd/PdyPMPoYxiuWe+XNePK9+4LoDc6ZVW4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E5MiZZdNwkyyTFeqk3HCxA53WMENYDAJBEo4KFID3FLcHyCWm9gGWge4QxMHb8wIHGfyjPSDSaT1rL7WMcZfaJ3XA+ujTA+ilhhhwrW6qJ3T6AohSNVbsZHaUdprp55VR44GsD75tbL2uirS1WcqtAXmmh9X9fq7GY9GcDSUID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s55jNMP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5F3C4CED1;
	Wed,  5 Mar 2025 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741197317;
	bh=PitLcp5xxnd/PdyPMPoYxiuWe+XNePK9+4LoDc6ZVW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s55jNMP/x+xg93N2YnbeGFuPp16W59pq29sSGyKMJJ0nP0ObG2agLLRa96iDwXOOA
	 fui0hGdhvSg3Xr6qMOEK6Xuf/6J/8/kWvTf9N1DDncxe5rY7xAdO95Z4wfVNyRgaEj
	 QN2HohgjlOFlvGPy8+0Jo45iHHnp+PmMk4W+/2Aewac9gp+VE9hofezfXfeiGCQTtO
	 KLCo/zospFZGUnfG9TZQwJ0c8cT31A9sX41XGYcOO0LYJsG4uFdeoIJM1LrH1uxxAI
	 jImPHLHJdL8/UZKsAdPYpYuf93I59my1K5RTWGzPPDe5m5g6Uvpg+4BZdxEvi4Ez4c
	 XEGPWb0AstDJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7119D380CEDD;
	Wed,  5 Mar 2025 17:55:51 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <0o3np45o-r9p7-s59s-0oss-opn264op2ron@xreary.bet>
References: <0o3np45o-r9p7-s59s-0oss-opn264op2ron@xreary.bet>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0o3np45o-r9p7-s59s-0oss-opn264op2ron@xreary.bet>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025030501
X-PR-Tracked-Commit-Id: db52926fb0be40e1d588a346df73f5ea3a34a4c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 848e076317446f9c663771ddec142d7c2eb4cb43
Message-Id: <174119735016.968605.13390473321551006663.pr-tracker-bot@kernel.org>
Date: Wed, 05 Mar 2025 17:55:50 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 5 Mar 2025 14:43:46 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025030501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/848e076317446f9c663771ddec142d7c2eb4cb43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

