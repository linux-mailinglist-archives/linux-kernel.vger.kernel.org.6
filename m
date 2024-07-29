Return-Path: <linux-kernel+bounces-265349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713893EFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BD01F22CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4313C669;
	Mon, 29 Jul 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wDBVYVIz"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62931130A7D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241579; cv=none; b=W6J1tmO+/QrUpjVC4rEaru494IGml9sIHMKkJ281eKFCwjITmuBqoN2SG0mILIBc81bUrfbjV5piReRQV1LCDC0i2hdDLfnU7KwYDMMehJsY4cClShuBn4qKWOTO4Gmodl/N8xAedgkJFOlWwSH7CDdVC5eqWPQLeOW6M9V3Xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241579; c=relaxed/simple;
	bh=f1HC4wTD7Il644IrETIAKW1tgtna4S1M7bRe/N1oluw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=WUzs8rcJr/Vq/60+4D4qJYlpBqNwaN3xYyWvwiMEp8HS4ZmY8vdiHmlrcJaFaN7YvEZkVkuhqIdOMmJHk9XmQCwhxaMz+hJFpnxqTbtjPJSwJ7Z+5zfggV+zWdt87pP87C6EVXO3aO8/glLCBcm+xSOzPjtiq9Iw9s1v4lw6rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wDBVYVIz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722241571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ENOKrcxqiGGdiwXvIoupR+x5XtTLH9YQOfYlff9V6w=;
	b=wDBVYVIzydUuJvWuzZGonpKDqNyLFgN7GDhSdsp/oirczSh4VnpZWI+JuKVO/fClRkTBvg
	GDfB0wZG5fMi031nnaHEx+jwwJqOAKbDuuNeBjh6gQR90dcKk60uRGS/c73WFBS3jOokUF
	HoWMWxfXnZG4G+S4EA/TgEnF21w/r1U=
Date: Mon, 29 Jul 2024 08:26:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <a17a7994657696fbba9c9be29c35629ef512f85b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] docs/zh_CN: add the translation of
 kbuild/headers_install.rst
To: "Dongliang Mu" <dzm91@hust.edu.cn>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <siyanteng@loongson.cn>, "Jonathan Corbet" <corbet@lwn.net>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
In-Reply-To: <20240726145754.2598197-1-dzm91@hust.edu.cn>
References: <20240726145754.2598197-1-dzm91@hust.edu.cn>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B47=E6=9C=8826=E6=97=A5 22:57, "Dongliang Mu" <dzm91@hust.edu.=
cn> =E5=86=99=E5=88=B0:



