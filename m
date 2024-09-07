Return-Path: <linux-kernel+bounces-319584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A673796FEDB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D457285EC5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD514947A;
	Sat,  7 Sep 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek5C+0rc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161765234;
	Sat,  7 Sep 2024 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671368; cv=none; b=kxbpNSuAEvKWOiTNeqSu6+n4W2UainrqXl0g2tVZyVqxVEso/XrTWQtyRYEGohlStApGKWGA6FnQ1gd2oljiPNxd2uxLCGcf/8o8iBO8NGzyV991QrVn0UOu3J5pYKOv0wobko71RKu9l4FN2k/bgYd91RAHzYSMRQPUI5hFYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671368; c=relaxed/simple;
	bh=opKYAQT5iNQbXTXcjShxxauTpkD9refMn5v2hiQDc7c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tn9WfVU69rOSiRtqg65sSBw2/OKWElva2qft9K16tquisEi4WNRBrki6mX+xEaTLMCDp7u2Y+44BXeVlN1cp7SrE3TG5Ng/iMLpGXXL6bXs+rf6/gkkbuLQQqd7wbW7YhAiGFeJWL4ddrKp7fJmzEEX/l0WQUIDE1BrFeIV4MPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek5C+0rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDEAC4CEC4;
	Sat,  7 Sep 2024 01:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725671367;
	bh=opKYAQT5iNQbXTXcjShxxauTpkD9refMn5v2hiQDc7c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ek5C+0rceHLbnA+o2PM8OVyC6qmklHOJoTzRrQViYCdxWwVMwSEu8OBPj/oQ59uUE
	 n6vh2698Lkxi5JQmsclRrCmLIHaEyo4iTxQbiNj97dxV7Lg8TpZvmdFOhDpogapqXC
	 kZNfOK5n2VkAW106eD9ehlfepskCONyoMRapYsmfdalUuiKxvdAZpCxLV096Snfkc/
	 L6JwOv47FsmlFsPuUrp8VYHyLNP4bPBCPum9kyN+ydQQY7YlmC9dFrB6LSOv63MttV
	 L1x0Zi/aKfaFx6GGOU084uaRg1vpbFkWFGRi2ulHILda6E2wlfvYGI+781Ke9WPVtX
	 pZOhG0gxAFgog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0BD3805D82;
	Sat,  7 Sep 2024 01:09:29 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240906193739.GA431645@bhelgaas>
References: <20240906193739.GA431645@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240906193739.GA431645@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.11-fixes-3
X-PR-Tracked-Commit-Id: 8f62819aaace77dd85037ae766eb767f8c4417ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 487ee43bac846446fb3e832436bdedd7acb4fe46
Message-Id: <172567136832.2572367.8234471294382217894.pr-tracker-bot@kernel.org>
Date: Sat, 07 Sep 2024 01:09:28 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Sep 2024 14:37:39 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.11-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/487ee43bac846446fb3e832436bdedd7acb4fe46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

