Return-Path: <linux-kernel+bounces-243943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C75929CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD6B21279
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B01BC46;
	Mon,  8 Jul 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xKlPAyu3"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1351CF8A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422601; cv=none; b=pfJzYvu9ip+RCmFmUDy5f1jtQIxCsuewpvat7Vc+ZPjjU+6VaigFKUVaNhW0UA5FCqqn0JtcUR5yJS5OpTGz5wlfnH1IklCU2MLGqqj77ILmHBmoWJck40ggnG3eYjgcFr/PTdEaJC/vR4zoN8K18KmSs56Qsw3gg79UIjjFgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422601; c=relaxed/simple;
	bh=A9PTwI8YT5pVoNb3VF0TqdJ6oNcLPEppXqMXpIJsPU8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QtJ2bWSN5BS+B6uheoDJAv8+qYk/jDld7m+e6ANLJJFWyjst6B0I0WxhKAHBqYJS0t7+jMlRkdPOR9POVxxPPUqkUpw54c6oPGdYrN/s0Oul5j2wOU1iYImYjUgc0n2+jxtVS5HA1H9G94gWwecCAX/cNDqdmuXqXbYzA/JMclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xKlPAyu3; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: wodemia@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720422597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz+4e8MYNxjZnBTV3vAkH7viLcR2ZQLRLOb85ovRbcE=;
	b=xKlPAyu339fdpnB1rGFob2leS14pWrvlCiMa1Tba2QpFMfpNNdS+Z+jwEaOyBC2PijSHaD
	228XRCzkOxb9tXGsyjMkjMuvGURPN01DfLJ6mRIr/bDTlAO2NwXUx9ad07wtwpAkxAyd4Z
	UyEQ5IH5WDiqgl+v4iKAZKgJKOyiyS4=
X-Envelope-To: alexs@kernel.org
X-Envelope-To: siyanteng@loongson.cn
X-Envelope-To: corbet@lwn.net
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 08 Jul 2024 07:09:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <296fd3f5f36a3d45de216029a6dcdf418d833632@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] zh_CN/admin-guide: one typo fix
To: "Tao Zou" <wodemia@linux.alibaba.com>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <siyanteng@loongson.cn>, "Jonathan Corbet" <corbet@lwn.net>
Cc: "Tao Zou" <wodemia@linux.alibaba.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240705022842.51451-1-wodemia@linux.alibaba.com>
References: <20240705022842.51451-1-wodemia@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B47=E6=9C=885=E6=97=A5 10:28, "Tao Zou" <wodemia@linux.alibaba=
.com> =E5=86=99=E5=88=B0:



>=20
>=20Fix one chinese typo error.
>=20
>=20Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thanks,
Yanteng
>=20
>=20---
>=20
>=20The previous translation patch v4 has already been appied, and the ch=
anges from v4 to v5 were missed.
>=20
>=20This patch is one typofix, and includes the changes from v4 to v5.
>=20
>=20=20
>=20
>  Documentation/translations/zh_CN/admin-guide/numastat.rst | 2 +-
>=20
>=20 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rs=
t b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>=20
>=20index c0f54d9a6b05..4d9817b91870 100644
>=20
>=20--- a/Documentation/translations/zh_CN/admin-guide/numastat.rst
>=20
>=20+++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>=20
>=20@@ -13,7 +13,7 @@ Numa=E7=AD=96=E7=95=A5=E5=91=BD=E4=B8=AD/=E6=9C=AA=
=E5=91=BD=E4=B8=AD=E7=BB=9F=E8=AE=A1
>=20
>=20=20
>=20
>  =E6=89=80=E6=9C=89=E6=95=B0=E6=8D=AE=E7=9A=84=E5=8D=95=E4=BD=8D=E9=83=
=BD=E6=98=AF=E9=A1=B5=E9=9D=A2=E3=80=82=E5=B7=A8=E9=A1=B5=E6=9C=89=E7=8B=
=AC=E7=AB=8B=E7=9A=84=E8=AE=A1=E6=95=B0=E5=99=A8=E3=80=82
>=20
>=20=20
>=20
> -numa_hit=E3=80=81numa_miss=E5=92=8Cnuma_foreign=E8=AE=A1=E6=95=B0=E5=
=99=A8=E5=8F=8D=E5=BA=94=E4=BA=86=E8=BF=9B=E7=A8=8B=E6=98=AF=E5=90=A6=E8=
=83=BD=E5=A4=9F=E5=9C=A8=E4=BB=96=E4=BB=AC=E5=81=8F=E5=A5=BD=E7=9A=84=E8=
=8A=82=E7=82=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E3=80=82
>=20
>=20+numa_hit=E3=80=81numa_miss=E5=92=8Cnuma_foreign=E8=AE=A1=E6=95=B0=E5=
=99=A8=E5=8F=8D=E6=98=A0=E4=BA=86=E8=BF=9B=E7=A8=8B=E6=98=AF=E5=90=A6=E8=
=83=BD=E5=A4=9F=E5=9C=A8=E4=BB=96=E4=BB=AC=E5=81=8F=E5=A5=BD=E7=9A=84=E8=
=8A=82=E7=82=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E3=80=82
>=20
>=20 =E5=A6=82=E6=9E=9C=E8=BF=9B=E7=A8=8B=E6=88=90=E5=8A=9F=E5=9C=A8=E5=
=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=
=86=85=E5=AD=98=E5=88=99=E5=9C=A8=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=
=82=B9=E4=B8=8A=E5=A2=9E=E5=8A=A0numa_hit=E8=AE=A1=E6=95=B0=EF=BC=8C=E5=
=90=A6=E5=88=99=E5=9C=A8=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=
=B8=8A=E5=A2=9E
>=20
>=20 =E5=8A=A0numa_foreign=E8=AE=A1=E6=95=B0=E5=90=8C=E6=97=B6=E5=9C=A8=
=E5=AE=9E=E9=99=85=E5=86=85=E5=AD=98=E5=88=86=E9=85=8D=E7=9A=84=E8=8A=82=
=E7=82=B9=E4=B8=8A=E5=A2=9E=E5=8A=A0numa_miss=E8=AE=A1=E6=95=B0=E3=80=82
>=20
>=20=20
>=20
> --=20
>=20
> 2.39.3 (Apple Git-146)
>

