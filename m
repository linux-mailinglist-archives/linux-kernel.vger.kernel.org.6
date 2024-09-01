Return-Path: <linux-kernel+bounces-310413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82076967C78
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F708281AF7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45C185B58;
	Sun,  1 Sep 2024 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2fax3gj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB8185B42
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228296; cv=none; b=ZykUAjo3IDHEbMiRc/42fxZMrxXkZPMhkZ3Ps1WXa9l3QxrxYg/xqtiTQDPmjJI562XynaS0Y9DpbQAxdq40XwgD4a74O0tKhlToLqXdjjWPXKL1Ne6JuT6eKDW51SZogTpq9alKQW5EqgadSQiWaA4ax5hTsoie4Zm1ZHn7TMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228296; c=relaxed/simple;
	bh=5UNww7I5dhsa13rrqBcREqjVdKvr0mdchPIVMykj/yo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NLo3L1GAx+squbXUJGYX9UeLrgQW0divrEXgMR0+Y2I4g7cdpxJFIUdsedoS8y+geCCv8uc7tkvg3RxCoMoJ4on9K9iF1ZM2InJeR/J5pTxS3zhCDnC0lVvgO4joyBDAz+wbT+IGjSzcnL6D+yUe3Eco0KSbp6RLY6H5HII/nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2fax3gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CDEC4CEC3;
	Sun,  1 Sep 2024 22:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725228296;
	bh=5UNww7I5dhsa13rrqBcREqjVdKvr0mdchPIVMykj/yo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D2fax3gjBZwsDC6mJX64lQXrVYedjUP6L/bl5TiMGWwTAq+yoVjeXYfH5UjaC0IY4
	 3pEOdiy3PSjQkT4N/ego/DiKmO/scbpzmDf07jQUcyrFq11cXZoPAZXZ5x/UuKLfyy
	 5jTtxL9Ng5h63Lw3kQd2Db9UpAH4l9Tu9pv8M9RaTg7hFjmk9kv19yDw3Aoiw84f2o
	 BXhGX1kTrMHuecb2cMQr66sa0QaKbY1gT5fNBNV0nM9Bf9CTyiI0qU5+DGsCbFFOIi
	 EDXsO/JcoKbM/xHBidF/u7s/6tm6A96E46LJQRW3HxupeLfMa1zO/fraZ36D3Mxlsi
	 o/7o6V44qkTbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E873822C86;
	Sun,  1 Sep 2024 22:04:58 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <172519097566.1871736.15971434529600428822.tglx@xen13>
References: <172519097408.1871736.16401401125691449823.tglx@xen13> <172519097566.1871736.15971434529600428822.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172519097566.1871736.15971434529600428822.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-08-25
X-PR-Tracked-Commit-Id: d33d26036a0274b472299d7dcdaa5fb34329f91b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51859c5aa6daa96340a81a1ea2de1b48ccadccf1
Message-Id: <172522829704.3406256.3200745717698473592.pr-tracker-bot@kernel.org>
Date: Sun, 01 Sep 2024 22:04:57 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  1 Sep 2024 13:44:01 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-08-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51859c5aa6daa96340a81a1ea2de1b48ccadccf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

