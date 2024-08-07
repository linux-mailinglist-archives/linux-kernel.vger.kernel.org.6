Return-Path: <linux-kernel+bounces-277795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA594A69F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78421C2122A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0E1E211D;
	Wed,  7 Aug 2024 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W35P9PGG"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890C1E515
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028832; cv=none; b=TIS73cCkd74pQ42rzmJhS2QrKJsLqAhhhLeDikFg25tNzfePhSx2+XLK46bQ+3kxXE8+vlazgBlk/OHiBjYgGpqaZp6VLjZVz9ns2OBgGyIzNogQxbC/STQE6/LnS29l2FTeIIlHaF9yXkDqSOfD/zrndmwfcnYEfBBKx17rBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028832; c=relaxed/simple;
	bh=8p0tkUidN1yCvraljhbXdMb7ia/s2Yy3bQmo8eSwL3E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UUj5qkVwBLmFGmEmpYEW0F+MuxtDIroAw/d016n1rVWdRB6Tcgf+ixT2fH6902pNFP7bNSti8BhkoOjDV23z2lWb9WOTlnJgqKACSpJl5h+Rxhp0BgUSyTylIuVCa72+Dlw9/eEWrbARd9pKic8CyVkGj0AUSIFSLPM26+wnL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W35P9PGG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723028817; x=1723633617; i=markus.elfring@web.de;
	bh=P9f5JhF5QX/KW3GdX2o9fsJ93F1Bd6JEYTRl89FKqAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W35P9PGG7ZWsQVbLwamHBG09pan21IEfuFK68epnaQRuHGU/2ey8NCS2kVuw+2zZ
	 iWAwZEhT3DaV0elKoyRaq/jlz56q2TyTtwFqLb77Atx0XJ1em/6KVwj2IGTsIwi2Q
	 cU6LUlaCCsyUtPV3sqhq/friXBM5Hl+la/xe62C4I9tljjvaaNtBsZHS0mj6BQjPQ
	 iv6Kw8aCx8VcVkcdqz8AM9iT2j8IMLqvrr3hbAHir1BhhzMYoVFpGqmE3lLa/lF4F
	 SJT8NRYuAexkYkRX3Z23kSio4TBWG7n4cCvDnHAwOv6CwavqpdDeISaUWPlpq4eLa
	 VUMc7aTMNN+Jzddh/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2gkl-1se8HW264F-005YAy; Wed, 07
 Aug 2024 13:06:57 +0200
Message-ID: <d7b4ea8a-74c5-40db-bf11-f8345f570ef5@web.de>
Date: Wed, 7 Aug 2024 13:06:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, George Yang <George.Yang@amd.com>,
 king.tam@amd.com, Max Zhen <max.zhen@amd.com>, Min Ma <min.ma@amd.com>,
 Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240805173959.3181199-2-lizhi.hou@amd.com>
Subject: Re: [PATCH V2 01/10] accel/amdxdna: Add a new driver for AMD AI
 Engine
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240805173959.3181199-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dPQzK6nuAq+WHCYIPbb7mHsmd1leSWJwLf5CRrW/N6LJYR8Tv6Z
 Xl5xwBc6meBYyFSOCT5fD6pyf2ucKvDEOuu/DhfWzq0RH8hzrL1gSJkhtXx2t4QcSEZaiID
 gwP7zPWI3zV5zacaXSQ/8iDjgx9fqlYdG+CNnD6s+hLAxQ/yHCCXMSsQkoHaL8kbERjcWHu
 26AdwifNcTgYBYcNsdD+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N+7wopy3sno=;JGL25eDSvLuu5NT7TWaBH5KpPUd
 ubtdRdc5AGfIhaH0oOWt+Rqzkp+Rg1Xt0D1IL9QoRiJoJRfj5bgU8dfNUZVCse2ZW3Ar3Z4qH
 4dSivU9hWzyMscmOXzdk9JX2L9bCvMk5mXmU+bafww358sa17u7Zc0xtOvoz/b8lIlwpIGfgd
 JlqGCC8Bb8JqDD8HstXPyqpVRABaXh5HHV5wIX/K9FFGR+rdzgfvMvrmcxDuK/ZIcxXelHqVy
 VsU59bRt7KJTU8j7kHTbusCFmPrT6nii7eP20YRKObT5EeY4oZG7JTl0avofJrpHIl99eRRVk
 ayN+V+lkuM6fnfwwbqBp9rpdxcMefWn1x3mBISMtmTsHR5vT23FErz4mIfJSNp0lk0NGmi+ev
 6Wu4EU5CJT/8LGAcVOOAeVrXbiX/6sTpQ8HyNxlmSwrtPSao08VY8Zcv0J/OfuPAfTiswJPve
 y17eckJl6nwsYJo2DRpx2uewszqRBmwisrbduhicUMFzr0gLMskZbmMU5iXQLScARSZMQvkaU
 bmAkwQ0LnEIDyHopfP4++Ugge7HlroC8c9ci80n6muQ6lYjkWp5tjulGvUjzKPqxww929k8iS
 XrwjUYgEyM+YJ5xwuO2D99l5yonQT55Je3wFDnv72j1riNX8ykM+zf9y+xt05nGbYyhTNX36r
 P0b/KGzzRffeal9CgDU82gtkvrMsq0qXYKaFn6lBftfBnwR8rqmPzRO1jn9ceZTKSIJwQhsZV
 o2dVA1qgYk/gQ71Rj9vdDUbcSCdcj41ScPZI6tDceEbf7N4luG56CYIz+Hu3HLj6l11MNh2J2
 XeN+8XdFEg30gBMYi6+J9WJw==

If you temporarily find the circumstances too challenging for applications
of scope-based resource management, I suggest to use the following stateme=
nts instead
(so that a bit of redundant code can be avoided).



=E2=80=A6
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -0,0 +1,182 @@
=E2=80=A6
> +static int aie2_init(struct amdxdna_dev *xdna)
> +{
=E2=80=A6
> +	release_firmware(fw);
> +	return 0;

	ret =3D 0;
	goto release_fw;

=E2=80=A6
> +release_fw:
> +	release_firmware(fw);
> +
> +	return ret;
> +}
=E2=80=A6


Otherwise (in case further collateral evolution will become more desirable=
):
=E2=80=A6
> +static int aie2_init(struct amdxdna_dev *xdna)
> +{
=E2=80=A6
> +	const struct firmware *fw;

I propose to take another software design option better into account.

* You may reduce the scope of such a local variable.

* How do you think about to use the attribute =E2=80=9C__free(firmware)=E2=
=80=9D?
  https://elixir.bootlin.com/linux/v6.11-rc2/source/include/linux/firmware=
.h#L214

=E2=80=A6
> +	ret =3D request_firmware(&fw, ndev->priv->fw_path, &pdev->dev);
=E2=80=A6


Regards,
Markus

