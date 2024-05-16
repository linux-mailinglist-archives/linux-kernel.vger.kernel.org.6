Return-Path: <linux-kernel+bounces-181308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CC8C7A40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF6A1C21869
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C614EC46;
	Thu, 16 May 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTLedGxN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138A2421A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876623; cv=none; b=tAiLLqWMoo1L30FeAruZQi4Z27OC4Qy6eH1S7NdVRs9HkpChNHVMVfBeWcvXJLZkafyfh5WS30AoOJZbRRI9cBvyFn6gQaOzKSLt2vIKziX2wKH0DLPbQD9/Arfwb3rN5HU2nxn1gTCJ+6D1UdnkrmIMOvDT3AVKazIs9OcSfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876623; c=relaxed/simple;
	bh=NWcuja2TGvoqXsxcrE5MZdVTFlrrtNmTLn/25njXllw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uOmQJtcA2S49pLCPBBuKpOL01Rh4jSLJTcDgHYVlg1+ks6PLZCZ/wMmW7R958iBC4sjdGk0SeqMSMNLP4buraOIwPDiZGNe3g3B717nnQOuxkaf+v7/YjzDaP7OFhI3fyv6OPLK/e7Lzr7Fi7MC96VPnh5rzKpyDK6Gy6+rXJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTLedGxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CCADC113CC;
	Thu, 16 May 2024 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715876623;
	bh=NWcuja2TGvoqXsxcrE5MZdVTFlrrtNmTLn/25njXllw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OTLedGxN9zu9QDg+g0UYEemiGx5U3mOHXRfwOHogsoOBmxq0jPz8Gc5wCjc8VLxF1
	 fV2pdtoUguDN93irirzKcq9TmwnN9sD3SNszpC1kyKG5+mBeoTs7Lws3apZc3iEIJz
	 ji4Di/duAC5vAFZA0/VnWykECzcXnm1MaDOJS0BgWl/yU1v2p25AN4tSa8QcsIMtlO
	 PQXPHUJIiO007uq/I66+EDwjtzEWGwx/44SkFlhiBXDnhp5a2PKaXl0YxHTVgheXZv
	 DaxtX5yYrJa5BGKFWRm4drvtne38oZNaTCOVkuymQ4oM4SJTlrCKVrisv6i2V/VO7V
	 11n6HkaUvjtNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20919C43339;
	Thu, 16 May 2024 16:23:43 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516111016.10d8abc4@xps-13>
References: <20240516111016.10d8abc4@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240516111016.10d8abc4@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.10
X-PR-Tracked-Commit-Id: 552c9380f98fc47950870ef0935f94cf3acec087
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b426433c03a6eb547515edbe74ebb3a90b9979dd
Message-Id: <171587662312.28916.5460814490515635624.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 16:23:43 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 11:10:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b426433c03a6eb547515edbe74ebb3a90b9979dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

