Return-Path: <linux-kernel+bounces-333138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67D97C46F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0C1C239FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708CD18E758;
	Thu, 19 Sep 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q81Roesj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175E18E375
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728494; cv=none; b=i1WB/LuNHLFqXzK4aG58jVCsVq1jyrJblRjCrwY8Xen9OclVTCllMzuuabQw6R/QyLwmqlaLyyh+2woP5Md6yuo+QctP1GR2bx53nGOdLEKQIappe4svSo5wrtetO1ritUx4mojR/cslA+9hOOXHG7rOi/skBp/Q3FAXBUgc00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728494; c=relaxed/simple;
	bh=ptlNwoMjKB9av3H5kpJ+WQGwxruc9JPLbe+DNrJLVE8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YW8rlyqAp1hK/hprz+QnG2uM3h3s3BfR6zCQuyM+PhUH5Gu/RrWKlAwoQ4ku/e90kz5NIAh42GUp5/F5s/lYwEXR1ME/+KdVJLyOz7K194AyJdL2WxEdzCTmEZc4DoOhs88sqHVBnHwcB18MdeuGEnxbgPeGl17uYVsOZMZ5/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q81Roesj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BBCC4CEC6;
	Thu, 19 Sep 2024 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726728494;
	bh=ptlNwoMjKB9av3H5kpJ+WQGwxruc9JPLbe+DNrJLVE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q81RoesjmcgXs13T7PojFQx/xWI4m2qQ/yhsgAmMGdmpzmk09z0Cwp+3OQO7mQfl4
	 nUbH5y0BGtPTRJe6gS1ynxU7wMi47hLP1/nml8F5g0iUS7e3h/GRjke7DYRPLqEDEN
	 xQ2ZMChb5A2ljV61fuVOc0LklEwORkqblhgyHbqzcpnRFaodnEbxX3Klr8h9Y/uxcO
	 AOOF/OqzhXLcOjU26S7ifaWnVUYcpD4jKiipJ54uEmq8weeuUyHbTMCPF9WARtDNUJ
	 Q9u1usn0lr9Ln7ya70ibPcOm4Ebfnh6vlnCdoIiNhydmBP5LCASu292WKqi9omBJNQ
	 kBr8A23J4YXpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF2A3809A80;
	Thu, 19 Sep 2024 06:48:17 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <8734lxqc1x.fsf@mail.lhotse>
References: <8734lxqc1x.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8734lxqc1x.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-1
X-PR-Tracked-Commit-Id: 39190ac7cff1fd15135fa8e658030d9646fdb5f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a7101e9b27fe97240c2fd430c71e61262447dd1
Message-Id: <172672849627.1360580.1044648835370166976.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 06:48:16 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, adubey@linux.ibm.com, alexs@kernel.org, arnd@arndb.de, bgray@linux.ibm.com, christophe.leroy@csgroup.eu, cuigaosheng1@huawei.com, gautam@linux.ibm.com, haren@linux.ibm.com, huangxiaojia2@huawei.com, jk@ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, naveen@kernel.org, nnmlinux@linux.ibm.com, robh@kernel.org, ruanjinjie@huawei.com, tzimmermann@suse.de, u.kleine-koenig@baylibre.com, zhangzekun11@huawei.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 00:19:38 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a7101e9b27fe97240c2fd430c71e61262447dd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

