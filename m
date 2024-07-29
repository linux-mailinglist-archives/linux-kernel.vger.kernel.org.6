Return-Path: <linux-kernel+bounces-265323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B538293EF83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FB71C2199A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B7A13A272;
	Mon, 29 Jul 2024 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G/GKRs9m"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4999139D0B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240675; cv=none; b=afbflhHN9zE+MEwy3cLCEE8Zwoiwu40wNkmdLRgrfjSSa8t9Eb1X4FYaVLTjMpYuyMFTlcesPRGs9yCyWF5HJ7f28p4q6Xqba5L8WEfjHRLD9SLIkf81a8wwBXPi8eJJi9Is3Q8vw4vK/Uyjxqn7i2M79TU+9w9mkXIaZuVMIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240675; c=relaxed/simple;
	bh=QaIO5njRFXj8oeeB7yYdlH9NERJ6srzt2pQ3WjZOfdE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fTKasi8VVkzohTr4/XOXXaqOfRvLhXxUa6GDfd/ls2aSoPzdcb7GgiviDrVaiogrspN+YVRy8XuZMQbaHAnXgl9kHR2SUumwtYfV6Obd87bxXwi+STxMnxPd9juzIVjLlKZ1ul6ensUBvcLk4Xxr/zSTpGOndb28ZOoyYRgNzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G/GKRs9m; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722240670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0+UkPK73KJlf5FYSNhfZfkVNEH/F6z+Hh5riM5OSDo=;
	b=G/GKRs9m/Hdee/JkzaBjoJOcAqbpQ2ARGpIJKnTbpfKQwQFJ9+FWvxxin+u0Ia95Qwb66O
	8hI5HQOizX07/DlJ4xCd+9G2Yri2vfsUxCOTwUOlvfOuy69Gwmu136mGO34WRAx8Qu1sHO
	1RV2+GDVAS1ToHNX6c6HBFt/W4VX6a8=
Date: Mon, 29 Jul 2024 08:11:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <4af1a31c723f18699965c0f3fba49ca2f2b34dec@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of security-bugs
To: "Dongliang Mu" <dzm91@hust.edu.cn>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <siyanteng@loongson.cn>, "Jonathan Corbet" <corbet@lwn.net>,
 "Hu Haowen" <2023002089@link.tyut.edu.cn>, "Konstantin Ryabitsev"
 <konstantin@linuxfoundation.org>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e80ef726-fc2a-4bbf-b61f-d1419179eda6@hust.edu.cn>
References: <20240611020514.48770-1-dzm91@hust.edu.cn>
 <e80ef726-fc2a-4bbf-b61f-d1419179eda6@hust.edu.cn>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B47=E6=9C=8826=E6=97=A5 21:21, "Dongliang Mu" <dzm91@hust.edu.=
cn> =E5=86=99=E5=88=B0:



