Return-Path: <linux-kernel+bounces-275601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99209948780
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCB21C21F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316EE320E;
	Tue,  6 Aug 2024 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wFbog/FI"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6318BEE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910868; cv=none; b=H5V3fSXXbKk5QX7CUEuZTlk6BFIEQvmQBpmZVKeLWhhTv5o5X/VTdgXVgbNQTz+GM7WNSiEd3G5QvhS+vRzwd5bUmk+U4l08ObF3/53x8rDg39702PgHkGmlXll+t/4C1tPplt1roijnQPgCXVcf+N2lWUbJh78JPPCGmDQ3kKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910868; c=relaxed/simple;
	bh=MNu5QCLbpWFDhva6rRt/gX74BkPC645qHMdB9dane+g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=K6KA0+9gS9t228WlrWAbWjESgMDfbO35nCmNiOyaF/QTaWWf59/MTsCQqRsREE+PTIx0lH2Lk8Y0CvrAL7uwb/oziRRGVv7jJzd4h9KL+WwfZZP8p5uMvfMzYvjgakmavf2G5Mwt5OPCeN51mRdrJloc7YLBLbVX+knjgnYKEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wFbog/FI; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722910863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNu5QCLbpWFDhva6rRt/gX74BkPC645qHMdB9dane+g=;
	b=wFbog/FIkNInVti6juDNfLRHuRYvGV0fmr7ciqRXLohEOxcERfIHbq/PJAhC0ccc/X5pvI
	GHn6ENYtmRKMMpT6owXf6qvAEbauQhDivSJ8A1LkniV4hfQrdmBjGUqEsiTPByRe/Wa+wK
	emiBfax/uiQ+3KzlwyhmPnZ10WWuaDI=
Date: Tue, 06 Aug 2024 02:20:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <074662fa2977a708d7a9a4545ffad26612514dc2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4] docs/zh_CN: Add dev-tools/kcsan Chinese translation
To: "Haoyang Liu" <tttturtleruss@hust.edu.cn>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <siyanteng@loongson.cn>, "Jonathan Corbet" <corbet@lwn.net>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, "Haoyang Liu"
 <tttturtleruss@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20240731180916.36617-1-tttturtleruss@hust.edu.cn>
References: <20240731180916.36617-1-tttturtleruss@hust.edu.cn>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B48=E6=9C=881=E6=97=A5 02:09, "Haoyang Liu" <tttturtleruss@hus=
t.edu.cn> =E5=86=99=E5=88=B0:



