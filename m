Return-Path: <linux-kernel+bounces-181168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3548C7864
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2FD1C217A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1368F14A4E5;
	Thu, 16 May 2024 14:23:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC73148FE8;
	Thu, 16 May 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869430; cv=none; b=SmjGZKyae167pMKDq6cBwVKTUEkHrO2SVywI1XAG7liclkIn+SkODJJqODHa30D5qC0h7PPQEgVKo7n0sSC3Pw0ebUhCJyAj+ESNNEyqoLspi+ggTKxlBbTRb2EtdvL3xby13LtS9xbsVd0YkuQ3cYQ01MM1QsW346sdpszGh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869430; c=relaxed/simple;
	bh=Fti6H3W1smNncPVKr74qDUHtHjkzeSdsYo6re5dw0yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FixOPNRaNBP8lvRpmzwr/K8xY0e1DSUFDHvs9PBSi59HKqvOy20Keyrgww+On8TMXEPLZxJOyKwWkKz3UKNxyX2et7PnMdP6QvIIISOXoFfdf2QwvN1Fqpy6bjciR0fys1SNR4G9Cu2C1V67z8P/fAsM/NVJafksIYSoG/EJ7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6F9C113CC;
	Thu, 16 May 2024 14:23:48 +0000 (UTC)
Date: Thu, 16 May 2024 16:23:46 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, loic.poulain@linaro.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com
Subject: Re: Re: Re: Re: [PATCH] bus: mhi: host: Add Foxconn SDX72 related
 support
Message-ID: <20240516142346.GA6922@thinkpad>
References: <20240510032657.789629-1-slark_xiao@163.com>
 <20240514143741.GA2306@thinkpad>
 <541de8e4.1600.18f79de44f3.Coremail.slark_xiao@163.com>
 <20240515074119.GA2445@thinkpad>
 <5eee5967.7bdf.18f7b4567b7.Coremail.slark_xiao@163.com>
 <20240515115239.GD4488@thinkpad>
 <58fb648d.ab03.18f7c2f90bd.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58fb648d.ab03.18f7c2f90bd.Coremail.slark_xiao@163.com>

