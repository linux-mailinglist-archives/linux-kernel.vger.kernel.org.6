Return-Path: <linux-kernel+bounces-391316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52E9B8513
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6671C20D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890821925A2;
	Thu, 31 Oct 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MMd4c7lL"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C21547C4;
	Thu, 31 Oct 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409316; cv=none; b=TLk3p3E+vIgXn4PMABS9nntDUW9fCD4P8U9WYtTL2sYmbFuh6gpuJ95n/piEDdB0oC7e+YYKlADswNQ+xk8EhWu40cpZuwqbJordjGl/pBkMKj93GuGPCYtEwglG5P57ZVmc3W8tNa59iZliUX5CL8kXkqsGFxe4bKZB9MmKEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409316; c=relaxed/simple;
	bh=FMeDO3/in9dy0MR3MBf9/JD4k5jVkvtEFlLDRCChmwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzuEt1HlU8qTGW/J6IiWwQ2Y/o7JykoFLuJfxq/5TrhPTQtIC76bNjcbZqp/XLZAhrKBpHdYLAGdEjqae8Jfkt454jQJxal/dzP3cPBsmPPdY6k+jrx5RMxcvQJFrcAyalkhQq3fE9WiFWERjgyY33xSq3p921Cxzy2sm1LNIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MMd4c7lL; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 6cMcts8ryNFce6cMdtem2t; Thu, 31 Oct 2024 22:05:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730408759;
	bh=kHTr7Iv0gmEQnUpxnSZ+vW5TfWpCKIjU3SILenyMnOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MMd4c7lLqQk1IIQrn9UYOnxntZYO4m5g9dqvPtMCFZ/TUIxMXlRWX6qcjw8loyRXd
	 1UflQhe42rEnpNE8TWhuj5fna0GNHRRj37g/S76l5iL9E4JkGzpP4aP8ZZmH89Maqk
	 rX2vGQb6vMSXA2n46zMU/F2X6/4Ok52vRDEVddIMdzdkrk5JSDfwaH6lpRbjvu0PmT
	 +Tvagfgk/D6OeFtKSMJ4fE/JpMQWXHLRDsYhLHdwJcenyL07gdSzUfwsGTkl0T/zjd
	 P+UzOzCZXQCt1QIFnA3kLEkTALTIghsSg+jYFiemya6gh8nkDape4tkeEGzYyuMolW
	 P5xmAg1JX1cZg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 31 Oct 2024 22:05:59 +0100
X-ME-IP: 90.11.132.44
Message-ID: <27bf1dde-ea35-4b3f-b857-4ee61959547b@wanadoo.fr>
Date: Thu, 31 Oct 2024 22:05:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] mailbox: Introduce support for T-head TH1520
 Mailbox driver
To: Michal Wilczynski <m.wilczynski@samsung.com>, drew@pdp7.com,
 guoren@kernel.org, wefu@redhat.com, jassisinghbrar@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 m.szyprowski@samsung.com, samuel.holland@sifive.com,
 emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241031204723.1149912-1-m.wilczynski@samsung.com>
 <CGME20241031204734eucas1p1ec2a8a101e805802a851b01d87709061@eucas1p1.samsung.com>
 <20241031204723.1149912-2-m.wilczynski@samsung.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241031204723.1149912-2-m.wilczynski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 31/10/2024 à 21:47, Michal Wilczynski a écrit :
> This driver was tested using the drm/imagination GPU driver. It was able
> to successfully power on the GPU, by passing a command through mailbox
> from E910 core to E902 that's responsible for powering up the GPU. The
> GPU driver was able to read the BVNC version from control registers,
> which confirms it was successfully powered on.
> 
> [   33.957467] powervr ffef400000.gpu: [drm] loaded firmware
> powervr/rogue_36.52.104.182_v1.fw
> [   33.966008] powervr ffef400000.gpu: [drm] FW version v1.0 (build
> 6621747 OS)
> [   38.978542] powervr ffef400000.gpu: [drm] *ERROR* Firmware failed to
> boot
> 
> Though the driver still fails to boot the firmware, the mailbox driver
> works when used with the not-yet-upstreamed firmware AON driver. There
> is ongoing work to get the BXM-4-64 supported with the drm/imagination
> driver [1], though it's not completed yet.
> 
> This work is based on the driver from the vendor kernel [2].
> 
> Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/2 [1]
> Link: https://github.com/revyos/thead-kernel.git [2]
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Hi,

