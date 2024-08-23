Return-Path: <linux-kernel+bounces-298452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C795C783
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2CA28794A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5214264C;
	Fri, 23 Aug 2024 08:08:53 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4413FD72;
	Fri, 23 Aug 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400532; cv=none; b=SjoSKiN8Y8uNAzfMoU7NFQQd5UWMBy/PXBy8ApyZpFuAJo95x58siOzKPIFF7C/emncWijAv0cLcrs9yTxi8f9GMrV/PZ49lLU6RTXt7vxM/AYO51qWQrZAW82mMnd1sRLj6aUZE0Q64DZgOHzYmNt7NgBIh7izLu4qC5imkCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400532; c=relaxed/simple;
	bh=+d6GEjAJzHDWsT6uC4M02uX5Tt9jnQA7UbKNS2F89zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTYuD0S+jP57lXy2Q0X/lue2dztsWh8EIb2066qM87bLZj6Xzv/QxH72uH+rnSx0rNG6qEOx8Ual6q9c3pvZ21WNftxHfHe2rTaiNsWbM8PXNsmRpC6KRHN9gcAMODNVLh0WUB2A0plLQt6h0zdUf8HER1wxj1rXZcvaqy0CQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt4d2Kqvz9sRr;
	Fri, 23 Aug 2024 10:08:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jDhdnb1gfOuw; Fri, 23 Aug 2024 10:08:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt4Z5bt6z9rvV;
	Fri, 23 Aug 2024 10:08:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AF48A8B77D;
	Fri, 23 Aug 2024 10:08:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BmXs51ivFIxZ; Fri, 23 Aug 2024 10:08:46 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 294D08B763;
	Fri, 23 Aug 2024 10:08:46 +0200 (CEST)
Message-ID: <2d063529-3281-4dce-8dbc-21a07ab478fa@csgroup.eu>
Date: Fri, 23 Aug 2024 10:08:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/36] MAINTAINERS: Add QE files related to the
 Freescale TSA controller
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-16-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-16-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> The Freescale TSA controller driver supports both QE and CPM1.
> 
> Add the newly introduced QE files to the existing entry.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..1d32d38f2247 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9011,9 +9011,11 @@ M:	Herve Codina <herve.codina@bootlin.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
> +F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
>   F:	drivers/soc/fsl/qe/tsa.c
>   F:	drivers/soc/fsl/qe/tsa.h
>   F:	include/dt-bindings/soc/cpm1-fsl,tsa.h
> +F:	include/dt-bindings/soc/qe-fsl,tsa.h
>   
>   FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
>   L:	netdev@vger.kernel.org

