Return-Path: <linux-kernel+bounces-262620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE893C9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A97B1C21FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DCE145345;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSNY/guI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02597143894
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939826; cv=none; b=pDt9HpWIM03wCHQFkFk7sYKn+TPBUxRe273iyFLqCGsyG/U/WOmvqQoM58buoQnhJb5HL9j3Edn/53l28XJGS+QeWzXQsSVdem7aN/wxaDREarqcQHoMQkVebmZPKjSyhxvYTD2GDyCADgnisHVm0kU/SPcDUHBAP568C/Vl7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939826; c=relaxed/simple;
	bh=ZQ3o2nWMceQhVH5/yoO1yXBMWRwaHH41Guj1mNtPLhQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BDrOTKVmmkp46/bIhFnBycHMdjXEcuoCWIRm09Pg1Zf0I6x16S6kfU2lhBgmeA/49NBVI+xna6QxSatsh7f1mwjPieSeQjdxJ3kZLpqSU5F3L8ccA1MWgzPWASocw6ZkIqhwbkDl9GzcgMUo0ild8Y7DpkKehuW6DetcHt0aMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSNY/guI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D779BC116B1;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939825;
	bh=ZQ3o2nWMceQhVH5/yoO1yXBMWRwaHH41Guj1mNtPLhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qSNY/guI2L2hBzmFuywhFbR3857gmGpV2cPb9IWwMjpJ5mrS5z+X157w1p7WvAX94
	 6Fx2xUAxlu03L6aEgiO8L9fkhHmWFB+a3U6LqRtRbcz0toWatgvP36f5CUZ8kWPFkn
	 VK307b2sZCr4F62ACxnKMNYjuPE24WDyKHe0J3YtfL0HQszwOZzQMSUuzMDwogEgQB
	 8AfxuLsyeJNHhqpXW9YAJsQa3cpvUfnOcm8ZCE1js/OcLQg1rPXLOt6cc6Kg2cFoej
	 pNypOR/WMSuFB77Z1O7MAy+64pDAhdU3Vhk3e8IJ21eiD/Cc2/+LeYSVRORJvoDng2
	 vp6seAUf+gNNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB26EC43445;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240725094733.GA2524052@aspen.lan>
References: <20240725094733.GA2524052@aspen.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240725094733.GA2524052@aspen.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.11-rc1
X-PR-Tracked-Commit-Id: 9bccbe7b20876a34c70b13430ea1b308fc8d5a7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b21993654871eda57dfeeee4739fea797a50b1e
Message-Id: <172193982582.17931.16120787739288663513.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:05 +0000
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Zheng Zengkai <zhengzengkai@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jul 2024 10:47:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b21993654871eda57dfeeee4739fea797a50b1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

