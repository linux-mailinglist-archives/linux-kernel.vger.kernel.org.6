Return-Path: <linux-kernel+bounces-298468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E395C7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C45B2728D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E009F14386D;
	Fri, 23 Aug 2024 08:13:01 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776013DDC3;
	Fri, 23 Aug 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400781; cv=none; b=qfIt4nvG0qDTjf2RxksgRs5AepGnmQ6ISRHTkWsyyc2AjbLxN0ODPPM7LsX3Bz6yacDa2/xelyx3T3yq+W6leGTi3kBC4NG2PZyxfOgVbQ54A+uSEjM+OtwrXzBpS2fu9qyymyYjVPzMmu11EQfbXUTK50ont7xkz83KZfRNvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400781; c=relaxed/simple;
	bh=KZi/jmFP/beZZsjoRh27npco9APo6qBS1WmX2iBF+h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fstbwzjty4oesNaTsOiJ060Lh0Lh0Ctfq4hSsHYTo4JOQGp9yaV+lC0DzIDoh6HFM0dOMq8cqfKJ/GACRHeyhOOUtDvJ1KK5sIK4CKfKBnfl5an3hSvqdxyq9/RyJR+ggrBLLef1ZRjBmvVhvvkV+LUFY2L5IGPqwNOsG/U/uLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt9Q2XVYz9sRr;
	Fri, 23 Aug 2024 10:12:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yr2tWc3yfXO; Fri, 23 Aug 2024 10:12:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt9Q1gWyz9rvV;
	Fri, 23 Aug 2024 10:12:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 28C4B8B77D;
	Fri, 23 Aug 2024 10:12:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 2VydmTKCVB_P; Fri, 23 Aug 2024 10:12:58 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C9468B763;
	Fri, 23 Aug 2024 10:12:57 +0200 (CEST)
Message-ID: <48882839-ebb0-43c7-8011-660cd64524a8@csgroup.eu>
Date: Fri, 23 Aug 2024 10:12:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/36] soc: fsl: cpm1: qmc: Rename qmc_chan_command()
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-29-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-29-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles CPM1 version of QMC and qmc_chan_command() is
> clearly CPM1 specific.
> 
> In order to prepare the support for the QUICC Engine (QE) version,
> rename qmc_chan_command() to reflect that point.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index b95227378f97..272da250a763 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -794,7 +794,7 @@ static int qmc_chan_setup_tsa_rx(struct qmc_chan *chan, bool enable)
>   	return qmc_chan_setup_tsa_32rx(chan, &info, enable);
>   }
>   
> -static int qmc_chan_command(struct qmc_chan *chan, u8 qmc_opcode)
> +static int qmc_chan_cpm1_command(struct qmc_chan *chan, u8 qmc_opcode)
>   {
>   	return cpm_command(chan->id << 2, (qmc_opcode << 4) | 0x0E);
>   }
> @@ -813,7 +813,7 @@ static int qmc_chan_stop_rx(struct qmc_chan *chan)
>   	}
>   
>   	/* Send STOP RECEIVE command */
> -	ret = qmc_chan_command(chan, 0x0);
> +	ret = qmc_chan_cpm1_command(chan, 0x0);
>   	if (ret) {
>   		dev_err(chan->qmc->dev, "chan %u: Send STOP RECEIVE failed (%d)\n",
>   			chan->id, ret);
> @@ -850,7 +850,7 @@ static int qmc_chan_stop_tx(struct qmc_chan *chan)
>   	}
>   
>   	/* Send STOP TRANSMIT command */
> -	ret = qmc_chan_command(chan, 0x1);
> +	ret = qmc_chan_cpm1_command(chan, 0x1);
>   	if (ret) {
>   		dev_err(chan->qmc->dev, "chan %u: Send STOP TRANSMIT failed (%d)\n",
>   			chan->id, ret);

