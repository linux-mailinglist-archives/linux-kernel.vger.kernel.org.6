Return-Path: <linux-kernel+bounces-390316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF09B7859
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723021C20CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854B197A9A;
	Thu, 31 Oct 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bdXYH2ok"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4012C478;
	Thu, 31 Oct 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369210; cv=none; b=tS2RGR0IOzw3Qrm2Gjq+BwLEv6tbSFakcm+An/61YmZAEaAUp0bLG0Q8mp7LZrLgSXcXthCWUzWpHWPj8e+vpF0Yr2G0FTFyaNaARv1uNtCE889NHy9PGZROg2ELD6HtlqMcKQs0k/N8MDZG/2nRxjUzbLPAluqHZZa7TeK7ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369210; c=relaxed/simple;
	bh=czggZw1ImOvUCNjV9J0Fcc94CVGtF4QXnBHN0bWctP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1v0IEsQBvlLl9xsrvujEY8sAJTJv61KbqU71lPcrk1HBl9clESiAAp9K0Rhjpm8mpFz4Mgo4Q8BFQ6y6UunmEjSlbUPUa9dAtCdVjpA143dAFd2G9+p7ykGOpRI282WWI1QVLfP+1u1xpnY4NxG2r2JqzC99baeHIDWYbrE7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bdXYH2ok; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730369194; x=1730973994; i=wahrenst@gmx.net;
	bh=czggZw1ImOvUCNjV9J0Fcc94CVGtF4QXnBHN0bWctP8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bdXYH2ok2ThyRDK0WQIxlpnIB7e/Chol5Cm3EywtEwFpI0+CQayBlS/tc8CvUt7D
	 Gz39OuPCzMWKdiVjHuwVRWBr6uu79HAd4MP0uV70Df+MXWTGe8CgPVJcr/tSMAs9I
	 nvqF4mIYQq2SOekDMjU8OVva3VtkoTvbrvaHHAeSbZkP3DhQLDqbCDnYk1yjxWMjY
	 0zvNPanqw7YJZ4ZN3MZMzf2eFJeWE/T4YOio/oCwiyuLSCxa45m6T1j54f41Skdb0
	 rMmYPEld9nG1WjD3J2kKb7YeU0KmJcbREO9dSbd87XaC6fKBzQgeS+zMjDOr7kb3m
	 Jyr/WUEdoNvxa1u+KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1tbP6Q31uq-00eZ21; Thu, 31
 Oct 2024 11:06:34 +0100
Message-ID: <1a851c21-18d2-472f-95ae-b4121ffded4f@gmx.net>
Date: Thu, 31 Oct 2024 11:06:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/4] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241022133040.686562-1-lukma@denx.de>
 <20241022133040.686562-4-lukma@denx.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241022133040.686562-4-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:F7iNUNqYNdiEuQkrR7RINVZPMB1Sy2y7T6+j14hQxtRoye0cYGT
 S0D3noRd9h1Q0UvacqGupZJ+mxwgvM044pV0jhv/Fn+qPyzbJ2Hm+driWi4b+bfVKExWLay
 LrMs6JrgPbKOHCXFHW2FEPN4I7blrn+1VbE+RVUmlEni8RptFd7yKAkOh6ABJLijBomkmRw
 +edM6v6gyUCRcwkL0mdiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s4eDwSPY0a8=;0KcBJFMpQiU1k9ATTJaFmUH2h5T
 vcJ8BbomjztZJIutSk/kPEkwZcR5oPkxlbfuy5FCSFW8VYlKyeNFmROJyFm1uqB9W7r88nyin
 sqg7EIsry0EYsQHtGVZ5HTweRxhcBANSqV84SiESUJmoxc2GklO5FuTLMsjg0CBfEeWGGitWy
 cvE08ycTnAbDwudWzQo6dZMG727usqShFvg3fHtEe1wFfaBBOFkSuMOOb6XFmw2l/HB5nYspK
 glddAOUMyEQVXStJMf7HQW5txZyzYYKrzIw2Jd4xXcG3GFwRz2M4OL2fskbhOVd1qaF2jCM43
 8/mRs33YUqVz/d5Hq2nAdhHlOkDrxmIvJb3BGfkQJTE0HYOFT4mDGkKmUeKRNBAaLPM/xDb9s
 wS6PsFDtMO71wrSlFTG8MyPpH5jWy3s1PN8MY1qAijurobv2El4MPXqatsgiL6MoW38hvlQGw
 XC9uM28Q1SFgjMMVayQDyqT/zxGXPnvA66ZNh3zZleFugbimW38Kxv/ir9F/z/GM7N3G7Qpl5
 rKsGEir4Iqw1Rx7tt+ee/ZNjTGCq3o07EeNx0mVwIyRA+Jj83v7Fi4TA2cQ8QIeWLymVTvXVi
 lMv7QpgDLWveaUi1yKS4FRhpJsfj5u4kb3p31HoM7njLj7rhgFjDuIe7PheTYuH/asVMBdST/
 GBIHA8G6Rr4DBkRCQttVXcRMVWtZH6Mby691qoezLy+PBpWdn3KgVFDkr4hBGdShfssLg9OX7
 SYIFooYqnasuEyUKvRtL8fne5ayO3gx4evx4EZOnpjSwS/96sZvrqjTxpYmGbHZPitMjcZAc7
 KfjphD/63KZOKhVHudWfmdpg==

Am 22.10.24 um 15:30 schrieb Lukasz Majewski:
> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> some extend similar to already upstreamed XEA devices, hence are
> using common imx28-lwe.dtsi file.
>
> New, imx28-btt3.dtsi has been added to embrace common DTS
> properties for different HW revisions for this device.
>
> As a result - changes introduced in imx28-btt3-[012].dts are
> minimal.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Assuming that Rob's comment wouldn't result in fundamental changes here:

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

