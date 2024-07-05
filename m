Return-Path: <linux-kernel+bounces-242209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D8E928508
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDEB254E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DA1465AC;
	Fri,  5 Jul 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eYWjbbIC"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC6139E;
	Fri,  5 Jul 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171381; cv=none; b=G4olk4Xd17wkX1yB7wVI8OTLFSZYx4ClPbKCXT6ftS8WfoG1jQNLLEI+5JchzzDrFabuol5HetL9MB4kCAn/+MYhTY6Y48j+bjjVrnWN4rIe/vES0Qvk9gtmlswOD0kEYn5uX82ki/ZsfQo1ypVKre+vnk1fUwExgS5SF+ADXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171381; c=relaxed/simple;
	bh=HjxNcLSO6MVAjRjFilxCXYUr5TtnxCe/QZ1vP6XUm1E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oGEFUgL4iFBDxBmU9ljnm5tQb/JC0sYFe+Q97eupunaw2/O3sbvpT2mFcz1NoaCvv+chbW+wTVvhKh3F6Hqb8Jlv8UOWtFG15OTEjccgFypTFjtl/P6B7eKGWzV3meP1/auWTfGNwT1hZQSuyJmlloZ1jOP33bMvxNg4EmwjSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eYWjbbIC; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720171376; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=IiE7NjlJpsW6PV08E8iKM1uyQVMgCvXj0tlg9WWsqbA=;
	b=eYWjbbICV+4fCXUw0H5GIQYoQei3wPCYTVuXmnViQ1XpS7T9Wvy/BJE7NDe2OId6nm9LjUhVH/cgTdbWNGC+8YsaKha8ILjO6fMnep6HwGZm73Cyk/120ThjN4okVW34lQ79phDeE4rb7Xk9SM24PB52biYKIOPCietSk34QyL4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=wodemia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W9uUodj_1720171374;
Received: from smtpclient.apple(mailfrom:wodemia@linux.alibaba.com fp:SMTPD_---0W9uUodj_1720171374)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 17:22:55 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1] zh_CN/admin-guide: one typo fix
From: Tao Zou <wodemia@linux.alibaba.com>
In-Reply-To: <CAD-N9QUPWrAaT-7UjibcKR7=L_etmGF4qy0voO8u3W+wk6G0nA@mail.gmail.com>
Date: Fri, 5 Jul 2024 17:22:54 +0800
Cc: Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E195EE5-F38E-4F32-ACA5-A36D79E66037@linux.alibaba.com>
References: <20240705022842.51451-1-wodemia@linux.alibaba.com>
 <CAD-N9QUPWrAaT-7UjibcKR7=L_etmGF4qy0voO8u3W+wk6G0nA@mail.gmail.com>
To: Dongliang Mu <mudongliangabcd@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)


2024=E5=B9=B47=E6=9C=885=E6=97=A5 16:18=EF=BC=8CDongliang Mu =
<mudongliangabcd@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 5, 2024 at 10:29=E2=80=AFAM Tao Zou =
<wodemia@linux.alibaba.com> wrote:
>>=20
>> Fix one chinese typo error.
>>=20
>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>=20
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>=20
Thanks a lot,  I will pick up your review tag.

Tao Zou
>> ---
>> The previous translation patch v4 has already been appied, and the =
changes from v4 to v5 were missed.
>> This patch is one typofix, and includes the changes from v4 to v5.
>>=20
>> Documentation/translations/zh_CN/admin-guide/numastat.rst | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git =
a/Documentation/translations/zh_CN/admin-guide/numastat.rst =
b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>> index c0f54d9a6b05..4d9817b91870 100644
>> --- a/Documentation/translations/zh_CN/admin-guide/numastat.rst
>> +++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
>> @@ -13,7 +13,7 @@ Numa=E7=AD=96=E7=95=A5=E5=91=BD=E4=B8=AD/=E6=9C=AA=E5=
=91=BD=E4=B8=AD=E7=BB=9F=E8=AE=A1
>>=20
>> =E6=89=80=E6=9C=89=E6=95=B0=E6=8D=AE=E7=9A=84=E5=8D=95=E4=BD=8D=E9=83=BD=
=E6=98=AF=E9=A1=B5=E9=9D=A2=E3=80=82=E5=B7=A8=E9=A1=B5=E6=9C=89=E7=8B=AC=E7=
=AB=8B=E7=9A=84=E8=AE=A1=E6=95=B0=E5=99=A8=E3=80=82
>>=20
>> =
-numa_hit=E3=80=81numa_miss=E5=92=8Cnuma_foreign=E8=AE=A1=E6=95=B0=E5=99=A8=
=E5=8F=8D=E5=BA=94=E4=BA=86=E8=BF=9B=E7=A8=8B=E6=98=AF=E5=90=A6=E8=83=BD=E5=
=A4=9F=E5=9C=A8=E4=BB=96=E4=BB=AC=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=
=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E3=80=82
>> =
+numa_hit=E3=80=81numa_miss=E5=92=8Cnuma_foreign=E8=AE=A1=E6=95=B0=E5=99=A8=
=E5=8F=8D=E6=98=A0=E4=BA=86=E8=BF=9B=E7=A8=8B=E6=98=AF=E5=90=A6=E8=83=BD=E5=
=A4=9F=E5=9C=A8=E4=BB=96=E4=BB=AC=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=
=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=86=85=E5=AD=98=E3=80=82
>> =
=E5=A6=82=E6=9E=9C=E8=BF=9B=E7=A8=8B=E6=88=90=E5=8A=9F=E5=9C=A8=E5=81=8F=E5=
=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=E5=88=86=E9=85=8D=E5=86=85=E5=AD=
=98=E5=88=99=E5=9C=A8=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=
=E5=A2=9E=E5=8A=A0numa_hit=E8=AE=A1=E6=95=B0=EF=BC=8C=E5=90=A6=E5=88=99=E5=
=9C=A8=E5=81=8F=E5=A5=BD=E7=9A=84=E8=8A=82=E7=82=B9=E4=B8=8A=E5=A2=9E
>> =
=E5=8A=A0numa_foreign=E8=AE=A1=E6=95=B0=E5=90=8C=E6=97=B6=E5=9C=A8=E5=AE=9E=
=E9=99=85=E5=86=85=E5=AD=98=E5=88=86=E9=85=8D=E7=9A=84=E8=8A=82=E7=82=B9=E4=
=B8=8A=E5=A2=9E=E5=8A=A0numa_miss=E8=AE=A1=E6=95=B0=E3=80=82
>>=20
>> --
>> 2.39.3 (Apple Git-146)
>>=20
>>=20


