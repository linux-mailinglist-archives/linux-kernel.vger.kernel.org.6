Return-Path: <linux-kernel+bounces-329451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53D97918C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869162846D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6851CFEDB;
	Sat, 14 Sep 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="B7v1HI+k"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FB1CF7BA;
	Sat, 14 Sep 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324901; cv=none; b=nMqwW5WWLhEsXxmVAKklAA+TSG/JaMXp+OSGFy1sSDTY8/h5+CyeS+qHxEcJhzb0TcetqOsQnt7T+aurJOAvQPmb4+K2rZNpy2NzSqqXwg134XhQwWigYglkdfQDj4iCOnlPJ3llsdQ9wdfnPO2yIYJlcrbcdIqJbEeKXd4te2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324901; c=relaxed/simple;
	bh=12hUWoTateuFqGVq4jVrb41kOiU/YeYQ2gkJmLbjaHo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JAD+OLYgWw/PJBKFw9OdBITIKfKvMrLETF5wEmAHyWypq3DCssZozRepAaZ1iiUIpiNWAqpk6LyLVt011P/YJTbg/g5h0ehbfm4G4rr6IiY7VCfK8b5QnEeqpYEN2ZSrhiT7yIK43haE0pRxZ8Pjm6VjjuUwMb7oFyPNN+mObAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=B7v1HI+k; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726324872; x=1726929672; i=markus.elfring@web.de;
	bh=otr/Fanph/ZBx2E0YWs7aAENovFVbw+paDqnBja9p6Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B7v1HI+k9UL1LkX1EczHGObCNAvPsOaEoNlKe0xDTtRi5u4HilzgywIZ1QSOVPDH
	 +cMsNb096xHsj5C3k8cLFWK49vM0O1jYDM+HDRVUK9RpUOUXsYiMAWEUuPh4Fykjj
	 HUJSdNeFOp6qN1G4W+75FFZxQbt4kubTmNThg49uF81UXlHFjGuZ7kH0xpxoy0+4k
	 u1JJ0+XI2LgZAeUpKERajoRV4LPVMiEJGrmzxsROTKArO4qDL4SPYjkxvSJ8FXuL8
	 IFDxC6XXsuWSsXkUimw/fMRzYXismyEYLXT5K68UacKUUHzP3+SJ81VG2XhoTF0+y
	 mEQOHaY5ZqsXMdQ8Uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5bV-1sUNHh0k3B-00JM7i; Sat, 14
 Sep 2024 16:41:12 +0200
Message-ID: <300b5d1a-ab88-4548-91d2-0792bc15e15e@web.de>
Date: Sat, 14 Sep 2024 16:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Generalising a transformation with SmPL?
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
 <186de981-7a3c-4fdb-8911-8dfee597c759@web.de>
