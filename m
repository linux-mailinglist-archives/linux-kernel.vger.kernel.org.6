Return-Path: <linux-kernel+bounces-298621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3B695C987
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F4D1F2533C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2C915382E;
	Fri, 23 Aug 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HaG1yV53"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1916145B00;
	Fri, 23 Aug 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406337; cv=none; b=A557G87fWUK1eQL4nZC2ffeRAAr9NPzVirHOVpwXsfBkMrc8ZwW0TxgrX0lkK/rlqW8P9vMfX3Ed+4q0XLK+xGiZj7G3Wbf6esPffpa1k+Ee2LonakBJctAS/SyIguIgRYo5DmT6TYf4w0zZ+BC6Ovi4mYCbamsiuOdV6U8ZKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406337; c=relaxed/simple;
	bh=TVFqLU4BQR7t4QSeOgHPuduMP9qPGrYZMv98oK3Bm/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX64v61R7tmfuo6/5W47xmCABqUF28a4p48BbeYcGTj4nkLDB7/Vjr80UORLyJZtJFU356Tmh02ma5mIuVD6srzDHmOnnhCcmS6yi1MNcVBZhqS6ylPQFWbEG3P78ECNyLf7bxAVnm7QJRANbwCYnj1+IOO5zyJa4uf8AKglXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HaG1yV53; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id hQrDsSkyGQaX2hQrEstUJe; Fri, 23 Aug 2024 11:45:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724406326;
	bh=aPj9/nQrWVCBqBacsw++RJ6mloODfSakma0eIz4MPgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HaG1yV53Ybd4FyM0Yk/jr11Vh6UIKD2pHYqCFBD+yxeslD8ubacunO4bmE3Ekyq2B
	 RcCKUS46uDs0ae2bAMDs/99IMFYjIhGNGJaA+VCHuExmfAUrR3YNlZiXUR9lQTswtL
	 uXCAw6IEmnC8YYOK+Y3VpHz4M2+4RZxnZX0TMURmFRnMeTV1E9TDUNXQnjesnyX+wo
	 2ywXkMn7NgMEcf1NJUW8UrY6itc5PADed899EpKZkvEhEf7kWJpwaN2hBMv2HdM3kv
	 2FcN7ZQxAClhHYXzYJJBopcUSJCk9Fz0A/yXarOcNCWizEmNZwqBF4YCxKUskEc4Q0
	 4oyl4fRyvUM0A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 23 Aug 2024 11:45:26 +0200
X-ME-IP: 90.11.132.44
Message-ID: <645bd24f-b86e-4cc1-b65f-7b48d81e633e@wanadoo.fr>
Date: Fri, 23 Aug 2024 11:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] net/9p/usbg: Add new usb gadget function transport
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: andrzej.p@collabora.com, asmadeus@codewreck.org, corbet@lwn.net,
 ericvh@kernel.org, gregkh@linuxfoundation.org, kernel@pengutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 v9fs@lists.linux.dev
References: <20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutronix.de>
 <20240116-ml-topic-u9p-v9-2-93d73f47b76b@pengutronix.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240116-ml-topic-u9p-v9-2-93d73f47b76b@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/08/2024 à 09:36, Michael Grzeschik a écrit :
> Add the new gadget function for 9pfs transport. This function is
> defining an simple 9pfs transport interface that consists of one in and
> one out endpoint. The endpoints transmit and receive the 9pfs protocol
> payload when mounting a 9p filesystem over usb.
> 
> Tested-by: Andrzej Pietrasiewicz <andrzej.p-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ---

Hi,

a few nitpicks below and 1 or 2 real questions.

> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/usb/composite.h>
> +#include <linux/usb/func_utils.h>
> +#include <linux/completion.h>

Keep it in alphabetic order?

> +
> +#include <net/9p/9p.h>
> +#include <net/9p/client.h>
> +#include <net/9p/transport.h>
> +

...

