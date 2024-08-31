Return-Path: <linux-kernel+bounces-309685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA73966F32
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165E61C21688
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 04:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753513A885;
	Sat, 31 Aug 2024 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APxbfoc9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696A139CF6;
	Sat, 31 Aug 2024 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077501; cv=none; b=oe6eIhuSG4NYVaL3RJxwc0oeAgK6hLlBksOfPaT5AZJt/sX7laDgxPfXtv/L2Cr6//82JnBUt7LQ/4gRcYD46uQPudrmynkGT3EgrDW6s3wGbZqqEoO7BXUXqLMZ+6JQb/cnnk5ziXEcknye//E9+ChCNBekChqA4STSY9YP92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077501; c=relaxed/simple;
	bh=OSKeTIHTj62GwoUlIBmNlFLWBcYniasR2WlcaU5gu4s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tZMz9dLSj2tk0wjxWs46nNdqHLHOSuHRoJTq97CX36usvkPnYsdAMXTrNnlVnyCLmfNIbIhlpwzXgdxolUdAtR0j/JRBAcp/hb7rOV168d25gh0fPyUnJk/GgclKty6ucaAi+icuOOlmuN2AQDFdhSc1ukVEx9mOy8wcOCAcACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APxbfoc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04832C4CECC;
	Sat, 31 Aug 2024 04:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725077501;
	bh=OSKeTIHTj62GwoUlIBmNlFLWBcYniasR2WlcaU5gu4s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=APxbfoc9BbQ8UElBRsWBnlAT6XNpEKE9EHvl/WzizzkZdqAfptHZNZHVlDEH6Z2Lk
	 R6/1HWL6WdD6G6UxVyDtTCpnm7ks/AtBv+nfqN+2eEOcHFPgYKiFOZ8Y7NK3tzkhpL
	 icGKHQPd4HZ3FgSwJy9Gjr9eEWvwYLmXpafFtlRZw/hMdsLBOV9szsJoVimn2C+lQV
	 QvxUamEjnpN5FnXq7iJOFHDZoBEqOHw4ytvfPkyNzg4T5qU84jmkwxYk065t18rLQ8
	 Clu2cJU5iuTJB6pkopJC8TxHM1+GcN+tYmu5d3af9/LqGfha177h7r1lmRmby0Mnfl
	 NPdXTdGV3I5/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9FA3809A80;
	Sat, 31 Aug 2024 04:11:42 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240830205733.GA126293@bhelgaas>
References: <20240830205733.GA126293@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240830205733.GA126293@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.11-fixes-2
X-PR-Tracked-Commit-Id: 150b572a7c1df30f5d32d87ad96675200cca7b80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8101b2766d5bfee43a4de737107b9592db251470
Message-Id: <172507750132.2790816.13533355901080312493.pr-tracker-bot@kernel.org>
Date: Sat, 31 Aug 2024 04:11:41 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Frank Li <Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 15:57:33 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.11-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8101b2766d5bfee43a4de737107b9592db251470

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

