Return-Path: <linux-kernel+bounces-298454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F695C789
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B967B261B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574941442E3;
	Fri, 23 Aug 2024 08:09:10 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD50143875;
	Fri, 23 Aug 2024 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400549; cv=none; b=J9cMGT+fnbJ5lpVqpgtSOlhoDvi2UxGpRS1TxlAe/VndFpagIYHXFy/VjnkO61gs/P/vFoNn87n8SjP5FlRVyiaywZgJbxVkWBlxCkFdZXaJV/Jf2evhdVr+eXHy68l6de/hFWRTU8aNPU9hWvHIVAeEiI3AoevDo3c0d6GvkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400549; c=relaxed/simple;
	bh=Tnna+cHstTs3qbcMx7nCXDEAuI8WFqW0i2hkm63086Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9llnQmMPeQOKjXjpSuyQ0PRM+wZeMzYPFUuy2KdexlRZNYEfrHn++/8ClGQBMU9h8CQ3bjIgpPNeGbRBR243PHO7Int3vxKBGD1cb8yd+VxI/eTgJTLYIKFRWSFToO5keYU9LcVzdFA8YhZpHlUNs69Rxx/lgHbjp0HEhYUjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt4y60rXz9sRr;
	Fri, 23 Aug 2024 10:09:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UiplMSDidgyX; Fri, 23 Aug 2024 10:09:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt4y4mdBz9rvV;
	Fri, 23 Aug 2024 10:09:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FA158B77D;
	Fri, 23 Aug 2024 10:09:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id NaWL9QwuywuU; Fri, 23 Aug 2024 10:09:06 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F2F6F8B763;
	Fri, 23 Aug 2024 10:09:05 +0200 (CEST)
Message-ID: <91ad5ded-43e5-4869-86a1-72f7c073a042@csgroup.eu>
Date: Fri, 23 Aug 2024 10:09:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/36] soc: fsl: cpm1: tsa: Introduce
 tsa_serial_get_num()
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-17-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-17-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> TSA consumers in CPM1 implementation don't need to know about the serial
> device number used by the TSA component. In QUICC Engine implementation,
> this information is needed.
> 
> Improve the TSA API with tsa_serial_get_num() in order to provide this
> information.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/tsa.c | 56 ++++++++++++++++++++++++++--------------
>   drivers/soc/fsl/qe/tsa.h |  3 +++
>   2 files changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index c540cf9144c0..f0889b3fcaf2 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -231,6 +231,39 @@ static bool tsa_is_qe(const struct tsa *tsa)
>   	return IS_ENABLED(CONFIG_QUICC_ENGINE);
>   }
>   
> +static int tsa_qe_serial_get_num(struct tsa_serial *tsa_serial)
> +{
> +	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
> +
> +	switch (tsa_serial->id) {
> +	case FSL_QE_TSA_UCC1: return 0;
> +	case FSL_QE_TSA_UCC2: return 1;
> +	case FSL_QE_TSA_UCC3: return 2;
> +	case FSL_QE_TSA_UCC4: return 3;
> +	case FSL_QE_TSA_UCC5: return 4;
> +	default:
> +		break;
> +	}
> +
> +	dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
> +	return -EINVAL;
> +}
> +
> +int tsa_serial_get_num(struct tsa_serial *tsa_serial)
> +{
> +	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
> +
> +	/*
> +	 * There is no need to get the serial num out of the TSA driver in the
> +	 * CPM case.
> +	 * Further more, in CPM, we can have 2 types of serial SCCs and FCCs.
> +	 * What kind of numbering to use that can be global to both SCCs and
> +	 * FCCs ?
> +	 */
> +	return tsa_is_qe(tsa) ? tsa_qe_serial_get_num(tsa_serial) : -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(tsa_serial_get_num);
> +
>   static int tsa_cpm1_serial_connect(struct tsa_serial *tsa_serial, bool connect)
>   {
>   	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
> @@ -271,26 +304,9 @@ static int tsa_qe_serial_connect(struct tsa_serial *tsa_serial, bool connect)
>   	int ucc_num;
>   	int ret;
>   
> -	switch (tsa_serial->id) {
> -	case FSL_QE_TSA_UCC1:
> -		ucc_num = 0;
> -		break;
> -	case FSL_QE_TSA_UCC2:
> -		ucc_num = 1;
> -		break;
> -	case FSL_QE_TSA_UCC3:
> -		ucc_num = 2;
> -		break;
> -	case FSL_QE_TSA_UCC4:
> -		ucc_num = 3;
> -		break;
> -	case FSL_QE_TSA_UCC5:
> -		ucc_num = 4;
> -		break;
> -	default:
> -		dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
> -		return -EINVAL;
> -	}
> +	ucc_num = tsa_qe_serial_get_num(tsa_serial);
> +	if (ucc_num < 0)
> +		return ucc_num;
>   
>   	spin_lock_irqsave(&tsa->lock, flags);
>   	ret = ucc_set_qe_mux_tsa(ucc_num, connect);
> diff --git a/drivers/soc/fsl/qe/tsa.h b/drivers/soc/fsl/qe/tsa.h
> index d9df89b6da3e..da137bc0f49b 100644
> --- a/drivers/soc/fsl/qe/tsa.h
> +++ b/drivers/soc/fsl/qe/tsa.h
> @@ -39,4 +39,7 @@ struct tsa_serial_info {
>   /* Get information */
>   int tsa_serial_get_info(struct tsa_serial *tsa_serial, struct tsa_serial_info *info);
>   
> +/* Get serial number */
> +int tsa_serial_get_num(struct tsa_serial *tsa_serial);
> +
>   #endif /* __SOC_FSL_TSA_H__ */

