Return-Path: <linux-kernel+bounces-192729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CD8D2156
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001501F22790
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42D172BCE;
	Tue, 28 May 2024 16:10:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD34172799;
	Tue, 28 May 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912655; cv=none; b=JO4JQRhNSZpRUWl7GECudL6WIYOMH2+l21DNJ9WiJST4+ToqIEIQaOMcJGuWUC7AOR8POnFZP/O0qUHZrs3VJjNw+CxWlPIdPJ0FTiG/TMoeFXXrNadnu8csQ37ZBvWeaabZF0tFgEhowf6BRS9+pA2d2BB+U1azta8H3ZyJMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912655; c=relaxed/simple;
	bh=Wj27vs35yiz7mps8QsyWtYCw+qknu3r3k2iuRblbpeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=okM/RvXHNCZkU69oMFqaxrWYxL7lQPJiNd0TLmnVO6d+6oTTidXpjek8Nf8ubiz4mj/gJ48SN5ZAeyMjnnEE/LPi7JzpF6srMvvcWsFv9yvV/Sz8hyUyA7Es9DSxs1j1/SOJDjB7Z/mUjdXuwtI3kNeI4xFMy/PA4libNwMRA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91D3C32782;
	Tue, 28 May 2024 16:10:54 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6D2855FB64;
	Wed, 29 May 2024 00:10:52 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the
 SoC dtsi for H6
Message-Id: <171691265244.683236.4063919073033888103.b4-ty@csie.org>
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

On Sun, 28 Apr 2024 13:40:36 +0200, Dragan Simic wrote:
> Add missing cache information to the Allwinner H6 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provided
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper H6 cache information.
> 
> Adding the cache information to the H6 SoC dtsi also makes the following
> warning message in the kernel log go away:
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[1/1] arm64: dts: allwinner: Add cache information to the SoC dtsi for H6
      https://git.kernel.org/sunxi/linux/c/c8240e4b0fd2

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


