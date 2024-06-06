Return-Path: <linux-kernel+bounces-205097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 659918FF705
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196C71F23529
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B039913C694;
	Thu,  6 Jun 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYR6Z/Jl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4211219E1;
	Thu,  6 Jun 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710457; cv=none; b=bLVxt5Om9WoSbTPYW2njhNyjasryi4T4zRGkpA6DwyPWcw1eGHr8ZPXPhwmDs2hN/5sTRo8Ft9twegO0aBVO4IgLij6gltmPr3pw46eYJgKFNG84yaI/iSl6/oQW+KQnG8iDTLHyQJepeNkuraI/DVwN5EDIVQHQodGrlobJi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710457; c=relaxed/simple;
	bh=dFn3yhVpa+oQpm7LH+q+Fv7OwlwNnf8gBKcAQhVyqqA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mOOeCkOn0mt4JkKMWvbwnOBY5ZnNv9Etm8ZrDQ3ScnfAWPjz2bIvpODFYFRBehIyavDsDuSGLmfPOwEtsZ2EQC57h3N3vNCKOVgwHrq5DlbpSEkWXNU4DlGVUdxpu4EZfyDRkGNbOSJFlYKKpk63OnAo3z8yZEObHeIB1EVYM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYR6Z/Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE172C2BD10;
	Thu,  6 Jun 2024 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717710456;
	bh=dFn3yhVpa+oQpm7LH+q+Fv7OwlwNnf8gBKcAQhVyqqA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CYR6Z/JlB6ftpHdY7pBeCJAp4gZTDi3eqSV4B89/DhwjrnA6WW+qKK9ppPHeH2JeN
	 BjJViAjCo8PPH4zTWpxAI354KV9UXVT4xquY0gg4XPry7q+WZx5dq86YkPDhjazdwV
	 MiYly/JQzH/ycRxBvv1njwbwm2Z4ti12vSnx15nW4Aj8Man8HPw81l5sCGj9x9uj7/
	 tOi0qtw36O+UdpRzCY3U3RvEKo+gNAMhdD/Uhv3AWggQ4pml80WoQb2BLcQJkESn6J
	 L5W0LEXgN98GRMG+KbavMcTU8plhs+o2XHgAhv8bZZaUXYTIylG4xGFfNQODCnakGl
	 HHDGa0xFNqHig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3302D2039D;
	Thu,  6 Jun 2024 21:47:36 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240606185925.GA810710@bhelgaas>
References: <20240606185925.GA810710@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240606185925.GA810710@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.10-fixes-1
X-PR-Tracked-Commit-Id: c9d52fb313d3719d69a040f4ca78a3e2e95fba21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d91e656262aeef16f6a296a2b6c8b0f7243f408a
Message-Id: <171771045672.14151.4527047493477849116.pr-tracker-bot@kernel.org>
Date: Thu, 06 Jun 2024 21:47:36 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Imre Deak <imre.deak@intel.com>, Hans de Goede <hdegoede@redhat.com>, Kalle Valo <kvalo@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Jani Saarinen <jani.saarinen@intel.com>, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Jun 2024 13:59:25 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.10-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d91e656262aeef16f6a296a2b6c8b0f7243f408a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

