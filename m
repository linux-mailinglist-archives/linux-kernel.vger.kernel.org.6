Return-Path: <linux-kernel+bounces-571150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6738A6B9C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F398018924FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF32206BB;
	Fri, 21 Mar 2025 11:20:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961E2206B8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556006; cv=none; b=Y6G13Z483c4sSKfKDLnIWlHIJq3fVkAbepQcvW9XgqOCPsr7fneVq5kxR+8rL42HrBmDsjmkQ68uhu80Qu4ULE2fn2c2FwJFbGFwRLW3eEVfBp77R+Adj9nuAsu1/pDhY2OE93vq6evJARORtXmoXcWDSncDLfvMZO80z8zClwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556006; c=relaxed/simple;
	bh=YFEfA3a/EPpaoRweBRoLldvePe/W9+0Mq/r+V3uEVEo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OkgUvWaUJTL3rHBDnAN8cHQYULCqO8qeR04rK3j6QsOLm21JpMevaKhkb6vCMVPeU9AeDxLLLlj8N8rCcutbLnBqgeVbYI2LMbpvT8IUh5TiHVkLqf8W7CKrd0mC9c9AmB9F01bpH/k0/cHZ0x1ZJ9QKwutKHVH5HTY3o82p05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZK0B25DGHz9sRr;
	Fri, 21 Mar 2025 12:11:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wP-_Bw1qImbH; Fri, 21 Mar 2025 12:11:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZK09y3kw9z9sPd;
	Fri, 21 Mar 2025 12:11:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FA0A8B79C;
	Fri, 21 Mar 2025 12:11:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ljt2SZDW7QiL; Fri, 21 Mar 2025 12:11:02 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AE398B763;
	Fri, 21 Mar 2025 12:11:02 +0100 (CET)
Message-ID: <2dea9d3d-ef48-4799-b3cb-df4658ae6e29@csgroup.eu>
Date: Fri, 21 Mar 2025 12:11:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [GIT PULL] SOC FSL for 6.15
To: soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Content-Language: fr-FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

Please pull the following Freescale Soc Drivers changes for 6.15

Thanks
Christophe

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

   https://github.com/chleroy/linux.git tags/soc_fsl-6.15-1

for you to fetch changes up to c25951eb7518844fcb7fc9ec58e888731e8c46d0:

   bus: fsl-mc: Remove deadcode (2025-03-21 09:46:08 +0100)

----------------------------------------------------------------
FSL SOC Changes for 6.15:

- irqdomain cleanups from Jiry

- Add Ioana as Maintainer of fsl-mc bus and remove Laurentiu and Stuart

- Remove deadcode from fsl-mc bus

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
       bus: fsl-mc: Remove deadcode

Ioana Ciornei (3):
       MAINTAINERS: add myself as maintainer for the fsl-mc bus
       MAINTAINERS: fix nonexistent dtbinding file name
       MAINTAINERS: add the linuppc-dev list to the fsl-mc bus entry

Jiri Slaby (SUSE) (1):
       irqdomain: soc: Switch to irq_find_mapping()

  MAINTAINERS                           |  6 +++---
  drivers/bus/fsl-mc/dpmcp.c            | 22 ----------------------
  drivers/bus/fsl-mc/fsl-mc-allocator.c |  5 -----
  drivers/bus/fsl-mc/fsl-mc-private.h   |  6 ------
  drivers/bus/fsl-mc/mc-io.c            | 20 --------------------
  drivers/soc/fsl/qe/qe_ic.c            |  4 ++--
  include/linux/fsl/mc.h                |  2 --
  7 files changed, 5 insertions(+), 60 deletions(-)

