Return-Path: <linux-kernel+bounces-259392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD2939537
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC2E282461
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66A45020;
	Mon, 22 Jul 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSpYZrT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18683F9FC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682548; cv=none; b=ITICdB88v1b4NDpDBp4ka8nGrzhRrJtapsPlo9nE2m/jLukLeSfqVgxJf23joaQadFEAnSCWi3w3kllpKzijkCxRh/E6Q/xdLoOSdHIE6ZZojYtzyS5x4ImPFV+485PqlnRieBx90CoqAaaKN1bfFO35snBlSvNANr+VIaFe1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682548; c=relaxed/simple;
	bh=7vWWcGnPUBaHrYGweJgJUGi44GlxfYc0Nkz/qtBaJXs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GJ8sfVD+WIzjSokZYpjjvsNVnF6g/tpgFJ0mnLWkKqMxar2pzyEiofVHk1iSgJfZ2iphkGGqIkOZCuah7xbBrQ2h1KRJAOJdUJa5mn7dFnLnxmSB8TtsKkfEMgvB77s+RHJxYV5NpB2DzEzLTJ17fKMGa4bAig5hDMx+VbJhswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSpYZrT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB56FC4AF0B;
	Mon, 22 Jul 2024 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721682548;
	bh=7vWWcGnPUBaHrYGweJgJUGi44GlxfYc0Nkz/qtBaJXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LSpYZrT3N30ne+VORDeTSPkpPA2vNKQoD+58BvQ1GjMOhMwGJfodzpu8Qd+7OLq+P
	 1/Mbm4lFNeFC/O+J9KxDjAWCIq7YemzQuicb9iunjjDIaqlnX+hsYsFbtY/PGc+1RF
	 t/uxS8BNTDyVnDseTcvzKKedBVfKQK81gVyVQtiCVQRiZcCxXOFIil3EpSgKITZqtD
	 Cw+EtV1ffoP8R+vjuponlWcu2eLicK1yIqtNKeSKecec4ZyQno3xhA7U3WMScC/u6x
	 xwHp9J/9zUCiiDn+6/mqMBJDSSJbXRTnyyQqTnZcxKnomgUwMiihneQ2BlnNqc8Q7W
	 3TK6oq9E5QMAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DE39C43443;
	Mon, 22 Jul 2024 21:09:08 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172167641737.62829.15719424739961406637.tglx@xen13>
References: <172167641737.62829.15719424739961406637.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172167641737.62829.15719424739961406637.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-07-15
X-PR-Tracked-Commit-Id: b7b377332b96a38bc98928d7ec2674c77a95fcb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac7473a179d65f6c5de06a4b10d3b3d36df3f172
Message-Id: <172168254864.16066.8172926410057526699.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 21:09:08 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 21:27:18 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-07-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac7473a179d65f6c5de06a4b10d3b3d36df3f172

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

