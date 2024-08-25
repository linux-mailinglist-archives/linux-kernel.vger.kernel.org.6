Return-Path: <linux-kernel+bounces-300491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8195E45C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918FF1F21529
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD33156F3C;
	Sun, 25 Aug 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bIcu0xoK"
Received: from st43p00im-zteg10073501.me.com (st43p00im-zteg10073501.me.com [17.58.63.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED11CD31
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724603345; cv=none; b=hgiPsairX2qK/6K92NXqUBn30VIC7oDCMJxPQusmtI07Td1G7usHrqt9eHehCADl910LiQtLXgArya1+LIogogKaRBwZNwCaPclteXGYHUmPmjQ2T+qLOq8jVIXYXPkVneS+XvdSF3KuiS7ag1eVg4hYnImv7JlOl6HOXrjH3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724603345; c=relaxed/simple;
	bh=cRiXtW/W7gEva1QfbYQHGlyzfhay3r2iy1AFlHyErWQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tuWAgzbgrbE7AjsIGsZe2ZbnG/6LS7LWa2vVnrtDGwgD2XxL9r2n9YHUYBQduP0expgI/u73VHYzx/HARWBGvwrH4eI2zOHPC5gZ0hCZssxxMN7rOxOr1SB4GHdfS9H/xKC8t6o5KLjSYlNKJ0rbiQWB5uFWMjx/DRNqEQ2yN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bIcu0xoK; arc=none smtp.client-ip=17.58.63.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724603342;
	bh=AzCw5QLZ7l/p6PS7v0oPCA4fX7Xj2R9lRNnxbx1J4Gs=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=bIcu0xoKDJkmgJLCJfjo9cDbmmaAB1TI7g8b2fY+oBRBHoTwopJxn/t2mCCYp3YkJ
	 XeOp/o/r4WyfNWf01VdC6kdARg/+mNrJ9ula1OAM4bXCbrkpm7Qw+y3wLQlm5aNl3q
	 KZdX/Jnte0M9fck9GclPEBsQfLUH2VbnlkZH7F88cpL+gkrcHzRtVFaFAbduKfdhGS
	 MCpPwH4T2nOcoezIlWsbu+4A1WXe9Djf4khyUgOhPnn1oz26zWJEhnykX6OvOzSgEV
	 30x1daNHpfw7trTWzyBFiIwQjgZTevuIyxOcOCR++4mVZKY2bjZknNddpNF5kdxFHw
	 do1wYaxH0cA+A==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10073501.me.com (Postfix) with ESMTPSA id CCBE8A005BE;
	Sun, 25 Aug 2024 16:28:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3 0/3] Add DTS for NanoPi R2S Plus
From: m.plak@icloud.com
In-Reply-To: <20240814170048.23816-1-jin@mediatomb.cc>
Date: Sun, 25 Aug 2024 18:28:44 +0200
Cc: robh@kernel.org,
 krzk+dt@kernel.org,
 conor+dt@kernel.org,
 heiko@sntech.de,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 cnsztl@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <39753BDF-DC8C-4AA7-8BBC-621324BF75F3@icloud.com>
References: <20240814170048.23816-1-jin@mediatomb.cc>
To: Sergey Bostandzhyan <jin@mediatomb.cc>
X-Mailer: Apple Mail (2.3776.700.51)
X-Proofpoint-ORIG-GUID: CwCDHv_4b7D2xsJVEH-ta0ZwFMvgEuRa
X-Proofpoint-GUID: CwCDHv_4b7D2xsJVEH-ta0ZwFMvgEuRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_13,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408250132

Hello Sergey,

On 14 Aug 2024, at 19:00, Sergey Bostandzhyan <jin@mediatomb.cc> wrote:
> here is version 3 of the NanoPi R2S Plus patchset.


Thanks! I was just experimenting with a patch for that board.


eMMC:

A close cousin of that board, the NanoPi R2C Plus, similarly adds eMMC =
to=20
its base version, R2C.

R2C Plus is already supported by rk3328-nanopi-r2c-plus.dts.

The r2c-plus DTS file differs slightly from your patch.
Would it not be better to use the same fragment for both r2s-plus and =
r2c-plus?=20
Or even place the eMMC activation in a shared dtsi file?


I=E2=80=99ve compared the two and the friendlyelec kernel (not u-boot) =
sources.
 your patch does not contain these lines from r2c-plus:
    vmmc-supply =3D <&vcc_io_33>;
    vqmmc-supply =3D <&vcc18_emmc>;
    mmc-ddr-1_8v;

your patch adds these lines that are not in r2c-plus:
    supports-emmc;
    disable-wp;
    num-slots =3D <1>;

r2c-plus has a line that is in rk3328.dtsi already:
    max-frequency =3D <150000000>;=20

the friendlyelec kernel sources also add:
    no-sd;


=46rom the description in the mmc-controller binding documentation, I =
believe
disable-wp should not be used. The description for no-sd  I find =
confusing.
Can't find num-slots and supports-emmc there.

The RK3288 datasheet does not mention support for DDR mode, so =
mmc-ddr-1_8v=20
surprises me a bit. The datasheet does explicitly mention that HS400 is =
_not_=20
supported.


USB:

Another change with the Plus version of the R2S is that the USB 2.0 port =
that=20
used to be wired to the ethernet chip now is used for an external USB =
port.=20
I don=E2=80=99t have the hardware here (yet), so can't test if that USB =
2.0 and the=20
USB 3.0 work independently or need to be explicitly separated.


refs:
Documentation/devicetree/bindings/mmc/mmc-controller.yaml


