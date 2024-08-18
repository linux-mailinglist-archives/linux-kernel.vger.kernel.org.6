Return-Path: <linux-kernel+bounces-291144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0307955DE3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DE01F2127C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD02B155335;
	Sun, 18 Aug 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVq5cNRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE62155300
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724001814; cv=none; b=ISRIQoTv8xQa3HpR5zCyOO8pqziZIK/N2mOe7331XtJy7hmTinEkvO1waui8uNzG+2gj/IEu7f7bjY3y6FPABqwoGn0fW8DtMQEgE+j57oz8da2x0TUJHqNurZIajx616uwNpt+OKyBrfZLMGUIW60EXqs/SoUP71zJ2ATp5FaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724001814; c=relaxed/simple;
	bh=9lJ8zQNmP6MvqAlRl5BgCiKB/92DFJiT/SNJXGzCXcU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ofDQCO8pUUdY1kCOnAqkNMyJaaBTvrW72mpi8EAARbQ5chlo08OQJePkq5bUb3eCEJXxrQFbIhjhwbwqzLkhXwChqvMi8JUTPdKoHSjgQhTAVOBsO26/fkVMBmLaYHXpEV+x2eyZDE0HQ4XrBgd+Ya0LFNVvz0H8JWdBGV5qEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVq5cNRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BB5C32786;
	Sun, 18 Aug 2024 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724001814;
	bh=9lJ8zQNmP6MvqAlRl5BgCiKB/92DFJiT/SNJXGzCXcU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZVq5cNRfN44Pl7+RrUbgUvKfKip/2e91bD6n5gUrvXOtQFk0vSQb4nHUzU+vI8kxK
	 BD6em9i4rMX+RnUX8GZOc0G55je4nhGkDO2bm4OvSLsV83dUWKNLWWxR7PeNa6VcQ7
	 7afvSV/4ueV+BjORsds1RRii6dALNNtgs+qXqbQEUDGxe944A1AwGucDHH8QDQ+qdF
	 5AhDO2rFp4LWQqTGnG6hcjbqIgBNOrSer6BVIh55ZMLNEt9j/5zOcgnVQrgDXkMHM5
	 yu1+jkS4rfTu6ejwSW9FbqH9EkNUOlhxDN4xn+owUSj+2NiyJ0IX+k5kaM+hoGW8w3
	 bflywe5iYxxbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBFF38231F8;
	Sun, 18 Aug 2024 17:23:34 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsIWUHiPLdjeo7ow@kroah.com>
References: <ZsIWUHiPLdjeo7ow@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsIWUHiPLdjeo7ow@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.11-rc4
X-PR-Tracked-Commit-Id: cdd1fa91a6b8c7cd93b3abf9f3ef05b8ce741b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccdbf91fdf5a71881ef32b41797382c4edd6f670
Message-Id: <172400181329.3949564.17300018595664098685.pr-tracker-bot@kernel.org>
Date: Sun, 18 Aug 2024 17:23:33 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Aug 2024 17:42:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccdbf91fdf5a71881ef32b41797382c4edd6f670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

