Return-Path: <linux-kernel+bounces-412452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B49D0928
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307F0B21921
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CC13D251;
	Mon, 18 Nov 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="HxyE6IXT"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17940DDC5;
	Mon, 18 Nov 2024 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909733; cv=none; b=g+9Ej8pQC6ZX/4Q8PLXkL9cX3ZtvZq5f5IhDNJ5q5D4Vynl9H9VXutMLTZWaD2iXxPogIEgT7JT6uzfpqY0LpIouu6hOTz3gC9gT+StrpAz+yVJhKwtbrYD8WlWOhLoLIoej7uQyw6Il+G4mB0GyJlFufNeZ2pvY+YgwK5x112w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909733; c=relaxed/simple;
	bh=K7vRR3PICpmX4+NW+QKL36XvwQqMOpMiqtREAJo3mCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFst2Uxi09hk/0+XBg2WpGZiUSO4tleDa219glW+5ROcX/NCLTZR/XOq1tAWc11eb+G3y4j54Me3oilWvYHlwWjiodfQQgMKzXPUlVLPMpkswUf+eiXzyNCKNBS11m5eAf+xQatga/ulnJjOgkrwi+BlGSNcdit0+xo4C7sGpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=HxyE6IXT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731909715; x=1732514515; i=wahrenst@gmx.net;
	bh=K7vRR3PICpmX4+NW+QKL36XvwQqMOpMiqtREAJo3mCo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HxyE6IXTtlFxApFrih9mES0rN4BW2vHr8HivWUeUjGAy04ZgjqWs21cUuVJpi/7j
	 77ltcXX2cfG/G5WRDKNz255Mf+6dWOrmQjaUfEgLfqsZ5jbBB3rAgUklwoU/5Ycp4
	 7g2DtXh7SBceCv9IbEOGWmjW/vklCUj7VRPU4XhxYVxyWSKYTH2ETQHRSvUUOD0eu
	 GSKQ6gGRGGyYjJ43rT6b9gTGZPFF9FPlorLhHxAvFs7oFRN2PI4qHKWcn6LexQxtf
	 wdfHag75YgpncPSTVsnvE9TX1ta8gnT0vZVuCiIGSxFEXKk/wX7s1y1TKe5mr27lp
	 tNvJNualfxEoTrNOzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1tKZnb1g7Q-00RsRv; Mon, 18
 Nov 2024 07:01:55 +0100
Message-ID: <70188a17-cf5d-4b0d-a575-900dad8f9c66@gmx.net>
Date: Mon, 18 Nov 2024 07:01:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] soc: imx: Add SoC device register for i.MX9
To: alice.guo@oss.nxp.com, alexander.stein@ew.tq-group.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
References: <20241118021716.396001-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241118021716.396001-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rLk4OWx6ljgfKFCL1ZiTAiqssGrPxUkR15IXSqDOTfOg3xbBvOE
 4Nbtq4AFQ8TyIv6dmAe4gaLgHr+lLvmergPk2s9UUQejZvMKTVlqJW1inMySCcne3Zmb4if
 d4got78nvMCDM9bT1lT6/lFbukxjB9Js/1XFinUfp9yOWyzgFJLIUFO1lfohW3GDdjCerMp
 Y7NaPK/tY2mM7Va/nEU8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zzK4fJzHw4Q=;4YihpUZvk/BUGl5vFAVpjYBSqC1
 fZIs3Ih4QtGM1QFE/Uo4pNikVLNxr9P54uXNd9VJHjPrLnJgT0jzZqEmM77srypLhyXfv/+BJ
 sb9sr8TawDG4Ua19VIzyLI4zm8awXJGiTBLq35JwKFHQD//mkrPz6MAwWFtEAjbcD1/261PCg
 qXidRnGIhslRUOW0r7uXCsyAu+OZPooi1G466phMGC1qWtY83sUnlBpQAQFDm83PrwndXyt73
 516pF8iLJBy8WDu4s1b/LPzklCCzE/sa6IVjOHsYdonjFNlUZtKLsnAFKNFWM4sF1crNF6x/+
 UzeqprIdIbv4UsD6fAHnv9AbanaBBuWjYCgeAA7QCu0224AunRXZ+1319pz1ZWLWYZ/q7sh3b
 u94mqX2u7nYAj4U/IkMByY4tKJppl8j5tyzewWhpVZyJI+bINzZMTd589VZp9Ie3lZBSgWT8l
 S7jXqGVBYQu6eo4IVoAkAvCABGjPOuYnSZ3UUBsbMWeOw6baclklwXRmAI7kKwONFLYLCnbs8
 bMs5GKimEOkjn8PbkGappkb3vmAIieKBgty1uK9RtJeY7LgwXKKsxY8A3RUU3dOQfeHg7Tpi1
 OpcA3UqdbSc0NWBrGukBhv7fTYHcLOEOGQ9q/oWDnmL5Oofy48PyRyNrdU5KthZGDldysHLzF
 3Z2NQ+yWpPVq0kIhRWmeLunBW02YhAcl6DYO+k/jcx0ekutRpDmPY1uWm5gh+FxCNzXI2rzRr
 YOlsw0hdLpVEx1IkmfUCTDaR97100Go5tWwqfx901qSLdNHbxrZUu9/YU2S0uHUouIdnTtF7+
 QQ8mz3YGyKkA0mI6STFNQm2+QEFQBXeh3CFo4KgHn5BjOdd19mOj3o3FMkUIMtgg/T/MG2uWQ
 GZx63ezRqPERoagwNGBNX41bfZPg9iFpFOw3YJx9+xbMBWXUvIowOpMFU

Am 18.11.24 um 03:17 schrieb alice.guo@oss.nxp.com:
> From: "alice.guo" <alice.guo@nxp.com>
>
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Looks good to me

Thanks

