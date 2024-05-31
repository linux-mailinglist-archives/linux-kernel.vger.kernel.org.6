Return-Path: <linux-kernel+bounces-196339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F868D5A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073141C2161E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B37F47F;
	Fri, 31 May 2024 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Gj+DNAIS"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180728DA5;
	Fri, 31 May 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136304; cv=none; b=RlyeZkt0LHqGwYre9kMlyGLhakpsl/Uc0aFSS3Jqd5g3nYtwAdV8LFEX4Ve4BuspebCjBAFAGF0wJHkQjRSWFecWZ2UI4qowU/dyX6mWryU4Npm+T7lEu2WbgEvUmO2uESt+6A+hF4CgCEDpJAd3MqolmEgXSozwqPCMWyYq928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136304; c=relaxed/simple;
	bh=aSfkq3WZ/4OzORejoCenRhi8w/CxYkLEASE8u3Z3luc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ObiwefBawR/d2zQY60/lGk7QkizLh6ixn9NaMGY9p54d/nAznh+kq3cD1hzPk3TblvSlPDkPDBAdnMNoXtX21eerR7kYmn2hMxhrc439vtltSS+5QoXSB4jyATX0GcwwzEDnYTAHREWUR4iI6kN6R7Fzib4EKhxGTkjAKJOCGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Gj+DNAIS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1717136285; x=1717741085; i=frank-w@public-files.de;
	bh=M5mfRLGUirXavE2Xknh6+26eGUEzHe9b2mcXUF1hh+A=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gj+DNAISHKXKwohz2RKllpTRiD/LPfxyF/t9UWkK22N3yGgKePR8EYLqN0R0UYq3
	 TI+VLLaBXCIlB87TFct2cfWx2Zk169jSnWOXA6vE5v/N6ZGgwJARg99OqIPhVPYEz
	 39ntd1yvfFRvAx9Ko8lRkMf2xa9YYySi65inqlm3B//4sL3rjBrLx6FzyM92mNuZh
	 kDY38/xppiNQz6VtvjbDpjV90xxKrIPmVeinRFB2YhL4PAaNt9iTfCHnzE657g2Kt
	 nFshefUQ2emtHd9z66yv1xTTcLPSPrC1AFKTbAMhdu1lVVVSeJPLqdxO76ky7VgP1
	 mgQ39x1bhSVzN6uA7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.156.178]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1sMnUW3Tme-00B7Xk; Fri, 31
 May 2024 08:18:04 +0200
Date: Fri, 31 May 2024 08:18:02 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
User-Agent: K-9 Mail for Android
In-Reply-To: <aaaeb4b2-e57e-4d7b-b598-a664cc05b0cf@arinc9.com>
References: <20240516204847.171029-1-linux@fw-web.de> <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com> <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de> <aaaeb4b2-e57e-4d7b-b598-a664cc05b0cf@arinc9.com>
Message-ID: <81944186-AFAA-4C8F-8E55-1AF4CBD97573@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I8OEAuMAbo0jM2nJJPq4o2LrOd6sUZ8+mjxbaAH1HWLivRlEwTe
 +1ltn1L3UqoZyEs4Z44oXBk8Oj6I3mL/i32vaJLKOiy2kxJHmTzScLqU4MmuCLc/Dkx6WMU
 2HBypx73XCI2WYtJd4DiB+v5I0apqyTxfLs1OIa7UdYlTmuWmEwK7jeb2CiW/hTm+3VvtqD
 VHVgfQ2IFyNL4B8KfM4+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yhh0q80s+ZY=;uoRfJI1nTo+W2V/J0/+kfPEodHJ
 0HnAeu1kDoJAeEkF9EN/6l34Fv0cNuVmKpaGwy3gqAURQ3UrvRHG9lZZgXlSNJ5gtyjLYpZ2U
 fKaet3IMGK1IzFpm0VMUynNTs49+cTorXPtVWmCcjVFsDnJsrvKQ558DriXid/nWBhKmP39WT
 C2Nxq7ucDj3gZ+eCgkeUQlOSAuYtUsFn09aDoL656kLziS7X6Dx/uaN7CvER7/JArgPh7e4GH
 xi5Jhv4/M9xdHgGtOqbaZHYvJwUBxsNUT4NnTDCZM6eJ4R1Amh+m9grcSUR6ewVhuQt6DdSBT
 tIeR5X/ynHYN1FKqex2QUOceJem7EkZ2yb2s24s0b8NMIqM4mftEkmsfTtlNpameRONtHiI/Z
 2y7r3LJktFgbB0LhY7H7al3zjoabme9WvEY9dcLfMT20fmZGv2QygGHHRPZx6yXwGHaoikqZ1
 AoAN0x3CwrR+iyQjGONSc9a+5iJnSYnyHYZq8LxiZcNyfATahtMURQLfVCB+pdILwwBjQGE0b
 JkCq7KFq/crrq4GmD+tZHZx4IOZ35+UhPlj+GYxaTFiJUaDCmeFNOw+4tqbSHOO2ioV6SLKto
 xlKJrPVkSDDu4R+esHAFkAndBPuzJT1h0l0CWq9JtL0y+i9rvCcYy7XSfsPKUdN7yB5IIv4SD
 mf1Ae+7BGabWet0qby5NFprrUWgLT2VIaVJ26COp/tG607cfKjul0fN5epgYKcLUQrqAUpxEq
 Sn2eWBq0LUduyjg8mKDAMr+70NSXkc2ouo9ckdfU7tqIYKh8FbWh+5Iv5CvvuC6I9sAaK0gMq
 eGEElmNbrDDe1m/EfYLukqSkSq9y+sfHcJwPwIgrdtmVA=

Am 31=2E Mai 2024 08:12:06 MESZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=
=2Eunal@arinc9=2Ecom>:
>On 17/05/2024 09=2E27, Frank Wunderlich wrote:
>> Am 17=2E Mai 2024 04:17:47 MESZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL" <ar=
inc=2Eunal@arinc9=2Ecom>:
>>> On 16/05/2024 23:48, Frank Wunderlich wrote:
>>>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>>>=20
>>>> After commit 868ff5f4944a
>>>> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree"=
)
>>>> the mt7531 switch on Bananapi-R64 was not detected=2E
>>>>=20
>>>> mt7530-mdio mdio-bus:00: reset timeout
>>>> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with er=
ror -110
>>>>=20
>>>> Fix this by adding phy address in devicetree=2E
>>>>=20
>>>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>>>=20
>>> I don't like the mention of the Linux kernel driver on the patch log=
=2E What
>>> you're fixing is the incorrect description of the switch's PHY address=
 on
>>> the DTS file=2E Whether or not any driver from any project is actually
>>> reading it from the DTS file is irrelevant to this patch=2E That said,=
 I
>>> already have a patch series I've been meaning to send the next version=
 of
>>> that already addresses this=2E Please wait for that=2E
>>>=20
>>> Ar=C4=B1n=C3=A7
>>=20
>> Hi arinc,
>>=20
>>  From my PoV it is a regression in next/6=2E10 because the driver chang=
e was merged (without "broadcast" fallback) and the dts patch [1] is not=2E
>
>What is a broadcast fallback? 0x1f is just another PHY address=2E

Afaik 0x0 is some kind of broadcast address if real phy address is not kno=
wn=2E The driver change seems not allow this 0x0 adress and forces devicetr=
ee to have the real address=2E

Thats what i mean with broadcast fallback=2E Maybe the naming is wrong=2E

>Ar=C4=B1n=C3=A7

@thorsten i have not tested again,but i have not seen any further fix for =
it=2E
regards Frank

