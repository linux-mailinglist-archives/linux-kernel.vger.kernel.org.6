Return-Path: <linux-kernel+bounces-298471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305195C7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F04C287FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4B143889;
	Fri, 23 Aug 2024 08:13:49 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA913AA2A;
	Fri, 23 Aug 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400828; cv=none; b=eFr2yQxESqN+U4F8ccEazWqV07O1yNue7Wt27KMYYwEaPwpJGbvsh1TDb1UYliL5to07il6xnBL4Gc4B/Q174SB9a8KXmCmVMB+22tZSPUxBH3Tu048Qd3XvE/EzXuF2zfQBux4/tPFHgA3XMTOPrz8cM4jm6Awl0DBmccUBeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400828; c=relaxed/simple;
	bh=8b1CiNZxeMydF8seXzTgBTwmTunzU4ZfJa55i4NFgC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7Gw1OviFk4PPAgZaC9G9NS5TW5j8Fsf5DGBt1A0ZwmXfgUcwD4z5aRxQTuxWm8EuI92hBzca6/UkGzJyMQXu1pxD2hwdDk0//JbiGL6UftN7i0gPjedmTFtLT3XrrPkmxPfP9C7eHDF8TxtWtAiAHO4g3Xomwe3JnsTx9i6gc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqtBK6jLMz9sRr;
	Fri, 23 Aug 2024 10:13:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0TzCTJvcQ1f; Fri, 23 Aug 2024 10:13:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqtBK5wN7z9rvV;
	Fri, 23 Aug 2024 10:13:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B8AB68B77D;
	Fri, 23 Aug 2024 10:13:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kB7Px0ji50NS; Fri, 23 Aug 2024 10:13:45 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 39E4E8B763;
	Fri, 23 Aug 2024 10:13:45 +0200 (CEST)
Message-ID: <9f17277e-17da-4ea5-aba5-22b17abbfc3f@csgroup.eu>
Date: Fri, 23 Aug 2024 10:13:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/36] soc: fsl: cpm1: qmc: Introduce qmc_version
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-32-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-32-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles the CPM1 version of QMC.
> 
> In order to prepare the support for the QUICC Engine (QE) version of
> QMC, introduce qmc_version to identify versions. This will enable the
> code to make the distinction between several QMC implementations.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 062477b7426e..8ff7eaaa4c50 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -215,7 +215,12 @@ struct qmc_chan {
>   	bool	is_rx_stopped;
>   };
>   
> +enum qmc_version {
> +	QMC_CPM1,
> +};
> +
>   struct qmc_data {
> +	enum qmc_version version;
>   	u32 tstate; /* Initial TSTATE value */
>   	u32 rstate; /* Initial RSTATE value */
>   	u32 zistate; /* Initial ZISTATE value */
> @@ -1811,6 +1816,7 @@ static void qmc_remove(struct platform_device *pdev)
>   }
>   
>   static const struct qmc_data qmc_data_cpm1 = {
> +	.version = QMC_CPM1,
>   	.tstate = 0x30000000,
>   	.rstate = 0x31000000,
>   	.zistate = 0x00000100,

