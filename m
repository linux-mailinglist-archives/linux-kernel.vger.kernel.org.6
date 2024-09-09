Return-Path: <linux-kernel+bounces-321351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A628797193A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CF51F2327E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F91B78F4;
	Mon,  9 Sep 2024 12:22:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CE1B5ECA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884553; cv=none; b=JbBlmSBtezeYM18x3uaQH64nILQ5cH4ZQIyZVdh2IBcboa6gRFayYGvCUBCfq+VkAy4zmHf1eJJDNltv/MHw+w0IM7tYMCGdWsvf3n9wSKWUXAx00YSHviUs/VirxarMowurwQ1wWXPni564zZsFHAHeh6akmmcMxlNKGQ0DCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884553; c=relaxed/simple;
	bh=k7yzdOfKgbn1F/8l72scMXobDc0dkkKkni5G3PGZz6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgPuKr+PT4UlYgkEbqNylR82Nu3EJ7VoKiq+IsByvAzG6DbNUJlcSBGYVakXYc5EdDezsAvRroFNjOMLiQRGlpy3KV11p26BgLpMmMp7ZaV/CowkLiGcYpWW/pRXocvJoD18hOzQE+8KnOd1JVvuqXbZwNhpdCCpjixMord+GkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sndPN-00087i-NN; Mon, 09 Sep 2024 14:22:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sndPM-006eRu-O0; Mon, 09 Sep 2024 14:22:16 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sndPM-00Fhw6-22;
	Mon, 09 Sep 2024 14:22:16 +0200
