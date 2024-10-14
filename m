Return-Path: <linux-kernel+bounces-363099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F599BDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD601F230DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0513213E;
	Mon, 14 Oct 2024 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX0KL7Ia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46F12CD8B;
	Mon, 14 Oct 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873548; cv=none; b=NlF+CY1Y5VCufdXWOSLdNsB9xjOFQLj2/AubMqCgxHX8tf7la+g/FCZ4eqE5Q5NNP9kwWx2/rS86Lmhy207GE1i7L7IKyDjl29emB3CdjO1aa493EiyAGCwxF41lMJhKbnx0J2esl6oZ+ZCcWDmg2emWu/EMFBowky+PBwp0cgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873548; c=relaxed/simple;
	bh=wsvTp51sIhItHm20mx3Zu+p7o3AA4PsG0j1vCJaowiM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kaj+muMGpl34EajaAX0zVebSBR7ksiy670CvqJ0jqoHlUDyA3KbzNpYzSKWObAdS23qrwKq2wiLfRioXIWCWBgiq3pGhpQoucD4bcInJ6LV6C7cTCSw6Uk5FbKROP36RCGef0NoYeOWqyYYZEkFPRZK0tKYh8AwJkiojRr9Ynjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX0KL7Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA89C4AF0B;
	Mon, 14 Oct 2024 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728873547;
	bh=wsvTp51sIhItHm20mx3Zu+p7o3AA4PsG0j1vCJaowiM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UX0KL7IatvL8TpEjt7gH3adEGaRpUHjLwG4vvJkJmu1qUu2UElGiQOMo6RfvpEjqA
	 AtlEge6aKYMaTaIqlKgAlTpWi2m6DeExAEUX/GtfxnO4nNRbbJ1jGooKlqOeUqGGTR
	 CP1IL1sm61l3/U1yy2CAG5jZKRCMjvn5ilbj5ZcDvqpThFxyqHkQQAGELu/JqqLgjW
	 D0ggAhH6W4eKdqghaHYX1lmci+WpsX4+LImHbxTLG5c63h8z9zVy9m7rju8Yb96EJj
	 cRA4+gzAnpWmnbpXWBoVGGO1Kel35GhjjXHchy8xYcd8GPvy0gDsbTv6uJCo7OjSTu
	 lW/3Sm8+SPstQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB35538363CB;
	Mon, 14 Oct 2024 02:39:13 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZwvGEV3LouMEb3L1@kroah.com>
References: <ZwvGEV3LouMEb3L1@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZwvGEV3LouMEb3L1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc3
X-PR-Tracked-Commit-Id: faa34159d08089036b6119c85e279fb36abb8bb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba01565ced22c04749a6f71aa8a658d3a64734bc
Message-Id: <172887355273.3903120.4133313669498552881.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 02:39:12 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Oct 2024 15:07:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba01565ced22c04749a6f71aa8a658d3a64734bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

