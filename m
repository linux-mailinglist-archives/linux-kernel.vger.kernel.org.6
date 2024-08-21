Return-Path: <linux-kernel+bounces-296229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19495A7F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E23D1C220A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA017C217;
	Wed, 21 Aug 2024 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8Uqaaxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10988168497;
	Wed, 21 Aug 2024 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280935; cv=none; b=STMarCxyThwFPLTsuuszsZPVLG2jnogmZLJzaJtmCnSWS3e1FtMJQ2SK9RplJuih5+/4pqLbvxEXs2CERCKqQMuuToKEwdSdW+PJVOctEvghaY5qmQqwHWXO/jbpXPdHd9Ql6XWGq5lNRCNV1qqkaKa9hOkKRlu9yOiPUadU0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280935; c=relaxed/simple;
	bh=LKwHMoya5PYCQqJayw3KN66I/Ippo+dKDfIgzCA3tFE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lXJL+nCKj9lvx2t+1F8Z7ROal4hT23vs2+4LLEOud9uUJUFU9TjKAXNwWqEZerd6ILEwkKfWPfY6xbgpAAvX1PDOox4+rnXfAxg2IKUepCySnCquIeAwtUd61yQ2lY+2IEpXsX87Z3pC9jlSyGUBatjOe7PJaEU173e3kX2rRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8Uqaaxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0ABC32781;
	Wed, 21 Aug 2024 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724280934;
	bh=LKwHMoya5PYCQqJayw3KN66I/Ippo+dKDfIgzCA3tFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k8UqaaxbXTNnQ7NdQ+tRTVyXRmpShbBfV44WYTTdaBLMgvTEqQVugTAP39GXUAuSO
	 wrvrDiYnmewyKLwJR6Y6puvQnj04rRVKyXeeDw78u+5GEZexQG4dG4jJ7GSUP+oWHt
	 bVvLv0JzpjM49o2P5razdFIJXp8sCTTuaoWv8IZl1+xInFSmw5UK2CZf+B/ItAA5pv
	 wjbv4z8URWqGN6PhTg4QZAE04tcRU2JFi6bIQtR+65QFV7LJ/qHkJOMO71p3BIV9M/
	 +v+XgddzrKAM7pt46k6NKmLw+I/tmIszFwyMEtSIWS/PT5mhYfIy1R3RqDbNuK9Zed
	 yrvO2BtOmyf0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF213804CAB;
	Wed, 21 Aug 2024 22:55:35 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.11-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240821104010-1325128977@linux.intel.com>
References: <pdx86-pr-20240821104010-1325128977@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240821104010-1325128977@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-4
X-PR-Tracked-Commit-Id: 46ee21e9f59205e54943dfe51b2dc8a9352ca37d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 872cf28b8df9c5c3a1e71a88ee750df7c2513971
Message-Id: <172428093435.1853724.7663677617138961714.pr-tracker-bot@kernel.org>
Date: Wed, 21 Aug 2024 22:55:34 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 Aug 2024 10:40:10 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/872cf28b8df9c5c3a1e71a88ee750df7c2513971

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

