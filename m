Return-Path: <linux-kernel+bounces-261487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7AD93B7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DE01F2538F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF7916CD3E;
	Wed, 24 Jul 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5usGqs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40584A18
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852328; cv=none; b=kSHsU6SqXHZU73Q8aplXMB2t1/RdaUsxD0D4RCxRLbvkildZuncC1ScAEOs1mSwX5YHEMfcRgUavIcIXq1jSGPgCazIoq66yU6k3QMlRsp1pUYh4rADDKrHa6p6P3z1eoMZBe83ntz6YKyd+4N5pJMpOpDnaMl0/fxBtEuade/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852328; c=relaxed/simple;
	bh=ZN1oXBIGtIbw5HyZUT3UMX3w6y+7WNJjVZ9FDli4XtM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dmpYZogByJNhZGzeJqRQTu8KOI38tcHPCREUN4p5S2TPjscu2/bznmOsKmVYiXxMpLshHr9dAiZwdRiF7+9yJQ56dcU4pU/H6XzRRANJKxB7s1a3yCkwuzWzunOMJq/5w8aw+Ybx0AgiDfnNB1OttsaDcv7iGRDzVV+BeoUHSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5usGqs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 982D5C32781;
	Wed, 24 Jul 2024 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852328;
	bh=ZN1oXBIGtIbw5HyZUT3UMX3w6y+7WNJjVZ9FDli4XtM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s5usGqs1bgrS3rhJ5UgSPHTzSmPkdrn1VdW/Um3rp0wqKKYxqAqcUTWvvM/7CnhCl
	 1+LT7949LmuWq5N2tfmaDlnLMhUxob1LRIwUfLj1cjtUBYtZt86EeqQtL/YSBPLgM/
	 KwWcAYr5ZL2faV+8LX2ji8gmsCQjsgoYh1OQhDOO8xbYk+GRgl/WtMBUEoX7lD1IB+
	 PVRpeSfA2rCBhOAtUtjiHWmiG49vMWGiJrtZEMX5jbE5TKcvDkSejnHdxJUr9+KYlX
	 jFGWemhP8AyU+RaKQ2v7tMV0ICQnpReWXxMLXJfvSA2+004od9IIRsjp1keRwCPpKi
	 hhIF7TEI1XVAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87FFAC43443;
	Wed, 24 Jul 2024 20:18:48 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqCxLa9FL9iXFOFz@matsya>
References: <ZqCxLa9FL9iXFOFz@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqCxLa9FL9iXFOFz@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.11-rc1
X-PR-Tracked-Commit-Id: b8ec9dba02a74797421c52b1226b23a4302362a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a46b17d4c00c2547b5bd82eec9489b19128fd65
Message-Id: <172185232854.2896.6063806493106446205.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2024 20:18:48 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 13:15:49 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a46b17d4c00c2547b5bd82eec9489b19128fd65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

