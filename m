Return-Path: <linux-kernel+bounces-371376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A429A3A40
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6120C283221
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63DB20010B;
	Fri, 18 Oct 2024 09:41:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26931FF7C4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244484; cv=none; b=TnExq2/E3GW0Jf1LfQrDMjlipsC9XVVyPhpBw5ydQySjKcKp5I/GFLymQ7Nip5oHpB7+MT6WXUh5P86aaz6wlQot4SrjmwuH21z+1axK8tK9KlDWTclXYsEEvb4cBfD+1wTt8FiWj0AZ+iF5M9vAkYjsdD0huiInBLC5h3vDiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244484; c=relaxed/simple;
	bh=wffCtmN6ytO8CqC4XzgTLHinARfHMCGXGwK1kHB+yJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBGpKlOVR4nkvtlWOKvD2QotFN8npyJdywmgrY3n8zIl7PjqXo1WyE4clyXi8BaeVMpxvZkoLOqA0W/x66VRI4y8RCwqiQ/Fvya/C1KazQTfcEgAlfJh1hfMVpS0FVHpAY9WDO7rPXz14lDXDbWjsN3kcG1x874lztpKMtESWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1t1jTS-0006BO-Et; Fri, 18 Oct 2024 11:40:46 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1t1jTP-000Bil-2D;
	Fri, 18 Oct 2024 11:40:43 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1t1jTP-000Qi1-1r;
	Fri, 18 Oct 2024 11:40:43 +0200
Date: Fri, 18 Oct 2024 11:40:43 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nikita.shubin@maquefel.me, arnd@arndb.de, vkoul@kernel.org,
	esben@geanix.com, linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
Message-ID: <ZxItGw0m_w0jgtAq@pengutronix.de>
References: <20241018022519.721914-1-hpchen0nvt@gmail.com>
 <20241018022519.721914-3-hpchen0nvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018022519.721914-3-hpchen0nvt@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2024 at 02:25:19AM +0000, Hui-Ping Chen wrote:
> +static int ma35_nfi_ecc_check(struct nand_chip *chip, u8 *addr)
> +{
> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int i, j, nchunks = 0;
> +	int report_err = 0;
> +	int err_cnt = 0;
> +	u32 status;
> +
> +	nchunks = mtd->writesize / chip->ecc.steps;
> +	if (nchunks < 4)
> +		nchunks = 1;
> +	else
> +		nchunks /= 4;
> +
> +	for (j = 0; j < nchunks; j++) {
> +		status = readl(nand->regs + MA35_NFI_REG_NANDECCES0 + j * 4);
> +		if (!status)
> +			continue;
> +
> +		for (i = 0; i < 4; i++) {
> +			if ((status & ECC_STATUS_MASK) == 0x01) {
> +				/* Correctable error */
> +				err_cnt = (status >> 2) & ECC_ERR_CNT_MASK;
> +				ma35_nfi_correct(chip, j * 4 + i, err_cnt, addr);
> +				report_err += err_cnt;

This is still wrong. This should be

				report_err = max(report_err, err_cnt);

You have to search for the subpage that has the most bitflips and return
the number of bitflips on that subpage, *not* the total amount of errors
on the whole page.

That said, the statistic counter should still count the total number of
bitflips occurred.

Sascha

> +			} else {
> +				/* Uncorrectable error */
> +				dev_warn(nand->dev, "uncorrectable error! 0x%4x\n", status);
> +				return -EBADMSG;
> +			}
> +			status >>= 8;
> +		}
> +	}
> +	return report_err;
> +}
> +

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

