Return-Path: <linux-kernel+bounces-422904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C49D9FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B081686AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B631DFE11;
	Tue, 26 Nov 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiVrumhB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1F1DFE06;
	Tue, 26 Nov 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664454; cv=none; b=KA2Sga9IRypy//laLkpWT0fkUtVmfshNqviWTfs6uKztwlF3E7s6W/sF8VS4Yfyi3QC4Qtf5bzl0wPr2KC1WR0xNQ4TX1+UPskAz+CG4dMDg6H9RFk2EiXlGHFJOXlfX+KAVvFgjrnyYow8/b475XzlfMw0IPNluv7bR03we+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664454; c=relaxed/simple;
	bh=fDXuP3gX7xBANZnL+Lz2U88o6VTOCMHwpTMez5Qogn4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N58fXZPPnDItmUj+UfNu5wdDcO40vs3S7o6QjmvH1dvjJDavGYpwml7Qf/ynY5AF4Py6e4dtcOnjxV+vLXmYoYw7Ia1EuYs67IUYGpxx4d6yts0j2XBNuRlVi50k4yEHi6Wv26zwyKVyuYU6Bc1tbkTEe+o+EFHwy3mzsg6WllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiVrumhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81C8C4CECF;
	Tue, 26 Nov 2024 23:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732664453;
	bh=fDXuP3gX7xBANZnL+Lz2U88o6VTOCMHwpTMez5Qogn4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WiVrumhB1gaefuPSu6kNTI3RDKwD9xem84D6DkOw238elCimgOq+E/RwicnMo9/8i
	 RZXZIIWKN8oSz4qIwj2/WqJkgZJUwsH811pnA8EltJRm3YqFWxCAGZbV7YPQFV6ORh
	 DWlu2E+O/GJjsVbu/sA2Gae6rguQhR+vbGJUGuvEbPu67EIIoVizHBLpG6fAa95dPn
	 6LM87aNpEZ3z6VcnlHru0RGYveJfWyHxovgy98uOrOe7mVDtHlsHVqxBG5EYzculAb
	 BfkxEpuuzVz3RMEgfWsDhMYKyH0lajTxZO2SdfKe+ruTp7Mi6N+eVcOVcuKjxM8gHL
	 602LPiuWNFrdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11E3809A00;
	Tue, 26 Nov 2024 23:41:07 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <81259608-5796-41ab-9832-0c8312e05b46@linux-m68k.org>
References: <81259608-5796-41ab-9832-0c8312e05b46@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <81259608-5796-41ab-9832-0c8312e05b46@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.13
X-PR-Tracked-Commit-Id: 63a24cf8cc330e5a68ebd2e20ae200096974c475
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ebe7afed716391a9831de8adc910fff65001ef2
Message-Id: <173266446660.577215.6136881598523084447.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 23:41:06 +0000
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: torvalds@linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 10:18:01 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ebe7afed716391a9831de8adc910fff65001ef2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

