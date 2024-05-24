Return-Path: <linux-kernel+bounces-188461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796BE8CE24C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71621F220E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB931292C1;
	Fri, 24 May 2024 08:23:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E35B1F8
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539032; cv=none; b=h+JDk4YQsoe5lGrij58mvpxRXBKeNgDQ7GtCT8APUgkMyl2C2QI9EbHhTRrYhknyzi8tuYR7iXMopIBrt0Kcd3JWd9nov19ziXZkbRD2uWVOFKXME38PzV+ptFEYctFCwTN14h2/9PvMpSt+YfKrwHZsbDgiJEhP16OonpF3lLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539032; c=relaxed/simple;
	bh=c/77p2U2FTSYEp++jjPcUy1koju/VvZWepirvC/V45s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUHrSzds8G5YJ68mHndYr8iBJmDWrkKnOTo8gaJzhsuZNoCMRgrbeJBUC7X6+h2/lHeG+gcJEp5uIHcNAANciWS8bZAI0YyYoU8fh5zFptwUgMU+4FKOrb/XgXWFirJyyKCFZK337WBko9jzyCaVDOGIQm3jaEeJjJMCy3o2aj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sAQCz-0000Om-DD; Fri, 24 May 2024 10:23:25 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sAQCu-002lmM-U0; Fri, 24 May 2024 10:23:20 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sAQCu-00Bc2V-2h;
	Fri, 24 May 2024 10:23:20 +0200
