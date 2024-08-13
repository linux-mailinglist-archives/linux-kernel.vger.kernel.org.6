Return-Path: <linux-kernel+bounces-285162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8529509FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10ED1C228EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F041A254B;
	Tue, 13 Aug 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBsIH5Ad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368561FCF;
	Tue, 13 Aug 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565872; cv=none; b=qCsxKVrx4r+/E6jAIvh9dELux8xoBoaEDSF8JoOFirRyQd/wKf2Z1j25rDqqCyvOJIvCf266qiNgtubq4rDzMreUK8FwMvokcTSgGnFFEnLJh4LVvibAQbBG+8TVBPsIQ/LmLvgJiPChX840PdDP8V9TTd4B4W3ssjHPcktoM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565872; c=relaxed/simple;
	bh=E5pELByvlHXnl49T38KLBtj2POmo/UVZkpM3ZdNzxWo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CChfadBXzAJ77sB4mW/jj0MNWk8VYvWegLbmhcwvjUu+1v98RBXL/n+L6zNCM2ikmwMGESf7JnSAmp60jNJlsokkxPZlkyeblAjbRoj2qSTlY3Fj2Vu91raA6GCSuDxUHuRhU2Wa7r8IuDpeOm12CntK9kXNx46wP4AYLU91Tig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBsIH5Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB68C4AF09;
	Tue, 13 Aug 2024 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723565872;
	bh=E5pELByvlHXnl49T38KLBtj2POmo/UVZkpM3ZdNzxWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WBsIH5AdSRNGiBGnnev7ENGkkNddfMt8t6NULBxPVNXkhvsfYTkOTODNlpeow4Fty
	 P7L17zOLenSkZw6UzFFwW7RszI544OEtTRMnxZmRSggXC+R2gO5+eN8tSJy7BsL8kw
	 DMI2DQAmoQeM/J30l0C7Hr+9+lFay6YpYHQgUaCSwyoDh1u4vk7N7J/9A2NBJVkaSF
	 LS8RAkUUllZqjuukSNfw+4KNcRMmK6EGEnw3jvsjJckuV3JxyXZmCfgFzvjr4s1XM3
	 3Syhk3Q10HTu+mUr5+iar7vBhwBuwBvRoO7I5SFrXCfHPjSPmof6pbQybDhJyZWwey
	 5z1urEUDy500Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718E43823327;
	Tue, 13 Aug 2024 16:17:52 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mse_XmxXZy8Xhav9S3K2pBvUTPFqf+jhJtOoCn3hM0stQ@mail.gmail.com>
References: <CAH2r5mse_XmxXZy8Xhav9S3K2pBvUTPFqf+jhJtOoCn3hM0stQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mse_XmxXZy8Xhav9S3K2pBvUTPFqf+jhJtOoCn3hM0stQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.11-rc3-ksmbd-fixes
X-PR-Tracked-Commit-Id: f6bd41280a44dcc2e0a25ed72617d25f586974a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b4aa469f04999c3f244515fa7491b4d093c5167
Message-Id: <172356587116.1687982.16180580175572855184.pr-tracker-bot@kernel.org>
Date: Tue, 13 Aug 2024 16:17:51 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Aug 2024 21:57:04 -0500:

> git://git.samba.org/ksmbd.git tags/6.11-rc3-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b4aa469f04999c3f244515fa7491b4d093c5167

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

