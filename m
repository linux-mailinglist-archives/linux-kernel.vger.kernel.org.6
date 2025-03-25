Return-Path: <linux-kernel+bounces-576140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6FA70B87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0308402F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AA266B4D;
	Tue, 25 Mar 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8MFOo10"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97026659E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934652; cv=none; b=rXtFSF2NecgsKMoxU4PJ1oC3+1MCXghK8k2DOYIxyg2hdpEN1obh9cJ9Seg1YgZ4eOanNyCKv6TO5nmip/6JSBUNJ5DL2JaOxh+gmX9HVnLRWODL7Ou4Y6IkNLAtAskpN3AJX0O1FVawBGKVc/GV+JrduQ+JagQAYOu8bPyttgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934652; c=relaxed/simple;
	bh=rw6n3r+EAI6T9l7Nz6NvwTeupTnbBS+YUvw9PdkEzYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l7CYeqAcN00y0SEYoovqrziL/HztrertqQlngNVoC+jWuGvC6WQudvOejfYGE64ilPCPH6ktxa22WxeQIUA694UnjqUb1E4pT6VPIfKbbAMMEImf0pYvunlpRoKf47216D+vZTnFZkiBLj9JX9Fq44reETBpGVobNuH1V9KlmtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8MFOo10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF13AC4AF09;
	Tue, 25 Mar 2025 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934651;
	bh=rw6n3r+EAI6T9l7Nz6NvwTeupTnbBS+YUvw9PdkEzYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u8MFOo10yQdpra1zBszdapQk3cgUePAAQpm497OP7OR3qnMHx1WE5QaFIZXppml7n
	 7BDScNROZTt1oDlqMJ0mzpVFa6+ISq1A9opKNweGuGB9sC+FrFuxY7ZUFVsBsbOxq6
	 ADjlYRkjsI9kAeektdQUhW/SRKKqgq+kV1lYuqJXLKfX8Ds1Mm1vDr9vozarPjPr2/
	 RmJrTiWVijOVrccnRivCV9q6extDykIA64EjifFHZFD2fJootpEMw96S62XGkJbvZ/
	 W/1XRQWo9jkwQpZCyoIx+U+VQ1lUtkFB9h4iUSfYE5RhtdEFia+UNc7fsIW3X2ZDpD
	 7Dveps452VWeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC0380DBFB;
	Tue, 25 Mar 2025 20:31:29 +0000 (UTC)
Subject: Re: [GIT pull] irq/msi for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <174275225917.1561082.11153014835496302156.tglx@xen13>
References: <174275225552.1561082.4969731002775597670.tglx@xen13> <174275225917.1561082.11153014835496302156.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <174275225917.1561082.11153014835496302156.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2025-03-23
X-PR-Tracked-Commit-Id: 8327df40592103bcc693a99c8cb478c35c7ec7e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36f5f026df6c1cd8a20373adc4388d2b3401ce91
Message-Id: <174293468803.715410.13662092624195929373.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:31:28 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 18:51:36 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2025-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36f5f026df6c1cd8a20373adc4388d2b3401ce91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

