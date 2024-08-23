Return-Path: <linux-kernel+bounces-298439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B4F95C758
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9323328662C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996041442E3;
	Fri, 23 Aug 2024 08:05:44 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4213E04C;
	Fri, 23 Aug 2024 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400344; cv=none; b=ZlnU7Mm1sz1yVSH7ulTtTXBnDxw0jaX8YymU92HfnE2cr8gH7dg4i9+NZCi0p+I0g5UBcpnlxDfyFGfB8RMolK2zymLfu9PdzE8FEUg4AuhhAB36tGVUg+v03VzCbk7ZCDhx28I/AILW9QHOkfa0HHglMJrTgL0ldMju3TZ5tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400344; c=relaxed/simple;
	bh=e0yj11dcQ8ROD7+xN9C2W7ZtzPSmPTVsruMd58Rb4uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a94B3VzxtZLjcqEoy6kVG9VvKzmIDPYobYnOsLSY4ZIhg79WZk71nVC2nChwsJDR6Tq+kc4MnU14q4ZxzOkF0qpptF21Jse/Bl5KPW4ulBFBgeiGM82HcdwRzwTM+UhGy9Y0r3yOHZ09R64J4PKuW1xFAB491CYD13UnIS0UETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt1101wjz9sRr;
	Fri, 23 Aug 2024 10:05:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RkHacFGZ_qoT; Fri, 23 Aug 2024 10:05:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt106KGfz9rvV;
	Fri, 23 Aug 2024 10:05:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C61178B77D;
	Fri, 23 Aug 2024 10:05:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4Wd__B8FoQjt; Fri, 23 Aug 2024 10:05:40 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 436638B763;
	Fri, 23 Aug 2024 10:05:40 +0200 (CEST)
Message-ID: <787d893d-2898-49e2-b0dd-f23a1b7186fe@csgroup.eu>
Date: Fri, 23 Aug 2024 10:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/36] soc: fsl: cpm1: tsa: Remove unused registers
 offset definition
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-9-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> SISTR, SICMR and SIRP registers offset definitions are not used.
> 
> In order to avoid unneeded code, remove them.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index a9d35b44489d..244d521d8780 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -66,12 +66,6 @@
>   #define   TSA_SIGMR_RDM_STATIC_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x2)
>   #define   TSA_SIGMR_RDM_DYN_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x3)
>   
> -/* SI status register (8 bits) */
> -#define TSA_SISTR	0x06
> -
> -/* SI command register (8 bits) */
> -#define TSA_SICMR	0x07
> -
>   /* SI clock route register (32 bits) */
>   #define TSA_SICR	0x0C
>   #define   TSA_SICR_SCC2_MASK		GENMASK(15, 8)
> @@ -102,9 +96,6 @@
>   #define       TSA_SICR_SCC_TXCS_CLK37	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x6)
>   #define       TSA_SICR_SCC_TXCS_CLK48	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x7)
>   
> -/* Serial interface RAM pointer register (32 bits) */
> -#define TSA_SIRP	0x10
> -
>   struct tsa_entries_area {
>   	void __iomem *entries_start;
>   	void __iomem *entries_next;