> +static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_usb9pfs *usb9pfs = ep->driver_data;
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	struct p9_req_t *p9_tx_req = req->context;
> +	unsigned long flags;
> +
> +	/* reset zero packages */
> +	req->zero = 0;
> +
> +	if (req->status) {
> +		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +			ep->name, req->status, req->actual, req->length);
> +		return;
> +	}
> +
> +	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +		ep->name, req->status, req->actual, req->length);
> +
> +	spin_lock_irqsave(&usb9pfs->lock, flags);
> +	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
> +
> +	p9_req_put(usb9pfs->client, p9_tx_req);
> +
> +	spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +
> +	complete(&usb9pfs->send);
> +
> +	return;

Is it needed?

> +}

...

> +static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_usb9pfs *usb9pfs = ep->driver_data;
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	struct p9_req_t *p9_rx_req;
> +
> +	if (req->status) {
> +		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +			ep->name, req->status, req->actual, req->length);
> +		return;
> +	}
> +
> +	p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
> +	if (!p9_rx_req) {
> +		return;
> +	}

The { } could be removd.

> +
> +	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
> +
> +	p9_rx_req->rc.size = req->actual;
> +
> +	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
> +	p9_req_put(usb9pfs->client, p9_rx_req);
> +
> +	complete(&usb9pfs->received);
> +
> +	return;

Is it needed?

> +}

...

> +static int alloc_requests(struct usb_composite_dev *cdev,
> +			  struct f_usb9pfs *usb9pfs)
> +{
> +	int ret = 0;
> +
> +	usb9pfs->in_req = usb_ep_alloc_request(usb9pfs->in_ep, GFP_ATOMIC);
> +	if (!usb9pfs->in_req) {
> +		ret = -ENOENT;
> +		goto fail;
> +	}
> +
> +	usb9pfs->out_req = alloc_ep_req(usb9pfs->out_ep, usb9pfs->buflen);
> +	if (!usb9pfs->out_req) {
> +		ret = -ENOENT;
> +		goto fail_in;
> +	}
> +
> +	usb9pfs->in_req->complete = usb9pfs_tx_complete;
> +	usb9pfs->out_req->complete = usb9pfs_rx_complete;
> +
> +	/* length will be set in complete routine */
> +	usb9pfs->in_req->context = usb9pfs;
> +	usb9pfs->out_req->context = usb9pfs;
> +
> +	return ret;

return 0; to be more explicit?
(and would avoid the = 0 when declared)

> +
> +fail_in:
> +	usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
> +fail:
> +	return ret;
> +}
> +
> +static int enable_endpoint(struct usb_composite_dev *cdev,
> +			   struct f_usb9pfs *usb9pfs, struct usb_ep *ep)
> +{
> +	int ret;
> +
> +	ret = config_ep_by_speed(cdev->gadget, &usb9pfs->function, ep);
> +	if (ret)
> +		return ret;
> +
> +	ret = usb_ep_enable(ep);
> +	if (ret < 0)
> +		return ret;
> +
> +	ep->driver_data = usb9pfs;
> +
> +	return ret;

return 0; to be more explicit?

> +}

...

