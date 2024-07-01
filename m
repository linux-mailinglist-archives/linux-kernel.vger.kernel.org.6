Return-Path: <linux-kernel+bounces-235689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AFC91D875
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AF71C21C91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A6858ABC;
	Mon,  1 Jul 2024 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="A1U6ZGQ/"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585729AB;
	Mon,  1 Jul 2024 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817344; cv=none; b=KzYTGOTEUVRGFBClxJFlcTUmbhrKQ7WL1TjTlt8e4F033SZfniHZUo+31z8Zkgw9J6+bjOJxTC+vJ7PlGu7X96AgP9yOMh2U7o2lgGH6trBzM6mjywEk3DFUdWIQOkrrclJ4cw9LlNhFnNde6jWpJ4BxARWNSI5pdUV8jebGlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817344; c=relaxed/simple;
	bh=7yktUN/gStqRPZN7+y3ofWazn0UWTgeoET7Zwx12TTg=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=DZ6MOEQt1VMVjWz64i2RQ4bpq1qzhjPxv60wIKZOyTCV96szIkZHFSesh656R+5ZvMdeUF2RrjcG2n0ozST58DKhJOxs4hRWUByMbXZrEpd7pFSpNbUeW/MC7wAiC123Na8R7vS44aHPoeFjqf3neM7VcubBDZRaIm5clygUDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=A1U6ZGQ/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1719817320; x=1720422120; i=frank-w@public-files.de;
	bh=7yktUN/gStqRPZN7+y3ofWazn0UWTgeoET7Zwx12TTg=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A1U6ZGQ//VDcVnLCnj99gRSn1/RH0ykxvaX4PgnWzoAQJ9TUXeFCTMPtEREF3cpC
	 l2IUXgVxGDUuEFo4XO763sQXZKAEBlrolIM+JbSl2vk/HWDawRJaGwqT2BcaW4tvB
	 chbOTy4f8kppxOR04f+EfAHh283jRbzl0ktT6gTU7TCP4uTY3lk7XhzketFFdbcmb
	 VLhgRWGi1J0P2dzvJgubyMEaYQ2tHsGXAlLywlUFSiZUPrNvDKhDDQzWDPRDGqqNN
	 UWFi8jVqGpEuaIP+p2Gj1oqps4sv5kC6cHf6K0ysJf5+v0d/dNxy1pRbX8O0YXAhE
	 F6yc13/VTRfl7y1MSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.41] ([217.61.148.41]) by web-mail.gmx.net
 (3c-app-gmx-bap25.server.lan [172.19.172.95]) (via HTTP); Mon, 1 Jul 2024
 09:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-4bc16904-d2f8-4932-8ec9-2973560f1dde-1719817320042@3c-app-gmx-bap25>
From: Frank Wunderlich <frank-w@public-files.de>
To: regressions@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Jakub Kicinski
 <kuba@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 Frank Wunderlich <linux@fw-web.de>, =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=
 <arinc.unal@arinc9.com>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Subject: Aw: Re: [PATCH] arm64: dts: mt7622: fix switch probe on
 bananapi-r64
Content-Type: text/plain; charset=UTF-8
Date: Mon, 1 Jul 2024 09:02:00 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
References: <20240516204847.171029-1-linux@fw-web.de>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
 <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
 <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
 <e92c3ca0-c9be-44ac-a4fc-57ca5ebedbc5@leemhuis.info>
 <1807a142-1534-4fa4-ad4b-d1c03af014c2@arinc9.com>
 <58d8ddea-71cc-427a-94cc-a95f6bce61d2@collabora.com>
 <16e9c06e-9908-455d-a387-614fefe5bcf8@arinc9.com>
 <5e87d31c-b059-4f9a-93f7-dc87465ed14a@collabora.com>
 <4416ef22-78cc-4ce5-b61d-69ff0903811e@arinc9.com>
 <bd6b6929-d34d-4bd5-9cb0-bc8fe850ee46@leemhuis.info>
 <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
 <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
 <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:iSzNiwwEGm+X9Sk/waPaMhv+3missYA8VAXRSbGHCV+HKBSTSrTEZxICirIavHnwicFi9
 2srm4ZrjCYSwJ1GlRhIvaheYakXtMAyZRQ2H7TXkUrFo2gDZ1vGImR9OQUSUqjTrzHaZpfFtlcyX
 qCFHGcVuA9dNudxieUc08D5y02DNqdADfpT2+y0BqeascmO1QbZSDhed5WvfIMYguEvqwW3rxCys
 wsKoON+aZlWXBRR926oMZQT7S9jj6ti+qsgQU+wrxYSPGL4lSymwuT4Hsr5cGnXQT8kyse1wY6kh
 W0=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TFqw0JB/3K4=;HFFRgvoA1Z6/Iqd3nHpxa9dft/I
 JzIG7BujbzaBNJHe6yIPS+fOp1Tf6fBi5hrwRM+ldiLXXK6NpOnWxMUsxzm/Vn4TL/4d9NrPN
 Li62NNQz3UYCSmsDwN6apWd7AROrSW3KOcqNwFcXqbZgrfqLnoSPADq6ha7PnsNfjnHbyD8ef
 D9qSlIzE4GKDTqJzQCsTwRxACO0FX1O5NMrTQ1NYlGEpYODBr/Ah2o/UGQGn1IXV+IObXJ6Ru
 h+mpqfBRH0O/RUEdMGukKfst435YgjuR2OkwgGuf6FX+ABCXtsmUQEju4wEHUCEnNxvv617ei
 qdR3WCdcJHrvCRUte02QMiOip0563rfBUR6VmTq5LVB8mr2Krhrd5j3qA1NJ7M6ToSDTxgrCJ
 Fwqfp+/nckb2HfyJXc1ajs2xOdfn4GvXsomUd24z7o9iT7AjcBOW34zx8r+8uwU7NzCkRDfXr
 Y976xfry+f24JhklN/mvDwElK3QgfHx3r6q7zoRK1VV6ggbFdYiDDLzyS/IJDbWFyg6itVnui
 U3o3KjF5oWi0TSGICHtMil/jixrS6/2qMcM0T4eXm/kb1qNwMbjQfP4+yc5cyiICiBWRk5trt
 NFcWrTc1aL9M+i8ycJe+sONMDaUGFMS8r1fDBZIhltL5z8joBDF+3iPGSa18hTK1tQ0mXK/b2
 +8kp9jb3a+hnmiYkinzBsCB53g3OEjbwuu2saeIwO2xCOh9ny/qhK6HnnZNa028=

