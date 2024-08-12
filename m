Return-Path: <linux-kernel+bounces-283636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D145394F72E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D391F22B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874C118E772;
	Mon, 12 Aug 2024 19:05:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706641547D6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489547; cv=none; b=AUgQHNEUHUr6SRwD23DjlToX1PHQvloY1dhr+jCQHc8FyiD0AhmtlKve9T/xF9WkjkaT8QKgCwhHcRho2paAgrk4yAPux25KIr6LVPrVb7wOPP0qxnFe0e3yR/t5yiJLRn4OwBBcdRse1TsOvCtzx64/p2JJOzBdmuT4jfT/f6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489547; c=relaxed/simple;
	bh=w5wyz+mUQ8KlGeJurnPQn6RxVeuBzDOI5+4ZYJcnAtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCxpztMDdc/xSrPbzGOwlAsi9jXKZvnUE1Vm3uXjyFEJtJLjwU7p0h5K0lhEpsrWzV5cD78V/ZPQ0oedhjUpAAmlBPzibcOlXeo35E1Dd1cc6ZroM0LA2h4Pno/ZFlLaeYpoi1XwK8SZrHgzr7lTRDHP1E/GJkHxdQsYfz1g+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: i72Q+fE9TwyAEXYdyLjwkw==
X-CSE-MsgGUID: cIFWA+M7TCSTboDu/NMj/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33021463"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="33021463"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:05:44 -0700
X-CSE-ConnectionGUID: rPjibFSKSBGLYJAEtQ+/rg==
X-CSE-MsgGUID: XLLeuGVDTNOX1d9rRKwj7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="89191944"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 12 Aug 2024 12:05:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BA7C41F8; Mon, 12 Aug 2024 22:05:40 +0300 (EEST)
Date: Mon, 12 Aug 2024 22:05:40 +0300
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] regmap: Allow setting IRQ domain name suffix
Message-ID: <ZrpdBL7GZKmXZ60g@black.fi.intel.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <776bc4996969e5081bcf61b9bdb5517e537147a3.1723120028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776bc4996969e5081bcf61b9bdb5517e537147a3.1723120028.git.mazziesaccount@gmail.com>

On Thu, Aug 08, 2024 at 03:36:28PM +0300, Matti Vaittinen wrote:
> When multiple IRQ domains are created from the same device-tree node they
> will get the same name based on the device-tree path. This will cause a
> naming collision in debugFS when IRQ domain specific entries are created.
> 
> The regmap-IRQ creates per instance IRQ domains. This will lead to a
> domain name conflict when a device which provides more than one
> interrupt line uses the regmap-IRQ.
> 
> Add support for specifying an IRQ domain name suffix when creating a
> regmap-IRQ controller.

...

> +static int regmap_irq_create_domain(struct fwnode_handle *fwnode, int irq_base,
> +				    const struct regmap_irq_chip *chip,
> +				    struct regmap_irq_chip_data *d)
> +{
> +	struct irq_domain_info info = {
> +		.fwnode = fwnode,
> +		.size = chip->num_irqs,
> +		.hwirq_max = chip->num_irqs,
> +		.virq_base = irq_base,
> +		.ops = &regmap_domain_ops,
> +		.host_data = d,
> +		.name_suffix = chip->domain_suffix,
> +	};
> +
> +	d->domain = irq_domain_instantiate(&info);
> +	if (IS_ERR(d->domain)) {
> +		dev_err(d->map->dev, "Failed to create IRQ domain\n");
> +		return PTR_ERR(d->domain);
> +	}
> +
> +	return 0;
> +}
> +
> +

One blank line is enough?

>  /**

-- 
With Best Regards,
Andy Shevchenko



