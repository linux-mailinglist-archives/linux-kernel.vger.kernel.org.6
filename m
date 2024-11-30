Return-Path: <linux-kernel+bounces-426402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF019DF298
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AF6162FF3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D81A0AE1;
	Sat, 30 Nov 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx10rEwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631428468
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991909; cv=none; b=Ffp6nPHMqsYXaUzr2zjEFIVnNEhZoBCV8zglfrnYAnuTJH7qvT6rbWxSh4UO2Ka8K3+3Lf3hcrWy9LM8mI0/BKFsEfXGuXW2ZzgIgUwR+r8SL2YkK014FcKdgThzjuvc3d4vclzSwbJUFCTPWduDre22nRzlVMWypvPQR7mF5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991909; c=relaxed/simple;
	bh=W/QJuPQIZUogHzPC03u+zV7UBqdHKiYcFHeWPcuY+h4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pNK/RI1Huo570/YgW8ZHxCqZMsev4ZvQ7LvnRMTO1UlbBaoV1NNcGdawj6IGjW8gAS7H2bIIMlNhYIkMoKvgfv7wxc7PUtGXkVdA6V9KMuSVqePJiPpQzhVu2nLjeGk2MQRuM2OhMLUhu6fwbPRay48uipdubP2c7VyGCgP/N0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx10rEwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E22C4CECC;
	Sat, 30 Nov 2024 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991909;
	bh=W/QJuPQIZUogHzPC03u+zV7UBqdHKiYcFHeWPcuY+h4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gx10rEwMnsCW5SNUWSLF3SfOrwaQOu1i1tVcSTq9sxZSv75Tv7KVc5SjmP+OOOqHQ
	 iYXDvc7zQgohVpxKd/dXWMZxkA1rGz9xre2QJlbv+2vMXqZeI+ImD51iLpDbEWciLQ
	 rzX/8DLkegLkfqOX59GDvXrxfeXJBz623qdmWAJfQaDv8eENtedfwqDOaLcN2NwSho
	 ddxnnbPsLkzZS5+DkXQjW8G0DU0OLCOU2K3q3IVFPEGDPEgSmMfQmnrK60haU30ZDi
	 HUzSJfkiDQbYDLYKTi1ZlO/ZpySCZB8620JxdbqPm9MtYYp72NCNrGRfqvDw4LyTTO
	 j3M8BFS8toWHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34478380A944;
	Sat, 30 Nov 2024 18:38:44 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at>
References: <1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.13-rc1
X-PR-Tracked-Commit-Id: bed2cc482600296fe04edbc38005ba2851449c10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 831c1926ee728c3e747255f7c0f434762e8e863d
Message-Id: <173299192287.2451487.16897611469630516621.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:38:42 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Nov 2024 00:06:21 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/831c1926ee728c3e747255f7c0f434762e8e863d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

