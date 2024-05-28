Return-Path: <linux-kernel+bounces-192687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7558D20B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626441F23DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D410A2A;
	Tue, 28 May 2024 15:46:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3216F274;
	Tue, 28 May 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911177; cv=none; b=HtLrvG38icxkvPC6+Ih/PEL/CIvoupdFxCAz7Jhi9yjJg5qiJFK/36mQtzND9uOMMj+Xo3b2E8KYgf2uLmMUQ4kZxa+cmGGT8+7abQaODjMEu8U/rL1mjiHZBuL5cO8DJkHNaD0z5bQAieo1SpbcGTCmMrTER1oL0oOVwT0+bY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911177; c=relaxed/simple;
	bh=Wj27vs35yiz7mps8QsyWtYCw+qknu3r3k2iuRblbpeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qj+cqunYyx4mSRDpsmNGqZKnkm1VdBZADncoolyQGpo08nm+rnwtM4syVppIMX9j4jW41jeHytl+JN75kCiDZOvFDdG6F7/ikVVNREZ/uDIyFt2qioqtyjwBbgTNDll8FxbcswZOuVjqdiwX5WkQCn1DVtS73JofcKebd4yA+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3FEC3277B;
	Tue, 28 May 2024 15:46:17 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id B353C5FA0C;
	Tue, 28 May 2024 23:46:14 +0800 (CST)
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
Message-Id: <171691117471.681554.6744393893618279840.b4-ty@csie.org>
Date: Tue, 28 May 2024 23:46:14 +0800
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


