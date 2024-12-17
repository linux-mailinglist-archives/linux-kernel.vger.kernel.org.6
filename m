Return-Path: <linux-kernel+bounces-449056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677099F4929
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330627A5E04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469A1E1A31;
	Tue, 17 Dec 2024 10:46:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A61DF963
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432402; cv=none; b=scbpAQCTLrZlRRCm4mx4gGBCdiHKNOn/gDeuUjJCFajzYXCS1sPh2UxlsSctA8vRgE6NEPg/NHWWddmAKj7EK+b8Uc2K4KSF7CDJ887jHPon4sGP0Ax/p1Bu5kjRBV1V6v0H6z8xPw4UXj+cb++pU+6wjyuOvRBQ4gVwNySjvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432402; c=relaxed/simple;
	bh=wr0Kuq5L0MBBBURZSuBTmsyK7yMvrKdWnQMD3ttDYOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdJhgTi9Vf6trFk/5QBS4KA/Icl3UOinVEzhk/A5NTFXgQcJP3q1XD76KN3s7S3AWSwQa7TRFN6dm4pWhe6CWxcSUxZ0MT2velcc79744V/46xynfNa4Eyhwe83/WuwME/5qU8heMfgB1A4vFbq7kCtcVUGk391Rj+H6NmEMJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tNV63-0001a5-EW; Tue, 17 Dec 2024 11:46:35 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tNV62-003qk0-0G;
	Tue, 17 Dec 2024 11:46:34 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tNV62-004VQ6-2Q;
	Tue, 17 Dec 2024 11:46:34 +0100
Date: Tue, 17 Dec 2024 11:46:34 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"marex@denx.de" <marex@denx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] soc: imx8m: Add remove function
Message-ID: <20241217104634.2fc7yo6hprhx2wnt@pengutronix.de>
References: <20241217015826.1374497-1-peng.fan@oss.nxp.com>
 <20241217082637.i2ou6bbr3tc3uvof@pengutronix.de>
 <PAXPR04MB8459A91EEC932F41E24AE04488042@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459A91EEC932F41E24AE04488042@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-12-17, Peng Fan wrote:
> > Subject: Re: [PATCH V2] soc: imx8m: Add remove function
> > 
> > Hi Peng,
> > 
> > thanks for you patch.
> > 
> > On 24-12-17, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Unregister the cpufreq device and soc device in remove path,
> > otherwise
> > 
> > After reconsidiering the patch approach, I think we shouldn't add a
> > .remove() function and instead should make use of the
> > devm_add_action() mechanism for the proper unregister calls.
> 
> Would you please share why devm_add_action is preferred?
> 
> Something as below?
> +static void imx8m_soc_remove(void *data)
> +{
> +       struct imx8m_soc_priv *priv = data;
> +
> +       if (priv->cpufreq_dev)
> +               platform_device_unregister(priv->cpufreq_dev);
> +
> +       soc_device_unregister(priv->soc_dev);
> +}

I would split it into two action functions due to the following reasons:
 - cleanup during the probe() if something fails afterwards
 - no need for the if(priv->cpufreq_dev) check.

> In Probe:
> +       return devm_add_action(&pdev->dev, imx8m_soc_remove, priv);

The actions should be added directly after the succeful device
registration, e.g.
 - after soc_device_register(soc_dev_attr) and
 - after platform_device_register_simple()

Regards,
   Marco

