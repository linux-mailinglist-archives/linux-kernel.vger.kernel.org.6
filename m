Return-Path: <linux-kernel+bounces-186588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59798CC603
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60101C21349
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742E1465AC;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDTnCkd5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F9145FF6
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401119; cv=none; b=TlaxCh0mn8Tdv8qEE00dN3nx5dwvEP00F1C4YmPDJeYXctAliPypRSk/6e6w7mx4YC+npwmtG/LNiwyMVSDF1bfUBazaroPa3BP1J1MjFKQ0eiDW+mnPnDF0cr6pleO/qZNsVDgxLIf9JRDJ08Q9xW5IkWiikEX8EtRDU4DphFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401119; c=relaxed/simple;
	bh=PPQw1gxL2GOznc7DFjtGyWShLS22Gau0OkpK0c+8qlE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YNVGhOnylvCmfg5eX2p1Nzf+iHkCjUWMY8YJDIMbzc1l9i2KAM+XNNdQL5O3oJKZoPZo1lsl6Kx+o3LhtPnRY9EZ+6fZnRYSsvDiSNUtvvO6tE0McAW/pmDaUCxBJweuGN/O7RHJZtV1BvaXutsVUzR7UdybQUKjt72jZGP+N6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDTnCkd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62026C2BBFC;
	Wed, 22 May 2024 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716401119;
	bh=PPQw1gxL2GOznc7DFjtGyWShLS22Gau0OkpK0c+8qlE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CDTnCkd5U89BaAVtW5mslkolkFWf/xyZB7ok9ziJ03LVBgtLIVbKRUmRfgLGA6B9a
	 ni1FEOC0cPhJ7BZNbUgUZUQSTmSRJM0/Vf/7MgvddkjySUhumbj9OEHGMFJS6qFV25
	 KsoHUKeD5RZMbqAGHZdbQPhaR2dr7ce+rrJx0H/++VL0drwMXAOhDk8Co7+tqTquO8
	 dUz0UuQY7ZtSxevM1HGt0AlYB5eDnDjKQpPhD8okS4JeqRs/8XuA7RQ0jO+a8rjy2/
	 8KPt8Ups1Uq2/jBjl6ZULBTyDu97yIExPa9qBDYsTB0FxHPeZW4QDBvBRP3ohO6ayI
	 g78PwsCxXPUzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A1D0C43619;
	Wed, 22 May 2024 18:05:19 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240522100253.GB6035@google.com>
References: <20240522100253.GB6035@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240522100253.GB6035@google.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-next-6.10
X-PR-Tracked-Commit-Id: 1482489b5196f4203576ae1dc2ba4ce3ada381c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a85629f435a4e724c414a6ae3e2f327272ab11af
Message-Id: <171640111936.25247.6782204308733763092.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 18:05:19 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 11:02:53 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-next-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a85629f435a4e724c414a6ae3e2f327272ab11af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

