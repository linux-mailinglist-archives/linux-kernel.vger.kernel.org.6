Return-Path: <linux-kernel+bounces-564774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3CA65A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A15B1888CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145121AF0BF;
	Mon, 17 Mar 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHxVWMeW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B10DDC1;
	Mon, 17 Mar 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231777; cv=none; b=F6pi6nOjQZ193rtFX5c5OPz90pCJlbJV94wUwxm5xFA8nK/i3xX1ivdbV6y05B99y0lReaD0wEp9hLShL1Z9EL2hU1W2jGz0BtG4obJES6i9E+DGYcHVOJYz5mi3Eoc9Kvuu8LtcUXrRYSvZyuJMQgGEOrh4B3xwG0hd/MneR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231777; c=relaxed/simple;
	bh=q9IbR+SPXKPwKHG0WRLenj1Bv3UPy2ku6dZrRsHDh4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUoiGuNk8mix/zgmeBz26OuQ4vfTSRhNWAQjC0ttxKoqXde/K7EOK+bl8gbBsfwxpWFG7CD/ozYaa/xHTED/AzA0TY+LfNrwOm9VVgizy/64rk17tzPyfbjlG2Cx1t+0v6p+dN+GTNl0zgCXZCTy9+eKYGjSIVATlCpTVZ70ngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHxVWMeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C9C4CEE3;
	Mon, 17 Mar 2025 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231776;
	bh=q9IbR+SPXKPwKHG0WRLenj1Bv3UPy2ku6dZrRsHDh4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SHxVWMeWe6PiwaWbEPnSxfwdepGEdOFxCyj2MK1VUTKvJxlAfXzp5JU0nLArAOBuB
	 ldw6bkNCxBAkdDAPeIrgJmwLPPDNNoEeruBCUIcbTDAto+E1Swuo7DRgl8TRgyB+Ev
	 FiQwYlEuAmfWbJRtaDv8l0wxX0ayjptIIUB8oR7hRfAvC++YJU+43bNDg7RKXawEty
	 kKnuLA45G+wI2kJLSAbV0uTdh53RYh1uf/Vddv5dsmSBJ8LB3UBS6oVCMY2rsgYcv/
	 NvfDPtIj91SthydyLrxI75ADfDfKrBa/4P3OTUD4dUgtGNNs21o/tOgFSarxlW5tVk
	 JsqZYTriXtbmA==
Message-ID: <d3f8fbe3-c061-4d34-a5a3-09cbf676bc4c@kernel.org>
Date: Mon, 17 Mar 2025 18:16:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/3] firmware: mediatek: Add vcp ipc protocol
 interface
To: Jjian Zhou <jjian.zhou@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20250317110331.2776-1-jjian.zhou@mediatek.com>
 <20250317110331.2776-3-jjian.zhou@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250317110331.2776-3-jjian.zhou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 12:03, Jjian Zhou wrote:
> Some of mediatek processors contain the Risc-V coprocessor.
> 
> The communication between Host CPU and vcp firmware is
> taking place using a shared memory area for message passing.
> 
> VCP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>  drivers/firmware/Kconfig                      |   9 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/mtk-vcp-ipc.c                | 481 ++++++++++++++++++
>  include/linux/firmware/mediatek/mtk-vcp-ipc.h | 151 ++++++
>  4 files changed, 642 insertions(+)
>  create mode 100644 drivers/firmware/mtk-vcp-ipc.c
>  create mode 100644 include/linux/firmware/mediatek/mtk-vcp-ipc.h

Do not send new versions while previous discussion is still going.

You still did not respond to previous feedback and you already sent two
versions repeating the same mistake.

> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 37e43f287e78..98c4ff667836 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -179,6 +179,15 @@ config MTK_ADSP_IPC
>  	  ADSP exists on some mtk processors.
>  	  Client might use shared memory to exchange information with ADSP.
>  

..

