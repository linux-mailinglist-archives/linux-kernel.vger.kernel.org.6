Return-Path: <linux-kernel+bounces-393913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB29BA765
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3654F281AB8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC018A6B0;
	Sun,  3 Nov 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyEat7re"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A7189F3E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658559; cv=none; b=Fh6YKv2xrL9LlxDiYloE5jfzr2yTNAUEvgZZYrVDbreUu95NnF2yyFu8iwauE2DS6wEyVv2rHzZLz5RkEUpXagRafjWDtRsNQAm0B/mNKhUbCD9YqJJvcn7hYqYYfDq9y/mmRLTy3eYG79rEC6YOpt7LtAocYQmPSyxNX0DMj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658559; c=relaxed/simple;
	bh=1aKu+d9398d5lu0OJpRPqVO2PkT630JN9PjvV+wY5Ec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R5IhmVlY9iySfdYC1uqNCP8mVMVow/oOfZEvDvDjveNsP5z4Ir98bcQ08IYCOYB+T/aJBZ8AV/WDE5jG/hyYsumsskjmRl2Np49CXUP6ZBe6r9NofBE1eKx/qJwnU/5TdBNAljrSArI3LEQ+z45JAZlkMGQiPF3ashJq2HHRzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyEat7re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3495C4CED4;
	Sun,  3 Nov 2024 18:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730658559;
	bh=1aKu+d9398d5lu0OJpRPqVO2PkT630JN9PjvV+wY5Ec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IyEat7rem16WXQtZP40q/rKaHnLe7MOzVyxJJEywmP9kEh/pqGcX9ncQ6Ji1sLWvd
	 V8d8Vw6Lj9fbcMEPN8qr9hVV/xmAFu9dI82/DgvNUzhyQ7X7+KX495sL0nblyRHVcB
	 ygdbXxL9vH5dIVm+xQOw1JHzTpcuURSkaMhfKF8j5MJanSpvDZxbad0yn/RxTiaQHZ
	 fdG7NHymZgkoPSk76khEQrJ9ygJPv0itBSz9ZZy3Cz6BBm4IJ22YgDHN3FLpTRMqWr
	 6Mb0muQuD/M+Y02nvZApjt2f22tTyptqkpTU8Bv8sbxa2Nzwd/ViQ46WJfmScsyfNx
	 HgB2qdyDA1RsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC0B38363C3;
	Sun,  3 Nov 2024 18:29:28 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <173062983020.1467946.18431922666552238508.tglx@xen13>
References: <173062982864.1467946.2540622433845043721.tglx@xen13> <173062983020.1467946.18431922666552238508.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173062983020.1467946.18431922666552238508.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-11-03
X-PR-Tracked-Commit-Id: e3dfd64c1f344ebec9397719244c27b360255855
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68f05b251b7156b10a6f6547f7f8672ffb94100f
Message-Id: <173065856718.3226528.16144448427754146488.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 18:29:27 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  3 Nov 2024 11:31:00 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68f05b251b7156b10a6f6547f7f8672ffb94100f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