>=20
>=20Translate dev-tools/kcsan commit 31f605a308e6
>=20
>=20("kcsan, compiler_types: Introduce __data_racy type qualifier")
>=20
>=20into Chinese and add it in dev-tools/zh_CN/index.rst
>=20
>=20Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>=20
>=20---
>=20
>=20v3 -> v4: Added original English text for proper nouns and modified s=
ome unclear experessions.=20
>=20
> v2 -> v3: Revised some sentences based on reviewer's suggestions and up=
dated the KTSAN url.
>=20
>=20v1 -> v2: Added commit tag and fixed style problems according to revi=
ewer's suggestions.
>=20
>=20 .../translations/zh_CN/dev-tools/index.rst | 2 +-
>=20
>=20 .../translations/zh_CN/dev-tools/kcsan.rst | 321 ++++++++++++++++++
>=20
>=20 2 files changed, 322 insertions(+), 1 deletion(-)
>=20
>=20 create mode 100644 Documentation/translations/zh_CN/dev-tools/kcsan.=
rst
>=20
>=20diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/D=
ocumentation/translations/zh_CN/dev-tools/index.rst
>=20
>=20index c540e4a7d5db..6a8c637c0be1 100644
>=20
>=20--- a/Documentation/translations/zh_CN/dev-tools/index.rst
>=20
>=20+++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>=20
>=20@@ -21,6 +21,7 @@ Documentation/translations/zh_CN/dev-tools/testing-=
overview.rst
>=20
>=20 testing-overview
>=20
>=20 sparse
>=20
>=20 kcov
>=20
>=20+ kcsan
>=20
>=20 gcov
>=20
>=20 kasan
>=20
>=20 ubsan
>=20
>=20@@ -32,7 +33,6 @@ Todolist:
>=20
>=20 - checkpatch
>=20
>=20 - coccinelle
>=20
>=20 - kmsan
>=20
>=20- - kcsan
>=20
>=20 - kfence
>=20
>=20 - kgdb
>=20
>=20 - kselftest
>=20
>=20diff --git a/Documentation/translations/zh_CN/dev-tools/kcsan.rst b/D=
ocumentation/translations/zh_CN/dev-tools/kcsan.rst
>=20
>=20new file mode 100644
>=20
>=20index 000000000000..39fa43d8c414
>=20
>=20--- /dev/null
>=20
>=20+++ b/Documentation/translations/zh_CN/dev-tools/kcsan.rst
>=20
>=20@@ -0,0 +1,321 @@
>=20
>=20+.. SPDX-License-Identifier: GPL-2.0
>=20
>=20+
>=20
>=20+.. include:: ../disclaimer-zh_CN.rst
>=20
>=20+
>=20
>=20+:Original: Documentation/dev-tools/kcsan.rst
>=20
>=20+:Translator: =E5=88=98=E6=B5=A9=E9=98=B3 Haoyang Liu <tttturtleruss@=
hust.edu.cn>
>=20
>=20+
>=20
>=20+=E5=86=85=E6=A0=B8=E5=B9=B6=E5=8F=91=E6=B6=88=E6=AF=92=E5=89=82(KCSA=
N)
>=20
>=20+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20+
>=20
>=20+=E5=86=85=E6=A0=B8=E5=B9=B6=E5=8F=91=E6=B6=88=E6=AF=92=E5=89=82=EF=
=BC=88KCSAN=EF=BC=89=E6=98=AF=E4=B8=80=E4=B8=AA=E5=8A=A8=E6=80=81=E7=AB=
=9E=E4=BA=89=E6=A3=80=E6=B5=8B=E5=99=A8=EF=BC=8C=E4=BE=9D=E8=B5=96=E7=BC=
=96=E8=AF=91=E6=97=B6=E6=8F=92=E6=A1=A9=EF=BC=8C=E5=B9=B6=E4=B8=94=E4=BD=
=BF=E7=94=A8=E5=9F=BA=E4=BA=8E=E8=A7=82=E5=AF=9F
>=20
>=20+=E7=82=B9=E7=9A=84=E9=87=87=E6=A0=B7=E6=96=B9=E6=B3=95=E6=9D=A5=E6=
=A3=80=E6=B5=8B=E7=AB=9E=E4=BA=89=E3=80=82KCSAN =E7=9A=84=E4=B8=BB=E8=A6=
=81=E7=9B=AE=E7=9A=84=E6=98=AF=E6=A3=80=E6=B5=8B `=E6=95=B0=E6=8D=AE=E7=
=AB=9E=E4=BA=89`_=E3=80=82
>=20
>=20+
>=20
>=20+=E4=BD=BF=E7=94=A8
>=20
>=20+----
>=20
>=20+
>=20
>=20+KCSAN =E5=8F=97 GCC =E5=92=8C Clang =E6=94=AF=E6=8C=81=E3=80=82=E4=
=BD=BF=E7=94=A8 GCC =E9=9C=80=E8=A6=81=E7=89=88=E6=9C=AC 11 =E6=88=96=E6=
=9B=B4=E9=AB=98=EF=BC=8C=E4=BD=BF=E7=94=A8 Clang =E4=B9=9F=E9=9C=80=E8=A6=
=81
>=20
>=20+=E7=89=88=E6=9C=AC 11 =E6=88=96=E6=9B=B4=E9=AB=98=E3=80=82
>=20
>=20+
>=20
>=20+=E4=B8=BA=E4=BA=86=E5=90=AF=E7=94=A8 KCSAN=EF=BC=8C=E7=94=A8=E5=A6=
=82=E4=B8=8B=E5=8F=82=E6=95=B0=E9=85=8D=E7=BD=AE=E5=86=85=E6=A0=B8::
>=20
>=20+
>=20
>=20+ CONFIG_KCSAN =3D y
>=20
>=20+
>=20
>=20+KCSAN =E6=8F=90=E4=BE=9B=E4=BA=86=E5=87=A0=E4=B8=AA=E5=85=B6=E4=BB=
=96=E7=9A=84=E9=85=8D=E7=BD=AE=E9=80=89=E9=A1=B9=E6=9D=A5=E8=87=AA=E5=AE=
=9A=E4=B9=89=E8=A1=8C=E4=B8=BA=EF=BC=88=E8=A7=81 ``lib/Kconfig.kcsan`` =
=E4=B8=AD=E7=9A=84=E5=90=84=E8=87=AA=E7=9A=84
>=20
>=20+=E5=B8=AE=E5=8A=A9=E6=96=87=E6=A1=A3=E4=BB=A5=E8=8E=B7=E5=8F=96=E6=
=9B=B4=E5=A4=9A=E4=BF=A1=E6=81=AF=EF=BC=89=E3=80=82
>=20
>=20+
>=20
>=20+=E9=94=99=E8=AF=AF=E6=8A=A5=E5=91=8A
>=20
>=20+~~~~~~~~
>=20
>=20+
>=20
>=20+=E4=B8=80=E4=B8=AA=E5=85=B8=E5=9E=8B=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=
=BA=89=E7=9A=84=E6=8A=A5=E5=91=8A=E5=A6=82=E4=B8=8B=E6=89=80=E7=A4=BA::
>=20
>=20+
>=20
>=20+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20+ BUG: KCSAN: data-race in test_kernel_read / test_kernel_write
>=20
>=20+
>=20
>=20+ write to 0xffffffffc009a628 of 8 bytes by task 487 on cpu 0:
>=20
>=20+ test_kernel_write+0x1d/0x30
>=20
>=20+ access_thread+0x89/0xd0
>=20
>=20+ kthread+0x23e/0x260
>=20
>=20+ ret_from_fork+0x22/0x30
>=20
>=20+
>=20
>=20+ read to 0xffffffffc009a628 of 8 bytes by task 488 on cpu 6:
>=20
>=20+ test_kernel_read+0x10/0x20
>=20
>=20+ access_thread+0x89/0xd0
>=20
>=20+ kthread+0x23e/0x260
>=20
>=20+ ret_from_fork+0x22/0x30
>=20
>=20+
>=20
>=20+ value changed: 0x00000000000009a6 -> 0x00000000000009b2
>=20
>=20+
>=20
>=20+ Reported by Kernel Concurrency Sanitizer on:
>=20
>=20+ CPU: 6 PID: 488 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>=20
>=20+ Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-=
2 04/01/2014
>=20
>=20+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20+
>=20
>=20+=E6=8A=A5=E5=91=8A=E7=9A=84=E5=A4=B4=E9=83=A8=E6=8F=90=E4=BE=9B=E4=
=BA=86=E4=B8=80=E4=B8=AA=E5=85=B3=E4=BA=8E=E7=AB=9E=E4=BA=89=E4=B8=AD=E6=
=B6=89=E5=8F=8A=E5=88=B0=E7=9A=84=E5=87=BD=E6=95=B0=E7=9A=84=E7=AE=80=E7=
=9F=AD=E6=80=BB=E7=BB=93=E3=80=82=E9=9A=8F=E5=90=8E=E6=98=AF=E7=AB=9E=E4=
=BA=89=E4=B8=AD=E7=9A=84=E4=B8=A4=E4=B8=AA=E7=BA=BF=E7=A8=8B=E7=9A=84
>=20
>=20+=E8=AE=BF=E9=97=AE=E7=B1=BB=E5=9E=8B=E5=92=8C=E5=A0=86=E6=A0=88=E4=
=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C KCSAN =E5=8F=91=E7=8E=B0=E4=BA=
=86=E4=B8=80=E4=B8=AA=E5=80=BC=E7=9A=84=E5=8F=98=E5=8C=96=EF=BC=8C=E9=82=
=A3=E4=B9=88=E9=82=A3=E4=B8=AA=E5=80=BC=E7=9A=84=E6=97=A7=E5=80=BC=E5=92=
=8C=E6=96=B0=E5=80=BC=E4=BC=9A=E5=9C=A8
>=20
>=20+=E2=80=9Cvalue changed=E2=80=9D=E8=BF=99=E4=B8=80=E8=A1=8C=E5=8D=95=
=E7=8B=AC=E6=98=BE=E7=A4=BA=E3=80=82
>=20
>=20+
>=20
>=20+=E5=8F=A6=E4=B8=80=E4=B8=AA=E4=B8=8D=E5=A4=AA=E5=B8=B8=E8=A7=81=E7=
=9A=84=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E7=B1=BB=E5=9E=8B=E7=9A=84=E6=
=8A=A5=E5=91=8A=E5=A6=82=E4=B8=8B=E6=89=80=E7=A4=BA::
>=20
>=20+
>=20
>=20+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20+ BUG: KCSAN: data-race in test_kernel_rmw_array+0x71/0xd0
>=20
>=20+
>=20
>=20+ race at unknown origin, with read to 0xffffffffc009bdb0 of 8 bytes =
by task 515 on cpu 2:
>=20
>=20+ test_kernel_rmw_array+0x71/0xd0
>=20
>=20+ access_thread+0x89/0xd0
>=20
>=20+ kthread+0x23e/0x260
>=20
>=20+ ret_from_fork+0x22/0x30
>=20
>=20+
>=20
>=20+ value changed: 0x0000000000002328 -> 0x0000000000002329
>=20
>=20+
>=20
>=20+ Reported by Kernel Concurrency Sanitizer on:
>=20
>=20+ CPU: 2 PID: 515 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>=20
>=20+ Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-=
2 04/01/2014
>=20
>=20+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20+
>=20
>=20+=E8=BF=99=E4=B8=AA=E6=8A=A5=E5=91=8A=E6=98=AF=E5=BD=93=E5=8F=A6=E4=
=B8=80=E4=B8=AA=E7=AB=9E=E4=BA=89=E7=BA=BF=E7=A8=8B=E4=B8=8D=E5=8F=AF=E8=
=83=BD=E8=A2=AB=E5=8F=91=E7=8E=B0=EF=BC=8C=E4=BD=86=E6=98=AF=E5=8F=AF=E4=
=BB=A5=E4=BB=8E=E8=A7=82=E6=B5=8B=E7=9A=84=E5=86=85=E5=AD=98=E5=9C=B0=E5=
=9D=80=E7=9A=84=E5=80=BC=E6=94=B9=E5=8F=98=E8=80=8C=E6=8E=A8=E6=96=AD
>=20
>=20+=E5=87=BA=E6=9D=A5=E7=9A=84=E6=97=B6=E5=80=99=E7=94=9F=E6=88=90=E7=
=9A=84=E3=80=82=E8=BF=99=E7=B1=BB=E6=8A=A5=E5=91=8A=E6=80=BB=E6=98=AF=E4=
=BC=9A=E5=B8=A6=E6=9C=89=E2=80=9Cvalue changed=E2=80=9D=E8=A1=8C=E3=80=82=
=E8=BF=99=E7=B1=BB=E6=8A=A5=E5=91=8A=E7=9A=84=E5=87=BA=E7=8E=B0=E9=80=9A=
=E5=B8=B8=E6=98=AF=E5=9B=A0
>=20
>=20+=E4=B8=BA=E5=9C=A8=E7=AB=9E=E4=BA=89=E7=BA=BF=E7=A8=8B=E4=B8=AD=E7=
=BC=BA=E5=B0=91=E6=8F=92=E6=A1=A9=EF=BC=8C=E4=B9=9F=E5=8F=AF=E8=83=BD=E6=
=98=AF=E5=9B=A0=E4=B8=BA=E5=85=B6=E4=BB=96=E5=8E=9F=E5=9B=A0=EF=BC=8C=E6=
=AF=94=E5=A6=82 DMA =E8=AE=BF=E9=97=AE=E3=80=82=E8=BF=99=E7=B1=BB=E6=8A=
=A5=E5=91=8A=E5=8F=AA=E4=BC=9A=E5=9C=A8
>=20
>=20+=E8=AE=BE=E7=BD=AE=E4=BA=86=E5=86=85=E6=A0=B8=E5=8F=82=E6=95=B0 ``CO=
NFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=3Dy`` =E6=97=B6=E6=89=8D=E4=BC=9A=
=E5=87=BA=E7=8E=B0=EF=BC=8C=E8=80=8C=E8=BF=99
>=20
>=20+=E4=B8=AA=E5=8F=82=E6=95=B0=E6=98=AF=E9=BB=98=E8=AE=A4=E5=90=AF=E7=
=94=A8=E7=9A=84=E3=80=82
>=20
>=20+
>=20
>=20+=E9=80=89=E6=8B=A9=E6=80=A7=E5=88=86=E6=9E=90
>=20
>=20+~~~~~~~~~~
>=20
>=20+
>=20
>=20+=E5=AF=B9=E4=BA=8E=E4=B8=80=E4=BA=9B=E7=89=B9=E5=AE=9A=E7=9A=84=E8=
=AE=BF=E9=97=AE=EF=BC=8C=E5=87=BD=E6=95=B0=EF=BC=8C=E7=BC=96=E8=AF=91=E5=
=8D=95=E5=85=83=E6=88=96=E8=80=85=E6=95=B4=E4=B8=AA=E5=AD=90=E7=B3=BB=E7=
=BB=9F=EF=BC=8C=E5=8F=AF=E8=83=BD=E9=9C=80=E8=A6=81=E7=A6=81=E7=94=A8=E6=
=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E6=A3=80=E6=B5=8B=E3=80=82
>=20
>=20+=E5=AF=B9=E4=BA=8E=E9=9D=99=E6=80=81=E9=BB=91=E5=90=8D=E5=8D=95=EF=
=BC=8C=E6=9C=89=E5=A6=82=E4=B8=8B=E5=8F=AF=E7=94=A8=E7=9A=84=E5=8F=82=E6=
=95=B0=EF=BC=9A
>=20
>=20+
>=20
>=20+* KCSAN =E6=94=AF=E6=8C=81=E4=BD=BF=E7=94=A8 ``data_race(expr)`` =E6=
=B3=A8=E8=A7=A3=EF=BC=8C=E8=BF=99=E4=B8=AA=E6=B3=A8=E8=A7=A3=E5=91=8A=E8=
=AF=89 KCSAN =E4=BB=BB=E4=BD=95=E7=94=B1=E8=AE=BF=E9=97=AE
>=20
>=20+ ``expr`` =E6=89=80=E5=BC=95=E8=B5=B7=E7=9A=84=E6=95=B0=E6=8D=AE=E7=
=AB=9E=E4=BA=89=E9=83=BD=E5=BA=94=E8=AF=A5=E8=A2=AB=E5=BF=BD=E7=95=A5=EF=
=BC=8C=E5=85=B6=E4=BA=A7=E7=94=9F=E7=9A=84=E8=A1=8C=E4=B8=BA=E5=90=8E=E6=
=9E=9C=E8=A2=AB=E8=AE=A4=E4=B8=BA=E6=98=AF=E5=AE=89=E5=85=A8=E7=9A=84=E3=
=80=82=E8=AF=B7=E6=9F=A5=E9=98=85
>=20
>=20+ `"Marking Shared-Memory Accesses" in the LKMM`_ =E8=8E=B7=E5=BE=97=
=E6=9B=B4=E5=A4=9A=E4=BF=A1=E6=81=AF=E3=80=82
>=20
>=20+
>=20
>=20+* =E4=B8=8E ``data_race(...)`` =E7=9B=B8=E4=BC=BC=EF=BC=8C=E5=8F=AF=
=E4=BB=A5=E4=BD=BF=E7=94=A8=E7=B1=BB=E5=9E=8B=E9=99=90=E5=AE=9A=E7=AC=A6 =
``__data_racy`` =E6=9D=A5=E6=A0=87=E8=AE=B0=E4=B8=80=E4=B8=AA=E5=8F=98=E9=
=87=8F
>=20
>=20+ =EF=BC=8C=E6=89=80=E6=9C=89=E8=AE=BF=E9=97=AE=E8=AF=A5=E5=8F=98=E9=
=87=8F=E8=80=8C=E5=AF=BC=E8=87=B4=E7=9A=84=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=
=BA=89=E9=83=BD=E6=98=AF=E6=95=85=E6=84=8F=E4=B8=BA=E4=B9=8B=E5=B9=B6=E4=
=B8=94=E5=BA=94=E8=AF=A5=E8=A2=AB KCSAN =E5=BF=BD=E7=95=A5::
>=20
>=20+
>=20
>=20+ struct foo {
>=20
>=20+ ...
>=20
>=20+ int __data_racy stats_counter;
>=20
>=20+ ...
>=20
>=20+ };
>=20
>=20+
>=20
>=20+* =E4=BD=BF=E7=94=A8=E5=87=BD=E6=95=B0=E5=B1=9E=E6=80=A7 ``__no_kcsa=
n`` =E5=8F=AF=E4=BB=A5=E5=AF=B9=E6=95=B4=E4=B8=AA=E5=87=BD=E6=95=B0=E7=A6=
=81=E7=94=A8=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E6=A3=80=E6=B5=8B::
>=20
>=20+
>=20
>=20+ __no_kcsan
>=20
>=20+ void foo(void) {
>=20
>=20+ ...
>=20
>=20+
>=20
>=20+ =E4=B8=BA=E4=BA=86=E5=8A=A8=E6=80=81=E9=99=90=E5=88=B6=E8=AF=A5=E4=
=B8=BA=E5=93=AA=E4=BA=9B=E5=87=BD=E6=95=B0=E7=94=9F=E6=88=90=E6=8A=A5=E5=
=91=8A=EF=BC=8C=E6=9F=A5=E9=98=85 `Debug =E6=96=87=E4=BB=B6=E7=B3=BB=E7=
=BB=9F=E6=8E=A5=E5=8F=A3`_ =E9=BB=91=E5=90=8D=E5=8D=95/=E7=99=BD=E5=90=8D=
=E5=8D=95=E7=89=B9=E6=80=A7=E3=80=82
>=20
>=20+
>=20
>=20+* =E4=B8=BA=E7=89=B9=E5=AE=9A=E7=9A=84=E7=BC=96=E8=AF=91=E5=8D=95=E5=
=85=83=E7=A6=81=E7=94=A8=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E6=A3=80=E6=
=B5=8B=EF=BC=8C=E5=B0=86=E4=B8=8B=E5=88=97=E5=8F=82=E6=95=B0=E5=8A=A0=E5=
=85=A5=E5=88=B0 ``Makefile`` =E4=B8=AD::
>=20
>=20+
>=20
>=20+ KCSAN_SANITIZE_file.o :=3D n
>=20
>=20+
>=20
>=20+* =E4=B8=BA ``Makefile`` =E4=B8=AD=E7=9A=84=E6=89=80=E6=9C=89=E7=BC=
=96=E8=AF=91=E5=8D=95=E5=85=83=E7=A6=81=E7=94=A8=E6=95=B0=E6=8D=AE=E7=AB=
=9E=E4=BA=89=E6=A3=80=E6=B5=8B=EF=BC=8C=E5=B0=86=E4=B8=8B=E5=88=97=E5=8F=
=82=E6=95=B0=E6=B7=BB=E5=8A=A0=E5=88=B0=E7=9B=B8=E5=BA=94=E7=9A=84
>=20
>=20+ ``Makefile`` =E4=B8=AD::
>=20
>=20+
>=20
>=20+ KCSAN_SANITIZE :=3D n
>=20
>=20+
>=20
>=20+.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel=
.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/=
Documentation/access-marking.txt
>=20
>=20+
>=20
>=20+=E6=AD=A4=E5=A4=96=EF=BC=8CKCSAN =E5=8F=AF=E4=BB=A5=E6=A0=B9=E6=8D=
=AE=E5=81=8F=E5=A5=BD=E8=AE=BE=E7=BD=AE=E6=98=BE=E7=A4=BA=E6=88=96=E9=9A=
=90=E8=97=8F=E6=95=B4=E4=B8=AA=E7=B1=BB=E5=88=AB=E7=9A=84=E6=95=B0=E6=8D=
=AE=E7=AB=9E=E4=BA=89=E3=80=82=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8=E5=A6=
=82=E4=B8=8B
>=20
>=20+Kconfig =E5=8F=82=E6=95=B0=E8=BF=9B=E8=A1=8C=E6=9B=B4=E6=94=B9:
>=20
>=20+
>=20
>=20+* ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY``: =E5=A6=82=E6=9E=9C=E5=
=90=AF=E7=94=A8=E4=BA=86=E8=AF=A5=E5=8F=82=E6=95=B0=E5=B9=B6=E4=B8=94=E9=
=80=9A=E8=BF=87=E8=A7=82=E6=B5=8B=E7=82=B9
>=20
>=20+ (watchpoint) =E8=A7=82=E6=B5=8B=E5=88=B0=E4=B8=80=E4=B8=AA=E6=9C=89=
=E5=86=B2=E7=AA=81=E7=9A=84=E5=86=99=E6=93=8D=E4=BD=9C=EF=BC=8C=E4=BD=86=
=E6=98=AF=E5=AF=B9=E5=BA=94=E7=9A=84=E5=86=85=E5=AD=98=E5=9C=B0=E5=9D=80=
=E4=B8=AD=E5=AD=98=E5=82=A8=E7=9A=84=E5=80=BC=E6=B2=A1=E6=9C=89=E6=94=B9=
=E5=8F=98=EF=BC=8C
>=20
>=20+ =E5=88=99=E4=B8=8D=E4=BC=9A=E6=8A=A5=E5=91=8A=E8=BF=99=E8=B5=B7=E6=
=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E3=80=82
>=20
>=20+
>=20
>=20+* ``CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC``: =E5=81=87=E8=AE=BE=E9=
=BB=98=E8=AE=A4=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E4=B8=8D=E8=B6=85=E8=
=BF=87=E5=AD=97=E5=A4=A7=E5=B0=8F=E7=9A=84=E7=AE=80
>=20
>=20+ =E5=8D=95=E5=AF=B9=E9=BD=90=E5=86=99=E5=85=A5=E6=93=8D=E4=BD=9C=E6=
=98=AF=E5=8E=9F=E5=AD=90=E7=9A=84=E3=80=82=E5=81=87=E8=AE=BE=E8=BF=99=E4=
=BA=9B=E5=86=99=E5=85=A5=E6=93=8D=E4=BD=9C=E4=B8=8D=E4=BC=9A=E5=8F=97=E5=
=88=B0=E4=B8=8D=E5=AE=89=E5=85=A8=E7=9A=84=E7=BC=96=E8=AF=91=E5=99=A8=E4=
=BC=98=E5=8C=96=E5=BD=B1=E5=93=8D=EF=BC=8C=E4=BB=8E=E8=80=8C=E5=AF=BC
>=20
>=20+ =E8=87=B4=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E3=80=82=E8=AF=A5=E9=
=80=89=E9=A1=B9=E4=BD=BF KCSAN =E4=B8=8D=E6=8A=A5=E5=91=8A=E4=BB=85=E7=94=
=B1=E4=B8=8D=E8=B6=85=E8=BF=87=E5=AD=97=E5=A4=A7=E5=B0=8F=E7=9A=84=E7=AE=
=80=E5=8D=95=E5=AF=B9=E9=BD=90=E5=86=99=E5=85=A5=E6=93=8D=E4=BD=9C=E5=BC=
=95=E8=B5=B7
>=20
>=20+ =E7=9A=84=E5=86=B2=E7=AA=81=E6=89=80=E5=AF=BC=E8=87=B4=E7=9A=84=E6=
=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E3=80=82
>=20
>=20+
>=20
>=20+* ``CONFIG_KCSAN_PERMISSIVE``: =E5=90=AF=E7=94=A8=E9=A2=9D=E5=A4=96=
=E7=9A=84=E5=AE=BD=E6=9D=BE=E8=A7=84=E5=88=99=E6=9D=A5=E5=BF=BD=E7=95=A5=
=E6=9F=90=E4=BA=9B=E5=B8=B8=E8=A7=81=E7=B1=BB=E5=9E=8B=E7=9A=84=E6=95=B0=
=E6=8D=AE=E7=AB=9E=E4=BA=89=E3=80=82
>=20
>=20+ =E4=B8=8E=E4=B8=8A=E9=9D=A2=E7=9A=84=E8=A7=84=E5=88=99=E4=B8=8D=E5=
=90=8C=EF=BC=8C=E8=BF=99=E6=9D=A1=E8=A7=84=E5=88=99=E6=9B=B4=E5=8A=A0=E5=
=A4=8D=E6=9D=82=EF=BC=8C=E6=B6=89=E5=8F=8A=E5=88=B0=E5=80=BC=E6=94=B9=E5=
=8F=98=E6=A8=A1=E5=BC=8F=EF=BC=8C=E8=AE=BF=E9=97=AE=E7=B1=BB=E5=9E=8B=E5=
=92=8C=E5=9C=B0=E5=9D=80=E3=80=82=E8=BF=99=E4=B8=AA
>=20
>=20+ =E9=80=89=E9=A1=B9=E4=BE=9D=E8=B5=96=E7=BC=96=E8=AF=91=E9=80=89=E9=
=A1=B9 ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dy``=E3=80=82=E8=AF=B7=E6=
=9F=A5=E7=9C=8B
>=20
>=20+ ``kernel/kcsan/permissive.h`` =E8=8E=B7=E5=8F=96=E6=9B=B4=E5=A4=9A=
=E7=BB=86=E8=8A=82=E3=80=82=E5=AF=B9=E4=BA=8E=E5=8F=AA=E4=BE=A7=E9=87=8D=
=E4=BA=8E=E7=89=B9=E5=AE=9A=E5=AD=90=E7=B3=BB=E7=BB=9F=E8=80=8C=E4=B8=8D=
=E6=98=AF=E6=95=B4=E4=B8=AA
>=20
>=20+ =E5=86=85=E6=A0=B8=E6=8A=A5=E5=91=8A=E7=9A=84=E6=B5=8B=E8=AF=95=E8=
=80=85=E5=92=8C=E7=BB=B4=E6=8A=A4=E8=80=85=EF=BC=8C=E5=BB=BA=E8=AE=AE=E7=
=A6=81=E7=94=A8=E8=AF=A5=E9=80=89=E9=A1=B9=E3=80=82
>=20
>=20+
>=20
>=20+=E8=A6=81=E4=BD=BF=E7=94=A8=E5=B0=BD=E5=8F=AF=E8=83=BD=E4=B8=A5=E6=
=A0=BC=E7=9A=84=E8=A7=84=E5=88=99=EF=BC=8C=E9=80=89=E6=8B=A9 ``CONFIG_KCS=
AN_STRICT=3Dy``=EF=BC=8C=E8=BF=99=E5=B0=86=E9=85=8D=E7=BD=AE KCSAN =E5=B0=
=BD=E5=8F=AF
>=20
>=20+=E8=83=BD=E7=B4=A7=E5=AF=86=E5=9C=B0=E9=81=B5=E5=BE=AA Linux =E5=86=
=85=E6=A0=B8=E5=86=85=E5=AD=98=E4=B8=80=E8=87=B4=E6=80=A7=E6=A8=A1=E5=9E=
=8B=EF=BC=88LKMM=EF=BC=89=E3=80=82
>=20
>=20+
>=20
>=20+Debug =E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E6=8E=A5=E5=8F=A3
>=20
>=20+~~~~~~~~~~~~~~~~~~
>=20
>=20+
>=20
>=20+=E6=96=87=E4=BB=B6 ``/sys/kernel/debug/kcsan`` =E6=8F=90=E4=BE=9B=E4=
=BA=86=E5=A6=82=E4=B8=8B=E6=8E=A5=E5=8F=A3=EF=BC=9A
>=20
>=20+
>=20
>=20+* =E8=AF=BB ``/sys/kernel/debug/kcsan`` =E8=BF=94=E5=9B=9E=E4=B8=8D=
=E5=90=8C=E7=9A=84=E8=BF=90=E8=A1=8C=E6=97=B6=E7=BB=9F=E8=AE=A1=E6=95=B0=
=E6=8D=AE=E3=80=82
>=20
>=20+
>=20
>=20+* =E5=B0=86 ``on`` =E6=88=96 ``off`` =E5=86=99=E5=85=A5 ``/sys/kerne=
l/debug/kcsan`` =E5=85=81=E8=AE=B8=E6=89=93=E5=BC=80=E6=88=96=E5=85=B3=E9=
=97=AD KCSAN=E3=80=82
>=20
>=20+
>=20
>=20+* =E5=B0=86 ``!some_func_name`` =E5=86=99=E5=85=A5 ``/sys/kernel/deb=
ug/kcsan`` =E4=BC=9A=E5=B0=86
>=20
>=20+ ``some_func_name`` =E6=B7=BB=E5=8A=A0=E5=88=B0=E6=8A=A5=E5=91=8A=E8=
=BF=87=E6=BB=A4=E5=88=97=E8=A1=A8=E4=B8=AD=EF=BC=8C=E8=AF=A5=E5=88=97=E8=
=A1=A8=EF=BC=88=E9=BB=98=E8=AE=A4=EF=BC=89=E4=BC=9A=E5=B0=86=E6=95=B0=E6=
=8D=AE=E7=AB=9E=E4=BA=89=E6=8A=A5=E5=91=8A=E4=B8=AD=E7=9A=84=E9=A1=B6
>=20
>=20+ =E5=B1=82=E5=A0=86=E6=A0=88=E5=B8=A7=E6=98=AF=E5=88=97=E8=A1=A8=E4=
=B8=AD=E5=87=BD=E6=95=B0=E7=9A=84=E6=83=85=E5=86=B5=E5=88=97=E5=85=A5=E9=
=BB=91=E5=90=8D=E5=8D=95=E3=80=82
>=20
>=20+
>=20
>=20+* =E5=B0=86 ``blacklist`` =E6=88=96 ``whitelist`` =E5=86=99=E5=85=A5=
 ``/sys/kernel/debug/kcsan`` =E4=BC=9A=E6=94=B9=E5=8F=98=E6=8A=A5=E5=91=
=8A
>=20
>=20+ =E8=BF=87=E6=BB=A4=E8=A1=8C=E4=B8=BA=E3=80=82=E4=BE=8B=E5=A6=82=EF=
=BC=8C=E9=BB=91=E5=90=8D=E5=8D=95=E7=9A=84=E7=89=B9=E6=80=A7=E5=8F=AF=E4=
=BB=A5=E7=94=A8=E6=9D=A5=E8=BF=87=E6=BB=A4=E6=8E=89=E7=BB=8F=E5=B8=B8=E5=
=8F=91=E7=94=9F=E7=9A=84=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89=E3=80=82=E7=
=99=BD=E5=90=8D=E5=8D=95=E7=89=B9=E6=80=A7=E5=8F=AF=E4=BB=A5=E5=B8=AE
>=20
>=20+ =E5=8A=A9=E5=A4=8D=E7=8E=B0=E5=92=8C=E4=BF=AE=E5=A4=8D=E6=B5=8B=E8=
=AF=95=E3=80=82
>=20
>=20+
>=20
>=20+=E6=80=A7=E8=83=BD=E8=B0=83=E4=BC=98
>=20
>=20+~~~~~~~~
>=20
>=20+
>=20
>=20+=E5=BD=B1=E5=93=8D KCSAN =E6=95=B4=E4=BD=93=E7=9A=84=E6=80=A7=E8=83=
=BD=E5=92=8C bug =E6=A3=80=E6=B5=8B=E8=83=BD=E5=8A=9B=E7=9A=84=E6=A0=B8=
=E5=BF=83=E5=8F=82=E6=95=B0=E6=98=AF=E4=BD=9C=E4=B8=BA=E5=86=85=E6=A0=B8=
=E5=91=BD=E4=BB=A4=E8=A1=8C=E5=8F=82=E6=95=B0=E5=85=AC=E5=BC=80=E7=9A=84=
=EF=BC=8C=E5=85=B6=E9=BB=98=E8=AE=A4
>=20
>=20+=E5=80=BC=E4=B9=9F=E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87=E7=9B=B8=E5=
=BA=94=E7=9A=84 Kconfig =E9=80=89=E9=A1=B9=E6=9B=B4=E6=94=B9=E3=80=82
>=20
>=20+
>=20
>=20+* ``kcsan.skip_watch`` (``CONFIG_KCSAN_SKIP_WATCH``): =E5=9C=A8=E5=
=8F=A6=E4=B8=80=E4=B8=AA=E8=A7=82=E6=B5=8B=E7=82=B9=E8=AE=BE=E7=BD=AE=E4=
=B9=8B=E5=89=8D=E6=AF=8F
>=20
>=20+ =E4=B8=AA CPU =E8=A6=81=E8=B7=B3=E8=BF=87=E7=9A=84=E5=86=85=E5=AD=
=98=E6=93=8D=E4=BD=9C=E6=AC=A1=E6=95=B0=E3=80=82=E6=9B=B4=E5=8A=A0=E9=A2=
=91=E7=B9=81=E7=9A=84=E8=AE=BE=E7=BD=AE=E8=A7=82=E6=B5=8B=E7=82=B9=E5=B0=
=86=E5=A2=9E=E5=8A=A0=E8=A7=82=E5=AF=9F=E5=88=B0=E7=AB=9E=E4=BA=89=E6=83=
=85=E5=86=B5=E7=9A=84=E5=8F=AF=E8=83=BD=E6=80=A7
>=20
>=20+ =E3=80=82=E8=BF=99=E4=B8=AA=E5=8F=82=E6=95=B0=E5=AF=B9=E7=B3=BB=E7=
=BB=9F=E6=95=B4=E4=BD=93=E7=9A=84=E6=80=A7=E8=83=BD=E5=92=8C=E7=AB=9E=E4=
=BA=89=E6=A3=80=E6=B5=8B=E8=83=BD=E5=8A=9B=E5=BD=B1=E5=93=8D=E6=9C=80=E6=
=98=BE=E8=91=97=E3=80=82
>=20
>=20+
>=20
>=20+* ``kcsan.udelay_task`` (``CONFIG_KCSAN_UDELAY_TASK``): =E5=AF=B9=E4=
=BA=8E=E4=BB=BB=E5=8A=A1=EF=BC=8C=E8=A7=82=E6=B5=8B=E7=82=B9=E8=AE=BE=E7=
=BD=AE=E4=B9=8B
>=20
>=20+ =E5=90=8E=E6=9A=82=E5=81=9C=E6=89=A7=E8=A1=8C=E7=9A=84=E5=BE=AE=E7=
=A7=92=E5=BB=B6=E8=BF=9F=E3=80=82=E5=80=BC=E8=B6=8A=E5=A4=A7=EF=BC=8C=E6=
=A3=80=E6=B5=8B=E5=88=B0=E7=AB=9E=E4=BA=89=E6=83=85=E5=86=B5=E7=9A=84=E5=
=8F=AF=E8=83=BD=E6=80=A7=E8=B6=8A=E9=AB=98=E3=80=82
>=20
>=20+
>=20
>=20+* ``kcsan.udelay_interrupt`` (``CONFIG_KCSAN_UDELAY_INTERRUPT``): =
=E5=AF=B9=E4=BA=8E=E4=B8=AD=E6=96=AD=EF=BC=8C
>=20
>=20+ =E8=A7=82=E6=B5=8B=E7=82=B9=E8=AE=BE=E7=BD=AE=E4=B9=8B=E5=90=8E=E6=
=9A=82=E5=81=9C=E6=89=A7=E8=A1=8C=E7=9A=84=E5=BE=AE=E7=A7=92=E5=BB=B6=E8=
=BF=9F=E3=80=82=E4=B8=AD=E6=96=AD=E5=AF=B9=E4=BA=8E=E5=BB=B6=E8=BF=9F=E7=
=9A=84=E8=A6=81=E6=B1=82=E6=9B=B4=E5=8A=A0=E4=B8=A5=E6=A0=BC=EF=BC=8C=E5=
=85=B6=E5=BB=B6=E8=BF=9F=E9=80=9A=E5=B8=B8=E5=BA=94=E8=AF=A5=E5=B0=8F
>=20
>=20+ =E4=BA=8E=E4=B8=BA=E4=BB=BB=E5=8A=A1=E9=80=89=E6=8B=A9=E7=9A=84=E5=
=BB=B6=E8=BF=9F=E3=80=82
>=20
>=20+
>=20
>=20+=E5=AE=83=E4=BB=AC=E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87 ``/sys/module=
/kcsan/parameters/`` =E5=9C=A8=E8=BF=90=E8=A1=8C=E6=97=B6=E8=BF=9B=E8=A1=
=8C=E8=B0=83=E6=95=B4=E3=80=82
>=20
>=20+
>=20
>=20+=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89
>=20
>=20+--------
>=20
>=20+
>=20
>=20+=E5=9C=A8=E4=B8=80=E6=AC=A1=E6=89=A7=E8=A1=8C=E4=B8=AD=EF=BC=8C=E5=
=A6=82=E6=9E=9C=E4=B8=A4=E4=B8=AA=E5=86=85=E5=AD=98=E8=AE=BF=E9=97=AE=E5=
=AD=98=E5=9C=A8 *=E5=86=B2=E7=AA=81*=EF=BC=8C=E5=9C=A8=E4=B8=8D=E5=90=8C=
=E7=9A=84=E7=BA=BF=E7=A8=8B=E4=B8=AD=E5=B9=B6=E5=8F=91=E6=89=A7=E8=A1=8C=
=EF=BC=8C=E5=B9=B6=E4=B8=94=E8=87=B3=E5=B0=91
>=20
>=20+=E6=9C=89=E4=B8=80=E4=B8=AA=E8=AE=BF=E9=97=AE=E6=98=AF *=E7=AE=80=E5=
=8D=95=E8=AE=BF=E9=97=AE*=EF=BC=8C=E5=88=99=E5=AE=83=E4=BB=AC=E5=B0=B1=E5=
=BD=A2=E6=88=90=E4=BA=86 *=E6=95=B0=E6=8D=AE=E7=AB=9E=E4=BA=89*=E3=80=82=
=E5=A6=82=E6=9E=9C=E5=AE=83=E4=BB=AC=E8=AE=BF=E9=97=AE=E4=BA=86=E5=90=8C=
=E4=B8=80=E4=B8=AA=E5=86=85=E5=AD=98=E5=9C=B0=E5=9D=80=E5=B9=B6=E4=B8=94
>=20
>=20+=E8=87=B3=E5=B0=91=E6=9C=89=E4=B8=80=E4=B8=AA=E6=98=AF=E5=86=99=E6=
=93=8D=E4=BD=9C=EF=BC=8C=E5=88=99=E7=A7=B0=E5=AE=83=E4=BB=AC=E5=AD=98=E5=
=9C=A8 *=E5=86=B2=E7=AA=81*=E3=80=82=E6=9C=89=E5=85=B3=E6=9B=B4=E8=AF=A6=
=E7=BB=86=E7=9A=84=E8=AE=A8=E8=AE=BA=E5=92=8C=E5=AE=9A=E4=B9=89=EF=BC=8C=
=E8=A7=81

>=20
>=20+`"Plain Accesses and Data Races" in the LKMM`_=E3=80=82
>=20
>=20+
>=20
>=20+.. _"Plain Accesses and Data Races" in the LKMM:

Sorry for the delay for so long, how about
translating it into Chinese as well?
=20


Thanks,
Yanteng

