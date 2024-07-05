Return-Path: <linux-kernel+bounces-242293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C699928652
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA27B21205
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1F4146A69;
	Fri,  5 Jul 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TVq8H7Lj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2B13B5BB;
	Fri,  5 Jul 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173840; cv=none; b=q13Alp1OODoTnHnsgUs90P6IOYWGnPEUY/Kp1ANtCe77Gc6y0enVUH4t9K5qG43DucJtwem4nY80e3PJSoBHSH5gPeLVPDcWZs1AKWLeGVR5Gmhmu+s5aKTcl/lcE86Ttaexecv2Jey+2QIpD+qtga7al++qbT0fOekjL9rsRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173840; c=relaxed/simple;
	bh=WgDu9ZpACAJvm7Pa4gqk+rNT3auetxE4+ckzl7sJ1ig=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ozOyeiiFL78nCEZNQUXlBGd2JFuBODbkB7PkvBJVSpeDQkxpcjqgIvRk39NaUlsKebEHrYOHAzX+vg8qqWsteLmAjYivQRc6zV/YP/zv6xK9E1u1CsXrb20ddPnRKDTqLp0IGc7n/jIDbGZoJbUm6+82NzlUbmyv7vrWSVFhxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TVq8H7Lj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDA511C0012;
	Fri,  5 Jul 2024 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720173836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63549/JWR8ZN81iPpBOmB7VHeCd6i6W3nkUlZJSwKPA=;
	b=TVq8H7Ljl3Cxhy3s5+zVlF60lJwrKbloXTFbbA1uBzXwUN4L9IFxGZn0Ppmd7mjAhknM+t
	dH28EleXtEiNik7Uu/HeIMf50fGEPNEHmYegErsdPcqWQ8WIr3Ltcoi9ddSmvN1MFjvHej
	Btbt/MHZBMveLeIv+jeblBjBMafXI4Cu8gZYUXeQk7SgWekwoRykFGXrmM9cWokCDbQS8M
	rsW0UKLi2KY8RY3GeouyXr4KxL6EiaaAtlNrMX/lr5vXEL53BXRtB3ADULbpULwT4QTDEA
	gq98IZRL1BGKxBdYhfcf9uW8g17wE/ONuaYHUDFYHruhwheM2i0T/G3STUP24A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 12:03:55 +0200
Message-Id: <D2HIQELPOBJD.1HJZS16QJSSZJ@bootlin.com>
Cc: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "kernel test robot" <lkp@intel.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 4/4] clk: eyeq: add driver
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240703-mbly-clk-v2-4-fe8c6199a579@bootlin.com>
 <202407050921.S41aCBdD-lkp@intel.com>
In-Reply-To: <202407050921.S41aCBdD-lkp@intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

*Grasp*, I forgot addressing this topic.

On Fri Jul 5, 2024 at 3:50 AM CEST, kernel test robot wrote:
> kernel test robot noticed the following build errors:

[...]

> All errors (new ones prefixed by >>):
>
>    In file included from drivers/clk/clk-eyeq.c:30:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:548:31: warning: performing pointer
>        arithmetic on a null pointer has undefined behavior [-Wnull-pointe=
r-arithmetic]
>      548 |         val =3D __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
[...]

Ignoring all the warnings relative to <linux/io.h> as they appear on all
objects using this config, nothing specific to clk-eyeq.

> >> drivers/clk/clk-eyeq.c:264:9: error: call to undeclared function
> >>     'readq'; ISO C99 and later do not support implicit function
> >>     declarations [-Wimplicit-function-declaration]
>      264 |                 val =3D readq(priv->base + pll->reg64);
>          |                       ^

Options are:

 - #include <linux/io-64-nonatomic-lo-hi.h> or
            <linux/io-64-nonatomic-hi-lo.h> or

 - in Kconfig, add "depends on 64BIT # for readq()"

I'm leaning towards the Kconfig option. Build testing this driver on
32bit platforms makes no sense, this is a SoC clk platform driver used
on 64bit SoCs. Including a compat layer is a more complex solution.

I'll wait a bit before sending next revision.
You can ping if you want it straight away of course.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


