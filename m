Return-Path: <linux-kernel+bounces-516937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A70A379FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12E03AEAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722014D2B7;
	Mon, 17 Feb 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EI7Ctg8e"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2E13D51E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761416; cv=none; b=IHc8xTtb4bGJdDEip93qNo+FuGYgWpytpLhTeLuDPQhfHq2kshJ+M3MrTZDRUeGT+im8vVSrjxUiPapyOErmYlfdykIMi781lKpIz94Y0DmL4jFtGleZ1L88Q607ZQL/YVH08Ixo93t0RMWmGAvKit996oCHthvZuSXR1vJRWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761416; c=relaxed/simple;
	bh=7rEn55U0ZdgPfLGcvK/xdhIvQ2V/IWflEuV3Jk766z0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YKRQvZVDcPwwSogCHO4zL2ArxfpJOauRWkaWflYsoQMgLDgj6TKP4jwJmev7zoMm5K68d+Xah0PYdA2iywhAE/9F4t6MS4MZLsqDcNgtHe/PISbTdmXZWBBANt4+m+2D7UrfKbkJbY3+NWkTGRa5XU0H78h5xpkfZHJ+y+F3/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EI7Ctg8e; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739761404; h=Message-ID:Subject:Date:From:To;
	bh=zE3PvSp3X2aonXMiOvGA+6M5i7UY66TkNmLjcndbkA8=;
	b=EI7Ctg8eoveBK12cqXrWOJKbG7pSEtoKBJ/qehqXfeE+nEKyzP+a4dqnYvBY51HvmqPG8g7y7YXkBL0vi9ke2Mj7KuQf1+emZ8YFRhKWnLyeEhsm/SfHBPOYDb+yl9zgcc0Bz8TO11HFtBsNBl8/8Rm1qPEN0I08pwbD8SE8Z+k=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WPYJKFW_1739761403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 11:03:23 +0800
Message-ID: <1739761322.950906-1-xuanzhuo@linux.alibaba.com>
Subject: Re: drivers/net/virtio_net.c:1227 xsk_append_merge_buffer() warn: unsigned '_x' is never less than zero.
Date: Mon, 17 Feb 2025 11:02:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <202502161158.KmluxANz-lkp@intel.com>
In-Reply-To: <202502161158.KmluxANz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sun, 16 Feb 2025 11:13:14 +0800, kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   496659003dac5d08ea292c44fce9dfb36fa34691
> commit: 99c861b44eb1fb9dfe8776854116a6a9064c19bb virtio_net: xsk: rx: support recv merge mode
> date:   7 months ago
> config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250216/202502161158.KmluxANz-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 14.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502161158.KmluxANz-lkp@intel.com/
>
> New smatch warnings:
> drivers/net/virtio_net.c:1227 xsk_append_merge_buffer() warn: unsigned '_x' is never less than zero.

This seems to be in the mm system.

Thanks.


>
> Old smatch warnings:
> include/linux/mm.h:1311 virt_to_head_page() warn: unsigned '_x' is never less than zero.
> include/linux/scatterlist.h:189 sg_set_buf() warn: unsigned '_x' is never less than zero.
> drivers/net/virtio_net.c:1934 build_skb_from_xdp_buff() error: uninitialized symbol 'nr_frags'.
> drivers/net/virtio_net.c:2016 virtnet_build_xdp_buff_mrg() error: uninitialized symbol 'shinfo'.
> drivers/net/virtio_net.c:5096 virtnet_update_settings() error: uninitialized symbol 'virtio_cread_v'.
> drivers/net/virtio_net.c:5804 virtnet_config_changed_work() error: uninitialized symbol 'virtio_cread_v'.
> drivers/net/virtio_net.c:5808 virtnet_config_changed_work() error: uninitialized symbol 'v'.
>
> vim +/_x +1227 drivers/net/virtio_net.c
>
>   1184
>   1185	static int xsk_append_merge_buffer(struct virtnet_info *vi,
>   1186					   struct receive_queue *rq,
>   1187					   struct sk_buff *head_skb,
>   1188					   u32 num_buf,
>   1189					   struct virtio_net_hdr_mrg_rxbuf *hdr,
>   1190					   struct virtnet_rq_stats *stats)
>   1191	{
>   1192		struct sk_buff *curr_skb;
>   1193		struct xdp_buff *xdp;
>   1194		u32 len, truesize;
>   1195		struct page *page;
>   1196		void *buf;
>   1197
>   1198		curr_skb = head_skb;
>   1199
>   1200		while (--num_buf) {
>   1201			buf = virtqueue_get_buf(rq->vq, &len);
>   1202			if (unlikely(!buf)) {
>   1203				pr_debug("%s: rx error: %d buffers out of %d missing\n",
>   1204					 vi->dev->name, num_buf,
>   1205					 virtio16_to_cpu(vi->vdev,
>   1206							 hdr->num_buffers));
>   1207				DEV_STATS_INC(vi->dev, rx_length_errors);
>   1208				return -EINVAL;
>   1209			}
>   1210
>   1211			u64_stats_add(&stats->bytes, len);
>   1212
>   1213			xdp = buf_to_xdp(vi, rq, buf, len);
>   1214			if (!xdp)
>   1215				goto err;
>   1216
>   1217			buf = napi_alloc_frag(len);
>   1218			if (!buf) {
>   1219				xsk_buff_free(xdp);
>   1220				goto err;
>   1221			}
>   1222
>   1223			memcpy(buf, xdp->data - vi->hdr_len, len);
>   1224
>   1225			xsk_buff_free(xdp);
>   1226
> > 1227			page = virt_to_page(buf);
>   1228
>   1229			truesize = len;
>   1230
>   1231			curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>   1232							    buf, len, truesize);
>   1233			if (!curr_skb) {
>   1234				put_page(page);
>   1235				goto err;
>   1236			}
>   1237		}
>   1238
>   1239		return 0;
>   1240
>   1241	err:
>   1242		xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
>   1243		return -EINVAL;
>   1244	}
>   1245
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

