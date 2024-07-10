Return-Path: <linux-kernel+bounces-247898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C753B92D612
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736CB2878BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B73A195F1A;
	Wed, 10 Jul 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHDxAuxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19819580C;
	Wed, 10 Jul 2024 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628054; cv=none; b=NhFGfo5UISMBoMQedLtHVduMPGZZ5uh5OqySv97iMe7X50yJTnLOsjIZfB6ei4YZrRFn8ucsUlhMu3LMawlcCXFcsonn0rRrOqhhJJMkiOIHYKulrON61bP8LXfJoDdHDeqZ8U9PdPtC4ze9IrIYHmmWG6XIuBqyVBJXth3UFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628054; c=relaxed/simple;
	bh=4fmGngg0GKfeUi4ExPfNLoC2zBK00yaL2AMpUlQFxVg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B/neihPOTPQkkGyJXZSsOFK1gl0ClvHYMf35KUiBFEWGu9JO1vLHECmTqHHhLybl69qoBsIvOczCuTHr7GEalNPejMyS6ukLYO5cpqSBD4dRmW9TSCMhdTOSbifzQa/IUyJRd7JWcNQOk4RlcqXxexGrzMqmjEesIHId//xMzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHDxAuxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56FF7C4AF17;
	Wed, 10 Jul 2024 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628054;
	bh=4fmGngg0GKfeUi4ExPfNLoC2zBK00yaL2AMpUlQFxVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RHDxAuxIlcFYvhizctsEJM9sQTXli50hUgRNeed8dWa6mI5/Ll+TT/CU/wSeBYCZh
	 4luP5JNJIIMr8VTEwYwh2NXwyloddggIyjU8MIEfANFLtvoWz2/T6IwSstvqS3ctHX
	 TAH+Z0SBwzoLhaderL0q2vfz4BA0ePXi28HrM3R1fCl1dUwjNLBtMWt2v7Mmz9VsB9
	 Zh8V+fC/dZ2/Ysr7PXSqm05d5POeUpaeCRptGAdZrREvZnXY7zo/lbzuU8nXFD5vPX
	 O+d1SLnTAZkk5zRJHq/bgVR5A8QVa/zLU7O/XV4kL5TVTREVO/Ka52t3DV6qBkWd0S
	 UfdW2VaLChGew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CE49C433E9;
	Wed, 10 Jul 2024 16:14:14 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.10, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240709223653.GA1276694-robh@kernel.org>
References: <20240709223653.GA1276694-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240709223653.GA1276694-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.10-2
X-PR-Tracked-Commit-Id: 2cf6b7d15a28640117bf9f75dc050892cf78a6e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 367cbaad8887c59e5d017d90d50d16cdd3d76ee2
Message-Id: <172062805431.17113.2114139134723852915.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jul 2024 16:14:14 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jul 2024 16:36:53 -0600:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/367cbaad8887c59e5d017d90d50d16cdd3d76ee2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

