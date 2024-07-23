Return-Path: <linux-kernel+bounces-260225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE893A4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F11B1F23904
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60643158A06;
	Tue, 23 Jul 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbvBbMuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CC158853
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754290; cv=none; b=gfbo/KdMASpWrpQI/PD2HBksa5kg0rSLzUGwKO9dBEziGDRfb5DW31CuaztJflY3WL/ro5gz3bKv0AZ9vsjso7V2Rg+ca3fnl8YR945U2MF+F6A87q3P8HaY6f08/DDFSKzPx++AOMUj56VUgWJ3sK8FE1CceYoJjTwPzk5lenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754290; c=relaxed/simple;
	bh=48eRKNrHdfW4Aq4z8AhJ0Qcb6HMqvtcmdCBXBSbeIlA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lpa77z2Z8wGMnHUvFIy/inyhV9vj2k9kmzGti3aBQWVZ2yydyMGh30ZqKPpkq24U5m/ejUKpDce9Q8FSqRwonz606AwYLZ8E26AjHluCj5uFZhAbFrF5DDPpCGAg2wlVZvHBNaLoyom5tA8Simt4iQpJHtBMP7n9KNPdeR1cQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbvBbMuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38B63C4AF0A;
	Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721754290;
	bh=48eRKNrHdfW4Aq4z8AhJ0Qcb6HMqvtcmdCBXBSbeIlA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UbvBbMuLQTXOvQnHn6Vd6A5CNZ3/knuFe8sDgjBnPwk3CNWoHTR3V7EPH1EKA7O03
	 NfSjF4t78lXQWHh1+inwLbULKxzT+QWQs+cyGORLuiKGalVX3Am8jxPKXkgcEfI+d0
	 p/VGyHVicHLDx3Khqf9jJUAfQDcX8yhXaHm0IjLIaGRwqNAWF8vAcYyNFAX6kFGgOa
	 5AP4DgCiZ1KEkNilYXMkwf+PgEyM8yogXYBEKO+a9Z5KRT4WJuNyU9JUR//XzQGc9N
	 XPulBCBNrCNdiXDDhC/6ip3wOkPdiLyIQ2igNpZqcYgmEpj1NwTFFWAVcyGNIcBGnD
	 aeDKWiSplg9cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E5D7C4332D;
	Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2DOB=RUQRm8m+5=f4ZEP1FbygenhbNGn5dEA5nVO7syQ@mail.gmail.com>
References: <CABb+yY2DOB=RUQRm8m+5=f4ZEP1FbygenhbNGn5dEA5nVO7syQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2DOB=RUQRm8m+5=f4ZEP1FbygenhbNGn5dEA5nVO7syQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.11
X-PR-Tracked-Commit-Id: a8bd68e4329f9a0ad1b878733e0f80be6a971649
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d51f8f63f7cf19c7c7d0288650fdee154a89d499
Message-Id: <172175429018.5236.2514400386756980265.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 17:04:50 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 00:55:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d51f8f63f7cf19c7c7d0288650fdee154a89d499

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