> 
> Regards,
> Peng.
> 
> > 
> > > there will be warning when do removing test:
> > > sysfs: cannot create duplicate filename '/devices/platform/imx-
> > cpufreq-dt'
> > > CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > > 6.13.0-rc1-next-20241204 Hardware name: NXP i.MX8MPlus EVK
> > board (DT)
> > >
> > > Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform
> > > driver")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Add err check when create the cpufreq platform device
> > 
> > thank you for addressing this.
> > 
> > Regards,
> >   Marco
> > 
> > >  drivers/soc/imx/soc-imx8m.c | 41
> > > +++++++++++++++++++++++++++++++------
> > >  1 file changed, 35 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-
> > imx8m.c
> > > index 8ac7658e3d52..97c8718c2aa1 100644
> > > --- a/drivers/soc/imx/soc-imx8m.c
> > > +++ b/drivers/soc/imx/soc-imx8m.c
> > > @@ -33,6 +33,11 @@ struct imx8_soc_data {
> > >  	int (*soc_revision)(u32 *socrev, u64 *socuid);  };
> > >
> > > +struct imx8m_soc_priv {
> > > +	struct soc_device *soc_dev;
> > > +	struct platform_device *cpufreq_dev; };
> > > +
> > >  #ifdef CONFIG_HAVE_ARM_SMCCC
> > >  static u32 imx8mq_soc_revision_from_atf(void)
> > >  {
> > > @@ -195,10 +200,11 @@ static __maybe_unused const struct
> > of_device_id
> > > imx8_soc_match[] = {  static int imx8m_soc_probe(struct
> > > platform_device *pdev)  {
> > >  	struct soc_device_attribute *soc_dev_attr;
> > > +	struct platform_device *cpufreq_dev;
> > >  	const struct imx8_soc_data *data;
> > >  	struct device *dev = &pdev->dev;
> > >  	const struct of_device_id *id;
> > > -	struct soc_device *soc_dev;
> > > +	struct imx8m_soc_priv *priv;
> > >  	u32 soc_rev = 0;
> > >  	u64 soc_uid = 0;
> > >  	int ret;
> > > @@ -207,6 +213,10 @@ static int imx8m_soc_probe(struct
> > platform_device *pdev)
> > >  	if (!soc_dev_attr)
> > >  		return -ENOMEM;
> > >
> > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > >  	soc_dev_attr->family = "Freescale i.MX";
> > >
> > >  	ret = of_property_read_string(of_root, "model",
> > > &soc_dev_attr->machine); @@ -235,21 +245,40 @@ static int
> > imx8m_soc_probe(struct platform_device *pdev)
> > >  	if (!soc_dev_attr->serial_number)
> > >  		return -ENOMEM;
> > >
> > > -	soc_dev = soc_device_register(soc_dev_attr);
> > > -	if (IS_ERR(soc_dev))
> > > -		return PTR_ERR(soc_dev);
> > > +	priv->soc_dev = soc_device_register(soc_dev_attr);
> > > +	if (IS_ERR(priv->soc_dev))
> > > +		return PTR_ERR(priv->soc_dev);
> > >
> > >  	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
> > >  		soc_dev_attr->revision);
> > >
> > > -	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
> > > -		platform_device_register_simple("imx-cpufreq-dt", -1,
> > NULL, 0);
> > > +	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
> > > +		cpufreq_dev = platform_device_register_simple("imx-
> > cpufreq-dt", -1, NULL, 0);
> > > +		if (!IS_ERR(cpufreq_dev))
> > > +			priv->cpufreq_dev = cpufreq_dev;
> > > +		else
> > > +			dev_err(dev, "Failed to create imx-cpufreq-
> > dev device: %ld",
> > > +				PTR_ERR(cpufreq_dev));
> > > +	}
> > > +
> > > +	platform_set_drvdata(pdev, priv);
> > >
> > >  	return 0;
> > >  }
> > >
> > > +static void imx8m_soc_remove(struct platform_device *pdev) {
> > > +	struct imx8m_soc_priv *priv = platform_get_drvdata(pdev);
> > > +
> > > +	if (priv->cpufreq_dev)
> > > +		platform_device_unregister(priv->cpufreq_dev);
> > > +
> > > +	soc_device_unregister(priv->soc_dev);
> > > +}
> > > +
> > >  static struct platform_driver imx8m_soc_driver = {
> > >  	.probe = imx8m_soc_probe,
> > > +	.remove	= imx8m_soc_remove,
> > >  	.driver = {
> > >  		.name = "imx8m-soc",
> > >  	},
> > > --
> > > 2.37.1
> > >
> > >
> > >
> 

