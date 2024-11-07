Return-Path: <linux-kernel+bounces-400183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 743819C0A11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236C11F261EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C0F213ED6;
	Thu,  7 Nov 2024 15:26:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AE47F4A;
	Thu,  7 Nov 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993198; cv=none; b=L5UHPyt65xTmLGkrPl43vybBjJolG8eIsMWwPU4ELC3Nnj7OZos2De/2oI72QgkhtKIbhtrL3EKBkVMIkhxy0I5tJQJTgFHcLjspRjctbAW9eEr5LBV3MMYtEjzrYF5h/pDDEr/XkkOakxjQ4iYfvnRJ0HKNimYG0cx4uE3VNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993198; c=relaxed/simple;
	bh=3D8hekrU3Z4GKpqjaWoZRBvsp56QUnfWVwFW/Y7MvW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oZpMUwaexTJ830wi16PNFwXt3yO5O2GNpgtJDRRflWzXovENMAMdokCSXRyjERTzGBJzf+TWpmRSRtXTv5CjSP7KZ176AOzI6VSQVYALtCfte3GU2WT3zKg6m6Ux5NY2Y44FTJY6kzQDhNH2VdkJqixBI0dp5mTmPMf95m2dwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1410C4CECC;
	Thu,  7 Nov 2024 15:26:37 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 163E25FB46;
	Thu,  7 Nov 2024 23:26:35 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Shoji Keita <awaittrot@shjk.jp>, Icenowy Zheng <icenowy@aosc.io>, 
 Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
Subject: Re: [PATCH 0/2] Fix magnetometers on PinePhone
Message-Id: <173099319508.2335414.4545070931289341462.b4-ty@csie.org>
Date: Thu, 07 Nov 2024 23:26:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 09 Sep 2024 00:47:16 +0300, Andrey Skvortsov wrote:
> Introduce support for alternative magnetometer (AF8133J) used on new
> batches of PinePhones and define mount-matrix for both magnetometers.
> 
> Icenowy Zheng (1):
>   arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone
> 
> Shoji Keita (1):
>   arm64: dts: sun50i-a64-pinephone: Add mount-matrix for PinePhone
>     magnetometers
> 
> [...]

Applied to dt-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone
      commit: 193b199a925b04e2d9bc9dde8bb63f6d55483b7d
[2/2] arm64: dts: sun50i-a64-pinephone: Add mount-matrix for PinePhone magnetometers
      commit: 844c35cea6b2d36608c3026c7d29a4f5350b7ad9

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