Date: Fri, 24 May 2024 10:23:20 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] firmware: imx: adds miscdev
Message-ID: <ZlBOeAnkrn4ki7Wv@pengutronix.de>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, May 23, 2024 at 04:19:36PM +0530, Pankaj Gupta wrote:
> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			     void *tx_msg, int tx_msg_sz)
> +{
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_msg_hdr *header;
> +	int err;
> +
> +	header = (struct se_msg_hdr *) tx_msg;
> +
> +	/*
> +	 * Check that the size passed as argument matches the size
> +	 * carried in the message.
> +	 */
> +	err = header->size << 2;
> +
> +	if (err != tx_msg_sz) {
> +		err = -EINVAL;
> +		dev_err(priv->dev,
> +			"%s: User buffer too small\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +	/* Check the message is valid according to tags */
> +	if (header->tag == priv->cmd_tag) {
> +		mutex_lock(&priv->se_if_cmd_lock);

Grabbing a mutex in a character devices write fop and releasing it in the
read fop is really calling for undesired race conditions.

If sending a command and receiving the response shall be an atomic
operation then you should really consider turning this into an ioctl
and just not implement read/write on the character device. With this
you'll be able to get rid of several oddities in this drivers locking.

> +		priv->waiting_rsp_dev = dev_ctx;
> +	} else if (header->tag == priv->rsp_tag) {
> +		/* Check the device context can send the command */
> +		if (dev_ctx != priv->cmd_receiver_dev) {
> +			dev_err(priv->dev,
> +				"%s: Channel not configured to send resp to FW.",
> +				dev_ctx->miscdev.name);
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	} else {
> +		dev_err(priv->dev,
> +			"%s: The message does not have a valid TAG\n",
> +				dev_ctx->miscdev.name);
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +	err = imx_ele_msg_send(priv, tx_msg);
> +	if (err < 0) {
> +		if (header->tag == priv->cmd_tag) {
> +			priv->waiting_rsp_dev = NULL;
> +			mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> +		}
> +	} else
> +		err = header->size << 2;
> +exit:
> +	return err;
> +}
> +

[...]

> +static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
> +				size_t size, loff_t *ppos)
> +{
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	int err;
> +
> +	dev_ctx = container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv = dev_ctx->priv;
> +	dev_dbg(priv->dev,
> +		"%s: write from buf (%p)%zu, ppos=%lld\n",
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
> +	if (size < SE_MU_HDR_SZ) {
> +		dev_err(priv->dev,
> +			"%s: User buffer too small(%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, SE_MU_HDR_SZ);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +	tx_msg = memdup_user(buf, size);
> +	if (!tx_msg) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}

memdup_user() returns an error pointer, not NULL. Also you are using
tx_msg uninitialized.

> +
> +	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     tx_msg, size, false);
> +
> +	err = imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/*
> + * Read a message from the MU.
> + * Blocking until a message is available.
> + */
> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +			       size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_buf_desc *b_desc;
> +	struct se_if_priv *priv;
> +	u32 size_to_copy;
> +	int err;
> +
> +	dev_ctx = container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv = dev_ctx->priv;
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
> +	err = imx_ele_miscdev_msg_rcv(dev_ctx);
> +	if (err)
> +		goto exit;
> +
> +	/* Buffer containing the message from FW, is
> +	 * allocated in callback function.
> +	 * Check if buffer allocation failed.
> +	 */
> +	if (!dev_ctx->temp_resp) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_dbg(priv->dev,
> +			"%s: %s %s\n",
> +			dev_ctx->miscdev.name,
> +			__func__,
> +			"message received, start transmit to user");
> +
> +	/*
> +	 * Check that the size passed as argument is larger than
> +	 * the one carried in the message.
> +	 */
> +	size_to_copy = dev_ctx->temp_resp_size << 2;
> +	if (size_to_copy > size) {
> +		dev_dbg(priv->dev,
> +			"%s: User buffer too small (%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, size_to_copy);
> +		size_to_copy = size;
> +	}
> +
> +	/*
> +	 * We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_out)) {
> +		b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +						  struct se_buf_desc,
> +						  link);
> +		if (!b_desc)
> +			continue;

b_desc will never be NULL because otherwise you wouldn't be in the loop
anymore. The usual way to iterate over a list is to use list_for_each_entry()
or list_for_each_entry_safe() in case you delete entries in the loop
body.

> +
> +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> +
> +			dev_dbg(priv->dev,
> +				"%s: Copy output data to user\n",
> +				dev_ctx->miscdev.name);
> +			if (copy_to_user(b_desc->usr_buf_ptr,
> +					 b_desc->shared_buf_ptr,
> +					 b_desc->size)) {
> +				dev_err(priv->dev,
> +					"%s: Failure copying output data to user.",
> +					dev_ctx->miscdev.name);
> +				err = -EFAULT;
> +				goto exit;
> +			}
> +		}
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);

list_del()

> +		kfree(b_desc);
> +	}
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     dev_ctx->temp_resp, size_to_copy, false);
> +	if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy to user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	err = size_to_copy;
> +	kfree(dev_ctx->temp_resp);
> +
> +	/* free memory allocated on the shared buffers. */
> +	dev_ctx->secure_mem.pos = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +exit:
> +	/*
> +	 * Clean the used Shared Memory space,
> +	 * whether its Input Data copied from user buffers, or
> +	 * Data received from FW.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> +				u64 arg)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
> +	struct imx_se_node_info *if_node_info;
> +	struct se_ioctl_get_if_info info;
> +	int err = 0;
> +
> +	if_node_info = (struct imx_se_node_info *)priv->info;

priv->info is of type const void *. You are casting away the the 'const'
here. Either it is const, then it should stay const, or not, in which
case it shouldn't be declared const. Also why isn't priv->info of type
struct imx_se_node_info * in the first place?

> +
> +	info.se_if_id = if_node_info->se_if_id;
> +	info.interrupt_idx = 0;
> +	info.tz = 0;
> +	info.did = if_node_info->se_if_did;
> +	info.cmd_tag = if_node_info->cmd_tag;
> +	info.rsp_tag = if_node_info->rsp_tag;
> +	info.success_tag = if_node_info->success_tag;
> +	info.base_api_ver = if_node_info->base_api_ver;
> +	info.fw_api_ver = if_node_info->fw_api_ver;
> +
> +	dev_dbg(priv->dev,
> +		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> +			dev_ctx->miscdev.name,
> +			info.se_if_id, info.interrupt_idx, info.tz, info.did);
> +
> +	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy mu info to user\n",
> +				dev_ctx->miscdev.name);

Just drop these error messages for failed copy_to_user(). They don't
give any valuable information and just bloat the code.

> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Copy a buffer of data to/from the user and return the address to use in
> + * messages
> + */
> +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_shared_mem *shared_mem = NULL;
> +	struct se_ioctl_setup_iobuf io = {0};
> +	struct se_buf_desc *b_desc = NULL;
> +	int err = 0;
> +	u32 pos;
> +
> +	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed copy iobuf config from user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	dev_dbg(dev_ctx->priv->dev,
> +			"%s: io [buf: %p(%d) flag: %x]\n",
> +			dev_ctx->miscdev.name,
> +			io.user_buf, io.length, io.flags);
> +
> +	if (io.length == 0 || !io.user_buf) {
> +		/*
> +		 * Accept NULL pointers since some buffers are optional
> +		 * in FW commands. In this case we should return 0 as
> +		 * pointer to be embedded into the message.
> +		 * Skip all data copy part of code below.
> +		 */
> +		io.ele_addr = 0;
> +		goto copy;
> +	}
> +
> +	/* Select the shared memory to be used for this buffer. */
> +	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {

If you don't support this flag (yet), just don't include it in your
submission.

> +		/* App requires to use secure memory for this buffer.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	} else {
> +		/* No specific requirement for this buffer. */
> +		shared_mem = &dev_ctx->non_secure_mem;
> +	}
> +
> +	/* Check there is enough space in the shared memory. */
> +	if (shared_mem->size < shared_mem->pos
> +			|| io.length >= shared_mem->size - shared_mem->pos) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Not enough space in shared memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Allocate space in shared memory. 8 bytes aligned. */
> +	pos = shared_mem->pos;
> +	shared_mem->pos += round_up(io.length, 8u);

You are checking if there's enough space in the shared memory without
taking this round_up into account.

> +	io.ele_addr = (u64)shared_mem->dma_addr + pos;
> +
> +	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> +	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> +		/*Add base address to get full address.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	memset(shared_mem->ptr + pos, 0, io.length);
> +	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> +	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> +		/*
> +		 * buffer is input:
> +		 * copy data from user space to this allocated buffer.
> +		 */
> +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> +				   io.length)) {
> +			dev_err(dev_ctx->priv->dev,
> +				"%s: Failed copy data to shared memory\n",
> +				dev_ctx->miscdev.name);
> +			err = -EFAULT;
> +			goto exit;
> +		}
> +	}
> +
> +	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +	if (!b_desc) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +copy:
> +	/* Provide the EdgeLock Enclave address to user space only if success.*/
> +	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy iobuff setup to user\n",
> +				dev_ctx->miscdev.name);
> +		kfree(b_desc);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	if (b_desc) {
> +		b_desc->shared_buf_ptr = shared_mem->ptr + pos;
> +		b_desc->usr_buf_ptr = io.user_buf;
> +		b_desc->size = io.length;
> +
> +		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +			/*
> +			 * buffer is input:
> +			 * add an entry in the "pending input buffers" list so
> +			 * that copied data can be cleaned from shared memory
> +			 * later.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
> +		} else {
> +			/*
> +			 * buffer is output:
> +			 * add an entry in the "pending out buffers" list so data
> +			 * can be copied to user space when receiving Secure-Enclave
> +			 * response.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
> +		}
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* IOCTL to provide SoC information */
> +static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> +					     u64 arg)
> +{
> +	struct imx_se_node_info_list *info_list;
> +	struct se_ioctl_get_soc_info soc_info;
> +	int err = -EINVAL;
> +
> +	info_list = (struct imx_se_node_info_list *)
> +			device_get_match_data(dev_ctx->priv->dev);

device_get_match_data() returns a const void *. It is generally not necessary
to explicitly cast void * to another pointer type. By explicitly casting
it you just cast away the 'const' without noticing.

> +	if (!info_list)
> +		goto exit;
> +
> +	soc_info.soc_id = info_list->soc_id;
> +	soc_info.soc_rev = dev_ctx->priv->soc_rev;
> +
> +	err = (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info));

First argument of copy_to_user() is a void *, then why do you cast it to
something entirely unrelated (u8)? Second argument is a void * as well,
so no need to explicitly cast.

> +	if (err) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy soc info to user\n",
> +			dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;

This goto is unnecessary.

> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	int err = 0;
> +
> +	/* Avoid race if opened at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* Authorize only 1 instance. */
> +	if (dev_ctx->status != SE_IF_CTX_FREE) {
> +		err = -EBUSY;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
> +					MAX_DATA_SIZE_PER_USER,
> +					&dev_ctx->non_secure_mem.dma_addr,
> +					GFP_KERNEL);

As Marc already mentioned: There is no point in using the managed
version on dma_alloc_coherent() here.

> +	if (!dev_ctx->non_secure_mem.ptr) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
> +	dev_ctx->non_secure_mem.pos = 0;
> +	dev_ctx->status = SE_IF_CTX_OPENED;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +	goto exit;
> +
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);

This code is unreachable.

> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_buf_desc *b_desc;
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
> +	if (priv->cmd_receiver_dev == dev_ctx)
> +		priv->cmd_receiver_dev = NULL;
> +
> +	/* check if this device was registered as waiting response. */
> +	if (priv->waiting_rsp_dev == dev_ctx) {
> +		priv->waiting_rsp_dev = NULL;
> +		mutex_unlock(&priv->se_if_cmd_lock);
> +	}
> +
> +	/* Unmap secure memory shared buffer. */
> +	if (dev_ctx->secure_mem.ptr)
> +		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);

