Return-Path: <linux-kernel+bounces-566315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9CA67632
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6E33B5257
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322520E008;
	Tue, 18 Mar 2025 14:20:10 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB12F20DD7D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307610; cv=none; b=P59t6BeaA/MGmD9RZJW6HITFJ04ow0NIDnUvtZIiroD8xzbrZPHvXlAUpXEqpCaThk7Jah0ms/ZqTPA5d5S1TXik3DZwBwloV/166ztQDJ6BvzYuNxNaJmOZztlsSN7bHTIsUAdP2mwGNZIHYUiSFoJJvmY9vsiubmXYmQGE2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307610; c=relaxed/simple;
	bh=vUloTrOUCIcf40SnnfQPQKJzMerY7bSFQFXtQepiPtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agW59Lidzm8NOmDlyvE6R2Fy3uzP+dm7T1rlN3B/CGQaysRCJm6kI3gXqBCZ2eijWgW+fg+RTAMLxGM/B87D9jS/L4VkFo3bduZlArGntSvh3qB9lsDt+hBysf0voJYw+bK9HDfJBj/xWVDENoIKcNl7wix4o/3QrT+GoxRq4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZHCnD3VgPz9sT8;
	Tue, 18 Mar 2025 14:46:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13JVH6dmrxGs; Tue, 18 Mar 2025 14:46:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZHCnD2cQvz9sSq;
	Tue, 18 Mar 2025 14:46:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 47E9D8B78F;
	Tue, 18 Mar 2025 14:46:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cGsNLrlU5MWU; Tue, 18 Mar 2025 14:46:56 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E0EE68B763;
	Tue, 18 Mar 2025 14:46:55 +0100 (CET)
Message-ID: <1d822960-85a7-42b3-88cf-9d3dbc75a831@csgroup.eu>
Date: Tue, 18 Mar 2025 14:46:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Maintenance path for the fsl-mc bus
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <2xzljdzktgpsyag5jhfwbxc2sroaacljecsq36hlxefu6jnz6g@zlorxu7niqnq>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <2xzljdzktgpsyag5jhfwbxc2sroaacljecsq36hlxefu6jnz6g@zlorxu7niqnq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ioana,

Le 18/03/2025 à 11:40, Ioana Ciornei a écrit :
> [Vous ne recevez pas souvent de courriers de ioana.ciornei@nxp.com. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> As highlighted by the discussion in the following thread, the
> maintenance path for the fsl-mc bus is not clear.
> 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-arm-kernel%2FZ9Lj9_yM1EK5pKee%40gallifrey&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C00bf096aa0fe40f9d8e908dd66094d7d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638778912314503921%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2F%2B%2FXzSQ9VUY81xPbjB8%2F0vIIF9ChaTRXupWd59%2Fvfco%3D&reserved=0
> 
> The fsl-mc bus driver was first added to drivers/staging and because of
> that, Greg was to one to pick up patches through his tree. Once it was
> moved to drivers/bus/fsl-mc, patches on this driver were picked either
> by Greg or by the Freescale SOC maintainer at that time - Li Yang.
> 
> Conceptually speaking, the fsl-mc bus driver is contributing to the same
> infrastructure level as the SoC drivers maintained now by Christophe.
> 
> Christophe, would you be open to pick up patches for this bus driver
> through your tree?

Yes its fine for me to take it via my soc fsl subtree unless Arnd tells 
different. But be aware that it will be purely administrative. I will 
have no mean to check whether any changes are actually working properly.

In that case please add the following entry in MAINTAINERS:

L:	linuxppc-dev@lists.ozlabs.org


> 
> As a side note, I know that the MAINTAINERS entry for this driver is not
> up to date - Laurentiu's email bounces. I will send a patch updating it
> after it's clear to whom I should send it.
> 
> Thanks,
> Ioana


