Return-Path: <linux-kernel+bounces-320270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E5970836
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC0281D82
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47108171652;
	Sun,  8 Sep 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XX5MdYW7"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D8EACD
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806687; cv=none; b=YQXpwDSleT6kWmtfenGCeEYjo72yJvtGDR4cw5KMwGbJi9G5goDUz4+s1ZjMRRar6Xfg3jWH1NWhHLKKIUE6UPMSSkC53EtPJmMTqkZgub+rOHhWpXjFncIFykaIUTK2E7wXAEMdxllPHQGzwcnsmjvovSXzgE+77R21rVxOsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806687; c=relaxed/simple;
	bh=I0qjUUfnPXmQ1uXaZFi0U19PUntebPrsSua+lCWaTx8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=fBzTumJlcmjATXvj/rvAD2Us8NI5xA/AvDk3WvxcHvLQuJLSSyojAu7ikPkwsNd8SvZS170JFssTqh3RfdFOnm0zMHOP8G5AMGcPe9SSsTdJMXhxSOjE/Sa9B3kkAc64D6frGuRDfh+8uv2cqEEwRSagEi5v7b31cWNS7pR18tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XX5MdYW7; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nJ9TsuXviS3tRnJ9Vs50vb; Sun, 08 Sep 2024 16:44:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725806676;
	bh=cR3VYMMURPSiFaFZKJGG3Rc11X1L8jXkvDrs4A4koFc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=XX5MdYW7WdDxfdC3dFTrteO3FizHnAtoGRFEC8UtBkPuwoYh823fAktnsbXLtkawH
	 rRRssBhWkNn9oQ+GCD9ctUpDAaVcTLtRA4KsbrtYqPVmEiyXqX2KOZPq5OG4wQMdPn
	 Nl97sO5SPcaIqgZ8kpwSnsRosE/x70oCLSHwtBG25KaxZUpQeEDnb/8/l7d6zLR/DW
	 8wVfslDmw4qu/IsNLPOSqTG9nL354GGtMgzScsEH/qobdmxZRfcSckTVxEsw1NHLSU
	 vRPkdkaY/Cd6N+bcJUc5fJljycP+U++UCgKiC47Is5Unv6PnAeioB3yHqhFgbF/q+d
	 ZdGFiAeJvhlHg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Sep 2024 16:44:36 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8debbb55-449d-4f8d-a6dd-3ba15836aacf@wanadoo.fr>
Date: Sun, 8 Sep 2024 16:44:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
X-Mozilla-News-Host: news://news.gmane.io
Content-Language: en-US, fr-FR
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/08/2024 à 22:28, Stuart Hayes a écrit :
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---

...

> +/**
> + * shutdown_one_device_async
> + * @data: the pointer to the struct device to be shutdown
> + * @cookie: not used
> + *
> + * Shuts down one device, after waiting for shutdown_after to complete.
> + * shutdown_after should be set to the cookie of the last child or consumer
> + * of this device to be shutdown (if any), or to the cookie of the previous
> + * device to be shut down for devices that don't enable asynchronous shutdown.
> + */
> +static void shutdown_one_device_async(void *data, async_cookie_t cookie)
> +{
> +	struct device *dev = data;
> +
> +	async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
> +
> +	shutdown_one_device(dev);
> +}
> +
>   /**
>    * device_shutdown - call ->shutdown() on each device to shutdown.
>    */
>   void device_shutdown(void)
>   {
>   	struct device *dev, *parent;
> +	async_cookie_t cookie = 0;
> +	struct device_link *link;
> +	int idx;
>   
>   	wait_for_device_probe();
>   	device_block_probing();
> @@ -4852,11 +4878,37 @@ void device_shutdown(void)
>   		list_del_init(&dev->kobj.entry);
>   		spin_unlock(&devices_kset->list_lock);
>   
> -		shutdown_one_device(dev);
> +
> +		/*
> +		 * Set cookie for devices that will be shut down synchronously
> +		 */
> +		if (!dev->driver || !dev->driver->async_shutdown_enable)
> +			dev->p->shutdown_after = cookie;
> +
> +		get_device(dev);
> +		get_device(parent);
> +
> +		cookie = async_schedule_domain(shutdown_one_device_async,
> +					       dev, &sd_domain);
> +		/*
> +		 * Ensure parent & suppliers wait for this device to shut down
> +		 */
> +		if (parent) {
> +			parent->p->shutdown_after = cookie;
> +			put_device(parent);

Would it make sense to have this put_device() out of the if block?

IIUC, the behavior would be exactly the same, but it is more intuitive 
to have a put_device(parent) called for each get_device(parent) call.

Another way to keep symmetry is to have:
	if (parent)
		get_device(parent);
above.

> +		}
> +
> +		idx = device_links_read_lock();
> +		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +				device_links_read_lock_held())
> +			link->supplier->p->shutdown_after = cookie;
> +		device_links_read_unlock(idx);
> +		put_device(dev);
>   
>   		spin_lock(&devices_kset->list_lock);
>   	}
>   	spin_unlock(&devices_kset->list_lock);
> +	async_synchronize_full_domain(&sd_domain);
>   }
>   
>   /*
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 1fc8b68786de..2b6127faaa25 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -56,6 +56,7 @@ enum probe_type {
>    * @mod_name:	Used for built-in modules.
>    * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>    * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
> + * @async_shutdown_enable: Enables devices to be shutdown asynchronously.
>    * @of_match_table: The open firmware table.
>    * @acpi_match_table: The ACPI match table.
>    * @probe:	Called to query the existence of a specific device,
> @@ -102,6 +103,7 @@ struct device_driver {
>   
>   	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
>   	enum probe_type probe_type;
> +	bool async_shutdown_enable;

Maybe keep these 2 bools together to potentially avoid hole?

Just my 2c.

CJ

>   
>   	const struct of_device_id	*of_match_table;
>   	const struct acpi_device_id	*acpi_match_table;


