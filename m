Return-Path: <linux-kernel+bounces-298477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAFE95C7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2E289297
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443B1448D9;
	Fri, 23 Aug 2024 08:15:16 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE71428E3;
	Fri, 23 Aug 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400916; cv=none; b=tq8rMGrhBPytDt/XTeeK/hV09U/PWN9gujxFn4EwQsMLNaDZVL0yoCrf/wmdTPl7wK4sinQYfjrv0J8l07n8/PtxaYan1pLpFraUQUPt9SnaQTvAROwnnybAIXqtO5hksGd/Vyt2mR6+OI21xPwd3e8H0EyUNvlwsI1vM4FSnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400916; c=relaxed/simple;
	bh=c9yTs9pk4E9gwtk8Yl1KIvm78h7+s4O4ZuG9CHMTVTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuNZz3BNLbTBSg+D8UHlYuMhlszEaBT0mvrFkZxenFX9ccPc8NHPkElerVZaYv27QtCwLeBHnydlzQLuCLL46rJQBFAKs5R7lj/B2I6hTX5CJG3n9X2m9cpqBG5WPu1wpQVMFEnrvYGTuoWLt71kwFIjgHmBKAG5dW3EPnSbGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqtD10DNtz9sRr;
	Fri, 23 Aug 2024 10:15:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXoGByX6bG9Q; Fri, 23 Aug 2024 10:15:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqtD06XWMz9rvV;
	Fri, 23 Aug 2024 10:15:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CE2358B77D;
	Fri, 23 Aug 2024 10:15:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wGaRUWbdC5iu; Fri, 23 Aug 2024 10:15:12 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A5758B763;
	Fri, 23 Aug 2024 10:15:12 +0200 (CEST)
Message-ID: <3217f63f-0d23-477f-b1e1-b2204773ac90@csgroup.eu>
Date: Fri, 23 Aug 2024 10:15:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 36/36] MAINTAINERS: Add QE files related to the
 Freescale QMC controller
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-37-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-37-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> The Freescale QMC controller driver supports both QE and CPM1.
> 
> Add the newly introduced QE files to the existing entry.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d32d38f2247..1331bdeb7386 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8996,6 +8996,7 @@ M:	Herve Codina <herve.codina@bootlin.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> +F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml
>   F:	drivers/soc/fsl/qe/qmc.c
>   F:	include/soc/fsl/qe/qmc.h
>   

