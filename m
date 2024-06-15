Return-Path: <linux-kernel+bounces-215753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A939096A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1CB282C23
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB9F17BD5;
	Sat, 15 Jun 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPF2jJnc"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60252114
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438233; cv=none; b=YifRrlXinPWqqvTtxCDzeIVf3sw0ZmP30SSgB4U4WDvYnSFkAxzcwdPuOTPAzZf9NjGoHR1chkaSrbT66DUGxz+H0kVuJF94Sj5SHAw7lHCgFN1EzHkmrG7MAdTxG8h/dLg7G/TG0ZDRqFin15BoCOf9/pnsVs3gYxZpBDXweEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438233; c=relaxed/simple;
	bh=c/bOb9NWDptsEULHZ+RqVk523GacMXCf7Q2K9ZJNfxs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VZq+ZWyQqsOJoIUfgdVk8WSdjMc3lrwjzZAI4XQXlKGrwk3aFpu783GRYfTluhu+gtXoK3u1UlAOV+OigiX97YNVdutCOE2l980cWXAKw4xWwwIbH2ZV7Pk13aTBdbyLDlv3CB8Zn9z5OcRw7uCKZkE/v6WbUbAwpI59YPssRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPF2jJnc; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dzm91@hust.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718438228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVSXAEAYYJ5QMyoR3fNbtOAlxOQo54TXyZi3+aaydQ4=;
	b=FPF2jJncCwta4T01EGeYfiY17UD3oqcYrkY0qszUYvgdmBM2W8rwa4hFxJytza2w4YEfzR
	oT4m1ncc5mts+2whQq9g18S7ME5XLtF4EYuqyvuG+uPdE5da/oS5ILtiM0T0256lVMD28S
	ixwACTRpkqV9bD1WsUXaiHOzC9cgH90=
X-Envelope-To: corbet@lwn.net
X-Envelope-To: alexs@kernel.org
X-Envelope-To: siyanteng@loongson.cn
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 07:57:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <4da91d0b2a0dc580ffaa7c67ab1860c310387e10@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 2/2] doc-guide: add help documentation
 checktransupdate.rst
To: "Dongliang Mu" <dzm91@hust.edu.cn>, "Jonathan Corbet" <corbet@lwn.net>,
 "Alex Shi" <alexs@kernel.org>, "Yanteng Si" <siyanteng@loongson.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240615035323.909650-2-dzm91@hust.edu.cn>
References: <20240615035323.909650-1-dzm91@hust.edu.cn>
 <20240615035323.909650-2-dzm91@hust.edu.cn>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B46=E6=9C=8815=E6=97=A5 11:53, "Dongliang Mu" <dzm91@hust.edu.=
cn> =E5=86=99=E5=88=B0:



