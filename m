Return-Path: <linux-kernel+bounces-253318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB43931F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C40282EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527844C89;
	Tue, 16 Jul 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acGVFcfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCA1CD39
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101300; cv=none; b=SAdmbi1AbgyMygukGD2RSnt9RL9F2N7FTVy2IJ3jPrdsalGn9fi7JAE23WrTZ8Pb7z7OFvi1iHQ1naJp3namR2x2Bn+i+xFyNoEyvnPqGQ00lg0pBGICBrMPrGBRbWCFVjrPEb62FNoXsIHw5Mv8M+tNuksB77zr72ufsC6YbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101300; c=relaxed/simple;
	bh=M9WiLUeGe70i9e92U0OEq5kXZlwO1wBMpNtpv5ReubI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=onpDUahfXJnuMC95D5EtlsEo1fFVVrb2JynkWTswGnW0Gi6maQ4ulOu0chB3tKMyeZXCcCPxd4/caJ1oXFQTzX4CChIa3aauJBch0Ffy55GvjBLQyIq4QMIkJE8xPFHoNy4sC1SXQ0DjDkExL9XUpuog1Orzhu6852xx8udcNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acGVFcfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85DDAC4AF51;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101300;
	bh=M9WiLUeGe70i9e92U0OEq5kXZlwO1wBMpNtpv5ReubI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=acGVFcfmzlUNLIr27aJdOM0y2mhs3VGJHtEiXgHt5YV99n3PV6zokpqo124x2QZUD
	 QBGUcuXPg+y/rhC8ETOufCrUAo8H6l4DDLQHiofN9/m28gdpF6JHmRxGCWX9X/ps8K
	 fTKEQhfoBo91unXPdQDROePyH+pHe7vyYGuvydU7PCyLTOnvh4pQmnbZvR4dwT3v66
	 dv8dBVIHScThNPv3Jysfl52D9gtHW84Q0zuzuI18EuNqZmrbtiAjNPeWfJaVuLOMQ2
	 rFgvKvCTYUkga0Wj5yOdA57gvg0LFqA+zeeWfN3kjeJ3e2TFPa+9bVW4H5LSw9Viyk
	 i39IkV1WUXT5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CCBEC4332D;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715182042.GAZpVoenFmK87PlcjT@fat_crate.local>
References: <20240715182042.GAZpVoenFmK87PlcjT@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715182042.GAZpVoenFmK87PlcjT@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 34b3fc558b537bdf99644dcde539e151716f6331
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d67978318827d06f1c0fa4c31343a279e9df6fde
Message-Id: <172110130050.18508.6351968177145099891.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:40 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 20:20:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d67978318827d06f1c0fa4c31343a279e9df6fde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

