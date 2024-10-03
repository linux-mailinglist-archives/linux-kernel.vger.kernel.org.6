Return-Path: <linux-kernel+bounces-348581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A298E956
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581E2B23857
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19A40BF2;
	Thu,  3 Oct 2024 05:21:30 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7FB2110E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932889; cv=none; b=A5+Rx6UV9bscPXIHwPNJG94K/XkwZrk75rpk17TdsJxsUdMubHtGRLfARUHcU/fIwv1sUq55yeW5sWhUBb4VWTw0Do7M9+B8vWwRLMJnGMXRkNWijMTrzdh6alzUIFV+5MGCW+R6zQQboDoBZUjHjbLERTSWVzvvcDk9C8t68HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932889; c=relaxed/simple;
	bh=TLlYfqsej1jvMOodcxUf7H4bpjzZHIIQhryYVpzqnd0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=uxTsx7RVkfKEcaVGockWuQlDDzYAxa6r2ztS4oMsW9A2pcbvw2yLU97zY7uftpdSVYTdlVInvJU+5yHrzoZXgKnFCNJtPm0tFNuGk9iXUv1OBqS//XdNu7VBcJEn+mb3yxKMYRaaakPvED/Tv8hku7xm62+D1zlR1dgTQlQisGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XK0QY4jZbz9sPd;
	Thu,  3 Oct 2024 07:21:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJL9cLjZYQ63; Thu,  3 Oct 2024 07:21:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XK0QY3xKXz9rvV;
	Thu,  3 Oct 2024 07:21:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 759BB8B766;
	Thu,  3 Oct 2024 07:21:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LiKfHjcgrxAl; Thu,  3 Oct 2024 07:21:25 +0200 (CEST)
Received: from [192.168.233.90] (unknown [192.168.233.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D0028B763;
	Thu,  3 Oct 2024 07:21:25 +0200 (CEST)
Message-ID: <c954bdb0-0c16-491a-8662-37e58f07208f@csgroup.eu>
Date: Thu, 3 Oct 2024 07:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [GIT PULL] SOC FSL fixes for 6.12
To: soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Herve Codina <herve.codina@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Content-Language: fr-FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

Please pull the following Freescale Soc Drivers fixes for 6.12

Thanks
Christophe

The following changes since commit 7a99b1c0bce5cf8c554ceecd29ad1e8085557fd3:

   Merge branch 'support-for-quicc-engine-tsa-and-qmc' (2024-09-03 
07:51:34 +0200)

are available in the Git repository at:

   https://github.com/chleroy/linux.git tags/soc_fsl-6.12-3

for you to fetch changes up to 1117b916f541fc8e4ce812843555432022e5aa0e:

   soc: fsl: cpm1: qmc: Fix unused data compilation warning (2024-10-02 
23:29:38 +0200)

----------------------------------------------------------------
FSL SOC fixes for v6.12:

- Fix a "cast to pointer from integer of different size" build error
due to IS_ERROR_VALUE() used with something which is not a pointer.

- Fix an unused data build warning.

----------------------------------------------------------------
Geert Uytterhoeven (1):
       soc: fsl: cpm1: qmc: Do not use IS_ERR_VALUE() on error pointers

Herve Codina (1):
       soc: fsl: cpm1: qmc: Fix unused data compilation warning

  drivers/soc/fsl/qe/qmc.c | 11 +++++------
  1 file changed, 5 insertions(+), 6 deletions(-)