On Wed, May 15, 2024 at 08:17:23PM +0800, Slark Xiao wrote:
> 
> 
> At 2024-05-15 19:52:39, "Manivannan Sadhasivam" <mani@kernel.org> wrote:
> >On Wed, May 15, 2024 at 04:01:37PM +0800, Slark Xiao wrote:
> >> 
> >> At 2024-05-15 15:41:19, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org> wrote:
> >> >+ Qiang
> >> >
> >> >On Wed, May 15, 2024 at 09:29:20AM +0800, Slark Xiao wrote:
> >> >> At 2024-05-14 22:37:41, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org> wrote:
> >> >> >On Fri, May 10, 2024 at 11:26:57AM +0800, Slark Xiao wrote:
> >> >> >> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> >> >> >> And also, add firehose support since SDX72.
> >> >> >> 
> >> >> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> >> >> ---
> >> >> >>  drivers/bus/mhi/host/pci_generic.c | 31 ++++++++++++++++++++++++++++++
> >> >> >>  1 file changed, 31 insertions(+)
> >> >> >> 
> >> >> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >> >> >> index 08844ee79654..0fd94c193fc6 100644
> >> >> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> >> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> >> >> @@ -399,6 +399,8 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
> >> >> >>  	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
> >> >> >>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> >> >> >>  	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> >> >> >> +	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> >> >> >> +	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
> >> >> >
> >> >> >This means SDX55 is also supporting FIREHOSE channels, which is not true I
> >> >> >believe.
> >> >> Actually, I just verified it with my sdx55 and the answer is Yes. These channels
> >> >> are common settings for Qcom device which support PCIe mode. BTW, the
> >> >> default settings of Qcom and Quectel support firehose for their sdx55 products.
> >> >
> >> >Qiang, can you please confirm that SDX55 supports FIREHOSE channels?
> >> >
> >> >> >
> >> >> >>  	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
> >> >> >>  	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
> >> >> >>  };
> >> >> >> @@ -419,6 +421,16 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
> >> >> >>  	.event_cfg = mhi_foxconn_sdx55_events,
> >> >> >>  };
> >> >> >>  
> >> >> >> +static const struct mhi_controller_config modem_foxconn_sdx72_config = {
> >> >> >> +	.max_channels = 128,
> >> >> >> +	.timeout_ms = 20000,
> >> >> >> +	.ready_timeout_ms = 50000,
> >> >> >> +	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
> >> >> >> +	.ch_cfg = mhi_foxconn_sdx55_channels,
> >> >> >> +	.num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
> >> >> >> +	.event_cfg = mhi_foxconn_sdx55_events,
> >> >> >> +};
> >> >> >> +
> >> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
> >> >> >>  	.name = "foxconn-sdx24",
> >> >> >>  	.config = &modem_foxconn_sdx55_config,
> >> >> >> @@ -448,6 +460,16 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx65_info = {
> >> >> >>  	.sideband_wake = false,
> >> >> >>  };
> >> >> >>  
> >> >> >> +static const struct mhi_pci_dev_info mhi_foxconn_sdx72_info = {
> >> >> >> +	.name = "foxconn-sdx72",
> >> >> >> +	.edl = "qcom/sdx72m/xbl_s_devprg_ns.melf",
> >> >> >
> >> >> >What is '.melf'? Is the firmware available somewhere? Did you plan to upstream
> >> >> >it to linux-firmware?
> >> >> >
> >> >> This file similar with "edl.mbn". In SDX72 product, the default "edl" file name is
> >> >> "xbl_s_devprg_ns.melf". Currently we don't plan to upstream it to linux-firmware
> >> >> since 2 reasons: 1: we share the same fold name sdx72m with qcom or other vendors
> >> >> 2: this file may be changed since sdx72 product still under developing in our side. we
> >> >> may change the base line according to QCOM release.
> >> >
> >> >Then I would ask you to add support when you have a stable firmware. I do not
> >> >want to change the firmware name after some time as it will confuse users.
> >> >
> >> >- Mani
> >> If a stable firmware must be provided, I think I shall change the folder name from qcom to
> >> fox, do you agree this?
> >
> >Even in that case, where can the user find the firmware?
> >
> I think this edl file could help user let device enter into edl mode(wwan0firehose0).
> For PCIE device, there is no opensource tool to support PCIE edl download. If user
> could get the tool to do the firehose download, I think it's not hard to get complete firmware
> from PC vendor or somewhere else.

I was told that Qcom will upstream the PCI support for QDL in the coming weeks.
Once that happens (even if a PR), I'll share that with you. Please test it and
let me know if that works or not.

And for entering EDL mode, we have recently added support to trigger EDL mode
from host [1]. Could you also test that? You just need to add `edl_trigger =
true` to the `mhi_pci_dev_info` struct of SDX72 and trigger EDL mode from host
by:

echo 1 > /sys/bus/mhi/devices/.../trigger_edl

> >> BTW, I need to check if it works after updating 'edl fw' from  xbl_s_devprg_ns.melf to
> >> edl.mbn. 
> 
> >
> >Okay. IMO, we should upstream the product support only after a stable firmware
> >release (well stable in the sense a stable name at least).
> >
> >- Mani
> The check result is we can rename it to align with previous format. Until now, 
> I didn't see any mhi device has upstream their firmware to /lib/firmware/qcom folder.

It is not mandatory, but it is a best practise that I recently started asking
for.

> If it's a must, I think we can upstream the edl file later.  Anyway, we hope we can
> merge this sdx72 support into 6.10 since customer(Dell) would use this kernel for official
> release. But no worry, we can make sure this firehose download method works well in
>  our local side.
> And also, please help a review about my previous email about fix sdx72 ping failure issue.
> There is a fix solution from us. 
> 

Qiang is working on that.

- Mani

[1] https://lore.kernel.org/mhi/1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com/

-- 
மணிவண்ணன் சதாசிவம்

