Return-Path: <linux-kernel+bounces-425011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40C9DBC71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493DA164767
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F51C3027;
	Thu, 28 Nov 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ncrd4drp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA21C2450
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821584; cv=none; b=g9psD5L2BxKhWOlTbe+M4ZXlHXkOO63RWaFZUYbeGJ0tivuy+kIvq73qkVV512jANcsWUFK+eEqZ3h+glFfPVGt+WmVQlx/fxYmW/ef5Rt1J4eGnl4K5ClPQc1k6mHCmbyGC8Oc2JeQsvj0n8Ha/mOEAsrF3r4t4xRLdXVMQRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821584; c=relaxed/simple;
	bh=lJQob3pAH49YjM4zDtqa74m1v+kASfcV9l5iaLEpTUQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=epNDmSzxo/iHmhHZm69RnEQLy3mkEP3D/aKAfXYjrHjyrriVpIHK3uVZ3o+L8yWlN4IuMqZSrmSjSv3FmCyEqGwXReOI33H23fVc76vPekzWkVcXX7fUHNDpE43iP9HRlM9shX2WzHcIoqr2MEiAMxngnVZlXO3LXSKAs7nwwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ncrd4drp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77FBC4CED3;
	Thu, 28 Nov 2024 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732821583;
	bh=lJQob3pAH49YjM4zDtqa74m1v+kASfcV9l5iaLEpTUQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ncrd4drpoNJ9jMS+k5GNoyIaQgYS9ib6xSGhjQfKVK8YZG2oyldMrrYLdNomtxMDg
	 K+nmc8fvp8Dte7b7+bhmw6PYLPDoMxfwV7dGgOLQ1kMnuS3/W219gnK0VN/Ujw6Nfl
	 G4Idp8M9uRLEcjkxvCFlPCuq6iSe+yYPXLNnztcTDQNWc1/ils+pEbQhcnjmihMCbo
	 gDRr/k/7NJNcwaqXsioTCTscru6oI4wuBqq45vzuzwCiM+xLGzQpSMVYdiDbOKa7ct
	 B6dcgG65Bp75GtoHmRByZYXhDbRiM+EIrE3ELqXovV3s3xh6w/+cwxv6BNr2fVbnqj
	 u3M3Wk9n5Wfjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A66380A944;
	Thu, 28 Nov 2024 19:19:58 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.13-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <4bfbd5a99af176813f7d8e165cb05dd7.broonie@kernel.org>
References: <4bfbd5a99af176813f7d8e165cb05dd7.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4bfbd5a99af176813f7d8e165cb05dd7.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.13-merge-window
X-PR-Tracked-Commit-Id: 351f2bfe6362c663f45f5c6111f14365cfd094ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d83ec4afd209a0619b32b867f45c845d4dddc2eb
Message-Id: <173282159676.1826869.17634116426828650037.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:19:56 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 13:54:36 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.13-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d83ec4afd209a0619b32b867f45c845d4dddc2eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

