Return-Path: <linux-kernel+bounces-400184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0839C0A12
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA004B21CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99994213ED8;
	Thu,  7 Nov 2024 15:26:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557338DC8;
	Thu,  7 Nov 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993198; cv=none; b=DXEjJ3fw56WGhbnszNlM2NWmHea97MjAbkr4SlldLa+ijwusIeJL5zkt0RtqRUHaRc1K19/q38bWXzLTxH/oEo5EC3nmrKotEAHDnZ0grHNBpPz8YARIitLp166svOvVbIRl3J+Xv9Dlj/voooPoCU+BRm4MsLzacdm4qUqev1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993198; c=relaxed/simple;
	bh=IVATSo4A5/rDZWgfIflL/vhr9/60fc4D3ww2fSxo93k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MRfU1lWVWwm4b0h63MiP3/xT9iTw/nfjQSzSu4fiCNdg8NzSFckg1+jUEEG9e5UOG0sn4+n/Q/SdOL0n86SkQBPJZTxU9hogRI64Lq5GeX2MqDh0tLBUgv1y4C0iuhDtHuP5+D5xZ4QaVUX49t0+t/KHQof0Ko513OgL3zYEPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EA6C4CED0;
	Thu,  7 Nov 2024 15:26:37 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 010B55F836;
	Thu,  7 Nov 2024 23:26:34 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Andre Przywara <andre.przywara@arm.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Alexandre TORGUE <alexandre.torgue@st.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Tony Lindgren <tony@atomide.com>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20241104230628.3736186-1-csokas.bence@prolan.hu>
References: <20241104230628.3736186-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH] ARM: dts: allwinner: Remove accidental suniv
 duplicates
Message-Id: <173099319493.2335414.3613270726802144836.b4-ty@csie.org>
Date: Thu, 07 Nov 2024 23:26:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Tue, 05 Nov 2024 00:06:27 +0100, Csókás, Bence wrote:
> Allwinner suniv boards' DT files were accidentally duplicated
> in the Makefile when they were moved to the new directory
> structure. Remove these duplicates for code cleanness.
> 
> 

Applied to dt-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/1] ARM: dts: allwinner: Remove accidental suniv duplicates
      commit: 2ccfecbf9d48edfd866259feb464f62ace681323

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


