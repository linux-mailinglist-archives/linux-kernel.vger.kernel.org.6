Return-Path: <linux-kernel+bounces-198529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6F8D79CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E99D1F21A77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B05163BF;
	Mon,  3 Jun 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATad+G0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879A4A08;
	Mon,  3 Jun 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378229; cv=none; b=g12S2U/o4JjDplxEHImjkf8ZQGEXsbXW9Y/nTNrikxBA47Q+Ibqnde5k+5GIVtXhw6ZYrfujoNVL7W6lsnA0Ocr5KdjtgSXDqKj7qGHgPJ46I+nKkeff0FbFz2K/EeO5nenprX7zKqD1wOKWIV0iq7IVzDJhDb7Bf9Twyh6tIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378229; c=relaxed/simple;
	bh=c/gcQfCpVJnfZDVPUk0eXP87yX0ySWpMX5T4FZ+WwZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TzjdxDYbkIrEm3BMVUQ/WEWX5GA2v2HJnrDWZ23HRshXH6PZSdhc5jEUM6vCrnj5pPzpdGpybtrO5xqJl0JsL6xrqOBMEnxb7fnn7PWv9XRIiWoJDLTTlCd/SHfS5GM78StkLnfBt7XomMwSt/lYyM/UkrrWX81SB88u1eu1FE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATad+G0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3526DC4AF0B;
	Mon,  3 Jun 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717378229;
	bh=c/gcQfCpVJnfZDVPUk0eXP87yX0ySWpMX5T4FZ+WwZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ATad+G0nFuK3JK8yMD6dxCR6bNIVI5x7qf+2PTJx1TJtYHJpnsTdYy8ZBo9SuOseE
	 e3lwxvbrCS+tGOc+AnD0bfkVxqeJnoDfu/+/o3qYpIoOb8P4+wOlsvyMqExIaoQLfq
	 KtL9MKnNjyByRYICxqw/L2r9Y/lrZwixfgEhkdoilXWJHDBqWvP0MqKhwFjWOECuWc
	 kFbvAeFcz6VINeOEOOXfChRFzAPXvPmMbr9q0ufsTvUQAu0egsowrQkI/VHaE/uPGu
	 nU5QCIT2IoyddGxVjZc+/H1N0trMHG5XoLPHikYJl3Z+fI55NA3E8l1nwrWpDZ0Hpl
	 vj13TC7zqhuAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24595D6191F;
	Mon,  3 Jun 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] ChromeOS Embedded controller hwmon driver
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171737822914.30104.2468762695672180347.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 01:30:29 +0000
References: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
In-Reply-To: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: jdelvare@suse.com, linux@roeck-us.net, bleung@chromium.org,
 lee@kernel.org, tzungbi@kernel.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 chrome-platform@lists.linux.dev, dustin@howett.net,
 mario.limonciello@amd.com, mdf@kernel.org, s.horvath@outlook.com.au,
 paranjperajas@gmail.com

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 29 May 2024 08:27:10 +0200 you wrote:
> Add a hwmon driver that reports fan and temperature readings from the
> ChromeOS Embedded controller.
> 
> There was an earlier effort in 2017 to add such a driver [0], but there
> was no followup after v1.
> The new driver is complete reimplementation based on newer APIs and with
> more features (temp sensor names).
> 
> [...]

Here is the summary with links:
  - [v4,1/3] platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_readmem()
    https://git.kernel.org/chrome-platform/c/a14a569a9918
  - [v4,2/3] hwmon: add ChromeOS EC driver
    https://git.kernel.org/chrome-platform/c/e8665a172378
  - [v4,3/3] mfd: cros_ec: Register hardware monitoring subdevice
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



