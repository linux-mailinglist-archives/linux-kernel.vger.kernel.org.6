Return-Path: <linux-kernel+bounces-538855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEFA49DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620283BE41E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1B27127A;
	Fri, 28 Feb 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Jvz7yJ45"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A119186E20;
	Fri, 28 Feb 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757579; cv=none; b=ZA22c+WTl/p+Mrb8Nwg4B/I3N8aQlfJcEKtYPeGjpdLf6F8usAZMNeU8NBml9bNE45eVKmQyRczf/oSsw8R7JwlOsfLs+dzctRnMp+6KsTqLkEa02Fj5dy6pwqRU4pK42ipgnerdlz3AVRKCTNcYsTMbCdovLlmGPhQoIk2YhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757579; c=relaxed/simple;
	bh=ZXBR5LYnXOurTmSvf/2h8CiBxpUcI0g6wzC2BoBWZNc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KpCkhsbAqzC9nEBlmKUb2kVDxkCnKith1v+sp7dYXzIJTWZ7essWyRfz0DFcl4AYW4de17XVBj2T9VBnbEWfdxYYAymgFXYix2gWSe6Cm3cWimnLV0wKzhvADCj6t2085DEuUxWi++lRYckz3WR4FTNpYEMiJCPEWmoq9sdBMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Jvz7yJ45; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740757575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luIE0Lf4JAHBS8LhKxuyQef8bCGyud3N4ZNDHk+iEL8=;
	b=Jvz7yJ452lR8t9YC1wIIxBp7ro7I7QTTxUlXDF7Oox+l6ZnknysKkZpnv7UnuJeiGoDQz8
	gkH3gqeNzEBGoIa78J7NYQi5Y3bW+sYOl+EUvtzo+BsbBQ50iuINXLKEeztXQRPDCDOf0w
	9WL/Mi7yluhc1X5awOdpq2CsCQqI+yEI5ykdtyzUie01AY7O62Grd2XFGSKPrdu4HO/Eo/
	N8SMvn73edg3RWBySKjupI+YBBcGkmS0WiODzMiYvunvy7WO+lLBWC0iS1uDbvYjHjSBAC
	J38ps6i8mBWDAVMuLu0b7WQoQ6QIaaiNseLdw721m133y0tqGLRzl8/av8TeVA==
Date: Fri, 28 Feb 2025 16:46:15 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Olivier Benjamin <olivier.benjamin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, oren@taumoda.com, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 0/2] Describe the cameras in the PinePhone Pro dts
In-Reply-To: <20250228-camera-v1-0-c51869f94e97@bootlin.com>
References: <20250228-camera-v1-0-c51869f94e97@bootlin.com>
Message-ID: <0338826971bfdd5b771bc1c6ada795eb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Olivier,

On 2025-02-28 16:19, Olivier Benjamin wrote:
> This series adds support for the Pine64 PinePhone Pro's rear and front
> cameras in Device Tree.
> This is based on some of Ondrej Jirman's patches hosted in his tree at
> https://codeberg.org/megi/linux, but I have also fully reviewed and
> re-written the code from the RK3399 datasheet, the PinePhone Pro
> schematic, and the IMX258-0AQH5 software reference manual.
> 
> I have tested these changes on my PinePhone Pro and am able to take
> photos from both cameras using libcamera's cam.
> 
> Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>

I'm afraid that you haven't addressed the notes from the feedback
you received earlier? [*]  Also, this should be the v2 of the series,
which should contain "PATCH v2" in the patch subjects, and provide
a summary of changes in the cover letter.

Or, did you just resend the v1 by mistake?

[*] https://lore.kernel.org/linux-rockchip/5127541.31r3eYUQgx@phil/

> ---
> Olivier Benjamin (2):
>       arm64: dts: PinePhone Pro: describe I2c Bus 1 and IMX258 world 
> camera
>       arm64: dts: PinePhone Pro: describe the OV8858 user camera
> 
>  .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 138 
> +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> ---

