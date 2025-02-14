Return-Path: <linux-kernel+bounces-514612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B016BA3594C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62366188E99E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CE221D9A;
	Fri, 14 Feb 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1VNyCwi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33309275401;
	Fri, 14 Feb 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522888; cv=none; b=oi9mRoBkEYVrA52hAV4DyQPywnotQYykAsz9Sttvr6L1wsnp788u6bYHO3v+5d82de5OAr/QyVw64aOEoBrCgX3uaJplh+ewgL9QoIsSCxIkJ5zX+UMH4acoudMuGi9n98cD7J1F10p/BS1ccagZ1d6f/HI6zG5RFx2YTLRzqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522888; c=relaxed/simple;
	bh=G2g+YE94HijZmiKvrLiQZ/MFM5yojKDRXo2gEydfZGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvIKRwxjpt9ekwuA3GhCGVrhsLlge1uED9Z4bqPpqhcelLUiu40D5l4tZOlW8QeKhydRpRvv0byaOfbuRGtz1CRx6AuCs4NWZfGjmLpBQ2MQP0JRZnoOXnZ7y0qfKXGgCqUv944BP+m1emPCFq+Aa4WN91djf15CWl2lCEB8HY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1VNyCwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F0FC4CED1;
	Fri, 14 Feb 2025 08:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739522887;
	bh=G2g+YE94HijZmiKvrLiQZ/MFM5yojKDRXo2gEydfZGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1VNyCwiviaCgE+fu8UovoX6ra2HOhZt4n+5DCe67vOG344OeSHfO2fRIxS61iKuj
	 vBk4kYQanZHi6f6uwhQd20ZiDhe1H4wAkbGOy8Mun+GMdLY4kqa4YkfSc6T6/rgLF0
	 GDuQFffLnIL+TWaGVhJpuZMAIZHOoXrE5Ut3oicG5NqirjzJgChXvFtvkrApfWKhAp
	 01deLpc1rkV+d5rYxxhBFub5jV4R9L30pG1iYxc+P+CLmAHXRoWRFezwBX/GRrDpuh
	 +6UMIrXecJDSI9DIGkYpu/0tXtICXld/GYkFSPO4c4H4/2kmd0eAQe6IVDYR+rUpID
	 zs3CVoi7NLrww==
Date: Fri, 14 Feb 2025 09:48:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, salee@marvell.com, gakula@marvell.com
Subject: Re: [PATCH 1/4] [PATCH 1/4] reset: simple: Add syscon device
 compatible
Message-ID: <20250214-arcane-raspberry-hornet-f22d93@krzk-bin>
References: <20250214065833.530276-1-dingwei@marvell.com>
 <20250214065833.530276-3-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214065833.530276-3-dingwei@marvell.com>

On Thu, Feb 13, 2025 at 10:58:30PM -0800, Wilson Ding wrote:
>  #define SOCFPGA_NR_BANKS	8
> @@ -171,26 +221,51 @@ static int reset_simple_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> -	if (IS_ERR(membase))
> -		return PTR_ERR(membase);
> +	if (devdata && devdata->syscon_dev) {
> +		data->regmap = syscon_node_to_regmap(pdev->dev.parent->of_node);
> +		if (IS_ERR(data->regmap))
> +			return PTR_ERR(data->regmap);
>  
> -	spin_lock_init(&data->lock);
> -	data->membase = membase;
> -	data->rcdev.owner = THIS_MODULE;
> -	data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
> -	data->rcdev.ops = &reset_simple_ops;
> -	data->rcdev.of_node = dev->of_node;
> +		if (device_property_read_u32(&pdev->dev, "offset",

Where is this binding documented? This is patch #1, so something anywy
is wrong here (see submitting patches for bindings).

> +					     &data->reg_offset))
> +			data->reg_offset = devdata->reg_offset;
>  
> -	if (devdata) {
> -		reg_offset = devdata->reg_offset;
> -		if (devdata->nr_resets)
> -			data->rcdev.nr_resets = devdata->nr_resets;
> +		if (devdata->nr_resets == 0) {
> +			dev_err(dev, "no reset line\n");
> +			return -EINVAL;
> +		}

Best regards,
Krzysztof