>=20
>=20ping?
>=20
>=20On 2024/6/11 10:04, Dongliang Mu wrote:
>=20
>=20>=20
>=20> Update to commit 5928d411557e ("Documentation: Document the Linux K=
ernel
> >=20
>=20>  CVE process")
> >=20
>=20>  commit 0217f3944aeb ("Documentation: security-bugs.rst: linux-dist=
ros
> >=20
>=20>  relaxed their rules")
> >=20
>=20>  commit 3c1897ae4b6b ("Documentation: security-bugs.rst: clarify CV=
E
> >=20
>=20>  handling")
> >=20
>=20>  commit 4fee0915e649 ("Documentation: security-bugs.rst: update
> >=20
>=20>  preferences when dealing with the linux-distros group")
> >=20
>=20>  commit 44ac5abac86b ("Documentation/security-bugs: move from admin=
-guide/
> >=20
>=20>  to process/")
> >=20
>=20>  Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thanks,
Yanteng
> >=20
>=20>  ---
> >=20
>=20>  v2->v3: revise the references in zh_TW
> >=20
>=20>  v1->v2: remove admin-guide/security-bugs, and revise all its refer=
ences
> >=20
>=20>  .../translations/zh_CN/admin-guide/index.rst | 1 -
> >=20
>=20>  .../zh_CN/admin-guide/reporting-issues.rst | 4 +-
> >=20
>=20>  .../translations/zh_CN/process/index.rst | 3 +-
> >=20
>=20>  .../security-bugs.rst | 42 ++++++++++++-------
> >=20
>=20>  .../zh_CN/process/submitting-patches.rst | 2 +-
> >=20
>=20>  .../zh_TW/admin-guide/reporting-issues.rst | 4 +-
> >=20
>=20>  .../zh_TW/process/submitting-patches.rst | 2 +-
> >=20
>=20>  7 files changed, 34 insertions(+), 24 deletions(-)
> >=20
>=20>  rename Documentation/translations/zh_CN/{admin-guide =3D> process}=
/security-bugs.rst (57%)
> >=20
>=20>  diff --git a/Documentation/translations/zh_CN/admin-guide/index.rs=
t b/Documentation/translations/zh_CN/admin-guide/index.rst
> >=20
>=20>  index ac2960da33e6..773c53956000 100644
> >=20
>=20>  --- a/Documentation/translations/zh_CN/admin-guide/index.rst
> >=20
>=20>  +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
> >=20
>=20>  @@ -37,7 +37,6 @@ Todolist:
> >=20
>=20>  > reporting-issues
> >=20
>=20>  reporting-regressions
> >=20
>=20>  - security-bugs
> >=20
>=20>  bug-hunting
> >=20
>=20>  bug-bisect
> >=20
>=20>  tainted-kernels
> >=20
>=20>  diff --git a/Documentation/translations/zh_CN/admin-guide/reportin=
g-issues.rst b/Documentation/translations/zh_CN/admin-guide/reporting-iss=
ues.rst
> >=20
>=20>  index 59e51e3539b4..9ff4ba94391d 100644
> >=20
>=20>  --- a/Documentation/translations/zh_CN/admin-guide/reporting-issue=
s.rst
> >=20
>=20>  +++ b/Documentation/translations/zh_CN/admin-guide/reporting-issue=
s.rst
> >=20
>=20>  @@ -300,7 +300,7 @@ Documentation/admin-guide/reporting-regression=
s.rst =E5=AF=B9=E6=AD=A4=E8=BF=9B=E8=A1=8C=E4=BA=86=E6=9B=B4=E8=AF=A6=E7=
=BB=86=E7=9A=84
> >=20
>=20>  =E6=B7=BB=E5=8A=A0=E5=88=B0=E5=9B=9E=E5=BD=92=E8=B7=9F=E8=B8=AA=E5=
=88=97=E8=A1=A8=E4=B8=AD=EF=BC=8C=E4=BB=A5=E7=A1=AE=E4=BF=9D=E5=AE=83=E4=
=B8=8D=E4=BC=9A=E8=A2=AB=E5=BF=BD=E7=95=A5=E3=80=82
> >=20
>=20>  > =E4=BB=80=E4=B9=88=E6=98=AF=E5=AE=89=E5=85=A8=E9=97=AE=E9=A2=98=
=E7=95=99=E7=BB=99=E6=82=A8=E8=87=AA=E5=B7=B1=E5=88=A4=E6=96=AD=E3=80=82=
=E5=9C=A8=E7=BB=A7=E7=BB=AD=E4=B9=8B=E5=89=8D=EF=BC=8C=E8=AF=B7=E8=80=83=
=E8=99=91=E9=98=85=E8=AF=BB
> >=20
>=20>  -Documentation/translations/zh_CN/admin-guide/security-bugs.rst =
=EF=BC=8C
> >=20
>=20>  +Documentation/translations/zh_CN/process/security-bugs.rst =EF=BC=
=8C
> >=20
>=20>  =E5=9B=A0=E4=B8=BA=E5=AE=83=E6=8F=90=E4=BE=9B=E4=BA=86=E5=A6=82=E4=
=BD=95=E6=9C=80=E6=81=B0=E5=BD=93=E5=9C=B0=E5=A4=84=E7=90=86=E5=AE=89=E5=
=85=A8=E9=97=AE=E9=A2=98=E7=9A=84=E9=A2=9D=E5=A4=96=E7=BB=86=E8=8A=82=E3=
=80=82
> >=20
>=20>  > =E5=BD=93=E5=8F=91=E7=94=9F=E4=BA=86=E5=AE=8C=E5=85=A8=E6=97=A0=
=E6=B3=95=E6=8E=A5=E5=8F=97=E7=9A=84=E7=B3=9F=E7=B3=95=E4=BA=8B=E6=83=85=
=E6=97=B6=EF=BC=8C=E6=AD=A4=E9=97=AE=E9=A2=98=E5=B0=B1=E6=98=AF=E4=B8=80=
=E4=B8=AA=E2=80=9C=E9=9D=9E=E5=B8=B8=E4=B8=A5=E9=87=8D=E7=9A=84=E9=97=AE=
=E9=A2=98=E2=80=9D=E3=80=82=E4=BE=8B=E5=A6=82=EF=BC=8C
> >=20
>=20>  @@ -983,7 +983,7 @@ Documentation/admin-guide/reporting-regression=
s.rst =EF=BC=9B=E5=AE=83=E8=BF=98=E6=8F=90=E4=BE=9B=E4=BA=86=E5=A4=A7=E9=
=87=8F=E5=85=B6
> >=20
>=20>  =E6=8A=A5=E5=91=8A=EF=BC=8C=E8=AF=B7=E5=B0=86=E6=8A=A5=E5=91=8A=E7=
=9A=84=E6=96=87=E6=9C=AC=E8=BD=AC=E5=8F=91=E5=88=B0=E8=BF=99=E4=BA=9B=E5=
=9C=B0=E5=9D=80=EF=BC=9B=E4=BD=86=E8=AF=B7=E5=9C=A8=E6=8A=A5=E5=91=8A=E7=
=9A=84=E9=A1=B6=E9=83=A8=E5=8A=A0=E4=B8=8A=E6=B3=A8=E9=87=8A=EF=BC=8C=E8=
=A1=A8=E6=98=8E=E6=82=A8=E6=8F=90=E4=BA=A4=E4=BA=86
> >=20
>=20>  =E6=8A=A5=E5=91=8A=EF=BC=8C=E5=B9=B6=E9=99=84=E4=B8=8A=E5=B7=A5=E5=
=8D=95=E9=93=BE=E6=8E=A5=E3=80=82
> >=20
>=20>  > -=E6=9B=B4=E5=A4=9A=E4=BF=A1=E6=81=AF=E8=AF=B7=E5=8F=82=E8=A7=81=
 Documentation/translations/zh_CN/admin-guide/security-bugs.rst =E3=80=82
> >=20
>=20>  +=E6=9B=B4=E5=A4=9A=E4=BF=A1=E6=81=AF=E8=AF=B7=E5=8F=82=E8=A7=81 D=
ocumentation/translations/zh_CN/process/security-bugs.rst =E3=80=82
> >=20
>=20>  > > =E5=8F=91=E5=B8=83=E6=8A=A5=E5=91=8A=E5=90=8E=E7=9A=84=E8=B4=
=A3=E4=BB=BB
> >=20
>=20>  diff --git a/Documentation/translations/zh_CN/process/index.rst b/=
Documentation/translations/zh_CN/process/index.rst
> >=20
>=20>  index 5c6c8ccdd50d..011dc2cf583a 100644
> >=20
>=20>  --- a/Documentation/translations/zh_CN/process/index.rst
> >=20
>=20>  +++ b/Documentation/translations/zh_CN/process/index.rst
> >=20
>=20>  @@ -49,10 +49,11 @@ TODOLIST:
> >=20
>=20>  > embargoed-hardware-issues
> >=20
>=20>  cve
> >=20
>=20>  + security-bugs
> >=20
>=20>  > TODOLIST:
> >=20
>=20>  > -* security-bugs
> >=20
>=20>  +* handling-regressions
> >=20
>=20>  > =E5=85=B6=E5=AE=83=E5=A4=A7=E5=A4=9A=E6=95=B0=E5=BC=80=E5=8F=91=
=E4=BA=BA=E5=91=98=E6=84=9F=E5=85=B4=E8=B6=A3=E7=9A=84=E7=A4=BE=E5=8C=BA=
=E6=8C=87=E5=8D=97=EF=BC=9A
> >=20
>=20>  > diff --git a/Documentation/translations/zh_CN/admin-guide/securi=
ty-bugs.rst b/Documentation/translations/zh_CN/process/security-bugs.rst
> >=20
>=20>  similarity index 57%
> >=20
>=20>  rename from Documentation/translations/zh_CN/admin-guide/security-=
bugs.rst
> >=20
>=20>  rename to Documentation/translations/zh_CN/process/security-bugs.r=
st
> >=20
>=20>  index d6b8f8a4e7f6..a8f5fcbfadc9 100644
> >=20
>=20>  --- a/Documentation/translations/zh_CN/admin-guide/security-bugs.r=
st
> >=20
>=20>  +++ b/Documentation/translations/zh_CN/process/security-bugs.rst
> >=20
>=20>  @@ -1,3 +1,5 @@
> >=20
>=20>  +.. SPDX-License-Identifier: GPL-2.0-or-later
> >=20
>=20>  +
> >=20
>=20>  .. include:: ../disclaimer-zh_CN.rst
> >=20
>=20>  > :Original: :doc:`../../../process/security-bugs`
> >=20
>=20>  @@ -5,6 +7,7 @@
> >=20
>=20>  :=E8=AF=91=E8=80=85:
> >=20
>=20>  > =E5=90=B4=E6=83=B3=E6=88=90 Wu XiangCheng <bobwxc@email.cn>
> >=20
>=20>  + =E6=85=95=E5=86=AC=E4=BA=AE Dongliang Mu <dzm91@hust.edu.cn>
> >=20
>=20>  > =E5=AE=89=E5=85=A8=E7=BC=BA=E9=99=B7
> >=20
>=20>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
>=20>  @@ -17,13 +20,13 @@ Linux=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E4=
=BA=BA=E5=91=98=E9=9D=9E=E5=B8=B8=E9=87=8D=E8=A7=86=E5=AE=89=E5=85=A8=E6=
=80=A7=E3=80=82=E5=9B=A0=E6=AD=A4=E6=88=91=E4=BB=AC=E6=83=B3=E7=9F=A5=E9=
=81=93=E4=BD=95=E6=97=B6=E5=8F=91=E7=8E=B0
> >=20
>=20>  > =E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6<security@kernel.org>=E8=81=94=E7=B3=BBLinux=E5=86=85=E6=A0=B8=
=E5=AE=89=E5=85=A8=E5=9B=A2=E9=98=9F=E3=80=82=E8=BF=99=E6=98=AF=E4=B8=80=
=E4=B8=AA=E5=AE=89=E5=85=A8=E4=BA=BA=E5=91=98
> >=20
>=20>  =E7=9A=84=E7=A7=81=E6=9C=89=E5=88=97=E8=A1=A8=EF=BC=8C=E4=BB=96=E4=
=BB=AC=E5=B0=86=E5=B8=AE=E5=8A=A9=E9=AA=8C=E8=AF=81=E9=94=99=E8=AF=AF=E6=
=8A=A5=E5=91=8A=E5=B9=B6=E5=BC=80=E5=8F=91=E5=92=8C=E5=8F=91=E5=B8=83=E4=
=BF=AE=E5=A4=8D=E7=A8=8B=E5=BA=8F=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E5=
=B7=B2=E7=BB=8F=E6=9C=89=E4=BA=86=E4=B8=80=E4=B8=AA
> >=20
>=20>  -=E4=BF=AE=E5=A4=8D=EF=BC=8C=E8=AF=B7=E5=B0=86=E5=85=B6=E5=8C=85=
=E5=90=AB=E5=9C=A8=E6=82=A8=E7=9A=84=E6=8A=A5=E5=91=8A=E4=B8=AD=EF=BC=8C=
=E8=BF=99=E6=A0=B7=E5=8F=AF=E4=BB=A5=E5=A4=A7=E5=A4=A7=E5=8A=A0=E5=BF=AB=
=E8=BF=9B=E7=A8=8B=E3=80=82=E5=AE=89=E5=85=A8=E5=9B=A2=E9=98=9F=E5=8F=AF=
=E8=83=BD=E4=BC=9A=E4=BB=8E=E5=8C=BA=E5=9F=9F=E7=BB=B4=E6=8A=A4
> >=20
>=20>  +=E4=BF=AE=E5=A4=8D=EF=BC=8C=E8=AF=B7=E5=B0=86=E5=85=B6=E5=8C=85=
=E5=90=AB=E5=9C=A8=E6=82=A8=E7=9A=84=E6=8A=A5=E5=91=8A=E4=B8=AD=EF=BC=8C=
=E8=BF=99=E6=A0=B7=E5=8F=AF=E4=BB=A5=E5=A4=A7=E5=A4=A7=E5=8A=A0=E5=BF=AB=
=E5=A4=84=E7=90=86=E8=BF=9B=E7=A8=8B=E3=80=82=E5=AE=89=E5=85=A8=E5=9B=A2=
=E9=98=9F=E5=8F=AF=E8=83=BD=E4=BC=9A=E4=BB=8E=E5=8C=BA=E5=9F=9F=E7=BB=B4=
=E6=8A=A4
> >=20
>=20>  =E4=BA=BA=E5=91=98=E9=82=A3=E9=87=8C=E8=8E=B7=E5=BE=97=E9=A2=9D=E5=
=A4=96=E7=9A=84=E5=B8=AE=E5=8A=A9=EF=BC=8C=E4=BB=A5=E7=90=86=E8=A7=A3=E5=
=92=8C=E4=BF=AE=E5=A4=8D=E5=AE=89=E5=85=A8=E6=BC=8F=E6=B4=9E=E3=80=82
> >=20
>=20>  > =E4=B8=8E=E4=BB=BB=E4=BD=95=E7=BC=BA=E9=99=B7=E4=B8=80=E6=A0=B7=
=EF=BC=8C=E6=8F=90=E4=BE=9B=E7=9A=84=E4=BF=A1=E6=81=AF=E8=B6=8A=E5=A4=9A=
=EF=BC=8C=E8=AF=8A=E6=96=AD=E5=92=8C=E4=BF=AE=E5=A4=8D=E5=B0=B1=E8=B6=8A=
=E5=AE=B9=E6=98=93=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E6=B8=85=
=E6=A5=9A=E5=93=AA=E4=BA=9B=E4=BF=A1=E6=81=AF=E6=9C=89=E7=94=A8=EF=BC=8C
> >=20
>=20>  =E8=AF=B7=E6=9F=A5=E7=9C=8B=E2=80=9CDocumentation/translations/zh_=
CN/admin-guide/reporting-issues.rst=E2=80=9D=E4=B8=AD
> >=20
>=20>  -=E6=A6=82=E8=BF=B0=E7=9A=84=E6=AD=A5=E9=AA=A4=E3=80=82=E4=BB=BB=
=E4=BD=95=E5=88=A9=E7=94=A8=E6=BC=8F=E6=B4=9E=E7=9A=84=E6=94=BB=E5=87=BB=
=E4=BB=A3=E7=A0=81=E9=83=BD=E9=9D=9E=E5=B8=B8=E6=9C=89=E7=94=A8=EF=BC=8C=
=E6=9C=AA=E7=BB=8F=E6=8A=A5=E5=91=8A=E8=80=85=E5=90=8C=E6=84=8F=E4=B8=8D=
=E4=BC=9A=E5=AF=B9=E5=A4=96=E5=8F=91=E5=B8=83=EF=BC=8C=E9=99=A4
> >=20
>=20>  -=E9=9D=9E=E5=B7=B2=E7=BB=8F=E5=85=AC=E5=BC=80=E3=80=82
> >=20
>=20>  +=E6=A6=82=E8=BF=B0=E7=9A=84=E6=AD=A5=E9=AA=A4=E3=80=82=E4=BB=BB=
=E4=BD=95=E5=88=A9=E7=94=A8=E6=BC=8F=E6=B4=9E=E7=9A=84=E6=94=BB=E5=87=BB=
=E4=BB=A3=E7=A0=81=E9=83=BD=E9=9D=9E=E5=B8=B8=E6=9C=89=E7=94=A8=EF=BC=8C=
=E6=9C=AA=E7=BB=8F=E6=8A=A5=E5=91=8A=E8=80=85=E5=90=8C=E6=84=8F=E4=B8=8D=
=E4=BC=9A=E5=AF=B9=E5=A4=96=E5=8F=91=E5=B8=83=EF=BC=8C
> >=20
>=20>  +=E9=99=A4=E9=9D=9E=E5=B7=B2=E7=BB=8F=E5=85=AC=E5=BC=80=E3=80=82
> >=20
>=20>  > =E8=AF=B7=E5=B0=BD=E5=8F=AF=E8=83=BD=E5=8F=91=E9=80=81=E6=97=A0=
=E9=99=84=E4=BB=B6=E7=9A=84=E7=BA=AF=E6=96=87=E6=9C=AC=E7=94=B5=E5=AD=90=
=E9=82=AE=E4=BB=B6=E3=80=82=E5=A6=82=E6=9E=9C=E6=89=80=E6=9C=89=E7=9A=84=
=E7=BB=86=E8=8A=82=E9=83=BD=E8=97=8F=E5=9C=A8=E9=99=84=E4=BB=B6=E9=87=8C=
=EF=BC=8C=E9=82=A3=E4=B9=88=E5=B0=B1=E5=BE=88=E9=9A=BE=E5=AF=B9
> >=20
>=20>  =E4=B8=80=E4=B8=AA=E5=A4=8D=E6=9D=82=E7=9A=84=E9=97=AE=E9=A2=98=E8=
=BF=9B=E8=A1=8C=E4=B8=8A=E4=B8=8B=E6=96=87=E5=BC=95=E7=94=A8=E7=9A=84=E8=
=AE=A8=E8=AE=BA=E3=80=82=E6=8A=8A=E5=AE=83=E6=83=B3=E8=B1=A1=E6=88=90=E4=
=B8=80=E4=B8=AA
> >=20
>=20>  @@ -49,24 +52,31 @@ Linux=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E4=
=BA=BA=E5=91=98=E9=9D=9E=E5=B8=B8=E9=87=8D=E8=A7=86=E5=AE=89=E5=85=A8=E6=
=80=A7=E3=80=82=E5=9B=A0=E6=AD=A4=E6=88=91=E4=BB=AC=E6=83=B3=E7=9F=A5=E9=
=81=93=E4=BD=95=E6=97=B6=E5=8F=91=E7=8E=B0
> >=20
>=20>  =E6=8D=A2=E5=8F=A5=E8=AF=9D=E8=AF=B4=EF=BC=8C=E6=88=91=E4=BB=AC=E5=
=94=AF=E4=B8=80=E6=84=9F=E5=85=B4=E8=B6=A3=E7=9A=84=E6=98=AF=E4=BF=AE=E5=
=A4=8D=E7=BC=BA=E9=99=B7=E3=80=82=E6=8F=90=E4=BA=A4=E7=BB=99=E5=AE=89=E5=
=85=A8=E5=88=97=E8=A1=A8=E7=9A=84=E6=89=80=E6=9C=89=E5=85=B6=E4=BB=96=E8=
=B5=84=E6=96=99=E4=BB=A5=E5=8F=8A=E5=AF=B9=E6=8A=A5=E5=91=8A
> >=20
>=20>  =E7=9A=84=E4=BB=BB=E4=BD=95=E5=90=8E=E7=BB=AD=E8=AE=A8=E8=AE=BA=EF=
=BC=8C=E5=8D=B3=E4=BD=BF=E5=9C=A8=E8=A7=A3=E9=99=A4=E9=99=90=E5=88=B6=E4=
=B9=8B=E5=90=8E=EF=BC=8C=E4=B9=9F=E5=B0=86=E6=B0=B8=E4=B9=85=E4=BF=9D=E5=
=AF=86=E3=80=82
> >=20
>=20>  > -=E5=8D=8F=E8=B0=83
> >=20
>=20>  -------
> >=20
>=20>  +=E4=B8=8E=E5=85=B6=E4=BB=96=E5=9B=A2=E9=98=9F=E5=8D=8F=E8=B0=83
> >=20
>=20>  +--------------
> >=20
>=20>  +
> >=20
>=20>  +=E8=99=BD=E7=84=B6=E5=86=85=E6=A0=B8=E5=AE=89=E5=85=A8=E5=9B=A2=
=E9=98=9F=E4=BB=85=E5=85=B3=E6=B3=A8=E4=BF=AE=E5=A4=8D=E6=BC=8F=E6=B4=9E=
=EF=BC=8C=E4=BD=86=E8=BF=98=E6=9C=89=E5=85=B6=E4=BB=96=E7=BB=84=E7=BB=87=
=E5=85=B3=E6=B3=A8=E4=BF=AE=E5=A4=8D=E5=8F=91=E8=A1=8C=E7=89=88=E4=B8=8A=
=E7=9A=84=E5=AE=89=E5=85=A8=E9=97=AE=E9=A2=98=E4=BB=A5=E5=8F=8A=E5=8D=8F=
=E8=B0=83
> >=20
>=20>  +=E6=93=8D=E4=BD=9C=E7=B3=BB=E7=BB=9F=E5=8E=82=E5=95=86=E7=9A=84=
=E6=BC=8F=E6=B4=9E=E6=8A=AB=E9=9C=B2=E3=80=82=E5=8D=8F=E8=B0=83=E9=80=9A=
=E5=B8=B8=E7=94=B1 "linux-distros" =E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8=
=E5=A4=84=E7=90=86=EF=BC=8C=E8=80=8C=E6=8A=AB=E9=9C=B2=E5=88=99=E7=94=B1
> >=20
>=20>  +=E5=85=AC=E5=85=B1 "oss-security" =E9=82=AE=E4=BB=B6=E5=88=97=E8=
=A1=A8=E8=BF=9B=E8=A1=8C=E3=80=82=E4=B8=A4=E8=80=85=E7=B4=A7=E5=AF=86=E5=
=85=B3=E8=81=94=E4=B8=94=E8=A2=AB=E5=B1=95=E7=A4=BA=E5=9C=A8 linux-distro=
s =E7=BB=B4=E5=9F=BA=EF=BC=9A
> >=20
>=20>  +<https://oss-security.openwall.org/wiki/mailing-lists/distros> ht=
tps://oss-security.openwall.org/wiki/mailing-lists/distros%3E=20
>=20>=20
>=20>  +
> >=20
>=20>  +=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E8=BF=99=E4=B8=89=E4=B8=AA=
=E5=88=97=E8=A1=A8=E7=9A=84=E5=90=84=E8=87=AA=E6=94=BF=E7=AD=96=E5=92=8C=
=E8=A7=84=E5=88=99=E6=98=AF=E4=B8=8D=E5=90=8C=E7=9A=84=EF=BC=8C=E5=9B=A0=
=E4=B8=BA=E5=AE=83=E4=BB=AC=E8=BF=BD=E6=B1=82=E4=B8=8D=E5=90=8C=E7=9A=84=
=E7=9B=AE=E6=A0=87=E3=80=82=E5=86=85=E6=A0=B8=E5=AE=89=E5=85=A8=E5=9B=A2=
=E9=98=9F
> >=20
>=20>  +=E4=B8=8E=E5=85=B6=E4=BB=96=E5=9B=A2=E9=98=9F=E4=B9=8B=E9=97=B4=
=E7=9A=84=E5=8D=8F=E8=B0=83=E5=BE=88=E5=9B=B0=E9=9A=BE=EF=BC=8C=E5=9B=A0=
=E4=B8=BA=E5=AF=B9=E4=BA=8E=E5=86=85=E6=A0=B8=E5=AE=89=E5=85=A8=E5=9B=A2=
=E9=98=9F=EF=BC=8C=E4=BF=9D=E5=AF=86=E6=9C=9F=EF=BC=88=E5=8D=B3=E6=9C=80=
=E5=A4=A7=E5=85=81=E8=AE=B8=E5=A4=A9=E6=95=B0=EF=BC=89=E6=98=AF=E4=BB=8E=
=E8=A1=A5=E4=B8=81
> >=20
>=20>  +=E5=8F=AF=E7=94=A8=E6=97=B6=E5=BC=80=E5=A7=8B=EF=BC=8C=E8=80=8C "=
linux-distros" =E5=88=99=E4=BB=8E=E9=A6=96=E6=AC=A1=E5=8F=91=E5=B8=83=E5=
=88=B0=E5=88=97=E8=A1=A8=E6=97=B6=E5=BC=80=E5=A7=8B=E8=AE=A1=E7=AE=97=EF=
=BC=8C=E6=97=A0=E8=AE=BA=E6=98=AF=E5=90=A6=E5=AD=98=E5=9C=A8=E8=A1=A5=E4=
=B8=81=E3=80=82
> >=20
>=20>  > -=E5=AF=B9=E6=95=8F=E6=84=9F=E7=BC=BA=E9=99=B7=EF=BC=88=E4=BE=8B=
=E5=A6=82=E9=82=A3=E4=BA=9B=E5=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E6=9D=83=
=E9=99=90=E6=8F=90=E5=8D=87=E7=9A=84=E7=BC=BA=E9=99=B7=EF=BC=89=E7=9A=84=
=E4=BF=AE=E5=A4=8D=E5=8F=AF=E8=83=BD=E9=9C=80=E8=A6=81=E4=B8=8E=E7=A7=81=
=E6=9C=89=E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8
> >=20
>=20>  -<linux-distros@vs.openwall.org>=E8=BF=9B=E8=A1=8C=E5=8D=8F=E8=B0=
=83=EF=BC=8C=E4=BB=A5=E4=BE=BF=E5=88=86=E5=8F=91=E4=BE=9B=E5=BA=94=E5=95=
=86=E5=81=9A=E5=A5=BD=E5=87=86=E5=A4=87=EF=BC=8C=E5=9C=A8=E5=85=AC=E5=BC=
=80=E6=8A=AB=E9=9C=B2
> >=20
>=20>  -=E4=B8=8A=E6=B8=B8=E8=A1=A5=E4=B8=81=E6=97=B6=E5=8F=91=E5=B8=83=
=E4=B8=80=E4=B8=AA=E5=B7=B2=E4=BF=AE=E5=A4=8D=E7=9A=84=E5=86=85=E6=A0=B8=
=E3=80=82=E5=8F=91=E8=A1=8C=E7=89=88=E5=B0=86=E9=9C=80=E8=A6=81=E4=B8=80=
=E4=BA=9B=E6=97=B6=E9=97=B4=E6=9D=A5=E6=B5=8B=E8=AF=95=E5=BB=BA=E8=AE=AE=
=E7=9A=84=E8=A1=A5=E4=B8=81=EF=BC=8C=E9=80=9A=E5=B8=B8
> >=20
>=20>  -=E4=BC=9A=E8=A6=81=E6=B1=82=E8=87=B3=E5=B0=91=E5=87=A0=E5=A4=A9=
=E7=9A=84=E9=99=90=E5=88=B6=EF=BC=8C=E8=80=8C=E4=BE=9B=E5=BA=94=E5=95=86=
=E6=9B=B4=E6=96=B0=E5=8F=91=E5=B8=83=E6=9B=B4=E5=80=BE=E5=90=91=E4=BA=8E=
=E5=91=A8=E4=BA=8C=E8=87=B3=E5=91=A8=E5=9B=9B=E3=80=82=E8=8B=A5=E5=90=88=
=E9=80=82=EF=BC=8C=E5=AE=89=E5=85=A8=E5=9B=A2=E9=98=9F
> >=20
>=20>  -=E5=8F=AF=E4=BB=A5=E5=8D=8F=E5=8A=A9=E8=BF=99=E7=A7=8D=E5=8D=8F=
=E8=B0=83=EF=BC=8C=E6=88=96=E8=80=85=E6=8A=A5=E5=91=8A=E8=80=85=E5=8F=AF=
=E4=BB=A5=E4=BB=8E=E4=B8=80=E5=BC=80=E5=A7=8B=E5=B0=B1=E5=8C=85=E6=8B=ACl=
inux=E5=8F=91=E8=A1=8C=E7=89=88=E3=80=82=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=83=
=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E8=AF=B7
> >=20
>=20>  -=E8=AE=B0=E4=BD=8F=E5=9C=A8=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=
=E4=B8=BB=E9=A2=98=E8=A1=8C=E5=89=8D=E9=9D=A2=E5=8A=A0=E4=B8=8A=E2=80=9C[=
vs]=E2=80=9D=EF=BC=8C=E5=A6=82linux=E5=8F=91=E8=A1=8C=E7=89=88wiki=E4=B8=
=AD=E6=89=80=E8=BF=B0=EF=BC=9A
> >=20
>=20>  -<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-=
to-use-the-lists>%E3%80%82 http://oss-security.openwall.org/wiki/mailing-=
lists/distros#how-to-use-the-lists%3E%E3%80%82=20
>=20>=20
>=20>  +=E5=9B=A0=E6=AD=A4=EF=BC=8C=E5=86=85=E6=A0=B8=E5=AE=89=E5=85=A8=
=E5=9B=A2=E9=98=9F=E5=BC=BA=E7=83=88=E5=BB=BA=E8=AE=AE=EF=BC=8C=E4=BD=9C=
=E4=B8=BA=E4=B8=80=E4=BD=8D=E6=BD=9C=E5=9C=A8=E5=AE=89=E5=85=A8=E9=97=AE=
=E9=A2=98=E7=9A=84=E6=8A=A5=E5=91=8A=E8=80=85=EF=BC=8C=E5=9C=A8=E5=8F=97=
=E5=BD=B1=E5=93=8D=E4=BB=A3=E7=A0=81=E7=9A=84=E7=BB=B4=E6=8A=A4=E8=80=85
> >=20
>=20>  +=E6=8E=A5=E5=8F=97=E8=A1=A5=E4=B8=81=E4=B9=8B=E5=89=8D=EF=BC=8C=
=E4=B8=94=E5=9C=A8=E6=82=A8=E9=98=85=E8=AF=BB=E4=B8=8A=E8=BF=B0=E5=8F=91=
=E8=A1=8C=E7=89=88=E7=BB=B4=E5=9F=BA=E9=A1=B5=E9=9D=A2=E5=B9=B6=E5=AE=8C=
=E5=85=A8=E7=90=86=E8=A7=A3=E8=81=94=E7=B3=BB "linux-distros"
> >=20
>=20>  +=E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8=E4=BC=9A=E5=AF=B9=E6=82=A8=
=E5=92=8C=E5=86=85=E6=A0=B8=E7=A4=BE=E5=8C=BA=E6=96=BD=E5=8A=A0=E7=9A=84=
=E8=A6=81=E6=B1=82=E4=B9=8B=E5=89=8D=EF=BC=8C=E4=B8=8D=E8=A6=81=E8=81=94=
=E7=B3=BB "linux-distros" =E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8=E3=80=82
> >=20
>=20>  +=E8=BF=99=E4=B9=9F=E6=84=8F=E5=91=B3=E7=9D=80=E9=80=9A=E5=B8=B8=
=E6=83=85=E5=86=B5=E4=B8=8B=E4=B8=8D=E8=A6=81=E5=90=8C=E6=97=B6=E6=8A=84=
=E9=80=81=E4=B8=A4=E4=B8=AA=E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8=EF=BC=8C=
=E9=99=A4=E9=9D=9E=E5=9C=A8=E5=8D=8F=E8=B0=83=E6=97=B6=E6=9C=89=E5=B7=B2=
=E6=8E=A5=E5=8F=97=E4=BD=86=E5=B0=9A=E6=9C=AA=E5=90=88=E5=B9=B6=E7=9A=84=
=E8=A1=A5=E4=B8=81=E3=80=82
> >=20
>=20>  +=E6=8D=A2=E5=8F=A5=E8=AF=9D=E8=AF=B4=EF=BC=8C=E5=9C=A8=E8=A1=A5=
=E4=B8=81=E8=A2=AB=E6=8E=A5=E5=8F=97=E4=B9=8B=E5=89=8D=EF=BC=8C=E4=B8=8D=
=E8=A6=81=E6=8A=84=E9=80=81 "linux-distros"=EF=BC=9B=E5=9C=A8=E4=BF=AE=E5=
=A4=8D=E7=A8=8B=E5=BA=8F=E8=A2=AB=E5=90=88=E5=B9=B6=E4=B9=8B=E5=90=8E=EF=
=BC=8C
> >=20
>=20>  +=E4=B8=8D=E8=A6=81=E6=8A=84=E9=80=81=E5=86=85=E6=A0=B8=E5=AE=89=
=E5=85=A8=E5=9B=A2=E9=98=9F=E3=80=82
> >=20
>=20>  > CVE=E5=88=86=E9=85=8D
> >=20
>=20>  --------
> >=20
>=20>  > -=E5=AE=89=E5=85=A8=E5=9B=A2=E9=98=9F=E9=80=9A=E5=B8=B8=E4=B8=8D=
=E5=88=86=E9=85=8DCVE=EF=BC=8C=E6=88=91=E4=BB=AC=E4=B9=9F=E4=B8=8D=E9=9C=
=80=E8=A6=81=E5=AE=83=E4=BB=AC=E6=9D=A5=E8=BF=9B=E8=A1=8C=E6=8A=A5=E5=91=
=8A=E6=88=96=E4=BF=AE=E5=A4=8D=EF=BC=8C=E5=9B=A0=E4=B8=BA=E8=BF=99=E4=BC=
=9A=E4=BD=BF=E8=BF=87=E7=A8=8B=E4=B8=8D=E5=BF=85
> >=20
>=20>  -=E8=A6=81=E7=9A=84=E5=A4=8D=E6=9D=82=E5=8C=96=EF=BC=8C=E5=B9=B6=
=E5=8F=AF=E8=83=BD=E8=80=BD=E8=AF=AF=E7=BC=BA=E9=99=B7=E5=A4=84=E7=90=86=
=E3=80=82=E5=A6=82=E6=9E=9C=E6=8A=A5=E5=91=8A=E8=80=85=E5=B8=8C=E6=9C=9B=
=E5=9C=A8=E5=85=AC=E5=BC=80=E6=8A=AB=E9=9C=B2=E4=B9=8B=E5=89=8D=E5=88=86=
=E9=85=8D=E4=B8=80=E4=B8=AACVE=E7=BC=96=E5=8F=B7=EF=BC=8C
> >=20
>=20>  -=E4=BB=96=E4=BB=AC=E9=9C=80=E8=A6=81=E8=81=94=E7=B3=BB=E4=B8=8A=
=E8=BF=B0=E7=9A=84=E7=A7=81=E6=9C=89linux-distros=E5=88=97=E8=A1=A8=E3=80=
=82=E5=BD=93=E5=9C=A8=E6=8F=90=E4=BE=9B=E8=A1=A5=E4=B8=81=E4=B9=8B=E5=89=
=8D=E5=B7=B2=E6=9C=89=E8=BF=99=E6=A0=B7=E7=9A=84CVE=E7=BC=96=E5=8F=B7=E6=
=97=B6=EF=BC=8C
> >=20
>=20>  -=E5=A6=82=E6=8A=A5=E5=91=8A=E8=80=85=E6=84=BF=E6=84=8F=EF=BC=8C=
=E6=9C=80=E5=A5=BD=E5=9C=A8=E6=8F=90=E4=BA=A4=E6=B6=88=E6=81=AF=E4=B8=AD=
=E6=8F=90=E5=8F=8A=E5=AE=83=E3=80=82
> >=20
>=20>  +=E5=AE=89=E5=85=A8=E5=9B=A2=E9=98=9F=E4=B8=8D=E5=88=86=E9=85=8D C=
VE=EF=BC=8C=E5=90=8C=E6=97=B6=E6=88=91=E4=BB=AC=E4=B9=9F=E4=B8=8D=E9=9C=
=80=E8=A6=81 CVE =E6=9D=A5=E6=8A=A5=E5=91=8A=E6=88=96=E4=BF=AE=E5=A4=8D=
=E6=BC=8F=E6=B4=9E=EF=BC=8C=E5=9B=A0=E4=B8=BA=E8=BF=99=E4=BC=9A=E4=BD=BF=
=E8=BF=87=E7=A8=8B=E4=B8=8D=E5=BF=85=E8=A6=81
> >=20
>=20>  +=E7=9A=84=E5=A4=8D=E6=9D=82=E5=8C=96=EF=BC=8C=E5=B9=B6=E5=8F=AF=
=E8=83=BD=E5=BB=B6=E8=AF=AF=E6=BC=8F=E6=B4=9E=E5=A4=84=E7=90=86=E3=80=82=
=E5=A6=82=E6=9E=9C=E6=8A=A5=E5=91=8A=E8=80=85=E5=B8=8C=E6=9C=9B=E4=B8=BA=
=E7=A1=AE=E8=AE=A4=E7=9A=84=E9=97=AE=E9=A2=98=E5=88=86=E9=85=8D=E4=B8=80=
=E4=B8=AA CVE =E7=BC=96=E5=8F=B7=EF=BC=8C
> >=20
>=20>  +=E5=8F=AF=E4=BB=A5=E8=81=94=E7=B3=BB :doc:`=E5=86=85=E6=A0=B8 CVE=
 =E5=88=86=E9=85=8D=E5=9B=A2=E9=98=9F <../process/cve>` =E8=8E=B7=E5=8F=
=96=E3=80=82
> >=20
>=20>  > =E4=BF=9D=E5=AF=86=E5=8D=8F=E8=AE=AE
> >=20
>=20>  ---------
> >=20
>=20>  diff --git a/Documentation/translations/zh_CN/process/submitting-p=
atches.rst b/Documentation/translations/zh_CN/process/submitting-patches.=
rst
> >=20
>=20>  index 7864107e60a8..7ca16bda3709 100644
> >=20
>=20>  --- a/Documentation/translations/zh_CN/process/submitting-patches.=
rst
> >=20
>=20>  +++ b/Documentation/translations/zh_CN/process/submitting-patches.=
rst
> >=20
>=20>  @@ -208,7 +208,7 @@ torvalds@linux-foundation.org =E3=80=82=E4=BB=
=96=E6=94=B6=E5=88=B0=E7=9A=84=E9=82=AE=E4=BB=B6=E5=BE=88=E5=A4=9A=EF=BC=
=8C=E6=89=80=E4=BB=A5=E4=B8=80=E8=88=AC=E6=9D=A5=E8=AF=B4
> >=20
>=20>  =E5=A6=82=E6=9E=9C=E6=82=A8=E6=9C=89=E4=BF=AE=E5=A4=8D=E5=8F=AF=E5=
=88=A9=E7=94=A8=E5=AE=89=E5=85=A8=E6=BC=8F=E6=B4=9E=E7=9A=84=E8=A1=A5=E4=
=B8=81=EF=BC=8C=E8=AF=B7=E5=B0=86=E8=AF=A5=E8=A1=A5=E4=B8=81=E5=8F=91=E9=
=80=81=E5=88=B0 security@kernel.org =E3=80=82=E5=AF=B9=E4=BA=8E
> >=20
>=20>  =E4=B8=A5=E9=87=8D=E7=9A=84bug=EF=BC=8C=E5=8F=AF=E4=BB=A5=E8=80=83=
=E8=99=91=E7=9F=AD=E6=9C=9F=E7=A6=81=E4=BB=A4=E4=BB=A5=E5=85=81=E8=AE=B8=
=E5=88=86=E9=94=80=E5=95=86=EF=BC=88=E6=9C=89=E6=97=B6=E9=97=B4=EF=BC=89=
=E5=90=91=E7=94=A8=E6=88=B7=E5=8F=91=E5=B8=83=E8=A1=A5=E4=B8=81=EF=BC=9B=
=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C
> >=20
>=20>  =E6=98=BE=E7=84=B6=E4=B8=8D=E5=BA=94=E5=B0=86=E8=A1=A5=E4=B8=81=E5=
=8F=91=E9=80=81=E5=88=B0=E4=BB=BB=E4=BD=95=E5=85=AC=E5=85=B1=E5=88=97=E8=
=A1=A8=E3=80=82
> >=20
>=20>  -=E5=8F=82=E8=A7=81 Documentation/translations/zh_CN/admin-guide/s=
ecurity-bugs.rst =E3=80=82
> >=20
>=20>  +=E5=8F=82=E8=A7=81 Documentation/translations/zh_CN/process/secur=
ity-bugs.rst =E3=80=82
> >=20
>=20>  > =E4=BF=AE=E5=A4=8D=E5=B7=B2=E5=8F=91=E5=B8=83=E5=86=85=E6=A0=B8=
=E4=B8=AD=E4=B8=A5=E9=87=8D=E9=94=99=E8=AF=AF=E7=9A=84=E8=A1=A5=E4=B8=81=
=E7=A8=8B=E5=BA=8F=E5=BA=94=E8=AF=A5=E6=8A=84=E9=80=81=E7=BB=99=E7=A8=B3=
=E5=AE=9A=E7=89=88=E7=BB=B4=E6=8A=A4=E4=BA=BA=E5=91=98=EF=BC=8C=E6=96=B9=
=E6=B3=95=E6=98=AF=E6=8A=8A=E4=BB=A5=E4=B8=8B=E5=88=97=E8=A1=8C
> >=20
>=20>  =E6=94=BE=E8=BF=9B=E8=A1=A5=E4=B8=81=E7=9A=84=E7=AD=BE=E5=87=86=E5=
=8C=BA=EF=BC=88=E6=B3=A8=E6=84=8F=EF=BC=8C=E4=B8=8D=E6=98=AF=E7=94=B5=E5=
=AD=90=E9=82=AE=E4=BB=B6=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=89::
> >=20
>=20>  diff --git a/Documentation/translations/zh_TW/admin-guide/reportin=
g-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-iss=
ues.rst
> >=20
>=20>  index bc132b25f2ae..1d4e4c7a6750 100644
> >=20
>=20>  --- a/Documentation/translations/zh_TW/admin-guide/reporting-issue=
s.rst
> >=20
>=20>  +++ b/Documentation/translations/zh_TW/admin-guide/reporting-issue=
s.rst
> >=20
>=20>  @@ -301,7 +301,7 @@ Documentation/admin-guide/reporting-regression=
s.rst =E5=B0=8D=E6=AD=A4=E9=80=B2=E8=A1=8C=E4=BA=86=E6=9B=B4=E8=A9=B3=E7=
=B4=B0=E7=9A=84
> >=20
>=20>  =E6=B7=BB=E5=8A=A0=E5=88=B0=E8=BF=B4=E6=AD=B8=E8=B7=9F=E8=B9=A4=E5=
=88=97=E8=A1=A8=E4=B8=AD=EF=BC=8C=E4=BB=A5=E7=A2=BA=E4=BF=9D=E5=AE=83=E4=
=B8=8D=E6=9C=83=E8=A2=AB=E5=BF=BD=E7=95=A5=E3=80=82
> >=20
>=20>  > =E4=BB=80=E9=BA=BC=E6=98=AF=E5=AE=89=E5=85=A8=E5=95=8F=E9=A1=8C=
=E7=95=99=E7=B5=A6=E6=82=A8=E8=87=AA=E5=B7=B1=E5=88=A4=E6=96=B7=E3=80=82=
=E5=9C=A8=E7=B9=BC=E7=BA=8C=E4=B9=8B=E5=89=8D=EF=BC=8C=E8=AB=8B=E8=80=83=
=E6=85=AE=E9=96=B1=E8=AE=80
> >=20
>=20>  -Documentation/translations/zh_CN/admin-guide/security-bugs.rst =
=EF=BC=8C
> >=20
>=20>  +Documentation/translations/zh_CN/process/security-bugs.rst =EF=BC=
=8C
> >=20
>=20>  =E5=9B=A0=E7=88=B2=E5=AE=83=E6=8F=90=E4=BE=9B=E7=9E=AD=E5=A6=82=E4=
=BD=95=E6=9C=80=E6=81=B0=E7=95=B6=E5=9C=B0=E8=99=95=E7=90=86=E5=AE=89=E5=
=85=A8=E5=95=8F=E9=A1=8C=E7=9A=84=E9=A1=8D=E5=A4=96=E7=B4=B0=E7=AF=80=E3=
=80=82
> >=20
>=20>  > =E7=95=B6=E7=99=BC=E7=94=9F=E4=BA=86=E5=AE=8C=E5=85=A8=E7=84=A1=
=E6=B3=95=E6=8E=A5=E5=8F=97=E7=9A=84=E7=B3=9F=E7=B3=95=E4=BA=8B=E6=83=85=
=E6=99=82=EF=BC=8C=E6=AD=A4=E5=95=8F=E9=A1=8C=E5=B0=B1=E6=98=AF=E4=B8=80=
=E5=80=8B=E2=80=9C=E9=9D=9E=E5=B8=B8=E5=9A=B4=E9=87=8D=E7=9A=84=E5=95=8F=
=E9=A1=8C=E2=80=9D=E3=80=82=E4=BE=8B=E5=A6=82=EF=BC=8C
> >=20
>=20>  @@ -984,7 +984,7 @@ Documentation/admin-guide/reporting-regression=
s.rst =EF=BC=9B=E5=AE=83=E9=82=84=E6=8F=90=E4=BE=9B=E4=BA=86=E5=A4=A7=E9=
=87=8F=E5=85=B6
> >=20
>=20>  =E5=A0=B1=E5=91=8A=EF=BC=8C=E8=AB=8B=E5=B0=87=E5=A0=B1=E5=91=8A=E7=
=9A=84=E6=96=87=E6=9C=AC=E8=BD=89=E7=99=BC=E5=88=B0=E9=80=99=E4=BA=9B=E5=
=9C=B0=E5=9D=80=EF=BC=9B=E4=BD=86=E8=AB=8B=E5=9C=A8=E5=A0=B1=E5=91=8A=E7=
=9A=84=E9=A0=82=E9=83=A8=E5=8A=A0=E4=B8=8A=E8=A8=BB=E9=87=8B=EF=BC=8C=E8=
=A1=A8=E6=98=8E=E6=82=A8=E6=8F=90=E4=BA=A4=E4=BA=86
> >=20
>=20>  =E5=A0=B1=E5=91=8A=EF=BC=8C=E4=B8=A6=E9=99=84=E4=B8=8A=E5=B7=A5=E5=
=96=AE=E9=8F=88=E6=8E=A5=E3=80=82
> >=20
>=20>  > -=E6=9B=B4=E5=A4=9A=E4=BF=A1=E6=81=AF=E8=AB=8B=E5=8F=83=E8=A6=8B=
 Documentation/translations/zh_CN/admin-guide/security-bugs.rst =E3=80=82
> >=20
>=20>  +=E6=9B=B4=E5=A4=9A=E4=BF=A1=E6=81=AF=E8=AB=8B=E5=8F=83=E8=A6=8B D=
ocumentation/translations/zh_CN/process/security-bugs.rst =E3=80=82
> >=20
>=20>  > > =E7=99=BC=E4=BD=88=E5=A0=B1=E5=91=8A=E5=BE=8C=E7=9A=84=E8=B2=
=AC=E4=BB=BB
> >=20
>=20>  diff --git a/Documentation/translations/zh_TW/process/submitting-p=
atches.rst b/Documentation/translations/zh_TW/process/submitting-patches.=
rst
> >=20
>=20>  index f12f2f193f85..64de92c07906 100644
> >=20
>=20>  --- a/Documentation/translations/zh_TW/process/submitting-patches.=
rst
> >=20
>=20>  +++ b/Documentation/translations/zh_TW/process/submitting-patches.=
rst
> >=20
>=20>  @@ -209,7 +209,7 @@ torvalds@linux-foundation.org =E3=80=82=E4=BB=
=96=E6=94=B6=E5=88=B0=E7=9A=84=E9=83=B5=E4=BB=B6=E5=BE=88=E5=A4=9A=EF=BC=
=8C=E6=89=80=E4=BB=A5=E4=B8=80=E8=88=AC=E4=BE=86=E8=AA=AA
> >=20
>=20>  =E5=A6=82=E6=9E=9C=E6=82=A8=E6=9C=89=E4=BF=AE=E5=BE=A9=E5=8F=AF=E5=
=88=A9=E7=94=A8=E5=AE=89=E5=85=A8=E6=BC=8F=E6=B4=9E=E7=9A=84=E8=A3=9C=E4=
=B8=81=EF=BC=8C=E8=AB=8B=E5=B0=87=E8=A9=B2=E8=A3=9C=E4=B8=81=E7=99=BC=E9=
=80=81=E5=88=B0 security@kernel.org =E3=80=82=E5=B0=8D=E6=96=BC
> >=20
>=20>  =E5=9A=B4=E9=87=8D=E7=9A=84bug=EF=BC=8C=E5=8F=AF=E4=BB=A5=E8=80=83=
=E6=85=AE=E7=9F=AD=E6=9C=9F=E7=A6=81=E4=BB=A4=E4=BB=A5=E5=85=81=E8=A8=B1=
=E5=88=86=E9=8A=B7=E5=95=86=EF=BC=88=E6=9C=89=E6=99=82=E9=96=93=EF=BC=89=
=E5=90=91=E7=94=A8=E6=88=B6=E7=99=BC=E4=BD=88=E8=A3=9C=E4=B8=81=EF=BC=9B=
=E5=9C=A8=E9=80=99=E7=A8=AE=E6=83=85=E6=B3=81=E4=B8=8B=EF=BC=8C
> >=20
>=20>  =E9=A1=AF=E7=84=B6=E4=B8=8D=E6=87=89=E5=B0=87=E8=A3=9C=E4=B8=81=E7=
=99=BC=E9=80=81=E5=88=B0=E4=BB=BB=E4=BD=95=E5=85=AC=E5=85=B1=E5=88=97=E8=
=A1=A8=E3=80=82
> >=20
>=20>  -=E5=8F=83=E8=A6=8B Documentation/translations/zh_CN/admin-guide/s=
ecurity-bugs.rst =E3=80=82
> >=20
>=20>  +=E5=8F=83=E8=A6=8B Documentation/translations/zh_CN/process/secur=
ity-bugs.rst =E3=80=82
> >=20
>=20>  > =E4=BF=AE=E5=BE=A9=E5=B7=B2=E7=99=BC=E4=BD=88=E5=85=A7=E6=A0=B8=
=E4=B8=AD=E5=9A=B4=E9=87=8D=E9=8C=AF=E8=AA=A4=E7=9A=84=E8=A3=9C=E4=B8=81=
=E7=A8=8B=E5=BA=8F=E6=87=89=E8=A9=B2=E6=8A=84=E9=80=81=E7=B5=A6=E7=A9=A9=
=E5=AE=9A=E7=89=88=E7=B6=AD=E8=AD=B7=E4=BA=BA=E5=93=A1=EF=BC=8C=E6=96=B9=
=E6=B3=95=E6=98=AF=E6=8A=8A=E4=BB=A5=E4=B8=8B=E5=88=97=E8=A1=8C
> >=20
>=20>  =E6=94=BE=E9=80=B2=E8=A3=9C=E4=B8=81=E7=9A=84=E7=B1=A4=E6=BA=96=E5=
=8D=80=EF=BC=88=E6=B3=A8=E6=84=8F=EF=BC=8C=E4=B8=8D=E6=98=AF=E9=9B=BB=E5=
=AD=90=E9=83=B5=E4=BB=B6=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=89::
> >
>