> +
> +/*
> + * mtk_vcp_ipc_send - send ipc command to MTK VCP
> + *
> + * @ipidev: VCP struct mtk_ipi_device handle
> + * @id: id of the feature IPI
> + * @data: message address
> + * @len: message length
> + *
> + * Return: Zero for success from mbox_send_message
> + *         negative value for error
> + */
> +int mtk_vcp_ipc_send(struct mtk_ipi_device *ipidev, u32 id, void *data, u32 len)
> +{
> +	struct device *dev;
> +	struct mtk_mbox_info *minfo;
> +	struct mtk_ipi_chan_table *table;
> +	struct mtk_vcp_ipc *vcp_ipc;
> +	int ret;
> +
> +	if (!ipidev || !ipidev->ipi_inited || !data)
> +		return IPI_UNAVAILABLE;
> +	vcp_ipc = ipidev->vcp_ipc;
> +	if (!vcp_ipc)
> +		return IPI_UNAVAILABLE;
> +
> +	table = ipidev->table;
> +	dev = ipidev->vcp_ipc->dev;
> +	minfo = &ipidev->vcp_ipc->info_table[table[id].mbox];
> +	if (!minfo) {
> +		dev_err(dev, "%s IPI%d minfo is invalid.\n", ipidev->name, id);
> +		return IPI_UNAVAILABLE;
> +	}
> +
> +	if (len > table[id].msg_size)
> +		return IPI_MSG_TOO_BIG;
> +	else if (!len)
> +		len = table[id].msg_size;
> +
> +	mutex_lock(&table[id].mutex_send);
> +
> +	minfo->ipi_info.msg = data;
> +	minfo->ipi_info.len = len;
> +	minfo->ipi_info.id = id;
> +	minfo->ipi_info.index = table[id].send_index;
> +	minfo->ipi_info.slot_ofs = table[id].send_ofs * MBOX_SLOT_SIZE;
> +
> +	ret = mbox_send_message(minfo->ch, &minfo->ipi_info);
> +	mutex_unlock(&table[id].mutex_send);
> +	if (ret < 0) {
> +		dev_err(dev, "%s IPI%d send failed.\n", ipidev->name, id);
> +		return IPI_MBOX_ERR;
> +	}
> +
> +	return IPI_ACTION_DONE;
> +}
> +EXPORT_SYMBOL(mtk_vcp_ipc_send);

Drop export - no users

Anyway, every export must be GPL.

> +
> +/*
> + * mtk_vcp_ipc_send_compl - send ipc command to MTK VCP
> + *
> + * @ipidev: VCP struct mtk_ipi_device handle
> + * @id: id of the feature IPI
> + * @data: message address
> + * @len: message length
> + * @timeout_ms:
> + *
> + * Return: Zero for success from mbox_send_message
> + *         negative value for error
> + */
> +int mtk_vcp_ipc_send_compl(struct mtk_ipi_device *ipidev, u32 id,
> +			   void *data, u32 len, u32 timeout_ms)
> +{
> +	struct device *dev;
> +	struct mtk_mbox_info *minfo;
> +	struct mtk_ipi_chan_table *table;
> +	struct mtk_vcp_ipc *vcp_ipc;
> +	int ret;
> +
> +	if (!ipidev || !ipidev->ipi_inited || !data)
> +		return IPI_UNAVAILABLE;
> +	vcp_ipc = ipidev->vcp_ipc;
> +	if (!vcp_ipc)
> +		return IPI_UNAVAILABLE;
> +
> +	table = ipidev->table;
> +	dev = ipidev->vcp_ipc->dev;
> +	minfo = &ipidev->vcp_ipc->info_table[table[id].mbox];
> +	if (!minfo) {
> +		dev_err(dev, "%s IPI%d minfo is invalid.\n", ipidev->name, id);
> +		return IPI_UNAVAILABLE;
> +	}
> +
> +	if (len > table[id].msg_size)
> +		return IPI_MSG_TOO_BIG;
> +	else if (!len)
> +		len = table[id].msg_size;
> +
> +	mutex_lock(&table[id].mutex_send);
> +
> +	minfo->ipi_info.msg = data;
> +	minfo->ipi_info.len = len;
> +	minfo->ipi_info.id = id;
> +	minfo->ipi_info.index = table[id].send_index;
> +	minfo->ipi_info.slot_ofs = table[id].send_ofs * MBOX_SLOT_SIZE;
> +
> +	atomic_inc(&table[id].holder);
> +
> +	ret = mbox_send_message(minfo->ch, &minfo->ipi_info);
> +	if (ret < 0) {
> +		atomic_set(&table[id].holder, 0);
> +		mutex_unlock(&table[id].mutex_send);
> +		dev_err(dev, "%s IPI%d send failed.\n", ipidev->name, id);
> +		return IPI_MBOX_ERR;
> +	}
> +
> +	/* wait for completion */
> +	ret = wait_for_completion_timeout(&table[id].notify,
> +					  msecs_to_jiffies(timeout_ms));
> +	atomic_set(&table[id].holder, 0);
> +	if (ret > 0)
> +		ret = IPI_ACTION_DONE;
> +
> +	mutex_unlock(&table[id].mutex_send);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mtk_vcp_ipc_send_compl);