>=20
>=20This commit adds help documents - Documentation/doc-guide/checktransu=
pdate.rst
>=20
>=20and Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>=20
>=20for scripts/checktransupdate.py, including English and Chinese versio=
ns
>=20
>=20Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>=20
>=20---
>=20
>=20v1->v2: fix some issues according to Randy
>=20
>=20 Documentation/doc-guide/checktransupdate.rst | 63 ++++++++++++++++++=
+
>=20
>=20 Documentation/doc-guide/index.rst | 1 +
>=20
>=20 .../zh_CN/doc-guide/checktransupdate.rst | 62 ++++++++++++++++++
>=20
>=20 .../translations/zh_CN/doc-guide/index.rst | 1 +
>=20
>=20 4 files changed, 127 insertions(+)
>=20
>=20 create mode 100644 Documentation/doc-guide/checktransupdate.rst
>=20
>=20 create mode 100644 Documentation/translations/zh_CN/doc-guide/checkt=
ransupdate.rst
>=20
>=20diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documenta=
tion/doc-guide/checktransupdate.rst
>=20
>=20new file mode 100644
>=20
>=20index 000000000000..4ece330882d6
>=20
>=20--- /dev/null
>=20
>=20+++ b/Documentation/doc-guide/checktransupdate.rst
>=20
>=20@@ -0,0 +1,63 @@
>=20
>=20+.. SPDX-License-Identifier: GPL-2.0
>=20
>=20+
>=20
>=20+Check translation update
>=20
>=20+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Let's get rid of unnecessary symbols.
>=20
>=20+
>=20
>=20+This script helps track the translation status of the documentation =
in
>=20
>=20+different locales, i.e.,=C2=A0whether the documentation is up-to-dat=
e with
>=20
>=20+the English counterpart.
>=20
>=20+
>=20
>=20+How it works
>=20
>=20+------------
>=20
>=20+
>=20
>=20+It uses ``git log`` command to track the latest English commit from =
the
>=20
>=20+translation commit (order by author date) and the latest English com=
mits
>=20
>=20+from HEAD. If any differences occur, the file is considered as out-o=
f-date,
>=20
>=20+then commits that need to be updated will be collected and reported.
>=20
>=20+
>=20
>=20+Features implemented
>=20
>=20+--------------------
>=20
>=20+
>=20
>=20+- check all files in a certain locale
>=20
>=20+- check a single file or a set of files
>=20
>=20+- provide options to change output format
>=20
>=20+
>=20
>=20+Usage
>=20
>=20+-----
>=20
>=20+
>=20
>=20+::
>=20
>=20+
>=20
>=20+ checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-=
commits] [--print-updated-files | --no-print-updated-files] [--debug | --=
no-debug] [files ...]
>=20
>=20+
>=20
>=20+Options
>=20
>=20+~~~~~~~
>=20
>=20+
>=20
>=20+- ``-l``, ``--locale``: locale to check when file is not specified
>=20
>=20+- ``--[no-]print-commits``: whether to print commits between origin =
and
>=20
>=20+ translation
>=20
>=20+- ``--[no-]print-updated-files``: whether to print files that do no
>=20
>=20+ need to be updated
>=20
>=20+- ``files``: files to check, if this option is specified, the locale
>=20
>=20+ option will be ignored.
>=20
>=20+
>=20
>=20+Samples
>=20
>=20+~~~~~~~
>=20
>=20+
>=20
>=20+- ``./scripts/checktransupdate.py -l zh_CN``
>=20
>=20+ This will print all the files that need to be updated in the zh_CN =
locale.
>=20
>=20+- ``./scripts/checktransupdate.py Documentation/translations/zh_CN/p=
rocess/coding-style.rst``
>=20
>=20+ This will only print the status of the specified file.
>=20
>=20+
>=20
>=20+Then the output is something like:
>=20
>=20+
>=20
>=20+::
>=20
>=20+
>=20
>=20+ Documentation/translations/zh_CN/process/coding-style.rst (2 commit=
s)
>=20
>=20+ commit 6813216bbdba ("Documentation: coding-style: ask function-lik=
e macros to evaluate parameters")
>=20
>=20+ commit 185ea7676ef3 ("Documentation: coding-style: Update syntax hi=
ghlighting for code-blocks")
>=20
>=20+
>=20
>=20+Features to be implemented
>=20
>=20+----------------------------
ditto

>=20
>=20+
>=20
>=20+- track the translation status of files that have no translation
>=20
>=20+- files can be a folder instead of only a file
>=20
>=20diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-gu=
ide/index.rst
>=20
>=20index 7c7d97784626..24d058faa75c 100644
>=20
>=20--- a/Documentation/doc-guide/index.rst
>=20
>=20+++ b/Documentation/doc-guide/index.rst
>=20
>=20@@ -12,6 +12,7 @@ How to write kernel documentation
>=20
>=20 parse-headers
>=20
>=20 contributing
>=20
>=20 maintainer-profile
>=20
>=20+ checktransupdate
>=20
>=20=20
>=20
>  .. only:: subproject and html
>=20
>=20=20
>=20
> diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdat=
e.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>=20
>=20new file mode 100644
>=20
>=20index 000000000000..37c0bb518ab8
>=20
>=20--- /dev/null
>=20
>=20+++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>=20
>=20@@ -0,0 +1,62 @@
>=20
>=20+.. SPDX-License-Identifier: GPL-2.0
>=20
>=20+
>=20
>=20+.. include:: ../disclaimer-zh_CN.rst
>=20
>=20+
>=20
>=20+:Original: Documentation/doc-guide/checktransupdate.rst
>=20
>=20+
>=20
>=20+:=E8=AF=91=E8=80=85: =E6=85=95=E5=86=AC=E4=BA=AE Dongliang Mu <dzm91=
@hust.edu.cn>
>=20
>=20+
>=20
>=20+=E6=A3=80=E6=9F=A5=E7=BF=BB=E8=AF=91=E6=9B=B4=E6=96=B0
>=20
>=20+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ditto
>=20
>=20+
>=20
>=20+=E8=BF=99=E4=B8=AA=E8=84=9A=E6=9C=AC=E5=B8=AE=E5=8A=A9=E8=B7=9F=E8=
=B8=AA=E4=B8=8D=E5=90=8C=E8=AF=AD=E8=A8=80=E7=9A=84=E6=96=87=E6=A1=A3=E7=
=BF=BB=E8=AF=91=E7=8A=B6=E6=80=81=EF=BC=8C=E5=8D=B3=E6=96=87=E6=A1=A3=E6=
=98=AF=E5=90=A6=E4=B8=8E=E5=AF=B9=E5=BA=94=E7=9A=84=E8=8B=B1=E6=96=87=E7=
=89=88=E6=9C=AC=E4=BF=9D=E6=8C=81=E6=9B=B4=E6=96=B0=E3=80=82
>=20
>=20+
>=20
>=20+=E5=B7=A5=E4=BD=9C=E5=8E=9F=E7=90=86
>=20
>=20+------------
>=20
>=20+
>=20
>=20+=E5=AE=83=E4=BD=BF=E7=94=A8 ``git log`` =E5=91=BD=E4=BB=A4=E6=9D=A5=
=E8=B7=9F=E8=B8=AA=E7=BF=BB=E8=AF=91=E6=8F=90=E4=BA=A4=E7=9A=84=E6=9C=80=
=E6=96=B0=E8=8B=B1=E6=96=87=E6=8F=90=E4=BA=A4=EF=BC=88=E6=8C=89=E4=BD=9C=
=E8=80=85=E6=97=A5=E6=9C=9F=E6=8E=92=E5=BA=8F=EF=BC=89=E5=92=8C=E8=8B=B1=
=E6=96=87=E6=96=87=E6=A1=A3=E7=9A=84
>=20
>=20+=E6=9C=80=E6=96=B0=E6=8F=90=E4=BA=A4=E3=80=82=E5=A6=82=E6=9E=9C=E6=
=9C=89=E4=BB=BB=E4=BD=95=E5=B7=AE=E5=BC=82=EF=BC=8C=E5=88=99=E8=AF=A5=E6=
=96=87=E4=BB=B6=E8=A2=AB=E8=AE=A4=E4=B8=BA=E6=98=AF=E8=BF=87=E6=9C=9F=E7=
=9A=84=EF=BC=8C=E7=84=B6=E5=90=8E=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=
=9A=84=E6=8F=90=E4=BA=A4=E5=B0=86=E8=A2=AB=E6=94=B6=E9=9B=86=E5=B9=B6=E6=
=8A=A5=E5=91=8A=E3=80=82
>=20
>=20+
>=20
>=20+=E5=AE=9E=E7=8E=B0=E7=9A=84=E5=8A=9F=E8=83=BD
>=20
>=20+--------------------
ditto

...

>=20
>=20+
>=20
>=20+- =E6=A3=80=E6=9F=A5=E7=89=B9=E5=AE=9A=E8=AF=AD=E8=A8=80=E4=B8=AD=E7=
=9A=84=E6=89=80=E6=9C=89=E6=96=87=E4=BB=B6
>=20
>=20+- =E6=A3=80=E6=9F=A5=E5=8D=95=E4=B8=AA=E6=96=87=E4=BB=B6=E6=88=96=E4=
=B8=80=E7=BB=84=E6=96=87=E4=BB=B6
>=20
>=20+- =E6=8F=90=E4=BE=9B=E6=9B=B4=E6=94=B9=E8=BE=93=E5=87=BA=E6=A0=BC=E5=
=BC=8F=E7=9A=84=E9=80=89=E9=A1=B9
>=20
>=20+
>=20
>=20+=E7=94=A8=E6=B3=95
>=20
>=20+-----
>=20
>=20+
>=20
>=20+::
>=20
>=20+
>=20
>=20+ checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-=
commits] [--print-updated-files | --no-print-updated-files] [--debug | --=
no-debug] [files ...]
>=20
>=20+
>=20
>=20+=E9=80=89=E9=A1=B9
>=20
>=20+~~~~~~~
>=20
>=20+
>=20
>=20+- ``-l``, ``--locale``: =E6=A3=80=E6=9F=A5=E6=8C=87=E5=AE=9A=E7=9A=
=84=E6=96=87=E4=BB=B6=E8=AF=AD=E8=A8=80=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=9C=
=AA=E6=8C=87=E5=AE=9A=E6=96=87=E4=BB=B6
>=20
>=20+- ``--[no-]print-commits``: =E6=98=AF=E5=90=A6=E6=89=93=E5=8D=B0=E8=
=8B=B1=E6=96=87=E5=8E=9F=E5=A7=8B=E7=89=88=E6=9C=AC=E5=92=8C=E7=BF=BB=E8=
=AF=91=E7=89=88=E6=9C=AC=E4=B9=8B=E9=97=B4=E7=9A=84=E6=8F=90=E4=BA=A4
>=20
>=20+- ``--[no-]print-updated-files``: =E6=98=AF=E5=90=A6=E6=89=93=E5=8D=
=B0=E6=97=A0=E9=9C=80=E6=9B=B4=E6=96=B0=E7=9A=84=E6=96=87=E4=BB=B6
>=20
>=20+- ``files``: =E8=A6=81=E6=A3=80=E6=9F=A5=E7=9A=84=E6=96=87=E4=BB=B6=
=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=8C=87=E5=AE=9A=E4=BA=86=E6=AD=A4=E9=80=89=
=E9=A1=B9=EF=BC=8C=E5=B0=86=E5=BF=BD=E7=95=A5=E8=AF=AD=E8=A8=80=E9=80=89=
=E9=A1=B9
>=20
>=20+
>=20
>=20+=E7=A4=BA=E4=BE=8B
>=20
>=20+~~~~~~~

ditto


Thanks,
Yanteng
>=20
>=20+
>=20
>=20+- ``./scripts/checktransupdate.py -l zh_CN``
>=20
>=20+ =E8=BF=99=E5=B0=86=E6=89=93=E5=8D=B0 zh_CN =E8=AF=AD=E8=A8=80=E4=B8=
=AD=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=9A=84=E6=89=80=E6=9C=89=E6=96=
=87=E4=BB=B6=E3=80=82
>=20
>=20+- ``./scripts/checktransupdate.py Documentation/translations/zh_CN/p=
rocess/coding-style.rst``
>=20
>=20+ =E8=BF=99=E5=B0=86=E5=8F=AA=E6=89=93=E5=8D=B0=E6=8C=87=E5=AE=9A=E6=
=96=87=E4=BB=B6=E7=9A=84=E7=8A=B6=E6=80=81=E3=80=82
>=20
>=20+
>=20
>=20+=E7=84=B6=E5=90=8E=E8=BE=93=E5=87=BA=E7=B1=BB=E4=BC=BC=E5=A6=82=E4=
=B8=8B=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=9A
>=20
>=20+
>=20
>=20+::
>=20
>=20+
>=20
>=20+ Documentation/translations/zh_CN/process/coding-style.rst (2 commit=
s)
>=20
>=20+ commit 6813216bbdba ("Documentation: coding-style: ask function-lik=
e macros to evaluate parameters")
>=20
>=20+ commit 185ea7676ef3 ("Documentation: coding-style: Update syntax hi=
ghlighting for code-blocks")
>=20
>=20+
>=20
>=20+=E5=BE=85=E5=AE=9E=E7=8E=B0=E7=9A=84=E5=8A=9F=E8=83=BD
>=20
>=20+-------------
>=20
>=20+
>=20
>=20+- =E8=B7=9F=E8=B8=AA=E6=B2=A1=E6=9C=89=E7=BF=BB=E8=AF=91=E8=BF=87=E7=
=9A=84=E6=96=87=E4=BB=B6=E7=9A=84=E7=BF=BB=E8=AF=91=E7=8A=B6=E6=80=81
>=20
>=20+- =E6=96=87=E4=BB=B6=E5=8F=82=E6=95=B0=E5=8F=AF=E4=BB=A5=E6=98=AF=E6=
=96=87=E4=BB=B6=E5=A4=B9=E8=80=8C=E4=B8=8D=E4=BB=85=E4=BB=85=E6=98=AF=E5=
=8D=95=E4=B8=AA=E6=96=87=E4=BB=B6
>=20
>=20diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/D=
ocumentation/translations/zh_CN/doc-guide/index.rst
>=20
>=20index 78c2e9a1697f..0ac1fc9315ea 100644
>=20
>=20--- a/Documentation/translations/zh_CN/doc-guide/index.rst
>=20
>=20+++ b/Documentation/translations/zh_CN/doc-guide/index.rst
>=20
>=20@@ -18,6 +18,7 @@
>=20
>=20 parse-headers
>=20
>=20 contributing
>=20
>=20 maintainer-profile
>=20
>=20+ checktransupdate
>=20
>=20=20
>=20
>  .. only:: subproject and html
>=20
>=20=20
>=20
> --=20
>=20
> 2.39.2
>

