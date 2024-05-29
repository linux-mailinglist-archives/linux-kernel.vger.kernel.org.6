Return-Path: <linux-kernel+bounces-193546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43EB8D2D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686311F26854
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657216078E;
	Wed, 29 May 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="g/1OA8Rr";
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="QQ9BedQy"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA27273DC;
	Wed, 29 May 2024 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965494; cv=none; b=E4oxDBSuAbw+o/3QhNgGGiTtq27Weu8El08BMHBDGBPz3IrZTOj6D59d6yPYZvuJ7ESrLCUcxEPuljtNiiQi6EG8CGjDyxO4fTLxLxrx6elE2+flyO6On41aAp4do9syArNQwZrhjc9K9amMoM+6PKTL0nWWndefFltIJ4JuAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965494; c=relaxed/simple;
	bh=jFTfeTtYWGbpeFmV+28NZwKVWAB7YPdr4ftKZZB4ahI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5ZQBMd9RIyjxMv3cq7cOQhlZnyXeBu7SZFQbaNEaQz1uXa+mUDLCTQbUBU2qgQepVj5m6PXyPRpH8UaHZ3ndJ4E27m1vJlh6Aau77sMyoduho4G+BoIazWFXHWTjYnmnYXMq71wnt91oDazM3MkZzjdnFPoYzqRryw2hZAEIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=g/1OA8Rr; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=QQ9BedQy; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716965489;
	bh=FM07nAP+48bSOuTtekpfEzG6O9VwkpGppNHrIxFz+7A=; l=1313;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=g/1OA8RrD2hD/Y3IXDklsGD0MS/eQnGbHTVlk1+iRzcMXSkwj1oq5UPU07xfL5FYf
	 qMFCThbGtzI71H8o6xzfKPa/EzEF5c/zHec4oCXrvIA9pBP5SR7SSbVzGF19uyTz9Y
	 VhYNGDZK1NaNXvA9indp3y0wcu7HUeEchpkCdUfDIcChLYvTArAGFQaIiVadJaYj5W
	 LKcqzCNwqPl/oWTiG+HH65FQIdZ08DOa5J/eiQh5CXHaUzMLBkJYcS+jPW2HnIUNSM
	 gR21PeGQnuxL8tCap0inNzvU3bkE6RoiJH4k6Ya0E7oAObiP5GrUJhgw9deNSoqyzw
	 rezj0l3cT3d1w==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(3828186:0:AUTH_RELAY)
	(envelope-from <prvs=1876C162DF=alina_yu@richtek.com>); Wed, 29 May 2024 14:51:28 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716965488;
	bh=FM07nAP+48bSOuTtekpfEzG6O9VwkpGppNHrIxFz+7A=; l=1313;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=QQ9BedQy6mBg+QqPLNU19qOS5+hbcKoeNFU8HAU/Dv3DovLWN1skAEGvJj2WOav3g
	 mgkdWTPZZo9w+PsjPOWaj9c0F3PLvEu6/1lChzqDsdJGGIptlX3sSbdiYvBJ2xNINN
	 FSZ2+edOfF6eVDJvMHX8QcuEF3USdaONJeiPUF8Vbl/Mnx4V772j8YUBzOtOCooQCo
	 vKdOf7Ph1cYJw8G/cpn32ILUJmi3oiTGnCH4XModKJxXN4j/KUOB/E8Fh4bv1dsFD9
	 adfb2KazguNn8VO+VjHiv+x+xZvuk65WuFbcvSQPz4DMClcNM1aeLYsiQws8VH9Iq/
	 ZgyR/dqqpt5Xg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213210:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 29 May 2024 14:41:23 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 14:41:23 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 14:41:23 +0800
Date: Wed, 29 May 2024 14:41:23 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<cy_huang@richtek.com>
Subject: Re: [PATCH 1/2] regulator: rtq2208: Add fixed LDO VOUT property and
 check that matches the constraints
Message-ID: <20240529064123.GA13317@linuxcarl2.richtek.com>
References: <cover.1715846612.git.alina_yu@richtek.com>
 <7c28d2e61d2fc13066ba4814d1ecfab8f344aaad.1715846612.git.alina_yu@richtek.com>
 <c0c7a63d-e435-4778-ad4c-3d93f0215116@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0c7a63d-e435-4778-ad4c-3d93f0215116@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, May 27, 2024 at 02:00:47PM +0100, Mark Brown wrote:
> On Thu, May 16, 2024 at 05:20:33PM +0800, Alina Yu wrote:
> > A fixed LDO VOUT property has been added to specify the fixed_uV of the regulator_desc.
> > Additionally, a check has been included in this version
> > to ensure that the fixed_uV matches the constraints.
> 
> This doesn't apply against current code, please check and resend.


Regarding the previous discussion in

https://lore.kernel.org/all/20240528060731.GA25526@linuxcarl2.richtek.com/

I found some patches missing in the linux-next tree.

So I merged the missing part in my latest resent sereies.

The issue has been addressed in

In '[RESEND 2/4] regulator: rtq2208: Fix LDO to be compatible with both fixed and adjustable vout'
https://lore.kernel.org/all/5ad4c7728c7fa7f6286db36b99d31c9d0f5d16c7.1716870419.git.alina_yu@richtek.com/


@@ -219,7 +219,7 @@ static const struct regulator_ops rtq2208_regulator_buck_ops = {
 	.set_suspend_mode = rtq2208_set_suspend_mode,
};
	  
-static const struct regulator_ops rtq2208_regulator_ldo_ops = {
+static const struct regulator_ops rtq2208_regulator_ldo_fix_ops = {
	.enable = regulator_enable_regmap,
	.disable = regulator_disable_regmap,
	.is_enabled = regulator_is_enabled_regmap,

..

Thanks,
Alina

