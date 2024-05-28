Return-Path: <linux-kernel+bounces-192728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851088D2155
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245191F242A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80918172BB1;
	Tue, 28 May 2024 16:10:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E26171E54;
	Tue, 28 May 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912655; cv=none; b=UzPcFX/ztC4XfJ6+eqIhuErmpdd5T5NV57eedOn/xZvwNz0y8qSEGFbqWuK3u+LkUGSlVVIj/dY9bOpnCBe8SmXdzQN8Xg8RtoBKmbm7QHk7BPRyzBxNjyNlrFByH+5u29QNvw5u+HEpUcF+5dr4Hilkk7ywE8ZI0fsjjt9OYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912655; c=relaxed/simple;
	bh=SPJ47waA3PIag5E3wvPEGhYlMD7tp9s3JnOOJ9UDRjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F3/Y/Wz3LRJxaQIeNTcDGGs0c45EbsMDrjt82KRDJnsNHEQ6jRzZJnCPs12Hbc2ADD2Ek6V3gRhhSSyJd0SsAXDoh1Vgr3C93FJQ7oNGCIgRj6VQSU2RyDBHmsqhRrCKXCq1gLUlr1slCHFYcSGafxbGWBzz0KppwBIufEC0XRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D0C32789;
	Tue, 28 May 2024 16:10:54 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 79F625FD47;
	Wed, 29 May 2024 00:10:52 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the
 SoC dtsi for A64
Message-Id: <171691265249.683236.17741143131124450716.b4-ty@csie.org>
Date: Wed, 29 May 2024 00:10:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 28 Apr 2024 13:40:35 +0200, Dragan Simic wrote:
> Add missing cache information to the Allwinner A64 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provided
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper A64 cache information.
> 
> While there, use a more self-descriptive label for the L2 cache node, which
> also makes it more consistent with other SoC dtsi files.
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[1/1] arm64: dts: allwinner: Add cache information to the SoC dtsi for A64
      https://git.kernel.org/sunxi/linux/c/950c51e8ebb4

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


