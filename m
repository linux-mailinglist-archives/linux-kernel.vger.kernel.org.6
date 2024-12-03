Return-Path: <linux-kernel+bounces-429355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95879E1AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF5C161207
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E31E3DD7;
	Tue,  3 Dec 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="MghAKHW3"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7941E377C;
	Tue,  3 Dec 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225281; cv=none; b=ayHoSKSOdF90x5hCLp+5zR40ePVfOT7yekS3o+Q1odoyfNB29vfGrHkZ766uymptw841fJliB4L59jk2eDsIIas95PgndScsQsqbAqRwMGuM5v6i//KbsLDZNodrFxKzxnRergtJA8xMufy8YAT496D8N40hU5xFKjN3mMOTQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225281; c=relaxed/simple;
	bh=6EksJKsiFap2QxBKxXjcDmN2lrztw2qKQd4n1fiu6jY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=M5M/NNyrb2umZD8e4Pu0dSHllcT4FitTmufimFMEyn6wFFoqBpu8w+0R+JNv9v/rbGjX3mXEj+Gn8VvcKwMjJZAOxHbN/gPGxoG+C0ZX4KYleI1tjg3WN7xstz8G714M+H+N3gcXS8Oud7mU3qDTXs25UrfErmUpcPoxDmvOPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=MghAKHW3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1733225263; x=1733830063; i=frank-w@public-files.de;
	bh=6EksJKsiFap2QxBKxXjcDmN2lrztw2qKQd4n1fiu6jY=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MghAKHW3tGo3q1BZ1EJmoPMg49P7Z0L2vjqz6dxxUZtI7ECXb8emWq4O1EjE8jqr
	 E/eliHzzVLtGZPfVuMPZD4p2ESIzVXMkIcamTnBpJepFuI+c4RbWJhCF4keHABUZW
	 /M8uvMX/Mnp7v6rCDl7hZBM1Rnmdg0Kg+aG/8/JDHdOff/Yadu9P5Sv07wDutnpGU
	 zupkDPUtdod3HO8AvDht2lG2yrWCGNhFj7iFSOoFngfINIFNGQZuHScqINtJuohqW
	 EMk0p41umeNnTda/Y28iWU0p7ebIQaB0JA3GQgc0NmxfJrvXF76V8WCngn1+ij34S
	 TpmzNVBx3QQtI9IY0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([157.180.225.184]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1tKdzb2nYe-00GWEb; Tue, 03
 Dec 2024 12:27:43 +0100
Date: Tue, 03 Dec 2024 12:27:44 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_10/18=5D_arm64=3A_dts=3A_medi?=
 =?US-ASCII?Q?atek=3A_mt7988=3A_enable_serial0_on_bpi-r4?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <32ef5ab8-a163-4fdc-8603-f5a6f0e8526b@collabora.com>
References: <20241202122602.30734-1-linux@fw-web.de> <20241202122602.30734-11-linux@fw-web.de> <32ef5ab8-a163-4fdc-8603-f5a6f0e8526b@collabora.com>
Message-ID: <6964E096-7C19-450C-8434-6A4456AFDD55@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:57lEu0aG68DMEdRIB/12vTePmSzW9S/G1BLtkgiWRJiGOaxcL1j
 mXamHQS2kjK/noArOfrZdXJ8gi1Y1UN6tTJZ9+Yrs81g6WsbuDbJzEKA+38N55DXgvJlnMP
 RWK4zRQ/oDJe1IGzQJK5mI9AYNMu+IOh81wcvRRx/hmrMWrYvyTkJ/rISm03YlecwS/Xckt
 YcEoycEa66TqpIXk0u37w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E8EYYPqHydc=;nvTjlJIsURMO4XRpjsbj4spcZSZ
 6aKYfgpHwRJZhthvA+rHt3WH16+wn+3YCIY5RWp31BEfUVChPy/fpZS/5rZzRiKLc9eyrvWK3
 gqv83dfnkmujiRe7+cCb+5w+I8lAbLJpC50qfIMHE3mg0zBw2WafQccoHKnuXcldlqizoL8n+
 0y6qU34JEqIFl8p1sEc0R9xo8+kmrDU8sV1AVutZ9/tNNuK6h857NLv/49eGnIkn5W78/kqS9
 I8Qrmzp7rYaY4b/MkF3+NUqtHOLJab43Yk5hUWku+KglqprqeysNjAX5JmlPL/mKjZT1b4Sjf
 KSNQhp80NI2MgkZsI6scluo2+NiOPniWP2mgHIV/CQcMqYTvTVg9mHu0qqUii0pNF6y7LV6T4
 kuPgMUTGD9KXrmQGR+OhPqtMsQl+9GVey7OIHWpVvGj3i8uWaldmtN1RnWECuU+sUyZoqYBp5
 34ZlMqSrIpOYNQnOwebGGDuD7tJjYrY5cVN9+Ho9l18oeY02324fGRXNQrgDay2nPrN6+gLOE
 /HztMBRGras8oozXAoP9hHq6qHmJjOl2K2CR9KsJCA5Hp81v83ICqo9NunfPKsyrXsaFyjH66
 +ybqG7hF3fUWMYO+QpziYt9XusYwuGaw28RKTunVOnJm8++XnL2MrouywJaKhyT/FcYqS5wMm
 GUlMyH6uItv6C30mhHxEjaG2jqTVPibVMImuOXFTHPWNm5kf2DnnwAmZM+fp/jH+5uk682vsD
 ARnf0D5miy7oS7R6mIK0/iV1imuTMuJ1gQYJ0sKR2MwVyFsy/7Ue6RsmPEbJwyJh5I+VZtg1J
 lkKPg9GRCLtLXURSgFfCFuFlkX9qD27JfNb/l8M79MeAV4cJPCNZ6rzc/YYESNUIzjWj6P6kd
 ynIg3Rc9igaUW2Vgmgw+2GLzSsxR5nSEfX360qrtsFZI4WGyYB+8jJVL1XMf+/DFcQbKDnES+
 Z2/yAs01PD4ChRZNq2J/b9MvCuGVNd5bIEbi4G5PupEl2EVk9ANwrpnhu7SerUwqp2wr/g+Wu
 HPqmWXizD2ZDQC17Fc+UskAqmY7X8dhFgQHiCF0MCVd4oaHhKGXQUO3ycj27RRSrV1OJIWmmN
 ytJd4CWokyOxhJuCif12bfv39sK+PO

Am 3=2E Dezember 2024 10:40:45 MEZ schrieb AngeloGioacchino Del Regno <ange=
logioacchino=2Edelregno@collabora=2Ecom>:
>Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>
>arm64: dts: mediatek: mt7988a-bpi-r4: Enable serial0 debug uart

You want new prefix here? That will change all r4 commits,right?

>> Enable the debug uart on Bananapi R4 board=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>
>Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino=2Edelregno@coll=
abora=2Ecom>
>


regards Frank

