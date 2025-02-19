Return-Path: <linux-kernel+bounces-521999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E15A3C4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA2C3B552B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D61FDE2B;
	Wed, 19 Feb 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="x9kPpfjt"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B006748F;
	Wed, 19 Feb 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981784; cv=none; b=azJMnGutQ29eYKRH13JUzK44+7ol2b+AriH3K3DEL4NLVQVDVQMnDplQAjkUhFifIFGqYCaA7tD8cZTRoKFBGo8oHioVSZne+g8MScDZlK49R4fI/QVgijki2sS1+OSI0yjcjmABwA6pe6zRM+TW6ba9L6b8bjre/O06XVQzaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981784; c=relaxed/simple;
	bh=CouTLvYHAtiNnlip9G0FD5i1Ag/n1t/QF1IZSAX1CUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT8ReuoIgB7S4bAU/XADOv/mjc33aFlslZ7bsFF4LV52yzQ+Syfxb51iao7mnjWEP3vmiLL+CCXTMR7g+Gr2YWFfbQOsTVCJ0HUXF3BGo8vP6HQfbogpvA96KfuCJZv89Dgeuczi9C3455OJuwDLVErHdB/B9W4cOwKu2CimtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=x9kPpfjt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id B9B981FBB9;
	Wed, 19 Feb 2025 17:16:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739981777;
	bh=S95CwWHL/dwOp5pCYoF4ahbpyruv/6wZ8TXtXTkd3Sc=; h=From:To:Subject;
	b=x9kPpfjtqHJZoRmH/qoGX2oUXBCDuEReb0dAFhh7Jaaxuqayh81oi8NuFuYo8GjpF
	 wv16O8md/5XeETP1LuGDo+Zl8rNN7skzwaA2zTGh44Z+6eVCEXAm2P0hqear7XVNB0
	 sf7u/R8c/6aIRU/DW5T3ILZpdVOL/8xLf+9HMcAf/FyvXyE6hyWDJzUvAEAA1i5364
	 saCrKHtyRvGcMfGjADd9AgPeu7t4+sx7hszahL5+9mJxRCEPbMhizjvyLco+p0iJ3e
	 HF66ubp9TBInBCV2ZcjQrH5vBNvuFm5Xwup3+8MG4G7C5FIKwx5c3eFgPJbF42xnCI
	 8LL10B3n0W//Q==
Date: Wed, 19 Feb 2025 17:16:11 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
	Francesco Dolcini <francesco@dolcini.it>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] hwmon: (amc6821) Add PWM polarity configuration
 with OF
Message-ID: <20250219161611.GB22470@francesco-nb>
References: <20250218165633.106867-1-francesco@dolcini.it>
 <20250218165633.106867-3-francesco@dolcini.it>
 <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>
 <07ec64e7-041d-4f5a-a04c-daa4b0794111@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07ec64e7-041d-4f5a-a04c-daa4b0794111@roeck-us.net>

On Wed, Feb 19, 2025 at 05:46:10AM -0800, Guenter Roeck wrote:
> On 2/19/25 02:08, Quentin Schulz wrote:
> > Hi Francesco,
> > 
> > On 2/18/25 5:56 PM, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > Add support to configure the PWM-Out pin polarity based on a device
> > > tree property.
> > > 
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >   drivers/hwmon/amc6821.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> > > index 1e3c6acd8974..1ea2d97eebca 100644
> > > --- a/drivers/hwmon/amc6821.c
> > > +++ b/drivers/hwmon/amc6821.c
> > > @@ -845,7 +845,7 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
> > >       return 0;
> > >   }
> > > -static int amc6821_init_client(struct amc6821_data *data)
> > > +static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
> > >   {
> > >       struct regmap *regmap = data->regmap;
> > >       int err;
> > > @@ -864,6 +864,9 @@ static int amc6821_init_client(struct amc6821_data *data)
> > >           if (err)
> > >               return err;
> > > +        if (of_property_read_bool(client->dev.of_node, "ti,pwm-inverted"))
> > 
> > I know that the AMC6821 is doing a lot of smart things, but this really tickled me. PWM controllers actually do support that already via PWM_POLARITY_INVERTED flag for example. See Documentation/devicetree/bindings/hwmon/adt7475.yaml which seems to be another HWMON driver which acts as a PWM controller. I'm not sure this is relevant, applicable or desired but I wanted to highlight this.
> > 
> > > +            pwminv = 1;
> > > +
> > 
> > This is silently overriding the module parameter.
> > 
> > I don't think this is a good idea, at the very least not silently.
> > 
> > I would suggest to add some logic in the probe function to set this value and check its consistency.
> > 
> > Something like:
> > 
> > """
> > diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> > index 1e3c6acd89740..3a13a914e2bbb 100644
> > --- a/drivers/hwmon/amc6821.c
> > +++ b/drivers/hwmon/amc6821.c
> > @@ -37,7 +37,7 @@ static const unsigned short normal_i2c[] = {0x18, 0x19, 0x1a, 0x2c, 0x2d, 0x2e,
> >    * Insmod parameters
> >    */
> > 
> > -static int pwminv;    /*Inverted PWM output. */
> > +static int pwminv = -1;    /* -1 not modified by the user, 0 default PWM output, 1 inverted PWM output */
> >   module_param(pwminv, int, 0444);
> > 
> >   static int init = 1; /*Power-on initialization.*/
> > @@ -904,6 +904,7 @@ static int amc6821_probe(struct i2c_client *client)
> >       struct amc6821_data *data;
> >       struct device *hwmon_dev;
> >       struct regmap *regmap;
> > +    bool pwminv_dt;
> >       int err;
> > 
> >       data = devm_kzalloc(dev, sizeof(struct amc6821_data), GFP_KERNEL);
> > @@ -916,6 +917,18 @@ static int amc6821_probe(struct i2c_client *client)
> >                        "Failed to initialize regmap\n");
> >       data->regmap = regmap;
> > 
> > +    pwminv_dt = of_property_read_bool(client->dev.of_node, "ti,pwm-inverted");
> > +
> > +    if (pwminv == -1) {
> > +        pwminv = pwminv_dt;
> 
> A devicetree property, associated with a single instance of the driver,
> overriding a module parameter affecting all instances ? This is a no-go.

I will rework the patch in such a way that the module parameter, when
specified, takes always the precedence over the DT code, works for you
Guenter ?

Francesco