> +static int p9_usbg_create(struct p9_client *client, const char *devname, char *args)
> +{
> +	struct f_usb9pfs_dev *dev;
> +	struct f_usb9pfs_dev *tmp;
> +	struct f_usb9pfs *usb9pfs;
> +	struct usb_function *f;
> +	int ret = -ENOENT;
> +	int found = 0;
> +
> +	if (!devname)
> +		return -EINVAL;
> +
> +	mutex_lock(&usb9pfs_lock);

Using cleanup.h would simplify locking in early exit paths.

> +	list_for_each_entry_safe(dev, tmp, &usbg_instance_list, usb9pfs_instance) {

Why the _safe version is used here?
The list is not modify here directly.

> +		if (!strncmp(devname, dev->tag, strlen(devname))) {
> +			if (!dev->inuse) {
> +				dev->inuse = true;
> +				found = 1;
> +				break;
> +			}
> +			ret = -EBUSY;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		mutex_unlock(&usb9pfs_lock);
> +		pr_err("no channels available for device %s\n", devname);
> +		return ret;
> +	}
> +
> +	usb9pfs = dev->usb9pfs;
> +	if (!usb9pfs) {
> +		mutex_unlock(&usb9pfs_lock);
> +		return -EINVAL;
> +	}
> +
> +	f = &usb9pfs->function;
> +
> +	client->trans = (void *)usb9pfs;
> +	if (!usb9pfs->in_req)
> +		client->status = Disconnected;
> +	else
> +		client->status = Connected;
> +	usb9pfs->client = client;
> +
> +	client->trans_mod->maxsize = usb9pfs->buflen;
> +
> +	complete(&usb9pfs->received);
> +	mutex_unlock(&usb9pfs_lock);
> +
> +	return 0;
> +}

...

> +static ssize_t f_usb9pfs_opts_buflen_show(struct config_item *item, char *page)
> +{
> +	struct f_usb9pfs_opts *opts = to_f_usb9pfs_opts(item);
> +	int ret;
> +
> +	mutex_lock(&opts->lock);
> +	ret = sprintf(page, "%d\n", opts->buflen);

sysfs_emit()?

> +	mutex_unlock(&opts->lock);
> +
> +	return ret;
> +}

...

> +static struct f_usb9pfs_dev *_usb9pfs_do_find_dev(const char *tag)
> +{
> +	struct f_usb9pfs_dev *usb9pfs_dev;
> +	struct f_usb9pfs_dev *tmp;
> +
> +	if (!tag)
> +		return NULL;
> +
> +	list_for_each_entry_safe(usb9pfs_dev, tmp, &usbg_instance_list, usb9pfs_instance) {

Why the _safe version is used here?
The list is not modify here directly.

> +		if (strcmp(usb9pfs_dev->tag, tag) == 0)
> +			return usb9pfs_dev;
> +	}
> +
> +	return NULL;
> +}

...

> +static void usb9pfs_free_instance(struct usb_function_instance *fi)
> +{
> +	struct f_usb9pfs_opts *usb9pfs_opts =
> +		container_of(fi, struct f_usb9pfs_opts, func_inst);
> +	struct f_usb9pfs_dev *dev = usb9pfs_opts->dev;
> +
> +	list_del(&dev->usb9pfs_instance);

When it is added in the usbg_instance_list list below, it is protected 
by the usb9pfs_lock mutex. Should it be also protected when it is removed?

> +	kfree(usb9pfs_opts);
> +}
> +
> +static struct usb_function_instance *usb9pfs_alloc_instance(void)
> +{
> +	struct f_usb9pfs_opts *usb9pfs_opts;
> +	struct f_usb9pfs_dev *dev;
> +
> +	usb9pfs_opts = kzalloc(sizeof(*usb9pfs_opts), GFP_KERNEL);
> +	if (!usb9pfs_opts)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&usb9pfs_opts->lock);
> +
> +	usb9pfs_opts->func_inst.set_inst_name = usb9pfs_set_inst_tag;
> +	usb9pfs_opts->func_inst.free_func_inst = usb9pfs_free_instance;
> +
> +	usb9pfs_opts->buflen = DEFAULT_BUFLEN;
> +
> +	mutex_lock(&usb9pfs_lock);
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);

If kzalloc() was called outside of the mutex, it would be slightly 
simpler, IMHO.

> +	if (IS_ERR(dev)) {
> +		mutex_unlock(&usb9pfs_lock);
> +		kfree(usb9pfs_opts);
> +		return ERR_CAST(dev);
> +	}
> +	list_add_tail(&dev->usb9pfs_instance, &usbg_instance_list);
> +	mutex_unlock(&usb9pfs_lock);
> +
> +	usb9pfs_opts->dev = dev;
> +	dev->opts = usb9pfs_opts;

'dev' is added to the usbg_instance_list list within a mutex section, so 
it looks possible that this list is also accessed from somewhere else.

Would it make sense to initialize dev->opts also within the mutex 
section, to avoid concurrent access to this new item, when dev->opts is 
still NULL?

> +
> +	config_group_init_type_name(&usb9pfs_opts->func_inst.group, "",
> +				    &usb9pfs_func_type);
> +
> +	return &usb9pfs_opts->func_inst;
> +}

...

CJ


