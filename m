Return-Path: <linux-kernel+bounces-411793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B725C9CFFB8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E5D1F23A52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF742A80;
	Sat, 16 Nov 2024 16:00:20 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911717548
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772819; cv=none; b=uFFUxezd7Jmzy+lLvwsMv84sr6APITIAoTi2F65uiMuXIdSAAja8LapgzXsbireJ3gmiaNzILaU9wnj6U34tRpZ23Qz4k+0URg8iPdA2826ezJZOONPTYTurjkJAwdSSrGjFodQU3L9D6sxht/vDe4r9dpFg1SCMXyhGYnDMlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772819; c=relaxed/simple;
	bh=/2RDu+SO8axerWzjW5gTtNKUmZI4rvLdyV1Iab3XkZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF0ZQsCdxa50rp6zdrGdq077X29NdR9X/M3cIdoora+zVSlkE+GYjsYzg7PiIbh9ox6Rq0CotqAtMSRYEEf7GYPS1wms7v8XgxoJW03X1j7Cr0LKC1N04dHIoRAFLP5IdVyGPHePwHeSqmj9RjelpvSg75bXOR/1f94V7lXJbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XrJWM10jYz9sSN;
	Sat, 16 Nov 2024 17:00:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iUa0mkZAD12z; Sat, 16 Nov 2024 17:00:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XrJWL71yTz9sSL;
	Sat, 16 Nov 2024 17:00:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DE8C58B7A0;
	Sat, 16 Nov 2024 17:00:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0OJ6eQSkLj9u; Sat, 16 Nov 2024 17:00:14 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 76A3A8B763;
	Sat, 16 Nov 2024 17:00:14 +0100 (CET)
Message-ID: <c1c01965-ac44-4d8e-aff1-3f6169bdd3cf@csgroup.eu>
Date: Sat, 16 Nov 2024 17:00:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/10] macintosh: Remove ADB_MACIO
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241114131114.602234-8-mpe@ellerman.id.au>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241114131114.602234-8-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/11/2024 à 14:11, Michael Ellerman a écrit :
> The macio-adb driver depends on PPC_CHRP, which has been removed, remove
> the driver also.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   drivers/macintosh/Kconfig     |   9 --
>   drivers/macintosh/Makefile    |   1 -
>   drivers/macintosh/adb.c       |   4 -
>   drivers/macintosh/macio-adb.c | 288 ----------------------------------
>   4 files changed, 302 deletions(-)
>   delete mode 100644 drivers/macintosh/macio-adb.c

What about:

drivers/macintosh/adb.c:        if (!machine_is(chrp) && 
!machine_is(powermac))
drivers/macintosh/adbhid.c:     if (!machine_is(chrp) && 
!machine_is(powermac))

Christophe

