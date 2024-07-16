Return-Path: <linux-kernel+bounces-254385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5B9332A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEF91F2361B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9419F477;
	Tue, 16 Jul 2024 20:08:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89541C7F;
	Tue, 16 Jul 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160501; cv=none; b=QJdn5aM94Z8e8sM8hdLFw6yqUFV4hnuz1HwBVU8GjcIXkioWfJFcBfzlYgros1Ela6HTtl41FptRQuf1dFaWj1wn6oats4x//3CEQWDT7qHiTrAAlSrIZ6U6SXZaQCZjgjsXxOTswlRauro2lT+6ybkktLeZ1e8bI121XHFFE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160501; c=relaxed/simple;
	bh=EN3+BKVHD02VXLcVLEhB7hXMOb4+VqlXh2yGMnd2dqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pwgp6FcglCHNy7xjCqLbzPbnd6hv4ABG4OYDBa4HoXXCVsRp20PWA1ClRu5zVWGumHdqVCfPtirtD61z5d3EkoEB7Hgxd85lO0gmvMFVU/gWNfGFhiBetgajybXFdfQWTDEroTabXYv7uknh6yLxAN2ZFMdvqKVLNVEazpQVpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sToSr-0006oY-7Q; Tue, 16 Jul 2024 22:07:57 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 0/2] Add support for Firefly CORE PX30 JD4
Date: Tue, 16 Jul 2024 22:07:56 +0200
Message-ID: <2101274.K71DO8KEF6@diego>
In-Reply-To: <81015d015aae01f2d5fa70262304837e@manjaro.org>
References:
 <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
 <81015d015aae01f2d5fa70262304837e@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 16. Juli 2024, 19:45:44 CEST schrieb Dragan Simic:
> Hello Christopher,
> 
> On 2024-07-16 17:51, Christopher Obbard wrote:
> > The Firefly CORE PX30 JD4 board is a SOM and motherboard bundle from
> > Firefly containing the Rockchip PX30 SOC. This series adds support for 
> > it.
> > 
> > ---
> > Christopher Obbard (2):
> >       dt-bindings: arm: rockchip: add Firefly CORE PX30 JD4
> >       arm64: dts: rockchip: add Firefly CORE PX30 JD4
> > 
> >  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
> >  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
> >  .../dts/rockchip/px30-firefly-core-px30-jd4.dts    | 562 
> > +++++++++++++++++++++
> >  3 files changed, 568 insertions(+)
> 
> It would be better to split this into two separate files: a dtsi
> for the SoM, and a dts for the carrier board (which would include
> the new dtsi).  That would reflect the actual hardware better.

correct :-) .

There are numerous examples of these types in the kernel
already, both these combinations - for inspiration :-) .



