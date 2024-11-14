Return-Path: <linux-kernel+bounces-409736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB7D9C90AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8225D284CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46A189F2A;
	Thu, 14 Nov 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="I2iJl4kv"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D194262A3;
	Thu, 14 Nov 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604892; cv=none; b=cz3CHchN9vHkDH2DDkC5lzecaU6VVIeyfu/9lr+9z0DShCDrUkTkdHRr1mh/89t7nlaixhXBN2Uo9/XVFO0q/0O6B7gmOlaNwWnkacY6LhS7mDIIaAB2YWzpGilZeZP6J/7Mv31z7sMto2AiarY/EfUtEsKA9m6JgPisB7nEXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604892; c=relaxed/simple;
	bh=XgMMy+4oHqhQAIKt3y7EZ0tmTJ2euqZWHA2y3veCa1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnzxg0sg774X6XDV1qXCn8+aniQQ+//IlVCf/TfCqBMYewhoDuBKmW3z8iVHFrUQAvp1iuaLosqkCZNi4Em1TmwRHkciZ+RdyFXXwl1Z4rmYV5JDgjcGBDaZgUaBuczXLJ+OqLh9W/eg4d5S/JKaYdtFP8LapAm/IhCLHftUhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=I2iJl4kv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731604873; x=1732209673; i=wahrenst@gmx.net;
	bh=XgMMy+4oHqhQAIKt3y7EZ0tmTJ2euqZWHA2y3veCa1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I2iJl4kv/k11IlACiHS3oKguS2fcLQ/k9CFWc7L1gwIQ4o/iT2Q46cW9aiqms1YJ
	 qLM4uOfYefXR06wpO/iIAgF8cwUFKDcT2uoJ9+ue/4zgELPGMQeVFKfNM8AqvYuTW
	 gw1IGqXywMpe9cT3GdqB3QXNpq9ymtLt7aPYheCUHenWTAVQnkMihZo25atj7AJdb
	 ihlt8GyUUzNXrBO17pmOenbnwYRPmbu8K8NlGALajiyoug8cCiQZAtU97Y+y/JtCx
	 g41dE5ijqGRFWBgM6CnEIMo9ad7TYPqRZIEBqbWuryJIvp7QcvD6OIHPxCvtlOOQH
	 gb8VpvNy2g2eGamo3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1t50lM41Lk-0063ZB; Thu, 14
 Nov 2024 18:21:13 +0100
Message-ID: <f9b27f78-2829-43b5-853e-55f87223b256@gmx.net>
Date: Thu, 14 Nov 2024 18:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2NV0gc29jOiBpbXg6?=
 =?UTF-8?Q?_Add_SoC_device_register_for_i=2EMX9?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alice Guo <alice.guo@nxp.com>,
 "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>
References: <20241111032307.144733-1-alice.guo@oss.nxp.com>
 <eed25785-7972-43ce-9903-d8350e51ff7e@gmx.net>
 <PAXPR04MB9644C81E428A2AD90F7E5E6EE25B2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <PAXPR04MB9644C81E428A2AD90F7E5E6EE25B2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KUmWu2rfel4DoRQNr3ppUnphw8MqIgFflIQCRmYcqL3vFXuNjPB
 2GZ4gLya/pILw+6fpSMDRK3vQiJSQqOmEW6KJOVpl1HZSuyEUNV15HxLHSs8v4vrjGuH0eb
 z5d6yEBF8bt0D+8q//de/Si1xtEcXvJJ+NhhFrOVgKe87gsghS9Ow3MLQviMZZCzBl89pPv
 IMYPn+dxDiif65UErLazw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M/YUmZxmemo=;8llD2nlaWqHmow9ukLbXBKykNYf
 kI2+l2mERSidDltwBgwT8zqcKUhX3bcnVaUOdd24sYvDi5MjJ08fKgnDdGQ3f3K59h0Yqr2Jz
 Mao9WspPeTDTPTNe3fRahH+YA+5vhQrgrjuu9z+kLaSOUZKuJVQtHTEyXdp2cMfPVxu917bNb
 D4mVXZMa/tR6m9TkmxYXvwnefyJ4PF52qUB/6UTJL2F0/BrWST797Y80KNFc4MZykZrOQkzsh
 4IJ+DRkX74TkdSgbe5/yILw1rHZphpmNjqDXtBNI5mHdkZZoIU2S0QUbHDLpwb1aqd6YFymcn
 DCDAaASqGuI50nn3j8oRnHxiS5Oe6FY8YCVQYRNkJyKNG8H9/PPyBI8fw7kAa4jBRDtZ/4l77
 VkXteFKUrn3yZEZ+CNOUOJckBlVjuYTvGgJp1bnhgM/dzmVGLqqFGOTt8lpoWwACyG5tfA/FA
 HOgENg/grMEO3ivqvvMO09nsPRgHYBdFZqwlQTjOgUi120SYdwjednYlQBwhbDLplPIdbcwit
 sVeoKK+itpaPZ18ccx4xhrGl29apq8ds0sdqGPQBTCMT6TZcF3DpBF2zUUmGSNwaT5PrV2rwu
 fehIZ0x+7lHJ/XnGokjWCDH8dakldcb749KD7qw7pIPIZDLbUoJHp8bpuZY+fVMWj3+ihYVGv
 JACw/SY6ih9JptbTv8uEUc+e8E3z0DjyPY1aOkaIOVJRHBjENO8r6qe+X9I0WpBRA8U25bHJB
 f2EVD1bxkXDxKRIwCqpc8I12bCtzVHpbJIAkfA+yGiltbviCNJ3t+42P0vKk1+yN4KbNp3GHk
 z39gu1ZFXXdBLvA46HCgTGawTY2ypgyJDw+SCPFbod9AMFug3QCQPloOvVmgHmkxYKfwpy/Yw
 PprV1xgovrCK8nNIvpNCf1lD9jCdvK2EPXwGNFYSpt1ytKl+5QHw6Sw+D

Hello Alice,

Am 14.11.24 um 08:58 schrieb Alice Guo (OSS):
> Hi Stefan,
>
> There is no device node which is bound to this driver in DTS file so tha=
t I did not use module_platform_driver. This method is the same with drive=
rs/soc/imx/soc-imx8m.c.
sorry, I wasn't aware that this must handled in this special way. Please
ignore the last comments. I will send new ones.

Best regards
>
> Best Regards,
> Alice Guo

