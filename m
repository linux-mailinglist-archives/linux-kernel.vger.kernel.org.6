Return-Path: <linux-kernel+bounces-410382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97379CDAC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1692834C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355818C03B;
	Fri, 15 Nov 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8T4Jkgp"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB52B9B9;
	Fri, 15 Nov 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660044; cv=none; b=SG1TQ99OK4RDtp6DLQbtI/yWXoB6btF8eIazSvqJETN40qCi66c8WJKMi5lJRHVXYFeTuUdVhDmc0IvQNu5Vwx3TBMyi3yH1UjeZUI6vC3X/O/GPp3uLG1bL3aU8Icj/WHBsJH4O2jPq6FqXx8yZA22Io/NZd7FSAf5/mROzxo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660044; c=relaxed/simple;
	bh=3pxHkELdFRmY716/LLr2+noVM+cr/XuZCNRaEBsV8bk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=GXjddvJSTUsMMr3dvidkBEyYOXlXmNZBAQkTSmrs5Iq/aKto1lM5eMcL0UjQqS/GN6B6CSnsRUgxTop4BOV2qOPTAqLUoaJo0MEqNhTwGOiShXQXuIa6nVTwW4FYEIP+8cZJViO8Wop0SiA0TAPp96R+oqePjmUM6dJTwz6+gyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D8T4Jkgp; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731660040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pxHkELdFRmY716/LLr2+noVM+cr/XuZCNRaEBsV8bk=;
	b=D8T4JkgpLTv7Lv6jSYEAwoMLeWZ1nxmv8U9bU9Ss0Yn8gT/PdOfvf0PDKV2OymWPGKBEes
	4rvF+lWpRRxljc17TsbuVMkXbR+G1PItyLYWavPiLOnF/qVj6KfuE+0/viDWIJkQnsgLv5
	glwCQnOpdXhrPWHrfwQ3aeClxO8NuIA=
Date: Fri, 15 Nov 2024 08:40:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: cixi.geng@linux.dev
Message-ID: <88ee4a5c504c86ef16362343eebf6b7cff8f585a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add a new compatible string for
 ums9632
To: "Wenhua Lin" <Wenhua.Lin@unisoc.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
Cc: "Orson Zhai" <orsonzhai@gmail.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Chunyan Zhang" <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, "wenhua lin" <wenhua.lin1994@gmail.com>,
 "Wenhua Lin" <Wenhua.Lin@unisoc.com>, "Xiongpeng Wu"
 <xiongpeng.wu@unisoc.com>, "Zhaochen Su" <Zhaochen.Su@unisoc.com>,
 "Zhirong Qiu" <Zhirong.Qiu@unisoc.com>
In-Reply-To: <20241113110516.2166328-3-Wenhua.Lin@unisoc.com>
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
 <20241113110516.2166328-3-Wenhua.Lin@unisoc.com>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B411=E6=9C=8813=E6=97=A5 19:05, "Wenhua Lin" <Wenhua.Lin@uniso=
c.com> =E5=86=99=E5=88=B0:



>=20
>=20The UMS9632 uses the SC9632 serial device.
>=20
>=20Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>=20
>=20---
>=20
>=20 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
>=20
>=20 1 file changed, 1 insertion(+)
>=20
>=20diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml =
b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
>=20
>=20index f4dbb6dc2b6e..a2a5056eba04 100644
>=20
>=20--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
>=20
>=20+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
>=20
>=20@@ -17,6 +17,7 @@ properties:
>=20
>=20 oneOf:
>=20
>=20 - items:
>=20
>=20 - enum:
>=20
>=20+ - sprd,sc9632-uart
>=20
>=20 - sprd,sc9860-uart
>=20
>=20 - sprd,sc9863a-uart
>=20
>=20 - sprd,ums512-uart
>=20
>=20--=20
>=20
> 2.34.1
>
Acked-by: Cixi Geng <cixi.geng@linux.dev>

