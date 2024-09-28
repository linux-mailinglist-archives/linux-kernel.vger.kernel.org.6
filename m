Return-Path: <linux-kernel+bounces-342576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A298908A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FFF1F223B5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76F6F099;
	Sat, 28 Sep 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIxXI601"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84960B8A;
	Sat, 28 Sep 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541906; cv=none; b=krXni5N1FBzXFqxe8IcM/l2QU9xBSUFXlqf+tFSBFYXVViD4+0uGbP1rVHe8mAPNTHeGc8QfX0IQSfrEUvUaSvJ9jF5/9r4xvtvBdp6z0a0RJW/waFLdQ/Tuf5k1UlKKFbisbld0h28OdQitIluOgej17K+GwMasDcfttbedIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541906; c=relaxed/simple;
	bh=W+QCWxaV3/8+3vmy4b0wINy5wFK776ZoGeWIdhLw6SI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wdqjiv8+h/pxzVDux1DTHZrJkcdqMDcwLL68fEb3U3d54uQoOgWuXLq1+zkjD45oR65ASiFtEq3cZWwAn9P25gEXMf5uqWQYoyvDyqyXyXArN62XX4GnTo41efvo/Ffgo9Lnnt/NqQ4CoI38NykUuaHDzow5uR0lli8OhiIYUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIxXI601; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E68C4CEC3;
	Sat, 28 Sep 2024 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727541906;
	bh=W+QCWxaV3/8+3vmy4b0wINy5wFK776ZoGeWIdhLw6SI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cIxXI601wPwSRkEIgNXmv8L7GtOOlcUFl4a5vy72QEelpprjAjSOAe55/5NLNQUmt
	 yUeLaZoWSZGLjz3jR5nL8mYLv/AAE5y03IEm1UNtBgCbWSkkPUnQ6WpPWGlrclyANp
	 0m/PDwnzSKraPgVpeVaKbdFZcWLsQXToh7rKLe4Blhe9fMErykSZnkvmbHvrEptfEL
	 wk0lr3tyzfsPT8hS9fjfq1DL1BzvY5Y0QQi1fr8xYbJU+K/k2mJkudPYns95aio6jR
	 mNTq+MzHqtzIc87IUsUm1ugK7OU0WAGmQXES6j+47titVzxRn5Ou8i5m+huqCt45AE
	 vXFojaRX0LBFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8073809A80;
	Sat, 28 Sep 2024 16:45:09 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv17isy4Or5+Gffn82y=HWWdgdsUOayJbbJ7dd4r3Teqw@mail.gmail.com>
References: <CAH2r5mv17isy4Or5+Gffn82y=HWWdgdsUOayJbbJ7dd4r3Teqw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv17isy4Or5+Gffn82y=HWWdgdsUOayJbbJ7dd4r3Teqw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.12rc-more-smb3-client-fixes
X-PR-Tracked-Commit-Id: 220d83b52c7d16ec3c168b82f4e6ce59c645f7ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f04ff5a02b66f99fce7c3293025169e440da8096
Message-Id: <172754190862.2302262.15880490427280934322.pr-tracker-bot@kernel.org>
Date: Sat, 28 Sep 2024 16:45:08 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 15:39:59 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.12rc-more-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f04ff5a02b66f99fce7c3293025169e440da8096

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

