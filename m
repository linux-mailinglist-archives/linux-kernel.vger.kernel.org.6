Return-Path: <linux-kernel+bounces-281389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1990894D655
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C291F2278E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF4015CD75;
	Fri,  9 Aug 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jViD42eV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6838381D9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228524; cv=none; b=bqpjzNEDkmpJxEan91ciMeI6W7KEWmdElfWXfEcGiLTxpYNNkjzQTpfIsG/QblCBqs+QXa8MzUH2ADd1mqyLThAc2vayM7OoBrA3NZousjGgn/Z86BNI7X2ZdWjHI/cYuEMBL3k1B1pESWcx/GuSMZ4k9S4W8/OAH4Kr20TuDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228524; c=relaxed/simple;
	bh=nQC+mnP6jnWjGrhKIbzzxPbRGGwgiBvOC9neQp8pBj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k50IoBU1mjYYEeorwuP0lBCZfBS1H+5TZy41UAG2k8ZXvhNglwGv/2Pbey6dw384r1LX1ymuuaVIpVKFLoE97fjltUOc5VzkxtWcLN/jPywNlUzeAyxtLRXf2WdVRpBJdo4zUbSV3gFP+mEVbvjmTgt6atE/4FqeQCm8lpqJ7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jViD42eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8842DC32782;
	Fri,  9 Aug 2024 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723228524;
	bh=nQC+mnP6jnWjGrhKIbzzxPbRGGwgiBvOC9neQp8pBj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jViD42eV4+4QUS980Yhqt39a52PoDFtZlIgRZRQ+HjJECy4FJvXXPu8sXCXXo+hyu
	 vNOZjWJ8S5QvuJKa/7b/90sQ95O2BBsiYSvW9n7Q41NJQOa56HJ8+aN2nksMzO2qQG
	 lDpx9pzEJuH+leVyoMnH1MEM/gUAbidnTxNJpt8hRimTQMGLS4HFq38Arag+6i9CSV
	 PJiz9pR2giOegrjmvTurVnKE8GgDuOQkgiTuCP3YwA+cBXSKzB9qRAXuVNKtrzU+6R
	 68zqbetQoH1j8UZYAdpYXWNqVX8x22L1v8aFDlzv5+wOxvVSUKbCPYl+s0HiBdmQ8k
	 xdJ9PBYaPAJcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8A382333D;
	Fri,  9 Aug 2024 18:35:24 +0000 (UTC)
Subject: Re: [GIT PULL] cpumask fix for 6.11-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZrZbs3oPNhzqR3E2@yury-ThinkPad>
References: <ZrZbs3oPNhzqR3E2@yury-ThinkPad>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZrZbs3oPNhzqR3E2@yury-ThinkPad>
X-PR-Tracked-Remote: https://github.com/norov/linux.git tags/bitmap-6.11-rc
X-PR-Tracked-Commit-Id: 5819e464a17587e6830cfab05f3e91a9a8753a41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afdab700f65e14070d8ab92175544b1c62b8bf03
Message-Id: <172322852331.3872157.10451440772262155305.pr-tracker-bot@kernel.org>
Date: Fri, 09 Aug 2024 18:35:23 +0000
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk, Jonathan.Cameron@huawei.com, salil.mehta@huawei.com, shan.gavin@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Aug 2024 11:11:13 -0700:

> https://github.com/norov/linux.git tags/bitmap-6.11-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afdab700f65e14070d8ab92175544b1c62b8bf03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