Hi,

i can confirm that daniels patch pointed by arinc fixes driver for the wro=
ng devicetree on BPI-R64=2E

but there are concerns from the netdev/dsa maintainers in its current stat=
e

https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/11f5f127d035=
0e72569c36f9060b6e642dfaddbb=2E1714514208=2Egit=2Edaniel@makrotopia=2Eorg/

regards Frank


> Gesendet: Montag, 01=2E Juli 2024 um 08:16 Uhr
> Von: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhu=
is=2Einfo>
> An: "Paolo Abeni" <pabeni@redhat=2Ecom>, "David S=2E Miller" <davem@dave=
mloft=2Enet>, "AngeloGioacchino Del Regno" <angelogioacchino=2Edelregno@col=
labora=2Ecom>, "Jakub Kicinski" <kuba@kernel=2Eorg>
> Cc: devicetree@vger=2Ekernel=2Eorg, linux-kernel@vger=2Ekernel=2Eorg, li=
nux-arm-kernel@lists=2Einfradead=2Eorg, linux-mediatek@lists=2Einfradead=2E=
org, "Daniel Golle" <daniel@makrotopia=2Eorg>, frank-w@public-files=2Ede, "=
Frank Wunderlich" <linux@fw-web=2Ede>, "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=
=2Eunal@arinc9=2Ecom>, "Rob Herring" <robh@kernel=2Eorg>, "Conor Dooley" <c=
onor+dt@kernel=2Eorg>, "Krzysztof Kozlowski" <krzk+dt@kernel=2Eorg>, "Matth=
ias Brugger" <matthias=2Ebgg@gmail=2Ecom>, "Linux regressions mailing list"=
 <regressions@lists=2Elinux=2Edev>
> Betreff: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r6=
4
>
> [CCing the other net maintainers]
>=20
> On 25=2E06=2E24 10:51, AngeloGioacchino Del Regno wrote:
> > Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) ha
> > scritto:
> >> On 17=2E06=2E24 13:08, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
> >>> wrote:
> >>> [=2E=2E=2E]
> >> It looks more and more like we are stuck here (or was there progress =
and
> >> I just missed it?) while the 6=2E10 final is slowly getting closer=2E=
 Hence:
> >>
> >> AngeloGioacchino, should we ask the net maintainers to revert
> >> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch fr=
om
> >> device tree") for now to resolve this regression? Reminder, there is
> >> nothing wrong with that commit per se afaik, it just exposes a proble=
m
> >> that needs to be fixed first before it can be reapplied=2E
> >=20
> > To be clear on this: I asked for the commit to be fixed such that it
> > guarantees
> > backwards compatibility with older device trees=2E
> >=20
> > If no fix comes,
>=20
> I haven't see any since that mail, did you? If not, I think=2E=2E=2E
>=20
> > then I guess that we should ask them to revert this commit
> > until a fix is available=2E
>=20
> =2E=2E=2Eit's time to ask them for the revert to resolve this for -rc7 (=
and
> avoid a last minute revert), or what do you think?
>=20
> > I don't like this situation, either, btw=2E
>=20
> I guess none of us does=2E :-/
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking=2Eleemhuis=2Einfo/about/#tldr
> If I did something stupid, please tell me, as explained on that page=2E
>=20
> #regzbot poke
>

