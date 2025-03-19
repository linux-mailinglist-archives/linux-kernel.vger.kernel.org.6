Return-Path: <linux-kernel+bounces-568612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D314A69865
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F613B51A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA920AF7B;
	Wed, 19 Mar 2025 18:50:12 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4814AD29
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410212; cv=none; b=swt4MAITmxcvQyPxkb2cTx2WLkYbgB/EogkU+706gIQGVkgLUqc5Wc/NeGXM+Ibb5aNcIL8n7+3VsxVt4/09mqbCS6EP1qquFphWTf1bJKc5+pHl+tRsbHV0aY2yM3GjlEWpsFDfmY2Fby8pTK5fsdIDV/ISOhTy8l2QFVA8s3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410212; c=relaxed/simple;
	bh=s49vwjQ3l4TyoesphNArH0fBetJeODPymwBaAu/ax3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrLZ9j6WttKxgHF3AgbuFkLh1G1ug0eRynFf7lSojq4aMsgqWpvdrAqJvuvMS86UuWFajGQRArfDVr9M1Exo3JjNdr2xs2bvVelrAA8WKC2L/pLEsDz4hHuHYgbKTNI3mQpasB4WGQWm+fECId1LpeqoTw1HhnS+S1ancg/lejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZHyLF6XWJz9sRy;
	Wed, 19 Mar 2025 19:44:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12Ee0xYLXrfT; Wed, 19 Mar 2025 19:44:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZHyLF5jSKz9sRs;
	Wed, 19 Mar 2025 19:44:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A403E8B796;
	Wed, 19 Mar 2025 19:44:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id R0yBEMijh7t3; Wed, 19 Mar 2025 19:44:37 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C18C8B763;
	Wed, 19 Mar 2025 19:44:37 +0100 (CET)
Message-ID: <6981de33-4ab4-4108-a2ad-e07d77483c56@csgroup.eu>
Date: Wed, 19 Mar 2025 19:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] MAINTAINERS: fix nonexistent dtbinding file name
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Stuart Yoder <stuyoder@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250319094311.2966519-1-ioana.ciornei@nxp.com>
 <20250319094311.2966519-3-ioana.ciornei@nxp.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250319094311.2966519-3-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/03/2025 à 10:43, Ioana Ciornei a écrit :
> [Vous ne recevez pas souvent de courriers de ioana.ciornei@nxp.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> The blamed commit converted the fsl,qoriq-mc.txt into fsl,qoriq-mc.yaml
> but forgot to also update the MAINTAINERS file to reference the new
> filename.
> 
> Fix this by using the corrent filename - fsl,qoriq-mc.yaml.
> 
> Fixes: bfb921b2a9d5 ("dt-bindings: misc: fsl,qoriq-mc: convert to yaml format")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76b6db4074ce..1e6aac2962dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19637,7 +19637,7 @@ M:      Ioana Ciornei <ioana.ciornei@nxp.com>
>   L:     linux-kernel@vger.kernel.org
>   S:     Maintained
>   F:     Documentation/ABI/stable/sysfs-bus-fsl-mc
> -F:     Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +F:     Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
>   F:     Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
>   F:     drivers/bus/fsl-mc/
>   F:     include/uapi/linux/fsl_mc.h
> --
> 2.34.1
> 