>=20
>=20Finish the translation of kbuild/headers_install.rst and
>=20
>=20kbuild/index.rst, then add kbuild into zh_CN/index.rst.
>=20
>=20Update to commit 5b67fbfc32b5 ("Merge tag 'kbuild-v5.7' of
>=20
>=20git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild"=
)
>=20
>=20Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>=20
>=20---
>=20
>=20 Documentation/translations/zh_CN/index.rst | 2 +-
>=20
>=20 .../zh_CN/kbuild/headers_install.rst | 39 +++++++++++++++++++
>=20
>=20 .../translations/zh_CN/kbuild/index.rst | 35 +++++++++++++++++
>=20
>=20 3 files changed, 75 insertions(+), 1 deletion(-)
>=20
>=20 create mode 100644 Documentation/translations/zh_CN/kbuild/headers_i=
nstall.rst
>=20
>=20 create mode 100644 Documentation/translations/zh_CN/kbuild/index.rst
>=20
>=20diff --git a/Documentation/translations/zh_CN/index.rst b/Documentati=
on/translations/zh_CN/index.rst
>=20
>=20index 20b9d4270d1f..7574e1673180 100644
>=20
>=20--- a/Documentation/translations/zh_CN/index.rst
>=20
>=20+++ b/Documentation/translations/zh_CN/index.rst
>=20
>=20@@ -89,10 +89,10 @@ TODOList:
>=20
>=20 admin-guide/index
>=20
>=20 admin-guide/reporting-issues.rst
>=20
>=20 userspace-api/index
>=20
>=20+ =E5=86=85=E6=A0=B8=E6=9E=84=E5=BB=BA=E7=B3=BB=E7=BB=9F <kbuild/inde=
x>
>=20
>=20=20
>=20
>  TODOList:
>=20
>=20=20
>=20
> -* =E5=86=85=E6=A0=B8=E6=9E=84=E5=BB=BA=E7=B3=BB=E7=BB=9F <kbuild/index=
>
>=20
>=20 * =E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E5=B7=A5=E5=85=B7 <tools/inde=
x>
>=20
>=20=20
>=20
>  =E4=B9=9F=E5=8F=AF=E5=8F=82=E8=80=83=E7=8B=AC=E7=AB=8B=E4=BA=8E=E5=86=
=85=E6=A0=B8=E6=96=87=E6=A1=A3=E7=9A=84 `Linux =E6=89=8B=E5=86=8C=E9=A1=
=B5 <https://www.kernel.org/doc/man-pages/>%60_ https://www.kernel.org/do=
c/man-pages/%3E%60_  =E3=80=82
>=20
>=20diff --git a/Documentation/translations/zh_CN/kbuild/headers_install.=
rst b/Documentation/translations/zh_CN/kbuild/headers_install.rst
>=20
>=20new file mode 100644
>=20
>=20index 000000000000..50ab819a7f96
>=20
>=20--- /dev/null
>=20
>=20+++ b/Documentation/translations/zh_CN/kbuild/headers_install.rst
>=20
>=20@@ -0,0 +1,39 @@
>=20
>=20+.. SPDX-License-Identifier: GPL-2.0
>=20
>=20+
>=20
>=20+.. include:: ../disclaimer-zh_CN.rst
>=20
>=20+
>=20
>=20+:Original: Documentation/kbuild/headers_install.rst
>=20
>=20+:Translator: =E6=85=95=E5=86=AC=E4=BA=AE Dongliang Mu <dzm91@hust.ed=
u.cn>
>=20
>=20+
>=20
>=20+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
>=20+=E5=AF=BC=E5=87=BA=E5=86=85=E6=A0=B8=E5=A4=B4=E6=96=87=E4=BB=B6=E4=
=BE=9B=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E4=BD=BF=E7=94=A8
>=20
>=20+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
>=20+
>=20
>=20+"make headers_install" =E5=91=BD=E4=BB=A4=E4=BB=A5=E9=80=82=E5=90=88=
=E4=BA=8E=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E7=A8=8B=E5=BA=8F=E7=9A=84=
=E5=BD=A2=E5=BC=8F=E5=AF=BC=E5=87=BA=E5=86=85=E6=A0=B8=E5=A4=B4=E6=96=87=
=E4=BB=B6=E3=80=82
>=20
>=20+
>=20
>=20+Linux =E5=86=85=E6=A0=B8=E5=AF=BC=E5=87=BA=E7=9A=84=E5=A4=B4=E6=96=
=87=E4=BB=B6=E6=8F=8F=E8=BF=B0=E4=BA=86=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=
=B4=E7=A8=8B=E5=BA=8F=E5=B0=9D=E8=AF=95=E4=BD=BF=E7=94=A8=E5=86=85=E6=A0=
=B8=E6=9C=8D=E5=8A=A1=E7=9A=84 API=E3=80=82=E8=BF=99=E4=BA=9B=E5=86=85=E6=
=A0=B8
>=20
>=20+=E5=A4=B4=E6=96=87=E4=BB=B6=E8=A2=AB=E7=B3=BB=E7=BB=9F=E7=9A=84 C =
=E5=BA=93=EF=BC=88=E4=BE=8B=E5=A6=82 glibc =E5=92=8C uClibc=EF=BC=89=E7=
=94=A8=E4=BA=8E=E5=AE=9A=E4=B9=89=E5=8F=AF=E7=94=A8=E7=9A=84=E7=B3=BB=E7=
=BB=9F=E8=B0=83=E7=94=A8=EF=BC=8C=E4=BB=A5=E5=8F=8A
>=20
>=20+=E4=B8=8E=E8=BF=99=E4=BA=9B=E7=B3=BB=E7=BB=9F=E8=B0=83=E7=94=A8=E4=
=B8=80=E8=B5=B7=E4=BD=BF=E7=94=A8=E7=9A=84=E5=B8=B8=E9=87=8F=E5=92=8C=E7=
=BB=93=E6=9E=84=E3=80=82C =E5=BA=93=E7=9A=84=E5=A4=B4=E6=96=87=E4=BB=B6=
=E5=8C=85=E6=8B=AC=E6=9D=A5=E8=87=AA linux =E5=AD=90=E7=9B=AE=E5=BD=95=E7=
=9A=84
>=20
>=20+=E5=86=85=E6=A0=B8=E5=A4=B4=E6=96=87=E4=BB=B6=E3=80=82=E7=B3=BB=E7=
=BB=9F=E7=9A=84 libc =E5=A4=B4=E6=96=87=E4=BB=B6=E9=80=9A=E5=B8=B8=E8=A2=
=AB=E5=AE=89=E8=A3=85=E5=9C=A8=E9=BB=98=E8=AE=A4=E4=BD=8D=E7=BD=AE /usr/i=
nclude=EF=BC=8C=E8=80=8C=E5=86=85=E6=A0=B8
>=20
>=20+=E5=A4=B4=E6=96=87=E4=BB=B6=E5=9C=A8=E8=AF=A5=E4=BD=8D=E7=BD=AE=E7=
=9A=84=E5=AD=90=E7=9B=AE=E5=BD=95=E4=B8=AD=EF=BC=88=E4=B8=BB=E8=A6=81=E6=
=98=AF /usr/include/linux =E5=92=8C /usr/include/asm=EF=BC=89=E3=80=82
>=20
>=20+
>=20
>=20+=E5=86=85=E6=A0=B8=E5=A4=B4=E6=96=87=E4=BB=B6=E5=90=91=E5=90=8E=E5=
=85=BC=E5=AE=B9=EF=BC=8C=E4=BD=86=E4=B8=8D=E5=90=91=E5=89=8D=E5=85=BC=E5=
=AE=B9=E3=80=82=E8=BF=99=E6=84=8F=E5=91=B3=E7=9D=80=E4=BD=BF=E7=94=A8=E6=
=97=A7=E5=86=85=E6=A0=B8=E5=A4=B4=E6=96=87=E4=BB=B6=E7=9A=84 C =E5=BA=93=
=E6=9E=84=E5=BB=BA=E7=9A=84=E7=A8=8B=E5=BA=8F
>=20
>=20+=E5=8F=AF=E4=BB=A5=E5=9C=A8=E6=96=B0=E5=86=85=E6=A0=B8=E4=B8=8A=E8=
=BF=90=E8=A1=8C=EF=BC=88=E5=B0=BD=E7=AE=A1=E5=AE=83=E5=8F=AF=E8=83=BD=E6=
=97=A0=E6=B3=95=E8=AE=BF=E9=97=AE=E6=96=B0=E7=89=B9=E6=80=A7=EF=BC=89=EF=
=BC=8C=E4=BD=86=E4=BD=BF=E7=94=A8=E6=96=B0=E5=86=85=E6=A0=B8=E5=A4=B4=E6=
=96=87=E4=BB=B6=E6=9E=84=E5=BB=BA=E7=9A=84=E7=A8=8B=E5=BA=8F
>=20
>=20+=E5=8F=AF=E8=83=BD=E6=97=A0=E6=B3=95=E5=9C=A8=E6=97=A7=E5=86=85=E6=
=A0=B8=E4=B8=8A=E8=BF=90=E8=A1=8C=E3=80=82
>=20
>=20+
>=20
>=20+"make headers_install" =E5=91=BD=E4=BB=A4=E5=8F=AF=E4=BB=A5=E5=9C=A8=
=E5=86=85=E6=A0=B8=E6=BA=90=E4=BB=A3=E7=A0=81=E7=9A=84=E9=A1=B6=E5=B1=82=
=E7=9B=AE=E5=BD=95=E4=B8=AD=E8=BF=90=E8=A1=8C=EF=BC=88=E6=88=96=E4=BD=BF=
=E7=94=A8=E6=A0=87=E5=87=86
>=20
>=20+=E7=9A=84=E6=A0=91=E5=A4=96=E6=9E=84=E5=BB=BA=EF=BC=89=E3=80=82=E5=
=AE=83=E6=8E=A5=E5=8F=97=E4=B8=A4=E4=B8=AA=E5=8F=AF=E9=80=89=E5=8F=82=E6=
=95=B0::
>=20
>=20+
>=20
>=20+ make headers_install ARCH=3Di386 INSTALL_HDR_PATH=3D/usr
>=20
>=20+
>=20
>=20+ARCH =E8=A1=A8=E6=98=8E=E4=B8=BA=E5=85=B6=E7=94=9F=E6=88=90=E5=A4=B4=
=E6=96=87=E4=BB=B6=E7=9A=84=E6=9E=B6=E6=9E=84=EF=BC=8C=E9=BB=98=E8=AE=A4=
=E4=B8=BA=E5=BD=93=E5=89=8D=E6=9E=B6=E6=9E=84=E3=80=82=E5=AF=BC=E5=87=BA=
=E5=86=85=E6=A0=B8=E5=A4=B4=E6=96=87=E4=BB=B6=E7=9A=84 linux/asm
>=20
>=20+=E7=9B=AE=E5=BD=95=E6=98=AF=E5=9F=BA=E4=BA=8E=E7=89=B9=E5=AE=9A=E5=
=B9=B3=E5=8F=B0=E7=9A=84=EF=BC=8C=E8=A6=81=E6=9F=A5=E7=9C=8B=E6=94=AF=E6=
=8C=81=E6=9E=B6=E6=9E=84=E7=9A=84=E5=AE=8C=E6=95=B4=E5=88=97=E8=A1=A8=EF=
=BC=8C=E4=BD=BF=E7=94=A8=E4=BB=A5=E4=B8=8B=E5=91=BD=E4=BB=A4::
>=20
>=20+
>=20
>=20+ ls -d include/asm-* | sed 's/.*-//'
>=20
>=20+
>=20
>=20+INSTALL_HDR_PATH =E8=A1=A8=E6=98=8E=E5=A4=B4=E6=96=87=E4=BB=B6=E7=9A=
=84=E5=AE=89=E8=A3=85=E4=BD=8D=E7=BD=AE=EF=BC=8C=E9=BB=98=E8=AE=A4=E4=B8=
=BA "./usr"=E3=80=82
>=20
>=20+
>=20
>=20+=E8=AF=A5=E5=91=BD=E4=BB=A4=E4=BC=9A=E5=9C=A8 INSTALL_HDR_PATH =E4=
=B8=AD=E8=87=AA=E5=8A=A8=E5=88=9B=E5=BB=BA=E5=88=9B=E5=BB=BA=E4=B8=80=E4=
=B8=AA 'include' =E7=9B=AE=E5=BD=95=EF=BC=8C=E8=80=8C=E5=A4=B4=E6=96=87=
=E4=BB=B6
>=20
>=20+=E4=BC=9A=E8=A2=AB=E5=AE=89=E8=A3=85=E5=9C=A8 INSTALL_HDR_PATH/inclu=
de =E4=B8=AD=E3=80=82
>=20
>=20+
>=20
>=20+=E5=86=85=E6=A0=B8=E5=A4=B4=E6=96=87=E4=BB=B6=E5=AF=BC=E5=87=BA=E7=
=9A=84=E5=9F=BA=E7=A1=80=E8=AE=BE=E6=96=BD=E7=94=B1 David Woodhouse <dwmw=
2@infradead.org> =E7=BB=B4=E6=8A=A4=E3=80=82
>=20
>=20\ No newline at end of file
Add a blankline.

With this:

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,
Yanteng
>=20
>=20diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Docu=
mentation/translations/zh_CN/kbuild/index.rst
>=20
>=20new file mode 100644
>=20
>=20index 000000000000..b9feb56b846a
>=20
>=20--- /dev/null
>=20
>=20+++ b/Documentation/translations/zh_CN/kbuild/index.rst
>=20
>=20@@ -0,0 +1,35 @@
>=20
>=20+.. SPDX-License-Identifier: GPL-2.0
>=20
>=20+
>=20
>=20+.. include:: ../disclaimer-zh_CN.rst
>=20
>=20+
>=20
>=20+:Original: Documentation/kbuild/index
>=20
>=20+:Translator: =E6=85=95=E5=86=AC=E4=BA=AE Dongliang Mu <dzm91@hust.ed=
u.cn>
>=20
>=20+
>=20
>=20+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20+=E5=86=85=E6=A0=B8=E7=BC=96=E8=AF=91=E7=B3=BB=E7=BB=9F
>=20
>=20+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20+
>=20
>=20+.. toctree::
>=20
>=20+ :maxdepth: 1
>=20
>=20+
>=20
>=20+ headers_install
>=20
>=20+
>=20
>=20+TODO:
>=20
>=20+
>=20
>=20+- kconfig-language
>=20
>=20+- kconfig-macro-language
>=20
>=20+- kbuild
>=20
>=20+- kconfig
>=20
>=20+- makefiles
>=20
>=20+- modules
>=20
>=20+- issues
>=20
>=20+- reproducible-builds
>=20
>=20+- gcc-plugins
>=20
>=20+- llvm
>=20
>=20+
>=20
>=20+.. only:: subproject and html
>=20
>=20+
>=20
>=20+ =E7=9B=AE=E5=BD=95
>=20
>=20+ =3D=3D=3D=3D=3D
>=20
>=20+
>=20
>=20+ * :ref:`genindex`
>=20
>=20--=20
>=20
> 2.43.0
>

