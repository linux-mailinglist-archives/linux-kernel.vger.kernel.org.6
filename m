Return-Path: <linux-kernel+bounces-298434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2399195C746
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520461C22667
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72B13DDB9;
	Fri, 23 Aug 2024 08:04:42 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3512C484;
	Fri, 23 Aug 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400282; cv=none; b=eqpd5FVOPbG1aYk64wogrZZpPzbJo9O/6o8MhtTlx3EA9Ii9BxSZBv/NRAwgFEP0TwNeA+nlXIXFkGUvAcn+LzBIwsQaFIskKMV+VlHlLqFF6DY08DhN53djeiogPNEgYLFVQvKNgiDSkkRywC9shYoQnw7hs0MQKIo0AWOpKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400282; c=relaxed/simple;
	bh=AHmV06ZYTmDQjFoxeDZyWEiUGtXYpoCK7VRJ989dx5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caZBtsxD+3+3YVsYRxZAnXk5yqABu89X+Yu91pxEHaX7A3+uF0KNfcohgN9WC4qFg82bU1Kf9qrVj0AvckYOHFvPU6jcBL0gthI6iaci8JTBJz7ZJy+dXX+Furao8baueco1o313KFyiiBBtbG/B1tBHhpzJ3lTMw0aIpQtsF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqszq1dSPz9sRr;
	Fri, 23 Aug 2024 10:04:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OkfwdsMvzURi; Fri, 23 Aug 2024 10:04:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqszq0jT4z9rvV;
	Fri, 23 Aug 2024 10:04:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 060808B77D;
	Fri, 23 Aug 2024 10:04:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jp5RpotxuUr2; Fri, 23 Aug 2024 10:04:38 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 72AB68B763;
	Fri, 23 Aug 2024 10:04:38 +0200 (CEST)
Message-ID: <1cf6e8ea-ded8-4cf7-b134-d54e1eedd559@csgroup.eu>
Date: Fri, 23 Aug 2024 10:04:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/36] soc: fsl: cpm1: tsa: Fix blank line and spaces
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-6-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:10, Herve Codina a écrit :
> checkpatch.pl raises the following issues
>    CHECK: Please don't use multiple blank lines
>    CHECK: spaces preferred around that '/' (ctx:VxV)
>    CHECK: spaces preferred around that '+' (ctx:VxV)
>    CHECK: spaces preferred around that '-' (ctx:VxV)
> 
> Fix them.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index dc4dda17dab8..7b1032fb1572 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -18,7 +18,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   
> -
>   /* TSA SI RAM routing tables entry */
>   #define TSA_SIRAM_ENTRY_LAST		BIT(16)
>   #define TSA_SIRAM_ENTRY_BYTE		BIT(17)
> @@ -244,8 +243,8 @@ static void tsa_init_entries_area(struct tsa *tsa, struct tsa_entries_area *area
>   	resource_size_t quarter;
>   	resource_size_t half;
>   
> -	quarter = tsa->si_ram_sz/4;
> -	half = tsa->si_ram_sz/2;
> +	quarter = tsa->si_ram_sz / 4;
> +	half = tsa->si_ram_sz / 2;
>   
>   	if (tdms == BIT(TSA_TDMA)) {
>   		/* Only TDMA */
> @@ -408,7 +407,7 @@ static int tsa_of_parse_tdm_route(struct tsa *tsa, struct device_node *tdm_np,
>   		}
>   
>   		dev_dbg(tsa->dev, "tdm_id=%u, %s ts %u..%u -> %s\n",
> -			tdm_id, route_name, ts, ts+count-1, serial_name);
> +			tdm_id, route_name, ts, ts + count - 1, serial_name);
>   		ts += count;
>   
>   		ret = tsa_add_entry(tsa, &area, count, serial_id);

