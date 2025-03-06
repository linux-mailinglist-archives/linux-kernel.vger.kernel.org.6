Return-Path: <linux-kernel+bounces-549727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A664A55696
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA853B3FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03526FD8C;
	Thu,  6 Mar 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQEn5sVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777C19E99E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289203; cv=none; b=tXPcppzo8LV2BYEt/tdht/h2SuwZHshd+2aYyrcesnckj2ljbsV8jG1bYiGtOfTy2NkRFRKLvWgRNSvcXMUTniXoioqZW9Qf/hp/VWNv1jHgyS/XOUJhWroPeeYERgvy15pmhtuK0iVcNj5lhHmkDkZAkGuuoS5N/JpqLlTQnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289203; c=relaxed/simple;
	bh=SxqFE7rWuo6rXKU9Y8eA6WhRPLF6ga1hxAzjpUuo3yw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kz7+k2Qf/xKUaQY7U5gEtSDlhQxxhJG/9+JyDcNViM9IGvYzZBuGHlZWsz2W23UfGLZiSn2vj6gneC+0iUa/uqDxuGPBxrgyZJW0rKoWBCQgMDr002TBt8mB/lTyPWqF6EZatECEpaknTM6vRs5SOgb/1fh08Pk3ygip/OGBUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQEn5sVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26FBC4CEE4;
	Thu,  6 Mar 2025 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741289202;
	bh=SxqFE7rWuo6rXKU9Y8eA6WhRPLF6ga1hxAzjpUuo3yw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OQEn5sVO8oBWdDwX3te4gqAVidJfyC3FqdpFlrvFP6LnsADv/1Z418fIUmL+Etg+p
	 XQv4/0C+POqIWqNVW1RVIeuUpSJ8LyZRo4FmQDJkxVCu2+mwMWPTTSUBXm/nPcAFVP
	 siCIwvo813UF37XtwZ4yja/iRfble3I/SIC112asQ5pG1gPqhPNTPq/S25hk/GH3/U
	 h1+4yJuprMozi/iHDrIhuYHBESsAn1HjnugkZORMecflk+RuBXOGq3uxCyRvToIFP6
	 4w1twXvhhBan7uF+0aPUw5bjoiQ7Vxdf/xZlXsDOcXLPWD2wqUX2nrx9NxRruDF39y
	 sTXP7QG3WL6rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF5380CEE6;
	Thu,  6 Mar 2025 19:27:17 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8_VoQiC98Fck8=uBPAS4A5GRurhbZHPBX4EVspZHe+Gg@mail.gmail.com>
References: <CAKYAXd8_VoQiC98Fck8=uBPAS4A5GRurhbZHPBX4EVspZHe+Gg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8_VoQiC98Fck8=uBPAS4A5GRurhbZHPBX4EVspZHe+Gg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.14-rc6
X-PR-Tracked-Commit-Id: 13940cef95491472760ca261b6713692ece9b946
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5872cca23a017aae01d0b2f82346907169f7aa01
Message-Id: <174128923590.1751313.18255283956274505536.pr-tracker-bot@kernel.org>
Date: Thu, 06 Mar 2025 19:27:15 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Mar 2025 21:39:48 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5872cca23a017aae01d0b2f82346907169f7aa01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

