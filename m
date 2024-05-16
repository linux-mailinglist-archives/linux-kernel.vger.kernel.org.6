Return-Path: <linux-kernel+bounces-181311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D08C7A49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E6D1C21A65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC7A14F132;
	Thu, 16 May 2024 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipk2Z/Nc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4514EC72
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876630; cv=none; b=cHca8Y1iNH1ZjaBxboF+X+aSKNa6W759UPTA8QeJRtJ4AT4OS/5i9ZvcERwZjmFwCb0O6GM0fdTLVXeTxTL1/0BFQKk278v1pEnF43iw7WD8f3/WhXNBvqdkQgv2lbqY3VlPcMLvdwNmvIcsN8R+WTPpS8/uwKpKxxZeYBSDzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876630; c=relaxed/simple;
	bh=2jv72vi9iRLSbf7VSIHm0pSfBr454mmo45Pi/MP0/0w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eCs8P+I/3fSlXrJ6hUnbYPrqZeLPSNTsdKUR6ad7Uu4qjHyrj/ifT0o1Dx/GvNWaxSEOsQh333woFEHEqIESBCSTfwVk1WlEKucbx4nHYbWwMXbEHVf+Vt4jrktW6gb8b2yb7GESn/USTZ5Zr1+vRL4uJ/hMunQDLsSufI9QAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipk2Z/Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29E35C4AF09;
	Thu, 16 May 2024 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715876630;
	bh=2jv72vi9iRLSbf7VSIHm0pSfBr454mmo45Pi/MP0/0w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ipk2Z/NcQxNwmitAKcL/mYsCr65J6kMKyQne1diPvBp9NIBgtt52zj42IpKN3bT5t
	 W916BAE0cbaKNkChrky3I0odi4uMs/Mbp485ViP+HY6zsDDdzNQL/qca4ixkVANxkL
	 WY+HUJPoaqRGvOhgt0AvoZ9Cgj5j8XxAqM9CV8ZAXGndBWVbjT4r0wWKk2WpotoS3B
	 1EXTz6953kJQkeiJEPBnVKvwSaH4xEL2/lofS2J0SEgIGr4w8/Gr5KjuJ8eX4JSZDO
	 nDId1QJUOBDonZGG3nV++WJthvkB+8pA1RvwevtT74qS5ibx/vKY4wfx3G9IsHYQvA
	 Km06FdE/sc73w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18977C41620;
	Thu, 16 May 2024 16:23:50 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.10-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <d9c1d381-be31-49e9-8a99-4a40a1344a66@redhat.com>
References: <d9c1d381-be31-49e9-8a99-4a40a1344a66@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d9c1d381-be31-49e9-8a99-4a40a1344a66@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-1
X-PR-Tracked-Commit-Id: 2513563edc984c3cf05bca1244b46de06daa4755
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea5f6ad9ad9645733b72ab53a98e719b460d36a6
Message-Id: <171587663009.28916.7502283122427529319.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 16:23:50 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 12:07:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea5f6ad9ad9645733b72ab53a98e719b460d36a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