Date: Mon, 9 Sep 2024 14:22:16 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 5/5] firmware: imx: adds miscdev
Message-ID: <Zt7oeCcag5LKKV3N@pengutronix.de>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-5-5afd2ab74264@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-imx-se-if-v7-5-5afd2ab74264@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2024 at 04:21:21PM +0530, Pankaj Gupta wrote:
> Adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like
> EdgeLock Enclave from:
> - User-Space Applications via character driver.
> 
> ABI documentation for the NXP secure-enclave driver.
> 
> User-space library using this driver:
> - i.MX Secure Enclave library:
>   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
> - i.MX Secure Middle-Ware:
>   -- URL: https://github.com/nxp-imx/imx-smw.git
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  Documentation/ABI/testing/se-cdev   |  43 ++
>  drivers/firmware/imx/ele_base_msg.c |   8 +-
>  drivers/firmware/imx/ele_common.c   |  36 +-
>  drivers/firmware/imx/ele_common.h   |   6 +-
>  drivers/firmware/imx/se_ctrl.c      | 790 ++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h      |  52 +++
>  include/uapi/linux/se_ioctl.h       |  94 +++++
>  7 files changed, 1010 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
> index e3e570a25e85..ae200ce64100 100644
> --- a/drivers/firmware/imx/ele_base_msg.c
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -68,7 +68,7 @@ int ele_get_info(struct device *dev, struct ele_dev_info *s_info)
>  	tx_msg->data[0] = upper_32_bits(get_info_addr);
>  	tx_msg->data[1] = lower_32_bits(get_info_addr);
>  	tx_msg->data[2] = sizeof(*s_info);
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_GET_INFO_REQ_MSG_SZ,
>  			       rx_msg,
> @@ -150,7 +150,7 @@ int ele_ping(struct device *dev)
>  		goto exit;
>  	}
>  
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_PING_REQ_SZ,
>  			       rx_msg,
> @@ -206,7 +206,7 @@ int ele_service_swap(struct device *dev,
>  	tx_msg->data[3] = lower_32_bits(addr);
>  	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
>  						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
>  			       rx_msg,
> @@ -268,7 +268,7 @@ int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
>  	tx_msg->data[0] = lower_32_bits(addr);
>  	tx_msg->data[2] = addr;
>  
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_FW_AUTH_REQ_SZ,
>  			       rx_msg,
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> index a06d7015d3f1..9114c3594567 100644
> --- a/drivers/firmware/imx/ele_common.c
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -18,16 +18,18 @@ u32 se_add_msg_crc(u32 *msg, u32 msg_len)
>  	return crc;
>  }
>  
> -int ele_msg_rcv(struct se_if_priv *priv,
> +int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
>  		struct se_clbk_handle *se_clbk_hdl)
>  {
> +	struct se_if_priv *priv = dev_ctx->priv;
>  	int err = 0;
>  
>  	err = wait_event_interruptible(se_clbk_hdl->wq,
>  				       atomic_read(&se_clbk_hdl->pending_hdr) != 0);
>  	if (err < 0)
>  		dev_err(priv->dev,
> -			"Err[0x%x]:Interrupted by signal.\n",
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			se_clbk_hdl->dev_ctx->devname,
>  			err);
>  	else
>  		err = se_clbk_hdl->rx_msg_sz;
> @@ -37,10 +39,11 @@ int ele_msg_rcv(struct se_if_priv *priv,
>  	return err;
>  }
>  
> -int ele_msg_send(struct se_if_priv *priv,
> +int ele_msg_send(struct se_if_device_ctx *dev_ctx,
>  		 void *tx_msg,
>  		 int tx_msg_sz)
>  {
> +	struct se_if_priv *priv = dev_ctx->priv;
>  	struct se_msg_hdr *header;
>  	int err;
>  
> @@ -53,7 +56,8 @@ int ele_msg_send(struct se_if_priv *priv,
>  	if (header->size << 2 != tx_msg_sz) {
>  		err = -EINVAL;
>  		dev_err(priv->dev,
> -			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
> +			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
> +			dev_ctx->devname,
>  			*(u32 *)header,
>  			header->size << 2, tx_msg_sz);
>  		goto exit;
> @@ -62,7 +66,9 @@ int ele_msg_send(struct se_if_priv *priv,
>  
>  	err = mbox_send_message(priv->tx_chan, tx_msg);
>  	if (err < 0) {
> -		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		dev_err(priv->dev,
> +			"%s: Error: mbox_send_message failure.",
> +			dev_ctx->devname);
>  		return err;
>  	}
>  	err = tx_msg_sz;
> @@ -72,24 +78,26 @@ int ele_msg_send(struct se_if_priv *priv,
>  }
>  
>  /* API used for send/receive blocking call. */
> -int ele_msg_send_rcv(struct se_if_priv *priv,
> +int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,

You are heavily patching a file you introduced just in the last patch.
It seems you have messed up while rebasing. Please cleanup.

> +static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int err = 0;
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != SE_IF_CTX_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}

You don't need this. Just trust Linux that it won't call your
ioctl/read/write ops when the device is not opened.

> +
> +	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 *)arg,
> +			   sizeof(cmd_snd_rcv_rsp_info))) {
> +		dev_err(dev_ctx->priv->dev,

You have priv as a variable already, please use it throughout this
function.

> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +			       size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err;
> +
> +	dev_dbg(priv->dev,
> +		"%s: read to buf %p(%zu), ppos=%lld\n",
> +			dev_ctx->miscdev.name,
> +			buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != SE_IF_CTX_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
> +	if (err < 0) {
> +		dev_err(dev_ctx->priv->dev,
> +				"%s: Err[0x%x]:Interrupted by signal.\n",
> +				dev_ctx->devname, err);
> +		dev_err(dev_ctx->priv->dev,
> +				"Current active dev-ctx count = %d.\n",
> +				dev_ctx->priv->active_devctx_count);

active_devctx_count is never used except for printing this message. I
don't think it provides meaningful information for userspace. Just dorp
it.

> +	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
> +			  se_shared_mem_mgmt->non_secure_mem.ptr,
> +			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
> +
> +	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
> +	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
> +	se_shared_mem_mgmt->non_secure_mem.size = 0;
> +	se_shared_mem_mgmt->non_secure_mem.pos = 0;
> +}
> +
> +/* Need to copy the output data to user-device context.
> + */
> +int se_dev_ctx_cpy_out_data(struct se_shared_mem_mgmt_info *se_shared_mem_mgmt)

Only used in this file. Make it static.

> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(se_shared_mem_mgmt,
> +							typeof(*dev_ctx),
> +							se_shared_mem_mgmt);

This function is only ever called like:

se_dev_ctx_cpy_out_data(&dev_ctx->se_shared_mem_mgmt);

Instead of this back and forth you could pass a struct se_if_device_ctx *
directly.

> +static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
> +			       struct se_ioctl_setup_iobuf *io,
> +			       struct se_shared_mem_mgmt_info *se_shared_mem_mgmt)
> +{
> +	struct se_buf_desc *b_desc = NULL;
> +
> +	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +	if (!b_desc)
> +		return -ENOMEM;
> +
> +	if (b_desc) {

b_desc is not NULL here.

> +		b_desc->shared_buf_ptr = shared_ptr_with_pos;
> +		b_desc->usr_buf_ptr = io->user_buf;
> +		b_desc->size = io->length;
> +
> +		if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +			/*
> +			 * buffer is input:
> +			 * add an entry in the "pending input buffers" list so
> +			 * that copied data can be cleaned from shared memory
> +			 * later.
> +			 */
> +			list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);
> +		} else {
> +			/*
> +			 * buffer is output:
> +			 * add an entry in the "pending out buffers" list so data
> +			 * can be copied to user space when receiving Secure-Enclave
> +			 * response.
> +			 */
> +			list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
> +		}
> +	}
> +
> +
> +	return 0;
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err = 0;
> +
> +	priv->dev_ctx_mono_count++;
> +	err = init_device_context(priv,
> +				  priv->dev_ctx_mono_count ?
> +					priv->dev_ctx_mono_count
> +					: priv->dev_ctx_mono_count++,

priv->dev_ctx_mono_count won't be 0 here as you just increased it.

> +				  &dev_ctx);
> +	if (err) {
> +		dev_err(priv->dev,
> +			"Failed[0x%x] to create device contexts.\n",
> +			err);
> +		goto exit;
> +	}
> +
> +	dev_ctx->status = SE_IF_CTX_OPENED;
> +
> +	fp->private_data = dev_ctx;
> +
> +exit:
> +	up(&dev_ctx->fops_lock);

You never acquired this semaphore which is likely not what you want.

> +	return err;
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +
> +	/* Avoid race if closed at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* The device context has not been opened */
> +	if (dev_ctx->status != SE_IF_CTX_OPENED)
> +		goto exit;
> +
> +	/* check if this device was registered as command receiver. */
> +	if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {

This is racy. priv->cmd_receiver_clbk_hdl can be accessed by multiple
tasks without locking.

> +		priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
> +		kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
> +		priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
> +		atomic_set(&priv->cmd_receiver_clbk_hdl.pending_hdr, 0);
> +	}
> +
> +	/* check if this device was registered as waiting response. */
> +	if (priv->waiting_rsp_clbk_hdl.dev_ctx == dev_ctx) {

> +		priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
> +		mutex_unlock(&priv->se_if_cmd_lock);

This mutex will never be locked here.

> +	}
> +
> +	se_dev_ctx_shared_mem_cleanup(&dev_ctx->se_shared_mem_mgmt);
> +	cleanup_se_shared_mem(&dev_ctx->se_shared_mem_mgmt);
> +	dev_ctx->status = SE_IF_CTX_FREE;
> +
> +	priv->active_devctx_count--;
> +	list_del(&dev_ctx->link);
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	kfree(dev_ctx->devname);
> +	kfree(dev_ctx);
> +
> +	return 0;
> +}
> +
>  static void se_if_probe_cleanup(struct platform_device *pdev)
>  {
> +	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
>  	struct device *dev = &pdev->dev;
>  	struct se_if_priv *priv;
>  
> @@ -247,6 +939,14 @@ static void se_if_probe_cleanup(struct platform_device *pdev)
>  		priv->imem.buf = NULL;
>  	}
>  
> +	list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
> +		list_del(&dev_ctx->link);
> +		priv->active_devctx_count--;
> +	}

The only place where this list is ever iterated over is here. active_devctx_count
is never used except for printing a message (see other comment).
Just drop this list.

> +
> +	devm_remove_action(dev, if_misc_deregister, &priv->priv_dev_ctx->miscdev);
> +	misc_deregister(&priv->priv_dev_ctx->miscdev);
> +
>  	/* No need to check, if reserved memory is allocated
>  	 * before calling for its release. Or clearing the
>  	 * un-set bit.
> @@ -254,6 +954,87 @@ static void se_if_probe_cleanup(struct platform_device *pdev)
>  	of_reserved_mem_device_release(dev);
>  }
>  
> +int init_device_context(struct se_if_priv *priv, int ch_id,
> +			struct se_if_device_ctx **new_dev_ctx)
> +{

static.

> +	const struct se_if_node_info *info = priv->info;
> +	struct se_if_device_ctx *dev_ctx;
> +	int ret = 0;
> +
> +	if (ch_id)
> +		dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
> +	else
> +		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
> +
> +	if (!dev_ctx) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	dev_ctx->status = SE_IF_CTX_FREE;
> +	dev_ctx->priv = priv;
> +
> +	if (ch_id)
> +		dev_ctx->devname = kasprintf(GFP_KERNEL, "%s_ch%d",
> +					     info->se_name, ch_id);
> +	else
> +		dev_ctx->devname = devm_kasprintf(priv->dev,
> +						  GFP_KERNEL, "%s_ch%d",
> +						  info->se_name, ch_id);
> +	if (!dev_ctx->devname) {
> +		ret = -ENOMEM;
> +		if (ch_id)
> +			kfree(dev_ctx);
> +
> +		return ret;
> +	}
> +
> +	sema_init(&dev_ctx->fops_lock, 1);

This semaphore only counts up to one in your code which basically makes
it a mutex. Just use a mutex instead.

> +/* Private struct for each char device instance. */
> +struct se_if_device_ctx {
> +	struct se_if_priv *priv;
> +	struct miscdevice miscdev;
> +	const char *devname;
> +
> +	enum se_if_dev_ctx_status_t status;
> +	struct semaphore fops_lock;
> +
> +	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
> +	struct notifier_block se_notify;

se_notify is never used.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

