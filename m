Return-Path: <linux-kernel+bounces-290055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD216954EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A931F266A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD461C0DF0;
	Fri, 16 Aug 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9fudAGO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15291B3F0F;
	Fri, 16 Aug 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825956; cv=none; b=NgGzBp0aMTgId/IPadbhX2KwABMhmKlfIlDIG7bAWwWNxL6G6J/jymF28rFTL9xPfCofmbFzw5sgAQ68P6Inpa5Na+1Fg3yUULuC2nprf5Fqb8Ma4kbJCDmjduRca/9v3Jf4tArcDEdFhLic0PP7JzzXI+CB9fE9X9VJ87LYPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825956; c=relaxed/simple;
	bh=0H5Y5BZ9JAaFGPHFVMTD5MDv4p3PQqkoAGH1Y0WZRGU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gMi7TMXX26cwkBqTKoRBDXjHb8M+4mrWWuTHeWK7Cf5bFsnBqY1Z7l5sAZtDqY0uMTJqHxr7mHR8i/TBuVGSjCZ35JfsunNiDoNWwHCsBtLBsK1gW9XvnP6BOvwEDLASOy1JLMCNbNgndcLgeQOhsRNEPLZUiT0LIWVofDlJs4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9fudAGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FDBC32782;
	Fri, 16 Aug 2024 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825955;
	bh=0H5Y5BZ9JAaFGPHFVMTD5MDv4p3PQqkoAGH1Y0WZRGU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W9fudAGOjEFsKeOHoSD6UQrAvwCg2ZFLudLAaRO69LwpksceQcYUjL99sHwS2AnVR
	 VqJYi8JJ55FLR2bU2JpvQas8EFlNtZmZjyHWm8PPhfL4HaJRMOJpQbcW/JGrF1JM2N
	 70MdS0nvduGxxqEZRn2lWp1EBnFvZIkwfbeXZs5Ul7g6hTUWB9Qe+DchX3LJFIJQNK
	 jdlwmWhpOBpE2rwJaVOMKmJTnjxorqP1zxXaoTWT21j2JUpz4d+doXgEPR3c0uLRlv
	 AUOKxiYJ51nEHrhti6YE3BKj058MyCIDLaRCL9uH1OVBq4bDlwgZoKwb/kGNcumPxg
	 vfEqigYEdSksQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2B38231F8;
	Fri, 16 Aug 2024 16:32:35 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zr9WubNFJyVjE1R0@8bytes.org>
References: <Zr9WubNFJyVjE1R0@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Zr9WubNFJyVjE1R0@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc3
X-PR-Tracked-Commit-Id: 92567a5f92bc947fb7aa4351979db1b7b71a554c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de53959e001b73ceeb631e04491b473157e1b1a2
Message-Id: <172382595456.3569819.12032006375454107622.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 16:32:34 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 15:40:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de53959e001b73ceeb631e04491b473157e1b1a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

