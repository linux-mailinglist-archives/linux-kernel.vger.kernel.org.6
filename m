Return-Path: <linux-kernel+bounces-388962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8249B66A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7021D1F21F84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56C1F4738;
	Wed, 30 Oct 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="k884u+i9"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E313FEE;
	Wed, 30 Oct 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300202; cv=none; b=m+tApo/rAFsFNWiLXgdgsKbfXfcjCzoT1CI69vN0IhxwdxNgrvcT9ipkDCR4k11VD+XIK0JNF+TFhf6lq7gby9MTICRk2XgF73yoix+cqrvvV3iCGCYyF/5wOsdWL05YYY+xAVwQHMxlFOcDzAzb3t1Yvd1asHD8Ig7upIOknsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300202; c=relaxed/simple;
	bh=jshZkYfvja2YSTTFhWzMe847j/Nt/PWYVOy1voJLicQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ9f2fDPKYLVC84xInPQEczvhqogxHJd6sCmz0MKzSR6T9W9aU386xYIizkvf2YRFXp1nCNADdNgdk+LufsFEcMoMJa+b0wVDSfcpO2b8sj4ghvK/tmPYJSM3/urgbFrvkBG+UhJ1SID2iilhc1zewzFnymGfP7NBLETQfblVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=k884u+i9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730300179; x=1730904979; i=wahrenst@gmx.net;
	bh=jshZkYfvja2YSTTFhWzMe847j/Nt/PWYVOy1voJLicQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k884u+i9keC0g2paphHbvsVqlTZxxRpT6XIs7pCFHvCBZi72zY6njsEqRP9I34Es
	 2HuFbuu6jY1Jr4OddMJnhC9VcVqXVrd1qe3W7ksIGbEciWWJNU5bDmeFnvyn01ga+
	 3R+hujGe91REFTTU6s9FEiDUbWYRQ8us7PsvLYWM6kTgjuxfNExgcdKBxYyt29mSe
	 P5XLbtJxKDLPICy5L2zinBsPssnpsVlYPvmzgw2xRCDH0+xVVzGCr6iopT6rf36sc
	 18ZxWbuwyWdhiOaOUF0LsjYwf3ps5VjXKuzMmw4SpWLs9GrK5w5D5WAtztDAmwREX
	 61phmsGSwxjwYCoFVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1tY6xL3csH-00exFl; Wed, 30
 Oct 2024 15:56:18 +0100
Message-ID: <28689191-db0a-4999-a13d-ab72f0bdc351@gmx.net>
Date: Wed, 30 Oct 2024 15:56:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: imx: Add SoC device register for i.MX9
To: alice.guo@oss.nxp.com, alexander.stein@ew.tq-group.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
References: <20241030091336.3901440-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241030091336.3901440-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KtNuXtD3fPz5cu76LoF89EA6xDMNunokgaZ6dxY+UMLrbQLZ/L/
 7N9suW9ppmK9Zm8uZ6NijM1whQQaDaRdB7PC7nburWSBlBHBNFnV9+oNGX+4ZFgnMiZFYYu
 qPLXTVz49b2/QWHISmoLQTaMjF00p30Kwy/dXexWdJeIInSDXsb8OvS0KhwGamLYdJFlNs7
 kCAAWw1kWlhtBp1yiqZOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6TszQDnBRpY=;knUkfFbO2LY6ibsEehq168459ty
 1lvxyAzWl/Lzcwkh34iAwkYmCo+tfPG8w5W4EWKxJocWIwVg+htgqXxtIEqeAhA6Gh1BVfnLU
 Wj3KgafF1fgzTqWbaAEPHaIVsdUIO62R4x59swDjElZAtCdQfA0h9oV1pk/tkkluEPBF4tFNV
 L1jPH+QSXLyaA9IUMs9V1Le4ThSmgLxnqPC56CcDMLvsyxIhuPhK+sW8RJqZSJckSd3r84nvg
 D87UIaPulahAaytmo8IpLFSIg+PlxJqNlDHGFs/Rah3z2Heh1DnJOrDTfQJqj7faHMiMF3EcL
 hYef1AL6L4PL+N3/x4J6Pe9JWOWV0LmUEqV+WNuwN5p2Ph+rNBQGCAx6MWRAaAn0ZX/vqEAVP
 Wh3qgvbH++OvgcObH0Relp27RtzdT/sK1pKnZHKznT2UEybzl3fai3+TOKCbRPqoklBtnnS5i
 cnxOJIdggqAO94wBWHuFT7zJjzP3lT3QLGbt//Ccmnbbc9iZOV+BJeT55BkHSXrdlWqXQjRa8
 tWsggbV65ajBef1QROqnYURvfvd1Lkn1xW8dTswbX5Q3bwjpvEs6wL1zJKARrMnTP8Mb5I/bf
 OqBjnSLcAcdSjOydQy2XzU2qW+90h15ZnLf77akmUyC2zI2buOLWwi9zh6wFDT2yAa3aT0xzv
 5HVHpchTh7ydUHqP51+L9d8hXBVKtKPu+LjzJtgFoCAWFGd5uV3x9Pu6PWqE6IZ4Yb6+N+ko8
 U84WrsxjCXmR0bgwPi5+307zXJeaM/IDHZspQxCtQ6fisAvfifYR9RRdMlCX6cIngdQDdCUkm
 /0hErBHyM8lXimoRkRi/QI9A==

Am 30.10.24 um 10:13 schrieb alice.guo@oss.nxp.com:
> From: "alice.guo" <alice.guo@nxp.com>
>
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
>
> Signed-off-by: alice.guo <alice.guo@nxp.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