> +static int th1520_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct th1520_mbox_priv *priv;
> +	unsigned int remote_idx = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
> +	priv->clocks[0].id = "clk-local";
> +	priv->clocks[1].id = "clk-remote-icu0";
> +	priv->clocks[2].id = "clk-remote-icu1";
> +	priv->clocks[3].id = "clk-remote-icu2";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(priv->clocks),
> +				priv->clocks);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clocks\n");
> +		return ret;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(priv->clocks), priv->clocks);

This should be undone if an error occurs later in the probe.
Using a devm_action_or_reset() would certainly be nicer and would avoid 
the need for a .remove() function.

> +	if (ret) {
> +		dev_err(dev, "Failed to enable clocks\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * The address mappings in the device tree align precisely with those
> +	 * outlined in the manual. However, register offsets within these
> +	 * mapped regions are irregular, particularly for remote-icu0.
> +	 * Consequently, th1520_map_mmio() requires an additional parameter to
> +	 * handle this quirk.
> +	 */
> +	priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0] =
> +		th1520_map_mmio(pdev, "local", 0x0);
> +	if (IS_ERR(priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0]))
> +		return PTR_ERR(priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0]);
> +
> +	priv->remote_icu[0] = th1520_map_mmio(pdev, "remote-icu0", 0x4000);
> +	if (IS_ERR(priv->remote_icu[0]))
> +		return PTR_ERR(priv->remote_icu[0]);
> +
> +	priv->remote_icu[1] = th1520_map_mmio(pdev, "remote-icu1", 0x0);
> +	if (IS_ERR(priv->remote_icu[1]))
> +		return PTR_ERR(priv->remote_icu[1]);
> +
> +	priv->remote_icu[2] = th1520_map_mmio(pdev, "remote-icu2", 0x0);
> +	if (IS_ERR(priv->remote_icu[2]))
> +		return PTR_ERR(priv->remote_icu[2]);
> +
> +	priv->local_icu[TH_1520_MBOX_ICU_CPU1] =
> +		priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0] +
> +		TH_1520_MBOX_CHAN_RES_SIZE;
> +	priv->local_icu[TH_1520_MBOX_ICU_CPU2] =
> +		priv->local_icu[TH_1520_MBOX_ICU_CPU1] +
> +		TH_1520_MBOX_CHAN_RES_SIZE;
> +	priv->local_icu[TH_1520_MBOX_ICU_CPU3] =
> +		priv->local_icu[TH_1520_MBOX_ICU_CPU2] +
> +		TH_1520_MBOX_CHAN_RES_SIZE;
> +
> +	priv->cur_cpu_ch_base = priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0];
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq < 0)
> +		return priv->irq;
> +
> +	/* init the chans */
> +	for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
> +		struct th1520_mbox_con_priv *cp = &priv->con_priv[i];
> +
> +		cp->idx = i;
> +		cp->chan = &priv->mbox_chans[i];
> +		priv->mbox_chans[i].con_priv = cp;
> +		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
> +			 "th1520_mbox_chan[%i]", cp->idx);
> +
> +		cp->comm_local_base = priv->local_icu[i];
> +		if (i != TH_1520_MBOX_ICU_KERNEL_CPU0) {
> +			cp->comm_remote_base = priv->remote_icu[remote_idx];
> +			remote_idx++;
> +		}
> +	}
> +
> +	spin_lock_init(&priv->mbox_lock);
> +
> +	priv->mbox.dev = dev;
> +	priv->mbox.ops = &th1520_mbox_ops;
> +	priv->mbox.chans = priv->mbox_chans;
> +	priv->mbox.num_chans = TH_1520_MBOX_CHANS;
> +	priv->mbox.of_xlate = th1520_mbox_xlate;
> +	priv->mbox.txdone_irq = true;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = th1520_mbox_init_generic(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to init mailbox context\n");
> +		return ret;
> +	}
> +
> +	return devm_mbox_controller_register(dev, &priv->mbox);
> +}
> +
> +static void th1520_mbox_remove(struct platform_device *pdev)
> +{
> +	struct th1520_mbox_priv *priv = platform_get_drvdata(pdev);
> +
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
> +}

...

CJ




