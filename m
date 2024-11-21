Return-Path: <linux-kernel+bounces-416456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9C9D452D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61E11F22279
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E37224FD;
	Thu, 21 Nov 2024 00:57:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C944C6F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150651; cv=none; b=T2abyWH/1pQQyRLXPXLOAzIgmNxljVlEp2IaeP+1/HOzVHXkA/fsR99W6Gyqoxh+SVxJ8AeSZYzKCPd8ySCHRPfnqA5WeRDHsiuyvvmCCjCv6UV6/uu6yz/7yNviintdYgPeFCNN/hlmYCaP1dRLHQE0QbxQ+9Mmk2JEEEnN0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150651; c=relaxed/simple;
	bh=K+wu3XfFWJBlXv5HfMdefpUvK4Z1fTXVFw/Offsr4VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNV1frrhk+QkkRyeElNXi9y4qrTYZxgsTaoLUBitsrjNV+xHL2OTsbOSMHL0Ytiwip0smlxC04p37rMIIsVWboE6QpA5XsoscMaHE5u05wpmjXatGRJDeC/TvXQ0VH7V7A/W9NDpOBijAkkO2MM6l+Urm3C6SCDOOp6nwTsGllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8f299912a7a311efa216b1d71e6e1362-20241121
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d72081cc-bcf3-4dd3-b518-6f0d4c47927a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:194cac105c72739bf0966551aad64ceb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:1
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8f299912a7a311efa216b1d71e6e1362-20241121
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 953411326; Thu, 21 Nov 2024 08:57:19 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 5350D16002081;
	Thu, 21 Nov 2024 08:57:19 +0800 (CST)
X-ns-mid: postfix-673E856F-26500222
Received: from [10.42.116.241] (unknown [10.42.116.241])
	by node4.com.cn (NSMail) with ESMTPA id BDCB616002081;
	Thu, 21 Nov 2024 00:57:16 +0000 (UTC)
Message-ID: <ec6dfc5b-7713-41c5-87dd-3254578e54fa@kylinos.cn>
Date: Thu, 21 Nov 2024 08:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Fix qmc_probe() warn missing error
 code ret
To: Herve Codina <herve.codina@bootlin.com>
Cc: qiang.zhao@nxp.com, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, xiaopeitux@foxmail.com
References: <bac2dc94-1bf3-4dcf-b776-cd78ef992d28@suswa.mountain>
 <82d8c18da160b9e0a73c5c5e2eb25ad2831cc6f9.1732095360.git.xiaopei01@kylinos.cn>
 <20241120120506.077d3388@bootlin.com>
Content-Language: en-US
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <20241120120506.077d3388@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2024/11/20 19:05, Herve Codina =E5=86=99=E9=81=93:
> Hi Pei,
>=20
> On Wed, 20 Nov 2024 17:38:20 +0800
> Pei Xiao <xiaopei01@kylinos.cn> wrote:
>=20
>> platform_get_irq() may failed,but ret still equals to 0,
>> will cacuse qmc_probe() return 0 but fail.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202411051350.KNy6ZIWA-lkp@intel.com/
>> Fixes: 3178d58e0b97 ("soc: fsl: cpm1: Add support for QMC")
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>   drivers/soc/fsl/qe/qmc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
>> index 19cc581b06d0..a78768cd6007 100644
>> --- a/drivers/soc/fsl/qe/qmc.c
>> +++ b/drivers/soc/fsl/qe/qmc.c
>> @@ -2004,8 +2004,10 @@ static int qmc_probe(struct platform_device *pd=
ev)
>>  =20
>>   	/* Set the irq handler */
>>   	irq =3D platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> +	if (irq < 0) {
>> +		ret =3D -EINVAL;
>>   		goto err_exit_xcc;
>> +	}
>>   	ret =3D devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", =
qmc);
>>   	if (ret < 0)
>>   		goto err_exit_xcc;
>=20
> I already send a fix:
> https://lore.kernel.org/all/20241105145623.401528-1-herve.codina@bootli=
n.com/
>=20

ok, I'm so sorry for send repeated patch.

Tnanks!
Pei.
> And it is available in the following PR done by Christophe:
> https://lore.kernel.org/all/c3c4961b-fe2a-4fcc-a7a1-f8b5352e09a2@csgrou=
p.eu/
>=20
> Best regards,
> Herv=C3=A9