secure_mem is unused in this patch set. Drop this and re-add it later
when you want to add support for this.

> +
> +	dev_ctx->secure_mem.ptr = NULL;
> +	dev_ctx->secure_mem.dma_addr = 0;
> +	dev_ctx->secure_mem.size = 0;
> +	dev_ctx->secure_mem.pos = 0;
> +
> +	/* Free non-secure shared buffer. */
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +	dev_ctx->non_secure_mem.ptr = NULL;
> +	dev_ctx->non_secure_mem.dma_addr = 0;
> +	dev_ctx->non_secure_mem.size = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	dev_ctx->status = SE_IF_CTX_FREE;
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a character device */
> +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *se_if_priv = dev_ctx->priv;
> +	int err = -EINVAL;
> +
> +	/* Prevent race during change of device context */
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case SE_IOCTL_ENABLE_CMD_RCV:
> +		if (!se_if_priv->cmd_receiver_dev) {
> +			se_if_priv->cmd_receiver_dev = dev_ctx;
> +			err = 0;
> +		}
> +		break;
> +	case SE_IOCTL_GET_MU_INFO:
> +		err = se_ioctl_get_mu_info(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_SETUP_IOBUF:
> +		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_GET_SOC_INFO:
> +		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> +		break;
> +
> +	default:
> +		err = -EINVAL;
> +		dev_dbg(se_if_priv->dev,
> +			"%s: IOCTL %.8x not supported\n",
> +				dev_ctx->miscdev.name,
> +				cmd);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return (long)err;
> +}
> +
> +/* Char driver setup */
> +static const struct file_operations se_if_fops = {
> +	.open		= se_if_fops_open,
> +	.owner		= THIS_MODULE,
> +	.release	= se_if_fops_close,
> +	.unlocked_ioctl = se_ioctl,
> +	.read		= se_if_fops_read,
> +	.write		= se_if_fops_write,
> +};
> +
> +/* interface for managed res to unregister a character device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
>  /* interface for managed res to free a mailbox channel */
>  static void if_mbox_free_channel(void *mbox_chan)
>  {
> @@ -270,6 +855,7 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct se_if_priv *priv;
>  	int ret = 0;
> +	int i;
>  
>  	priv = dev_get_drvdata(dev);
>  	if (!priv) {
> @@ -294,6 +880,17 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
>  		priv->imem.buf = NULL;
>  	}
>  
> +	if (priv->ctxs) {
> +		for (i = 0; i < priv->max_dev_ctx; i++) {
> +			if (priv->ctxs[i]) {
> +				devm_remove_action(dev,
> +						   if_misc_deregister,
> +						   &priv->ctxs[i]->miscdev);
> +				misc_deregister(&priv->ctxs[i]->miscdev);
> +			}
> +		}
> +	}
> +
>  	if (priv->flags & RESERVED_DMA_POOL) {
>  		of_reserved_mem_device_release(dev);
>  		priv->flags &= (~RESERVED_DMA_POOL);
> @@ -302,6 +899,84 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int init_device_context(struct device *dev)
> +{
> +	const struct imx_se_node_info *info;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	u8 *devname;
> +	int ret = 0;
> +	int i;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	if (!priv) {
> +		ret = -EINVAL;
> +		dev_err(dev, "Invalid SE-MU Priv data");
> +		return ret;
> +	}

You won't hit this as you already have called dev_set_drvdata(). Just
drop this check. Also you should pass a struct se_if_priv * directly
to this function instead of taking the detour of passing a struct device
*.

> +	info = priv->info;
> +
> +	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
> +				  GFP_KERNEL);
> +
> +	if (!priv->ctxs) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	/* Create users */
> +	for (i = 0; i < priv->max_dev_ctx; i++) {
> +		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
> +		if (!dev_ctx) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->dev = dev;
> +		dev_ctx->status = SE_IF_CTX_FREE;
> +		dev_ctx->priv = priv;
> +
> +		priv->ctxs[i] = dev_ctx;
> +
> +		/* Default value invalid for an header. */
> +		init_waitqueue_head(&dev_ctx->wq);
> +
> +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> +		sema_init(&dev_ctx->fops_lock, 1);
> +
> +		devname = devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
> +					 info->se_name, i);
> +		if (!devname) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->miscdev.name = devname;
> +		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
> +		dev_ctx->miscdev.fops = &se_if_fops;
> +		dev_ctx->miscdev.parent = dev;
> +		ret = misc_register(&dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev, "failed to register misc device %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = devm_add_action(dev, if_misc_deregister,
> +				      &dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to add action to the misc-dev\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static void se_load_firmware(const struct firmware *fw, void *context)
>  {
>  	struct se_if_priv *priv = (struct se_if_priv *) context;
> @@ -461,6 +1136,16 @@ static int se_if_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (info->max_dev_ctx) {
> +		ret = init_device_context(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed[0x%x] to create device contexts.\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
>  	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
>  		 info->se_name);
>  	return devm_of_platform_populate(dev);
> @@ -502,6 +1187,10 @@ static int se_resume(struct device *dev)
>  	struct se_if_priv *priv = dev_get_drvdata(dev);
>  	const struct imx_se_node_info *info
>  					= priv->info;
> +	int i;
> +
> +	for (i = 0; i < priv->max_dev_ctx; i++)
> +		wake_up_interruptible(&priv->ctxs[i]->wq);
>  
>  	if (info && info->imem_mgmt)
>  		se_restore_imem_state(dev);

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

