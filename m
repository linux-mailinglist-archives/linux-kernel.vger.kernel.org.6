Return-Path: <linux-kernel+bounces-254329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E3A9331D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CE7B210E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA001A2C1C;
	Tue, 16 Jul 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsUdog+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAA1A2C00
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157945; cv=none; b=MnYzpyh5xrXzXn8eB0XwdW68o606aqR+/KlDZ6NNXgQRIW0/eCGowvGRYWR1GUa52GnlL4pzX139qPTeApHvhFY4swK83MSIvkIpDET5zpsoNCPDhkBPIeuotdaLDL+NJ5EgUC/T4LuwVE/A2cFUzN+zw0BmBh1ipKKgQdI1u1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157945; c=relaxed/simple;
	bh=4xjswKjKrPe/tRWllYqFYjWaAmqJzIQeB8IXiZqGgw0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nebHG77Oeb0xiJ9t+KE1THnB//DGlkvoOfk02I3CZG5b/ONJd9bSIdoqUp6Xuck8oaiV+OzNlo4m93ea1XlXxjLCG1C2LK3ywYhU6TFIACPyhV81eiqKkH9kpeSMVn/k6pfRyNl3TTri5zddPB8oeBeLfESaJU+uER86OZs6lDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsUdog+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB6D9C4AF13;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721157945;
	bh=4xjswKjKrPe/tRWllYqFYjWaAmqJzIQeB8IXiZqGgw0=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=XsUdog+Dif69MSO1AEb3kKUAR6tSMBxCfMzL+v/Q0awm4keqpacHszkVgNa3tTUOA
	 3zKAci0r52rpjBMq1HwWEI45+Gm0lofHM5RLDr3IdXoAJeFOiwfN1RvWofNCzUQ67a
	 eTh/4ipUE8cwwDdXAwnuIPZPOCc3plY5WkAbpJkB9hmH9WGDEo0LG5Q4n9SdcOI1wJ
	 ioj0LgvmS2NmBPNqGOLXsqlhTnjay/5mhxzy0Ftojy1B43l0tkpZmsAbxhF6Ogokxr
	 0TIbNgTtDEiZw7GZ3JwoTPdbE9/OOS5asYcjD6GQcM/18wVZbt4oGqLoL8pUKc1Oj5
	 TBQMfMzzWTsoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A03AFC43445;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Subject: Re: [GIT PULL 4/4] soc: arm platform updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <6e920ecb-384d-4fca-988d-fd3380c2daed@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com> <6e920ecb-384d-4fca-988d-fd3380c2daed@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <6e920ecb-384d-4fca-988d-fd3380c2daed@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.11
X-PR-Tracked-Commit-Id: dead06c5e110c25931bafc8cf017e3077b871ac5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5db8e4544a4dc7143f30a1438686a4d5fa6d775
Message-Id: <172115794565.10577.13848078673989818961.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 19:25:45 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 23:12:14 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5db8e4544a4dc7143f30a1438686a4d5fa6d775

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

