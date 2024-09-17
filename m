Return-Path: <linux-kernel+bounces-331337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73697AB76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388B728C9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E514A0A0;
	Tue, 17 Sep 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5M3fiO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2C156250
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554943; cv=none; b=GnJk2HkfQQLcD52x6b3BRVOrkOMKq4ZMc8qKiWciK0CTfynJIkCjsxzzTXXoznSgPrShcWiS0apb6FXVrn+Rx47a6ELQVyxTvoOLgnikKdcVr0C+67yQjunkuB8oIGL1t2eDzhSlu6TxXE6zCGoxSq3HmnmE1g2mzGK0N4SP6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554943; c=relaxed/simple;
	bh=fxG+vl3BA59FeUGT/WE0LQcj4hjmDsKTvyxe1LgIul4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W7Lkxx9clGknlEMokziESFtQA6f4VIrigxAH/+q8KkOMjPJcHFSD4p+3AIR9BPQuhhI69RUX6etSXi4j42M+DHpEip7z1O7HwX/roCqwEh25PDnu0s5vBceGwZpXqbF5bon+mNRttS5xJtnEhN+ouTUkQx4Ld4U6EwJO6gkPs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5M3fiO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A277C4CEC6;
	Tue, 17 Sep 2024 06:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726554943;
	bh=fxG+vl3BA59FeUGT/WE0LQcj4hjmDsKTvyxe1LgIul4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z5M3fiO8uQSsEGAxoSn5Y+GTiwFTXlNQVvde6UFwb5KwFP9w397mlJw1jUN9MJF5B
	 hTH9o0nBHeENceIoNFmwbehyRifw5wxZAa81Q6XHYHvnhZzH/lO38oqul1NFQBaFFs
	 OYvtCN60GAS+emo6Pxxww4AvP/aMvaLDfYUwenxRo5MIyhny3WnDS2gNGMfAxDwaFV
	 3U76Eiqbokr3b5Ts7FVU1KeLroRRhXVyqtzSnS4m12RkYFPNm9qMU1aAJhjE+3iDdZ
	 jnQbrOHwNL4G/ZrmeBqf7ahNnnVl9XQ4RTWaQ9mGZ2haoE4UpPRxVCrkTxi160VB+G
	 hhKhghV9gL9ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 354F13809A80;
	Tue, 17 Sep 2024 06:35:46 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172647588843.2450257.3544233832195550173.tglx@xen13>
References: <172647588843.2450257.3544233832195550173.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172647588843.2450257.3544233832195550173.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-09-16
X-PR-Tracked-Commit-Id: 63a4a9b52c3c7f86351710739011717a36652b72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: daa394f0f9d3cb002c72e2d3db99972e2ee42862
Message-Id: <172655494481.13787.15302987172277347426.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 06:35:44 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 10:38:34 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/daa394f0f9d3cb002c72e2d3db99972e2ee42862

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

