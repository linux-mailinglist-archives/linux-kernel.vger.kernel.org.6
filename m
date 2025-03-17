Return-Path: <linux-kernel+bounces-563767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA13A647F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8AE3B3770
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C71AAA32;
	Mon, 17 Mar 2025 09:45:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A282D98
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204730; cv=none; b=N34uMhVqtFbyobI/PmZoNQBfstqPRv0uv5CMYz2usZho3PnyfN90dgfvXBaqA0hzT3DlhLubj1YF8ashcQ9UddHsE0jEc57EVGO1yvB75djTvYiAMSDep1LSCsOe+qtr/LLym0BS4TzcBooCxzAF9fHRekocXZaxdAjmaFoih64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204730; c=relaxed/simple;
	bh=oTTljZWBVhyMYOri5e1Sd4AdjNYMYL5t/xz1a6HBDHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktxz1sVXIiqN3vYBgw6Mf77Lj1yZ3fI5A+Zec/Af1m2zECT9FapYFsEu+3LB7wzE02UVPzrodtnkG1eI+6AkQuIo0707HgDn51gw4i6sOtYHVS2fDf6lpd7ctBaCgf8DLn6xWVP03eoIVIVRfubJNC+17NqOTLFfsSa4mySJYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tu727-00042i-9p; Mon, 17 Mar 2025 10:45:19 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tu726-000Dre-1k;
	Mon, 17 Mar 2025 10:45:18 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tu726-0018Bq-2l;
	Mon, 17 Mar 2025 10:45:18 +0100
Date: Mon, 17 Mar 2025 10:45:18 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, marex@denx.de,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: imx: Dump higher 64bits UID
Message-ID: <20250317094518.yf2hbq5sjl7lgfwb@pengutronix.de>
References: <20250314065225.442717-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314065225.442717-1-peng.fan@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Peng,

On 25-03-14, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP UID is actually 128bits and partitioned into two parts.
> The 1st 64bits are at 0x410 and 0x420, and 2nd 64bits are at 0xE00
> and 0xE10.
> 
> Dump the whole 128bits for i.MX8MP, by introducing soc_uid_h.

Thanks for taking care of this :) We noticed that this is crucial for
burning the field-return fuse to keep the LOCK fuse unlocked.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 3ed8161d7d28..02d8c85e9a28 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -24,13 +24,15 @@
>  #define OCOTP_UID_HIGH			0x420
>  
>  #define IMX8MP_OCOTP_UID_OFFSET		0x10
> +#define IMX8MP_OCOTP_UID_HIGH		0xE00
>  
>  /* Same as ANADIG_DIGPROG_IMX7D */
>  #define ANADIG_DIGPROG_IMX8MM	0x800
>  
>  struct imx8_soc_data {
>  	char *name;
> -	int (*soc_revision)(u32 *socrev, u64 *socuid);
> +	int (*soc_revision)(u32 *socrev, u64 *socuid, u64 *socuid_h);
> +	bool uid_len_128;

Albeit your patch is not wrong, it could be far simpler if we redefine
the soc_revision to serial_number. This way each SoC can specify 
the dedicated mechanism of setting the serial number. Going this way we
need two patches, the first one is converting the logic and the 2nd one
is adding a dedicated hook for the i.MX8MP.

Regards,
  Marco

>  };
>  
>  #ifdef CONFIG_HAVE_ARM_SMCCC
> @@ -49,7 +51,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
>  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
>  #endif
>  
> -static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
> +static int imx8mq_soc_revision(u32 *socrev, u64 *socuid, u64 *socuid_h)
>  {
>  	struct device_node *np __free(device_node) =
>  		of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
> @@ -102,7 +104,7 @@ static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
>  	return ret;
>  }
>  
> -static int imx8mm_soc_uid(u64 *socuid)
> +static int imx8mm_soc_uid(u64 *socuid, u64 *socuid_h)
>  {
>  	struct device_node *np __free(device_node) =
>  		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
> @@ -131,6 +133,12 @@ static int imx8mm_soc_uid(u64 *socuid)
>  	*socuid <<= 32;
>  	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
>  
> +	if (offset) {
> +		*socuid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);
> +		*socuid_h <<= 32;
> +		*socuid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);
> +	}
> +
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
>  
> @@ -139,7 +147,7 @@ static int imx8mm_soc_uid(u64 *socuid)
>  	return ret;
>  }
>  
> -static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
> +static int imx8mm_soc_revision(u32 *socrev, u64 *socuid, u64 *socuid_h)
>  {
>  	struct device_node *np __free(device_node) =
>  		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
> @@ -156,7 +164,7 @@ static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
>  
>  	iounmap(anatop_base);
>  
> -	return imx8mm_soc_uid(socuid);
> +	return imx8mm_soc_uid(socuid, socuid_h);
>  }
>  
>  static const struct imx8_soc_data imx8mq_soc_data = {
> @@ -177,6 +185,7 @@ static const struct imx8_soc_data imx8mn_soc_data = {
>  static const struct imx8_soc_data imx8mp_soc_data = {
>  	.name = "i.MX8MP",
>  	.soc_revision = imx8mm_soc_revision,
> +	.uid_len_128 = true,
>  };
>  
>  static __maybe_unused const struct of_device_id imx8_soc_match[] = {
> @@ -211,7 +220,7 @@ static int imx8m_soc_probe(struct platform_device *pdev)
>  	const struct of_device_id *id;
>  	struct soc_device *soc_dev;
>  	u32 soc_rev = 0;
> -	u64 soc_uid = 0;
> +	u64 soc_uid = 0, soc_uid_h = 0;
>  	int ret;
>  
>  	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
> @@ -232,7 +241,7 @@ static int imx8m_soc_probe(struct platform_device *pdev)
>  	if (data) {
>  		soc_dev_attr->soc_id = data->name;
>  		if (data->soc_revision) {
> -			ret = data->soc_revision(&soc_rev, &soc_uid);
> +			ret = data->soc_revision(&soc_rev, &soc_uid, &soc_uid_h);
>  			if (ret)
>  				return ret;
>  		}
> @@ -242,7 +251,11 @@ static int imx8m_soc_probe(struct platform_device *pdev)
>  	if (!soc_dev_attr->revision)
>  		return -ENOMEM;
>  
> -	soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL, "%016llX", soc_uid);
> +	if (data && data->uid_len_128)
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
> +							soc_uid_h, soc_uid);
> +	else
> +		soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL, "%016llX", soc_uid);
>  	if (!soc_dev_attr->serial_number)
>  		return -ENOMEM;
>  
> -- 
> 2.37.1
> 
> 
> 

