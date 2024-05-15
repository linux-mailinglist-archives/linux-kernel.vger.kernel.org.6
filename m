Return-Path: <linux-kernel+bounces-179286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8338C5E73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7A6B21B10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652251D52C;
	Wed, 15 May 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoRqET76"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5110962;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734395; cv=none; b=tQDdlvYo0QnLrabnocX/FT2StUjCLfVNzpBm+zgyOrpg3onaAD62bJDEG92/ugOD9nvJWeR6NWiZU6GbH6bvjlwuAnvoBptdpPda8ocynGkl2Y6wVS6iTeTUuNAvnTBuiiBqPK9NZ2vObiWAGtPAonyj72m3VSGgALbZGivyYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734395; c=relaxed/simple;
	bh=h0KspI1xxN++nL3EeDozI/JSChSgsWMIHyxHaBvgy7w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gqShKiIRGkVNBzY02VCvi1/eOjxa+P9LAQG3dKBfxV9G+f2r00MBDd8xSFWeti/+G6ljZFt6k2RX7KPU3FB74yTWMOzqsmJZ8rfTU6QnyTKuvdEQq90ctOvhVbGsV8JcTLuyM/ZDr9NDW44ZTivGe2qpejJj2TO4lididvG1+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoRqET76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80EC0C32781;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715734395;
	bh=h0KspI1xxN++nL3EeDozI/JSChSgsWMIHyxHaBvgy7w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RoRqET76beajXgiskdF9GqIIV80SNVE4TSScYLrV3WAmKBJ2KtkDMrV9+E2gHoUIC
	 c5JbCNebOvfUgeOPeJ75nma79zbXxNby1UWAoo50xHLiXWGplgfOzy6r8zIr/UyYdV
	 IUbH7r57zKKzWabQqKyyouP9XcvYWfx11AQ6JaJQ8srlWMVgVg+8UYTdTaKjp7wbCt
	 Q5mCyjDpcLbIkaSPcGytKcUMgYcZltDPYTlUn4vTQDqwLTQp4ZmcSaSaTzul1iMwRw
	 uSFeV4sWHhiMOHVhvX2OCmnRQ/p+DTfQgWc/rpj9nnIjwi5hB2Y02zL931QPeUvW3u
	 zv0VPWQVdCoTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77B13C1614E;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513210338.267167-1-agruenba@redhat.com>
References: <20240513210338.267167-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513210338.267167-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-v6.10
X-PR-Tracked-Commit-Id: c1c53c26e3380a79b65e6b53dac6c3c797a7e8f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9518ae6ec57ada7d6c373588036163bf7aaf1c50
Message-Id: <171573439548.24206.11649920995050188739.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 00:53:15 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 23:03:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9518ae6ec57ada7d6c373588036163bf7aaf1c50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