> 
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index fb38f684444f..aebe7ca50e59 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -135,15 +135,6 @@ config PMAC_BACKLIGHT_LEGACY
>   	  programs which use this old interface. New and updated programs
>   	  should use the backlight classes in sysfs.
>   
> -config ADB_MACIO
> -	bool "Include MacIO (CHRP) ADB driver"
> -	depends on ADB && PPC_CHRP && !PPC_PMAC64
> -	help
> -	  Say Y here to include direct support for the ADB controller in the
> -	  Hydra chip used on PowerPC Macintoshes of the CHRP type.  (The Hydra
> -	  also includes a MESH II SCSI controller, DBDMA controller, VIA chip,
> -	  OpenPIC controller and two RS422/Geoports.)
> -
>   config INPUT_ADBHID
>   	bool "Support for ADB input devices (keyboard, mice, ...)"
>   	depends on ADB && INPUT=y
> diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
> index 712edcb3e0b0..efecf2c20af3 100644
> --- a/drivers/macintosh/Makefile
> +++ b/drivers/macintosh/Makefile
> @@ -23,7 +23,6 @@ obj-$(CONFIG_PMAC_SMU)		+= smu.o
>   obj-$(CONFIG_ADB)		+= adb.o
>   obj-$(CONFIG_ADB_MACII)		+= via-macii.o
>   obj-$(CONFIG_ADB_IOP)		+= adb-iop.o
> -obj-$(CONFIG_ADB_MACIO)		+= macio-adb.o
>   
>   obj-$(CONFIG_THERM_WINDTUNNEL)	+= therm_windtunnel.o
>   obj-$(CONFIG_THERM_ADT746X)	+= therm_adt746x.o
> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
> index 88adee42ba82..f1186ce04167 100644
> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -52,7 +52,6 @@ extern struct adb_driver via_macii_driver;
>   extern struct adb_driver via_cuda_driver;
>   extern struct adb_driver adb_iop_driver;
>   extern struct adb_driver via_pmu_driver;
> -extern struct adb_driver macio_adb_driver;
>   
>   static DEFINE_MUTEX(adb_mutex);
>   static struct adb_driver *adb_driver_list[] = {
> @@ -67,9 +66,6 @@ static struct adb_driver *adb_driver_list[] = {
>   #endif
>   #ifdef CONFIG_ADB_PMU
>   	&via_pmu_driver,
> -#endif
> -#ifdef CONFIG_ADB_MACIO
> -	&macio_adb_driver,
>   #endif
>   	NULL
>   };
> diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
> deleted file mode 100644
> index 19c63959ebed..000000000000
> --- a/drivers/macintosh/macio-adb.c
> +++ /dev/null
> @@ -1,288 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Driver for the ADB controller in the Mac I/O (Hydra) chip.
> - */
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/kernel.h>
> -#include <linux/delay.h>
> -#include <linux/spinlock.h>
> -#include <linux/interrupt.h>
> -#include <linux/pgtable.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
> -#include <linux/adb.h>
> -
> -#include <asm/io.h>
> -#include <asm/hydra.h>
> -#include <asm/irq.h>
> -#include <linux/init.h>
> -#include <linux/ioport.h>
> -
> -struct preg {
> -	unsigned char r;
> -	char pad[15];
> -};
> -
> -struct adb_regs {
> -	struct preg intr;
> -	struct preg data[9];
> -	struct preg intr_enb;
> -	struct preg dcount;
> -	struct preg error;
> -	struct preg ctrl;
> -	struct preg autopoll;
> -	struct preg active_hi;
> -	struct preg active_lo;
> -	struct preg test;
> -};
> -
> -/* Bits in intr and intr_enb registers */
> -#define DFB	1		/* data from bus */
> -#define TAG	2		/* transfer access grant */
> -
> -/* Bits in dcount register */
> -#define HMB	0x0f		/* how many bytes */
> -#define APD	0x10		/* auto-poll data */
> -
> -/* Bits in error register */
> -#define NRE	1		/* no response error */
> -#define DLE	2		/* data lost error */
> -
> -/* Bits in ctrl register */
> -#define TAR	1		/* transfer access request */
> -#define DTB	2		/* data to bus */
> -#define CRE	4		/* command response expected */
> -#define ADB_RST	8		/* ADB reset */
> -
> -/* Bits in autopoll register */
> -#define APE	1		/* autopoll enable */
> -
> -static volatile struct adb_regs __iomem *adb;
> -static struct adb_request *current_req, *last_req;
> -static DEFINE_SPINLOCK(macio_lock);
> -
> -static int macio_probe(void);
> -static int macio_init(void);
> -static irqreturn_t macio_adb_interrupt(int irq, void *arg);
> -static int macio_send_request(struct adb_request *req, int sync);
> -static int macio_adb_autopoll(int devs);
> -static void macio_adb_poll(void);
> -static int macio_adb_reset_bus(void);
> -
> -struct adb_driver macio_adb_driver = {
> -	.name         = "MACIO",
> -	.probe        = macio_probe,
> -	.init         = macio_init,
> -	.send_request = macio_send_request,
> -	.autopoll     = macio_adb_autopoll,
> -	.poll         = macio_adb_poll,
> -	.reset_bus    = macio_adb_reset_bus,
> -};
> -
> -int macio_probe(void)
> -{
> -	struct device_node *np __free(device_node) =
> -		of_find_compatible_node(NULL, "adb", "chrp,adb0");
> -
> -	if (np)
> -		return 0;
> -
> -	return -ENODEV;
> -}
> -
> -int macio_init(void)
> -{
> -	struct device_node *adbs __free(device_node) =
> -		of_find_compatible_node(NULL, "adb", "chrp,adb0");
> -	struct resource r;
> -	unsigned int irq;
> -
> -	if (!adbs)
> -		return -ENXIO;
> -
> -	if (of_address_to_resource(adbs, 0, &r))
> -		return -ENXIO;
> -
> -	adb = ioremap(r.start, sizeof(struct adb_regs));
> -	if (!adb)
> -		return -ENOMEM;
> -
> -
> -	out_8(&adb->ctrl.r, 0);
> -	out_8(&adb->intr.r, 0);
> -	out_8(&adb->error.r, 0);
> -	out_8(&adb->active_hi.r, 0xff); /* for now, set all devices active */
> -	out_8(&adb->active_lo.r, 0xff);
> -	out_8(&adb->autopoll.r, APE);
> -
> -	irq = irq_of_parse_and_map(adbs, 0);
> -	if (request_irq(irq, macio_adb_interrupt, 0, "ADB", (void *)0)) {
> -		iounmap(adb);
> -		printk(KERN_ERR "ADB: can't get irq %d\n", irq);
> -		return -EAGAIN;
> -	}
> -	out_8(&adb->intr_enb.r, DFB | TAG);
> -
> -	printk("adb: mac-io driver 1.0 for unified ADB\n");
> -
> -	return 0;
> -}
> -
> -static int macio_adb_autopoll(int devs)
> -{
> -	unsigned long flags;
> -	
> -	spin_lock_irqsave(&macio_lock, flags);
> -	out_8(&adb->active_hi.r, devs >> 8);
> -	out_8(&adb->active_lo.r, devs);
> -	out_8(&adb->autopoll.r, devs? APE: 0);
> -	spin_unlock_irqrestore(&macio_lock, flags);
> -	return 0;
> -}
> -
> -static int macio_adb_reset_bus(void)
> -{
> -	unsigned long flags;
> -	int timeout = 1000000;
> -
> -	/* Hrm... we may want to not lock interrupts for so
> -	 * long ... oh well, who uses that chip anyway ? :)
> -	 * That function will be seldom used during boot
> -	 * on rare machines, so...
> -	 */
> -	spin_lock_irqsave(&macio_lock, flags);
> -	out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | ADB_RST);
> -	while ((in_8(&adb->ctrl.r) & ADB_RST) != 0) {
> -		if (--timeout == 0) {
> -			out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) & ~ADB_RST);
> -			spin_unlock_irqrestore(&macio_lock, flags);
> -			return -1;
> -		}
> -	}
> -	spin_unlock_irqrestore(&macio_lock, flags);
> -	return 0;
> -}
> -
> -/* Send an ADB command */
> -static int macio_send_request(struct adb_request *req, int sync)
> -{
> -	unsigned long flags;
> -	int i;
> -	
> -	if (req->data[0] != ADB_PACKET)
> -		return -EINVAL;
> -	
> -	for (i = 0; i < req->nbytes - 1; ++i)
> -		req->data[i] = req->data[i+1];
> -	--req->nbytes;
> -	
> -	req->next = NULL;
> -	req->sent = 0;
> -	req->complete = 0;
> -	req->reply_len = 0;
> -
> -	spin_lock_irqsave(&macio_lock, flags);
> -	if (current_req) {
> -		last_req->next = req;
> -		last_req = req;
> -	} else {
> -		current_req = last_req = req;
> -		out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | TAR);
> -	}
> -	spin_unlock_irqrestore(&macio_lock, flags);
> -	
> -	if (sync) {
> -		while (!req->complete)
> -			macio_adb_poll();
> -	}
> -
> -	return 0;
> -}
> -
> -static irqreturn_t macio_adb_interrupt(int irq, void *arg)
> -{
> -	int i, n, err;
> -	struct adb_request *req = NULL;
> -	unsigned char ibuf[16];
> -	int ibuf_len = 0;
> -	int complete = 0;
> -	int autopoll = 0;
> -	int handled = 0;
> -
> -	spin_lock(&macio_lock);
> -	if (in_8(&adb->intr.r) & TAG) {
> -		handled = 1;
> -		req = current_req;
> -		if (req) {
> -			/* put the current request in */
> -			for (i = 0; i < req->nbytes; ++i)
> -				out_8(&adb->data[i].r, req->data[i]);
> -			out_8(&adb->dcount.r, req->nbytes & HMB);
> -			req->sent = 1;
> -			if (req->reply_expected) {
> -				out_8(&adb->ctrl.r, DTB + CRE);
> -			} else {
> -				out_8(&adb->ctrl.r, DTB);
> -				current_req = req->next;
> -				complete = 1;
> -				if (current_req)
> -					out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | TAR);
> -			}
> -		}
> -		out_8(&adb->intr.r, 0);
> -	}
> -
> -	if (in_8(&adb->intr.r) & DFB) {
> -		handled = 1;
> -		err = in_8(&adb->error.r);
> -		if (current_req && current_req->sent) {
> -			/* this is the response to a command */
> -			req = current_req;
> -			if (err == 0) {
> -				req->reply_len = in_8(&adb->dcount.r) & HMB;
> -				for (i = 0; i < req->reply_len; ++i)
> -					req->reply[i] = in_8(&adb->data[i].r);
> -			}
> -			current_req = req->next;
> -			complete = 1;
> -			if (current_req)
> -				out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | TAR);
> -		} else if (err == 0) {
> -			/* autopoll data */
> -			n = in_8(&adb->dcount.r) & HMB;
> -			for (i = 0; i < n; ++i)
> -				ibuf[i] = in_8(&adb->data[i].r);
> -			ibuf_len = n;
> -			autopoll = (in_8(&adb->dcount.r) & APD) != 0;
> -		}
> -		out_8(&adb->error.r, 0);
> -		out_8(&adb->intr.r, 0);
> -	}
> -	spin_unlock(&macio_lock);
> -	if (complete && req) {
> -	    void (*done)(struct adb_request *) = req->done;
> -	    mb();
> -	    req->complete = 1;
> -	    /* Here, we assume that if the request has a done member, the
> -    	     * struct request will survive to setting req->complete to 1
> -	     */
> -	    if (done)
> -		(*done)(req);
> -	}
> -	if (ibuf_len)
> -		adb_input(ibuf, ibuf_len, autopoll);
> -
> -	return IRQ_RETVAL(handled);
> -}
> -
> -static void macio_adb_poll(void)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	if (in_8(&adb->intr.r) != 0)
> -		macio_adb_interrupt(0, NULL);
> -	local_irq_restore(flags);
> -}

