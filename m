Return-Path: <linux-kernel+bounces-545595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842FA4EF06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9673A5A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8226A0C8;
	Tue,  4 Mar 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIjvlQq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B92E337D;
	Tue,  4 Mar 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122348; cv=none; b=j7kmn7AXn/R3hVGZW7xYNrtTCCodC/v3oJdrcY/2CbnyE0734rNaNC/kQLsoHwYR3F4Ylv64Y7cuxJfm6HHNVR8I4F3bZ4ESo0qv8kCoW8iRT3Ozfb/gas45GC9aZiKuoXalPQ/3Gw2BVOc1jIU+wLBgxzjllKn1UxBAlNRZofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122348; c=relaxed/simple;
	bh=ZkNevJ/X2pCvACDP3KNUBM9uavxoPIn3VdNvcezbMK8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=elOC8+Fb3ggWHcsb8vh+7n+hpsSWrNhVad3a486ykNk6fzs/nuLopTPMDtgpqqonCZ0RRapkz4yQwZDF/tlUY63bNhf3EWX9u+/NxOxGQWDoSqoEbu49cXDMz4889UHYtEgmcNpMrV19sbIt00ddPFCF/50LQ3/GjASdu/HAgZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIjvlQq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA63C4CEE5;
	Tue,  4 Mar 2025 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741122347;
	bh=ZkNevJ/X2pCvACDP3KNUBM9uavxoPIn3VdNvcezbMK8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NIjvlQq3lH0GzQfiqovzexPplZb9AIpuRGmZ2z5N1C5eI2M0UTk2PrRvmC/LaA6hp
	 u5aZTa/BCe1irpUV4Cxa6pOYk9Y17B/+zzFnf74yN06+iwl6d++UJPjWIP95CznzBL
	 lYgWWNU2Tr/zXMC9AwgcjQMWjAGUoNyXpaYyLaZHbrvAr6iaiMjWVv2wFmUVp7Qr8H
	 29O/pRXKj661eMUCoKMl/AIgrx1r4cGudyMNHMAMUVIOvDO+F8p4+kQhkuz6EjUu0u
	 8+6DvcNL2UP/y4bfo0jiZtULFH1tlP3PxqJVQKokVDGpe+POSjIDXZrsygTzWcWl1d
	 EPVB4Pei6bVDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF390380CEF6;
	Tue,  4 Mar 2025 21:06:21 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fix for v6.14, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250304160040.GA2690690-robh@kernel.org>
References: <20250304160040.GA2690690-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250304160040.GA2690690-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.14-2
X-PR-Tracked-Commit-Id: 75f1f311d883dfaffb98be3c1da208d6ed5d4df9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48a5eed9ad584315c30ed35204510536235ce402
Message-Id: <174112238013.293286.10628075210224411896.pr-tracker-bot@kernel.org>
Date: Tue, 04 Mar 2025 21:06:20 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 4 Mar 2025 10:00:40 -0600:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48a5eed9ad584315c30ed35204510536235ce402

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

