Return-Path: <linux-kernel+bounces-237516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74536923A24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF870B218D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372F15746E;
	Tue,  2 Jul 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="oiNMnWSk"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE615572D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912689; cv=none; b=GyVaiEfsf4Laa9QDMOUche36soh2keNbzrn1e9o9j5a2M2xtsqovhCaEPxMMVZigDkNDglZaB0jeYr9zysAbzPK10hzLOi3LnN1EkbUn4paPOQBQKX8fYqDiSKtStcNqbFe3dawJrv2qD0x5TlVYBo9Afk6RGyr+sn1G8boIcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912689; c=relaxed/simple;
	bh=1urb7h4FdGSXSqsQXFG2kiMZ8nreKlLBoVe7Io1ozMQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kfcon3AXUTscEXKmAi4azqcb8mehnBakwjor/JqAmL13OF7BsS4BSvHhdQc3S15WO66ORVCm1i13HTZFvmAm2PNxq53fvqlmYuS8KnF92I5Sy5ZBVXz/3cQeVJ00xVYyI3EZ/YlBV/4PtKiJShnNMFqiht4VJC/vLEpfXekuKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=oiNMnWSk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719912680; x=1720517480; i=aros@gmx.com;
	bh=1urb7h4FdGSXSqsQXFG2kiMZ8nreKlLBoVe7Io1ozMQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oiNMnWSkylICMfCnO9ANFtxCS9DTfowpxWa9YKQX06Wz0hZG+HehpMRoMx4b8Gve
	 +3b5y6ZAbEf66w8lzjj0/LneWuukmvJz+KMBhdTmrXyBHWUe9uPC9pTHZIOUDhRM3
	 bvOyVhfhPcetbixwroIEjANr9UvmTz1VUZgNJOaJQK+SB3uoWNVlX6UDoPR785OIZ
	 IvPlsB0CCKYqRQ1e+0YoEYx2K1y+fyE3ozQpzRMbIHQw4RbQi+xp4z69lWDck88DE
	 KYX5mzdt+hHiaVv49G8PwJcDpn29cHlB1tLNHG6dDYg/7Fgiccl7FikIx9vFSXkil
	 g5XITKmMqBAninq4Wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.21.110.28] ([98.159.234.63]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1sXy2g0yc2-00CcTU; Tue, 02
 Jul 2024 11:31:20 +0200
Message-ID: <39b02e72-201a-4f3a-9473-31895aaccbb8@gmx.com>
Date: Tue, 2 Jul 2024 09:31:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Kernel modules compression handling
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rglf0ZdaFM8BeynGTR0t9xdCukryChvUDKF7JFoieqopinX0CVC
 14JHL8pHx0vOe2KhmmQJo6oXS3SS7jfH/KZ1mAqETsTbo5PxPHHlFaOo7Cvpnl+sqSdQSF+
 RPx/4evBjzf6DmtrDo+eAhublFfYUc2nkz5WxkKiAm1c4z0RRsqp4I0ULApCi/tTAYTMZq1
 +Zfi+astFNZegWy91EubA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1sCEyp4Nftk=;imcPJMPu1DF4vd3Ehovy2DU9SgD
 wnSegKSQDQjSHj7nYglqJ2D6URSF0+QD2Q04SLBeb5L00rR0s+e3CjImnxvslwa5twhFQ4qdE
 PmwVm0SCdPJVkJyNfbKasG1kCl9LWRsd2RSjCS4Tcc9p66+g0oyOb35QYBYezicx6/9aBueVr
 G1ptR7rrNo7mMhZceo9louUPbB5ukbczVI7on3Gve275nerTQjI/iwTwmF/5umyPYHjhi2Ipe
 xgqj5H/+yR6QQKTlfbBrrI6t/qmPFPvB6LxAdW2MXylelkabr/2w8QYrhWG7j4QGYPe3jGSJs
 cdgjmdJ9wsNnvNP2WlXq7b69jxbEvA5GxdsK/vLYan5Fuwe6LPeETily3hLS8L+qWT2F0rveQ
 M8d9KmB7GqAa2qiLpbGYKtO4VaZZ2snyO7VrW+DGLdliRO2s8oKC8gVogNaP//mI2FB8h0BOs
 jvkfsVL/7ikeVpEsC0IuogPhlJugHaP0L0YZKbYa2lQX0d0LUOoOxkJpbAnjRDMHfvBfVsSMX
 3/l8LzE+QQl6EG/No//b76HLyrmKSpSOs3qzZ8LIxaqox6xeVttUKkRrsPhJp3YVaaLi8zLaU
 0fkrbCf7IDp7mmU3LD5I+K2lbnZG4IiIvAflKlx58Pmdl17L1aAjjwTxv+FyG7mZA1zSEafTT
 XRO7YLQk10TO7gIRI9SZbNDZG6GJYt5o27n9KWXXx/NorFdBjDqiVw0IfuRlm74l4GO4E4Fa1
 btJOQ2WZo+LGtpyt4nDlycPCvPM6kxzgN6vdzgGBf76GTjHDNt4NhhT6nFW5CAnqHXWSHrPhB
 ndn57DNloAT//YTVRBmUSx8e7W+rXtNWTZJUCelnylE80=

Hello,

Please correct me if I'm wrong but it looks like the way modules
installation is currently handled in the Linux kernel, first .ko files
are copied to the destination directory and then the chosen compressor
is executed on top of them.

I wonder if this could be changed such a way, so that the installation
script (Makefile?) applied compression on the fly without again copying
.ko files.

All the three compressors supported by the Linux kernel support piping,
so it shouldn't be an issue. I'd love to write a patch myself but I'm
probably too stupid for that.


Best regards,
Artem

