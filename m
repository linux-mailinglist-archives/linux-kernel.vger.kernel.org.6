Return-Path: <linux-kernel+bounces-429298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE59E1B12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B91B29CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89651E32C5;
	Tue,  3 Dec 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="catE6Oo8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CB1E2610;
	Tue,  3 Dec 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223503; cv=none; b=TxCJHep9mICWqBsOWlp0TSvhxU4F/pXlLjjAdbRgTyjvSCSfn2A9WYS6MPxL0KZ0d3tqAKVlZRuBgNJ3AKh0LRUNvFTPnP7je1QQ/3fVFVpGQ+GhQFMlbywgbHtW1ZTHok73aQRqjsgDZUJ3GGkWhtos/alogQK17510Pnz4e+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223503; c=relaxed/simple;
	bh=ViWFhif/deFZuZbnJbaYJlieWHE9b1wDUanLpmlN4gs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=h4zBdGr382OA2hQ8B1nq3cru1ckrFCFi7N+u7jG2Xu5BWVcmFVBOp4jnDiRxmapNOQQqaR+CQjnu6ft8j+qlQiNyfx1lZrYtSKB/0zQmjzCIJDrI8P46hdNKwDHW93627c1UYEU369y9aKE3HQ3dqteJmmxLv8bjZ5l4dr9nkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=catE6Oo8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1733223487; x=1733828287; i=frank-w@public-files.de;
	bh=ViWFhif/deFZuZbnJbaYJlieWHE9b1wDUanLpmlN4gs=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=catE6Oo8vo76H6xateUNLsfwp9A1mxYE8wru5d7gmBXwD/wQoM3xHUHsO9Kjx4bu
	 c+G2p0YieMUzdvcxXcMRBIiO7d4AW+fICVP4HlVthGFWGf82FMxQxJ7ekE6YhrWwC
	 jf6f4E2dbhppLK3SkWXDrASN5IymeN8UqqUt2bqsjMydYiHZ12twnarjX+MVwx0e5
	 x/eHrhzhaTX6qZUa5PoZlqvxFheXi5p//DfaPfFggA5bLBolJHDqfLCHVUCXvAfPF
	 v7PhObqnw1WyC7gPtqyfxoDTl6QgPAsRdInPuZEwmcshYx69y8JLVJ5PotjAFVU3B
	 o5EOoWM1LChNVHI+4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([157.180.225.184]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1tysUC0VwV-00bTSm; Tue, 03
 Dec 2024 11:58:07 +0100
Date: Tue, 03 Dec 2024 11:58:07 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_13/18=5D_arm64=3A_dts=3A_medi?=
 =?US-ASCII?Q?atek=3A_mt7988=3A_add_i2c_to_bpi-r4_board?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <1ad355df-3f2a-4257-9374-1d125e138791@collabora.com>
References: <20241202122602.30734-1-linux@fw-web.de> <20241202122602.30734-14-linux@fw-web.de> <1ad355df-3f2a-4257-9374-1d125e138791@collabora.com>
Message-ID: <CA7E06EB-D26A-45D0-BF13-9C6B640F27A0@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVh/VT4zyLEOOLYLOzpPuxIpal1zwRBxEtQNrRChYqjhtpSmpbf
 2U6qcQfUeOBex46poaqbKi3AsAoyE3PrgU+6UobajJqfs5EeA/g67gxFWAo5Uf01+zSU8Eb
 gtypw3djq16hUoUtPI8Pvyil2HlMh1Hwc4TWp+7Ysoz/2Ijadww/0BK5wP3O6niNzJsiNpT
 5Gf7Xw8LjOXzGBhgWXZoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LV1CDWyYqq8=;r6TAGlS+V55H76U9GsrrMswN3d+
 8Xwv/2BFoCClTb58octvBihMkB4cdzns2fsZkwNByO4DV4jAUOfSzwVaLD6PSZv6oe46A9Bix
 REDnk+Y2hQHGcFYN/vYDRNlejxHv8A+8CUvTc6RGvWS608xkCCK1hYh+aUM8K+DEp442Q8orf
 VUoK2q4Wstzc8UpVPIt1epv5HYUl2sdD8w7kXQ0qbu2/z+5W1kbP6FT4Gg5D0GkLpren9Mtai
 ap7c7ZnVy3qjuPwimzre6n1sbyR75c57Ramv/ngkrjanx9kIwqzr+LnEo64+jivcBsY5iQea+
 NM/ZNRNIH3GrEG7sP/3HQHOuElw9Q99iMfyiXH75Om9OW+Xnpl9WOi8G/Rz7clUv9lcIhkiX5
 8+cUJ5kXgEmK23ufk76pZQt5qkPrGgABSzepJIYD9QgOO3qo295de3d5kOg4j+m3le66pcbzv
 M8WIeVeXb6r1kH3GyApzXTIGUb8mqI9qVDsvS2tx9vdMdFNd9biAdkAElvdRY9JDNxZikdZt6
 TykXsiCNLW92XNvYL4v7oKW43Hffndcjo8mtYCSe8tT5PxOS2AFGLhenT5FXPKQ0luRYguP6L
 dE+52dgmcLU7Qc00tHZASvL4FaYLYktWmizpZEIe/KvUP4r+DcBKuce+CT5EUXx+YHOZ8StDN
 CyXr7PMGhbqp6DJFOpsTr8aSKoP8I9EjcUAjRL0wIqoPNz1a7U0JfwomHcvy1WI7MpVkODoHi
 uYLiVrFXvWxjn7j7pq9lRJ95bGYNXG3VXVmup5gYSm0sB8pIgB2jbmBTr6rX0CfhcS7eRKhgi
 WGUTQz14iCtCZgqaWlTZcGHPQOQf6mC5beFxFHO3Hc+7CImx1aO1EDuLe0g49T6Ij/h1xGhhF
 vlfAp43zPPkngtG7wy+4XpH2jBH0vQ5fv+3dNgSgsJUXnwnkIIKDyUXFntRA5dJKD9ZDNZj1M
 2e1EFE/1PPCapEkI+za5CCiu8NAezMdonRvcX+YCKSb9fOvLljqI7Mn5Wb6d616RwiY4NHk/q
 7lihezwS9v4Tt2yYSExI494kmDgWTgXGs4JaWDtL6R6QiaSlfwNU3yz6Gat103/J6bFfKZO7G
 nIByL/MNjYpizZammHW2BNDUf57wuQ

Am 3=2E Dezember 2024 10:40:38 MEZ schrieb AngeloGioacchino Del Regno <ange=
logioacchino=2Edelregno@collabora=2Ecom>:
>Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add basic i2c nodes to bananapi R4 board=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>
>arm64: dts: mediatek: mt7988a-bpi-r4: Enable I2C controllers
>
>Enable the I2C0, I2C2 controllers found on the BananaPi R4 board; these
>controllers are accessible at =2E=2E=2E I don't know, a header on the boa=
rd?

These 2 i2c have directly connected spare devices (pmic on i2c0 and i2c-mu=
x on i2c2 added in later commits to have it a bit cleaner)=2E I2c1 is on gp=
io header which i have not added to let user choose if he wants i2c option =
or gpio=2E I can also add i2c1 to r4 board with the right pinctrl but imho =
it should be disabled to have gpio function default=2E

>After which,
>
>Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino=2Edelregno@coll=
abora=2Ecom>
>
>


regards Frank

