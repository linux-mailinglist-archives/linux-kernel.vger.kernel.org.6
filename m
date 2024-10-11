Return-Path: <linux-kernel+bounces-361933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D708599AF1A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68033287030
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A11EBA09;
	Fri, 11 Oct 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7UiJCsu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307A1E2019;
	Fri, 11 Oct 2024 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688244; cv=none; b=lT/Qot6cpBRE/UWpqMRi9ypQAd092z+yPZkpm0nMXj/sL3GaVaL50RrzLGEG2pjaOVfKdSwAbj+fncAXRt3rCk/dSEH6xlQo5iM+cU6B79jogiWpTI2N0lhILfIN1UMNWjt6G9UAucd/YSfRVuC61APk5DpLTKD7AZ0HKks37nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688244; c=relaxed/simple;
	bh=nw2jwMAeISOin6wHwGGTqPy6phtXpYNwv2/HLBphEjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ix/vkHE5SogGbOk5EHCe0TqO+RKfnBvgDqrw0I0/vbPZF9ByeaVt32ILfyDj4b80frofmTBTdnJ7+DR0hEWgapMOGAE8Q7qFqBCKESfnCniZ6eqRVvuk8jSisHUw2vkaueCZlBPsoS3rw5TTrhidbnBaoIkd76IqyRsEPrOq9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7UiJCsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE9C4CEC3;
	Fri, 11 Oct 2024 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688243;
	bh=nw2jwMAeISOin6wHwGGTqPy6phtXpYNwv2/HLBphEjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y7UiJCsuGsF5iCgMtIzStujf6vZMgu5jh7q0fkxSZkEycI4SXz4RKgu1z7DzJ0rD7
	 W0E+QrXPJDFLFgXwlb2t3aQ+Ok+vhHApB8UHeBFbiXEm4qiXZbOR/fbk3l2MRxdMh0
	 ZLe+gzEWmTAfmZLxJ/jCO9veyEougKW/ekS+EWtzWL0yDE+fhH0aPrY8z8MRtX2yCO
	 FgXsCjxsbspFgqKC+do7/GDGH9f1WBlAGGCQzhlwgt9xlPso4r0CO6Oij8PCbb1lbd
	 8llef+d2jORgMl9pkdTOxj9J8wPlvhrw5KV9cT3I4GnTPZUVCVamtGHlq8W8H/dT/j
	 ovM1YaDqFBFVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE13638363CB;
	Fri, 11 Oct 2024 23:10:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] microchip_t1s: Update on Microchip 10BASE-T1S
 PHY driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868824823.3022673.9404105689070586196.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:48 +0000
References: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
In-Reply-To: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ramon.nordin.rodriguez@ferroamp.se, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, parthiban.veerasooran@microchip.com,
 UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 13:51:58 +0530 you wrote:
> This patch series contain the below updates:
> - Restructured lan865x_write_cfg_params() and lan865x_read_cfg_params()
>   functions arguments to more generic.
> - Updated new/improved initial settings of LAN865X Rev.B0 from latest
>   AN1760.
> - Added support for LAN865X Rev.B1 from latest AN1760.
> - Moved LAN867X reset handling to a new function for flexibility.
> - Added support for LAN867X Rev.C1/C2 from latest AN1699.
> - Disabled/enabled collision detection based on PLCA setting.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] net: phy: microchip_t1s: restructure cfg read/write functions arguments
    https://git.kernel.org/netdev/net-next/c/9826b9a08b9c
  - [net-next,v4,2/7] net: phy: microchip_t1s: update new initial settings for LAN865X Rev.B0
    https://git.kernel.org/netdev/net-next/c/d793beee2d80
  - [net-next,v4,3/7] net: phy: microchip_t1s: add support for Microchip's LAN865X Rev.B1
    https://git.kernel.org/netdev/net-next/c/7a0414fdccf3
  - [net-next,v4,4/7] net: phy: microchip_t1s: move LAN867X reset handling to a new function
    https://git.kernel.org/netdev/net-next/c/117b70e4c67b
  - [net-next,v4,5/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
    https://git.kernel.org/netdev/net-next/c/662d9c5fe19d
  - [net-next,v4,6/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
    https://git.kernel.org/netdev/net-next/c/6b079d8f7b95
  - [net-next,v4,7/7] net: phy: microchip_t1s: configure collision detection based on PLCA mode
    https://git.kernel.org/netdev/net-next/c/78341049fbcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