NAK, no users.

> +
> +int mtk_vcp_mbox_ipc_register(struct mtk_ipi_device *ipidev, int id,
> +			      mbox_pin_cb_t cb, void *prdata, void *msg)
> +{
> +	if (!ipidev || !ipidev->ipi_inited)
> +		return IPI_DEV_ILLEGAL;
> +	if (!msg)
> +		return IPI_NO_MSGBUF;
> +
> +	if (ipidev->table[id].pin_buf)
> +		return IPI_ALREADY_USED;
> +	ipidev->table[id].mbox_pin_cb = cb;
> +	ipidev->table[id].pin_buf = msg;
> +	ipidev->table[id].prdata = prdata;
> +
> +	return IPI_ACTION_DONE;
> +}
> +EXPORT_SYMBOL(mtk_vcp_mbox_ipc_register);

NAK, no users.


> +
> +int mtk_vcp_mbox_ipc_unregister(struct mtk_ipi_device *ipidev, int id)
> +{
> +	if (!ipidev || !ipidev->ipi_inited)
> +		return IPI_DEV_ILLEGAL;
> +
> +	/* Drop the ipi and reset the record */
> +	complete(&ipidev->table[id].notify);
> +
> +	ipidev->table[id].mbox_pin_cb = NULL;
> +	ipidev->table[id].pin_buf = NULL;
> +	ipidev->table[id].prdata = NULL;
> +
> +	return IPI_ACTION_DONE;
> +}
> +EXPORT_SYMBOL(mtk_vcp_mbox_ipc_unregister);

NAK, no users.


> +
> +static void mtk_fill_in_entry(struct mtk_ipi_chan_table *entry, const u32 ipi_id,
> +			      const struct mtk_mbox_table *mbdev)
> +{
> +	const struct mtk_mbox_send_table *mbox_send = mbdev->send_table;
> +	u32 index;
> +
> +	for (index = 0; index < mbdev->send_count; index++) {
> +		if (ipi_id != mbox_send[index].ipi_id)
> +			continue;
> +
> +		entry->send_ofs = mbox_send[index].offset;
> +		entry->send_index = mbox_send[index].pin_index;
> +		entry->msg_size = mbox_send[index].msg_size;
> +		entry->mbox = mbox_send[index].mbox_id;
> +		return;
> +	}
> +
> +	entry->mbox = -ENOENT;
> +}
> +
> +int mtk_vcp_ipc_device_register(struct mtk_ipi_device *ipidev,
> +				u32 ipi_chan_count, struct mtk_vcp_ipc *vcp_ipc)
> +{
> +	struct mtk_ipi_chan_table *ipi_chan_table;
> +	struct mtk_mbox_table *mbdev;
> +	u32 index;
> +
> +	if (!vcp_ipc || !ipidev)
> +		return -EINVAL;
> +
> +	ipi_chan_table = kcalloc(ipi_chan_count,
> +				 sizeof(struct mtk_ipi_chan_table), GFP_KERNEL);
> +	if (!ipi_chan_table)
> +		return -ENOMEM;
> +
> +	mbdev = vcp_ipc->mbdev;
> +	vcp_ipc->ipi_priv = (void *)ipidev;
> +	ipidev->table = ipi_chan_table;
> +	ipidev->vcp_ipc = vcp_ipc;
> +
> +	for (index = 0; index < ipi_chan_count; index++) {
> +		atomic_set(&ipi_chan_table[index].holder, 0);
> +		mutex_init(&ipi_chan_table[index].mutex_send);
> +		init_completion(&ipi_chan_table[index].notify);
> +		mtk_fill_in_entry(&ipi_chan_table[index], index, mbdev);
> +	}
> +
> +	ipidev->ipi_inited = 1;
> +
> +	dev_dbg(vcp_ipc->dev, "%s (with %d IPI) has registered.\n",
> +		ipidev->name, ipi_chan_count);
> +
> +	return IPI_ACTION_DONE;
> +}
> +EXPORT_SYMBOL(mtk_vcp_ipc_device_register);

NAK, no users.


