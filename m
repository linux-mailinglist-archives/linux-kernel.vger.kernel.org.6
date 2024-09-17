Return-Path: <linux-kernel+bounces-331437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B85F97ACE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9571C23BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1515C125;
	Tue, 17 Sep 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU2Y7igd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F715B99D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562236; cv=none; b=bn1ySYLv2zlfWKvYE/z6c0jNUUgiF4b6Twz9Dit1pK0uTwVvj3QqqiyfZFjGr87UKLqlYHWPmCQuSoCxgaMqkS0zZigzi6Pz/u1mGwSK/WeFm7SrW2zZPPQLeZx7y4uWO4z7G/tKD8qQy0rQDj2LwnfxFDXuVXcW8Zdj/xHLq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562236; c=relaxed/simple;
	bh=YMgri9DEJu1xAINJY+RS0FhBdBLkhWqQ8CdHcVSRmH0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pw+ArgV7Tzkl9HKV3O41o6Eo5u5/2SoueGfx6eMmNgwwF41PgARM5Ep2Z24e2Apz1sJX75OSJPUWrTxph76ctGOv1jPvphuL9fs//RLs0lbv2oYYHeJ44Mo7V+0tZN38cZ5YbYyjPvrBVCzy4+CbiNqX/AF3QyUfrCBLTYtP2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU2Y7igd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A313C4CEC7;
	Tue, 17 Sep 2024 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726562236;
	bh=YMgri9DEJu1xAINJY+RS0FhBdBLkhWqQ8CdHcVSRmH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mU2Y7igdsH53XxBT7883IlNi2vgXddhqk9RXv+J6Q9Mm25fQiP3l7f6w8nnuxGfwf
	 fFVMa9NIbYb5lhkj6oTbOjomeOLdIWA8INq+L+qBwN2MrfgI7YxgdsMsN+ZyVxbAcD
	 L4pZKLNeaP8+O14sxo78r156gGokh0hEqpmtMZwAPh4NpVNgx/PMBPHOflBXrlX9oZ
	 UTosgIA019i0IG53foRXSjif0O8W/MnY5T8/sE4O1+YG+XjGXfTAw+Cv/5gW7foYcu
	 HwbE7NmgOhMcTv0vuyyUGT6KwFYGvl/wmpRi2QrxuiOorsT1MaDkUZkRTcy4v6TTxt
	 a1Kg85mReg0og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5AD7A3809A80;
	Tue, 17 Sep 2024 08:37:19 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <43d1b7d25ce662bedb2438b6d0614a77.broonie@kernel.org>
References: <43d1b7d25ce662bedb2438b6d0614a77.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <43d1b7d25ce662bedb2438b6d0614a77.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.12
X-PR-Tracked-Commit-Id: c7edb7ac8472a57e0c56a3a95796db3af98b2383
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9179b73aa72add1bd54d8fa15d7f47a1fa602248
Message-Id: <172656223807.49587.2065251056458575308.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 08:37:18 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 00:26:11 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9179b73aa72add1bd54d8fa15d7f47a1fa602248

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