Content-Language: en-GB
In-Reply-To: <186de981-7a3c-4fdb-8911-8dfee597c759@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HoPsqyKslKdr1/wDHKIm21VHDAszlWtNHLl9bGyfP1+Hg9zGId1
 QqconPycwS+U7U7P6YZzvSULENsCcC6IMS9ZbFvtF43P7ylEFrrqy2UiTFTCAnG/t3xGJPv
 jIy3AbBYK2pS6S91iO8bYnbU/0eGUrfQo/ZpvQYGmEzGUGQloRigSHs+QjCycxpCFWRUubR
 ikpwux6/SRiUOLtTMeufQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9t68vCu+5is=;nwxrIk6VB5MbEnzetXnqx5U2p6i
 9ype9tcoamIuXMwI8S0Y6oEVcN0fW7/1CgNjFw6ITdkNUTPSSGGPGKuTidxsqvlLMP4URI8oN
 1Y2XMwrRzSmun5ObFsURie8sv+m/4EDEBn8BQ9e3p9fqOKomDEL+D7y6HJTXMGq5bwxLoLEuc
 EDyrxabmDnrlPJGuKBDTQT6cL/HJfr8bE1XyJ1igFgXo03ZveIo1CgTLZKSXJHTP5LYGZJwFw
 oIeXR1GATrPL28gH828b7rl0nnPJ17+0rT6Y8iQfBR3Hl1etwslEGAYJieNKMGI0igP4tRjEE
 NhLyw7KzKvI0/z9nnuF1ZthvE6UV8/+Ub6TdoJmYK4nlJ+0oYgMwIz9kAsbok0+JTWVrMNKvI
 m2Lh12PId+3YPWPoaFnhfVExQxWDkaB4lfTi3Lk8izykTyxNVd/d9E4LKdCkivkIhXO0G4dbD
 zehFF/QkLEIlWdU4FDKhsZqxgW2q5O6dVjARZvdy0eDo5LC7cQt/zDKS4Tbp4O62px+CA4gK1
 e8D6msSQVrDNXHOMm7GK+VM4Ic+z60IhKCc73MZnvHMOIso/6fUVVha5u83gxqY5Hex4UzjdC
 HPGoxYx1kaiRazKT/VE8KHYAo6NGtntnYgnurf3XFDghNUCUnwu4FtuuIMO/M7fWXGCoDjm5y
 i2LZPT5xJWQ55LMbig2B2z4PwkCPYy+kc2XbQC0kXyzWzsPme2QcYSswg4f0ibN1/15uK9TEJ
 4Rzj12o2qsc/gCriD2MjmMuX5l3W0KjpiPoZyGUEt20psLLvFFzC55YPXncbZzt/zFE0m8BND
 KE2QnWaKpHHdjiNTdCQBd7Rw==

=E2=80=A6
> I found it easy to convert it also into the following small script varia=
nt
> for the semantic patch language (Coccinelle software).
>
>
> @adjustment@
> expression e, x;
> @@
> +of_node_put(e);
>  if (...)
>  {
>  <+... when !=3D e =3D x
> -   of_node_put(e);
>  ...+>
>  }
> -of_node_put(e);
>
>
> 58 patches were accordingly generated for source files of the software =
=E2=80=9CLinux next-20240913=E2=80=9D.
=E2=80=A6

This SmPL script references a known function name.
https://elixir.bootlin.com/linux/v6.11-rc7/source/drivers/of/dynamic.c#L43

I imagine that it can become helpful to avoid duplicate function calls
also in combination with other functions.
But there are development challenges to consider for functions like mutex_=
unlock()
which get addresses passed for data structure members.
Thus I hoped that something can be achieved with the following script vari=
ant.


@extended_adjustment@
expression e, f, x, y;
@@
+f(e);
 if (...)
 {
 <+... when !=3D \( e =3D x \| y(..., &e, ...) \)
(   f(&e);
|
-   f(e);
)
 ...+>
 }
(f(&e);
|
-f(e);
)


But the software combination =E2=80=9CCoccinelle 1.2-00038-g2297fc0f=E2=80=
=9D points details out
for further development considerations.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch driver=
s/pmdomain/rockchip/pm-domains.c =E2=80=A6/Projekte/Coccinelle/janitor/avo=
id_duplicate_function_call.cocci
=E2=80=A6
previous modification:

  <<< f(e);
CONTEXT

According to environment 2:
   extended_adjustment.e -> pmu->mutex

   extended_adjustment.f -> mutex_unlock


current modification:

  <<< f(e);
CONTEXT

According to environment 2:
   extended_adjustment.e -> &pmu->mutex

   extended_adjustment.f -> mutex_unlock


exn while in timeout_function
extended_adjustment: already tagged token:
C code context
File "drivers/pmdomain/rockchip/pm-domains.c", line 538, column 1, charpos=
 =3D 14292
  around =3D 'if',
  whole content =3D       if (rockchip_pmu_domain_is_on(pd) !=3D power_on)=
 {



How can such a software situation be improved?

Regards,
Markus

