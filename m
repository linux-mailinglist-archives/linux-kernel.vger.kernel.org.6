Return-Path: <linux-kernel+bounces-320333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B357F9708F6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73920281ECE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E656176AAE;
	Sun,  8 Sep 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgnQ6aTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2033176249
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816680; cv=none; b=U2cwZbCf+9qI4kG4v0zjn5ZXXP2Mts53dj8yeqHqvFvL8SSmacEA8Tx/lu/x+bKnx84PqjfiBh84Loq3blK3uA6jBlbdvI2R3xrMeMfpCSJspWVvadaks7xiDPuR1YHDLXYgVg7forTnSCl3z+3jaj4HZF6E7z/W5KHhTelYK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816680; c=relaxed/simple;
	bh=gQrlikFWIKrUwAflFEhcVAKNnSvgEcEo4iOkQOx7h90=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WCLu/plBgAGG4re0Va2AJ04fyR/OLTykGTj+cZ1e4AU2ILysynxUhnYf64anKLi70CssYGNprpOQqBRzPkTHOIbAEjRy3Npcr6e7DcmxTDQ28UTi7LqHIUGbg8x+AXkdF+zjTRjGBlP8qrP15/Rkb5i8N5Kc1obKV3dhfxWo5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgnQ6aTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44387C4CEC3;
	Sun,  8 Sep 2024 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725816680;
	bh=gQrlikFWIKrUwAflFEhcVAKNnSvgEcEo4iOkQOx7h90=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MgnQ6aTKfRUKLnejm+W/XtRAE8NKhO85a+gZ7BIn7JxfBSCkP+emhsyUmotfoDnTy
	 m1KaG032PA5yqi7vLF/QaLhOpgBcESkyv3MolNn4USwF3OA2vutJla2iRPNXFpWPZF
	 9Ef6DnFnZ8OGbhOp/ti2Mbqmcluy8jAB42DIL+6bouo8JIj7aC+hYqCN1gW0+y4gQ/
	 0rKlcpAz1ExbzsJFLGzIm/37zyY2S46dMGkafr+t/9TpaKeDjAIRFfiXM53wIsOgMK
	 QASliS2PYPxiSLBU3xaAcN7AlcjVOV2Pont1eeCXJyK40ZSZ93Nn4V1egTtPfAgcI0
	 hbJkjanxiMVFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF63805D82;
	Sun,  8 Sep 2024 17:31:22 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240908091200.GAZt1qYAzqQjCa7H2W@fat_crate.local>
References: <20240908091200.GAZt1qYAzqQjCa7H2W@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240908091200.GAZt1qYAzqQjCa7H2W@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.11_rc7
X-PR-Tracked-Commit-Id: 342123d6913c62be17e5ca1bb325758c5fd0db34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89f5e14d05b4852db5ecdf222dc6a13edc633658
Message-Id: <172581668103.2929521.13580422461993027858.pr-tracker-bot@kernel.org>
Date: Sun, 08 Sep 2024 17:31:21 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Sep 2024 11:12:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.11_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89f5e14d05b4852db5ecdf222dc6a13edc633658

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