> +
> +static int setup_mbox_table(struct mtk_mbox_table *mbdev, u32 mbox)
> +{
> +	struct mtk_mbox_send_table *mbox_send = &mbdev->send_table[0];
> +	struct mtk_mbox_recv_table *mbox_recv = &mbdev->recv_table[0];
> +	u32 i, last_ofs = 0, last_idx = 0, last_slot = 0, last_sz = 0;
> +
> +	for (i = 0; i < mbdev->send_count; i++) {
> +		if (mbox == mbox_send[i].mbox_id) {
> +			mbox_send[i].offset = last_ofs + last_slot;
> +			mbox_send[i].pin_index = last_idx + last_sz;
> +			last_idx = mbox_send[i].pin_index;
> +			last_sz = DIV_ROUND_UP(mbox_send[i].msg_size, MBOX_SLOT_ALIGN);
> +			last_ofs = last_sz * MBOX_SLOT_ALIGN;
> +			last_slot = last_idx * MBOX_SLOT_ALIGN;
> +		} else if (mbox < mbox_send[i].mbox_id) {
> +			/* no need to search the rest id */
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < mbdev->recv_count; i++) {
> +		if (mbox == mbox_recv[i].mbox_id) {
> +			mbox_recv[i].offset = last_ofs + last_slot;
> +			mbox_recv[i].pin_index = last_idx + last_sz;
> +			last_idx = mbox_recv[i].pin_index;
> +			last_sz = DIV_ROUND_UP(mbox_recv[i].msg_size, MBOX_SLOT_ALIGN);
> +			last_ofs = last_sz * MBOX_SLOT_ALIGN;
> +			last_slot = last_idx * MBOX_SLOT_ALIGN;
> +		} else if (mbox < mbox_recv[i].mbox_id) {
> +			/* no need to search the rest id */
> +			break;
> +		}
> +	}
> +
> +	if (last_idx > MBOX_MAX_PIN || (last_ofs + last_slot) > MAX_SLOT_NUM)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int mtk_vcp_ipc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_vcp_ipc *vcp_ipc;
> +	struct mbox_client *cl;
> +	struct mtk_mbox_info *minfo;
> +	int ret;
> +	u32 mbox, i;
> +	struct mtk_mbox_table *mbox_data = dev_get_platdata(dev);
> +
> +	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
> +
> +	vcp_ipc = devm_kzalloc(dev, sizeof(*vcp_ipc), GFP_KERNEL);
> +	if (!vcp_ipc)
> +		return -ENOMEM;
> +
> +	if (!mbox_data) {

Check goes immediately after declaration. I doubt it is useful in the
first place as this cannot even happen...


> +		dev_err(dev, "No platform data available\n");

No, drop. Cannot happen or fix your drivers. Who provides the platdata here?

> +		return -EINVAL;
> +	}
> +	vcp_ipc->mbdev = mbox_data;
> +
> +	/* alloc and init mmup_mbox_info */
> +	vcp_ipc->info_table = vzalloc(sizeof(*vcp_ipc->info_table) * VCP_MBOX_NUM);
> +	if (!vcp_ipc->info_table)
> +		return -ENOMEM;
> +
> +	/* create mbox dev */
> +	for (mbox = 0; mbox < VCP_MBOX_NUM; mbox++) {
> +		minfo = &vcp_ipc->info_table[mbox];
> +		minfo->mbox_id = mbox;
> +		minfo->vcp_ipc = vcp_ipc;
> +		spin_lock_init(&minfo->mbox_lock);
> +
> +		ret = setup_mbox_table(vcp_ipc->mbdev, mbox);
> +		if (ret)
> +			return ret;
> +
> +		cl = &minfo->cl;
> +		cl->dev = &pdev->dev;
> +		cl->tx_block = false;
> +		cl->knows_txdone = false;
> +		cl->tx_prepare = NULL;
> +		cl->rx_callback = mtk_vcp_ipc_recv;
> +		minfo->ch = mbox_request_channel_byname(cl, mbox_names[mbox]);
> +		if (IS_ERR(minfo->ch)) {
> +			ret = PTR_ERR(minfo->ch);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Failed to request mbox channel %s ret %d\n",
> +					mbox_names[mbox], ret);

Do not open code dev_err_probe.

> +
> +			for (i = 0; i < mbox; i++) {
> +				minfo = &vcp_ipc->info_table[i];
> +				mbox_free_channel(minfo->ch);
> +			}
> +
> +			vfree(vcp_ipc->info_table);
> +			return ret;
> +		}
> +	}
> +
> +	vcp_ipc->dev = dev;
> +	dev_set_drvdata(dev, vcp_ipc);
> +	dev_dbg(dev, "MTK VCP IPC initialized\n");

No, drop


Best regards,
Krzysztof

