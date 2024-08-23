Return-Path: <linux-kernel+bounces-299387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E6295D3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487E01F23FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BBC187855;
	Fri, 23 Aug 2024 17:00:34 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB82185926
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432434; cv=none; b=kgnJzCrTUE4zgWTuWB0qdAp1PccNhqrbQmvopDpB2IPwNYB+WvTlrUlLx7j4R3hGZtpwPqotH5QZ3wicTorjUyBNe/KRA5eKm7TXxH1S7zRuwG+tH5ST1kNSDuZlOd+QsOtoUfilayaTIrZjkyne+YPS/lJJ4XrRQKBncn8ShQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432434; c=relaxed/simple;
	bh=MfKQ6H+tqkA+T2IDx/GYF/jlqv4gRrlkmoDifvwI5ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szP9RV8fLnsgqU1QC+95WIGxifnXrzc1IdP3QvW0XK9Xm8CgvvREP9P8Y8u0Dr2k6eKcY07rIfIDMuefsUx/Tbdlu+DObCdVd1NSx3XI/axMOyK/9ie72e7+2YWT4he4qDxG9OT4wlYSpHD7OSe31riFxm4VY7wNPM1U//hBR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wr5t62S3Qz9sRr;
	Fri, 23 Aug 2024 19:00:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5E58EHGa9Ba; Fri, 23 Aug 2024 19:00:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wr5t61dk7z9sRk;
	Fri, 23 Aug 2024 19:00:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2720C8B781;
	Fri, 23 Aug 2024 19:00:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gn3olMTCJfO7; Fri, 23 Aug 2024 19:00:30 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B6E8C8B763;
	Fri, 23 Aug 2024 19:00:29 +0200 (CEST)
Message-ID: <584eebac-d052-4748-8886-ded7c8776f5a@csgroup.eu>
Date: Fri, 23 Aug 2024 19:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: fsl-mc: make fsl_mc_bus_type const
To: Kunwu Chan <kunwu.chan@linux.dev>, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Kunwu Chan <chentao@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240823062440.113628-1-kunwu.chan@linux.dev>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240823062440.113628-1-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/08/2024 à 08:24, Kunwu Chan a écrit :
> [Vous ne recevez pas souvent de courriers de kunwu.chan@linux.dev. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the fsl_mc_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu> # for 
include/linux/fsl/mc.h

> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
>   include/linux/fsl/mc.h          | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index dd68b8191a0a..930d8a3ba722 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -309,7 +309,7 @@ static struct attribute *fsl_mc_bus_attrs[] = {
> 
>   ATTRIBUTE_GROUPS(fsl_mc_bus);
> 
> -struct bus_type fsl_mc_bus_type = {
> +const struct bus_type fsl_mc_bus_type = {
>          .name = "fsl-mc",
>          .match = fsl_mc_bus_match,
>          .uevent = fsl_mc_bus_uevent,
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index 083c860fd28e..c90ec889bfc2 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -436,7 +436,7 @@ void fsl_mc_free_irqs(struct fsl_mc_device *mc_dev);
>   struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
>                                            u16 if_id);
> 
> -extern struct bus_type fsl_mc_bus_type;
> +extern const struct bus_type fsl_mc_bus_type;
> 
>   extern struct device_type fsl_mc_bus_dprc_type;
>   extern struct device_type fsl_mc_bus_dpni_type;
> --
> 2.43.0
> 

