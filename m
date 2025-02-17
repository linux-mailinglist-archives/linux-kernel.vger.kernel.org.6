Return-Path: <linux-kernel+bounces-515896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4085DA36A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4952E3B196D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119A142905;
	Sat, 15 Feb 2025 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8t9e6Fr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A813C682;
	Sat, 15 Feb 2025 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580804; cv=none; b=MVkVZ9O5lFzxyOPUt2W2C0dylI/mF1sCDG7erLm5yyPCvvgIoKxcL2DWfk/jz28H15FgKcHlb+DnSxaXB7SVlWLugsjxxDOUzq7F+AFXmHhedoBUsIy+bfOk69DmBRxm5x2G9cAWWUXhji/+5EQ+9+tzSNAB/8GznBjRJq4NFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580804; c=relaxed/simple;
	bh=DlrmAMoJX5ZYdXEgH/Flr+DIdLdp31zRWx/KtYPX5rc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OrABrQ7TBoLRAQdvzrLdbDaLXE9lFAlQN+c3m/za4y0AsHAgB9Eu324Ij9k9VtynPlTVAk2JRsq18MIIWnidXNjsNDAOEPaCABBZfkGgha0HamXzzsmjCdnHRLXpX6oiCpxXi/18Wqb7DvslNPSqPcl1qETIhU3I+VCC7o4H+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8t9e6Fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F063DC4CED1;
	Sat, 15 Feb 2025 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580804;
	bh=DlrmAMoJX5ZYdXEgH/Flr+DIdLdp31zRWx/KtYPX5rc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k8t9e6FroZVzxPFd5FyU1x4B1dVqEH3R5d/s2JEvuW28btoc/jBSSBbFvXSGAb74x
	 8H6hbuR+PkfrOKcjiJilewo43uvUj7Pqfivn7KDiXXrdz680ThxyPerGNO/TF5kBy5
	 HkLwl4Mptb6yTb7o5kgj5WRqIUFQRGx3kTaPVluUoImYkdaHgYsFFn2tt+E2McqjrB
	 YGI6idOrRHGmxsDucVHarKFdp8IdMJieXrgmCP46BLVw91+ENodC8ZXuvDd0NmIqaF
	 Jvo/8pUm/hFstnr1dO9acy4OrGO0s3zO2B9tqmdfAOpg5CqIgwaRhuQtzAFEPgYn0y
	 RJOR7rWHSaF8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0BC380CEE8;
	Sat, 15 Feb 2025 00:53:54 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250214234904.GA174406@bhelgaas>
References: <20250214234904.GA174406@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250214234904.GA174406@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-fixes-3
X-PR-Tracked-Commit-Id: 81f64e925c29fe6e99f04b131fac1935ac931e81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78a632a2086c5d5468b0e088a97b26e47c569567
Message-Id: <173958083323.2153475.7277353770182590828.pr-tracker-bot@kernel.org>
Date: Sat, 15 Feb 2025 00:53:53 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>, Alex Williamson <alex.williamson@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 17:49:04 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78a632a2086c5d5468b0e088a97b26e47c569567

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

