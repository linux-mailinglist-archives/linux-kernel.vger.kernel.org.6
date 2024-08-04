Return-Path: <linux-kernel+bounces-273941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF57946FE9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4ED8281284
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AB13C682;
	Sun,  4 Aug 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0KvDIUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1D13B5AD
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790466; cv=none; b=dG7Yv2lAOHZXRpzfBVLIxLPbiJ/OFHVlu3CE7jjDbpvJRm/zPGfB+EVCctlVJ0dNQftNjzhR3GU/TVanCJohnFrjA26LdnP8imHj6aK5WM2T6V8+MAWAqQ1aYUYWFZvvF/AXKJsLVKz3ojbCwDkK6a3wazznYTJnOxzwr5TQLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790466; c=relaxed/simple;
	bh=8XsOzGYgvEort9VXPRj6J78WiuWHNLPGHnI740LDkE0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rILrJs++S46xRTFG2prl/UDRsipKkNMGYSirzy2+dkcLDLTFRNYEkkqGRm/HvK2f07qPbpoBiRzMWIAufk4O/yYKGPS63MfqvPzIGuQPemObaBTdvWdET6BNdOeIoIqC5Z5bdt9y1vdBd3jT1GIh1QptvRLXbGMEdvGZd75Ut4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0KvDIUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0D33C4AF13;
	Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722790465;
	bh=8XsOzGYgvEort9VXPRj6J78WiuWHNLPGHnI740LDkE0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G0KvDIUvkZ55SvEgPk2MiR5GTXAMiUKjjxMm7ZJJ3//Ht8k01uy34LGYw+keXa+V1
	 4urR8500zgIpI2+ZKRJPdNgfHEPNMAQ/7/HIGQcIbaVYseRS/MJjV/juyT/pl8JEU2
	 es0rawDojOo75fHo32E1A03IMS7a2UdpJqCMEUXqrm1OPa2N9Htaqce9mdBCXKeRdt
	 vF62FavVscktGlzBTYTxE9I7UGNXkaUOoB7erFSnfTiCxjDgVzqxr5Jod0ThMeIxBM
	 BY9g4b9U4pGTbq4Ni4iBQY46Sh5bNSOQNUgeJqRQU/sXup8Lh3eNVEYkKuxTkwA6zd
	 mgyY90JZEGxRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97426C433F2;
	Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <172277654786.866296.7434610502723586152.tglx@xen13>
References: <172277654174.866296.10517632866315552419.tglx@xen13> <172277654786.866296.7434610502723586152.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172277654786.866296.7434610502723586152.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-08-04
X-PR-Tracked-Commit-Id: f2655ac2c06a15558e51ed6529de280e1553c86e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61ca6c78295e242d4b681003112bfcdc54597489
Message-Id: <172279046561.9825.13323690041419912381.pr-tracker-bot@kernel.org>
Date: Sun, 04 Aug 2024 16:54:25 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  4 Aug 2024 15:02:58 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61ca6c78295e242d4b681003112bfcdc54597489

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

