Return-Path: <linux-kernel+bounces-381247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0581D9AFC79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66967B24A58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A2A1D1738;
	Fri, 25 Oct 2024 08:26:24 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489EF1D0E28
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844783; cv=none; b=TaunpGO9NPhIu1wYUAAgkrBypUe3BQucC5WOdcUizZnogR616+vK61beQgw4i8vxOcE8bDee+2CnDGyPWPoVkGLPi8lgnD2sQalxxHc8TC//cWULH/xSuvbyd5do82bef148YOOeQ0AysYltq9AOdunl9HX5UoRa/C2zfMVuFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844783; c=relaxed/simple;
	bh=/RanIQPlr/Us9s7VWWqUqOTagS90ewt3Ir1W5ak3Ze0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kN0tBtgCEDac/R7DsDRAh8OV65onwB/2crG70DfDw1iRbY9EYkH74bZJUk69y8W0TNSk4Qqg621gxPOXryofzF+DVP1iVBYimVw6T0Cel/rTVT0+3dZPo7/Qtb7VodsakO3i2T74JvjD78iobTl+ujBI+JVA2pZIn/fYF3AMwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XZbTk02jwz1ynf8;
	Fri, 25 Oct 2024 16:26:18 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 567961A0188;
	Fri, 25 Oct 2024 16:26:10 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 16:26:09 +0800
Message-ID: <ec505433-3929-4a17-b875-198edab3066a@huawei.com>
Date: Fri, 25 Oct 2024 16:26:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:645
 mt7925_load_clc() error: buffer overflow 'phy->clc' 2 <= 2
To: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
CC: <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>
References: <e3c426c9-c3d0-4b72-b2db-8780d61b1583@stanley.mountain>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <e3c426c9-c3d0-4b72-b2db-8780d61b1583@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/10/25 15:36, Dan Carpenter 写道:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4e46774408d942efe4eb35dc62e5af3af71b9a30
> commit: 9679ca7326e52282cc923c4d71d81c999cb6cd55 wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc
> config: parisc-randconfig-r071-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250608.Ly4Aj2NI-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410250608.Ly4Aj2NI-lkp@intel.com/
> 
> New smatch warnings:
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:645 mt7925_load_clc() error: buffer overflow 'phy->clc' 2 <= 2
> 
> Old smatch warnings:
> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1158 mt7925_mcu_set_mlo_roc() warn: variable dereferenced before check 'mconf' (see line 1130)
> 
> vim +645 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> 
> c948b5da6bbec7 Deren Wu       2023-09-18  589  static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
> c948b5da6bbec7 Deren Wu       2023-09-18  590  {
> c948b5da6bbec7 Deren Wu       2023-09-18  591  	const struct mt76_connac2_fw_trailer *hdr;
> c948b5da6bbec7 Deren Wu       2023-09-18  592  	const struct mt76_connac2_fw_region *region;
> c948b5da6bbec7 Deren Wu       2023-09-18  593  	const struct mt7925_clc *clc;
> c948b5da6bbec7 Deren Wu       2023-09-18  594  	struct mt76_dev *mdev = &dev->mt76;
> c948b5da6bbec7 Deren Wu       2023-09-18  595  	struct mt792x_phy *phy = &dev->phy;
> c948b5da6bbec7 Deren Wu       2023-09-18  596  	const struct firmware *fw;
> c948b5da6bbec7 Deren Wu       2023-09-18  597  	int ret, i, len, offset = 0;
> c948b5da6bbec7 Deren Wu       2023-09-18  598  	u8 *clc_base = NULL;
> c948b5da6bbec7 Deren Wu       2023-09-18  599
> c948b5da6bbec7 Deren Wu       2023-09-18  600  	if (mt7925_disable_clc ||
> c948b5da6bbec7 Deren Wu       2023-09-18  601  	    mt76_is_usb(&dev->mt76))
> c948b5da6bbec7 Deren Wu       2023-09-18  602  		return 0;
> c948b5da6bbec7 Deren Wu       2023-09-18  603
> c948b5da6bbec7 Deren Wu       2023-09-18  604  	ret = request_firmware(&fw, fw_name, mdev->dev);
> c948b5da6bbec7 Deren Wu       2023-09-18  605  	if (ret)
> c948b5da6bbec7 Deren Wu       2023-09-18  606  		return ret;
> c948b5da6bbec7 Deren Wu       2023-09-18  607
> c948b5da6bbec7 Deren Wu       2023-09-18  608  	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
> c948b5da6bbec7 Deren Wu       2023-09-18  609  		dev_err(mdev->dev, "Invalid firmware\n");
> c948b5da6bbec7 Deren Wu       2023-09-18  610  		ret = -EINVAL;
> c948b5da6bbec7 Deren Wu       2023-09-18  611  		goto out;
> c948b5da6bbec7 Deren Wu       2023-09-18  612  	}
> c948b5da6bbec7 Deren Wu       2023-09-18  613
> c948b5da6bbec7 Deren Wu       2023-09-18  614  	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
> c948b5da6bbec7 Deren Wu       2023-09-18  615  	for (i = 0; i < hdr->n_region; i++) {
> c948b5da6bbec7 Deren Wu       2023-09-18  616  		region = (const void *)((const u8 *)hdr -
> c948b5da6bbec7 Deren Wu       2023-09-18  617  					(hdr->n_region - i) * sizeof(*region));
> c948b5da6bbec7 Deren Wu       2023-09-18  618  		len = le32_to_cpu(region->len);
> c948b5da6bbec7 Deren Wu       2023-09-18  619
> c948b5da6bbec7 Deren Wu       2023-09-18  620  		/* check if we have valid buffer size */
> c948b5da6bbec7 Deren Wu       2023-09-18  621  		if (offset + len > fw->size) {
> c948b5da6bbec7 Deren Wu       2023-09-18  622  			dev_err(mdev->dev, "Invalid firmware region\n");
> c948b5da6bbec7 Deren Wu       2023-09-18  623  			ret = -EINVAL;
> c948b5da6bbec7 Deren Wu       2023-09-18  624  			goto out;
> c948b5da6bbec7 Deren Wu       2023-09-18  625  		}
> c948b5da6bbec7 Deren Wu       2023-09-18  626
> c948b5da6bbec7 Deren Wu       2023-09-18  627  		if ((region->feature_set & FW_FEATURE_NON_DL) &&
> c948b5da6bbec7 Deren Wu       2023-09-18  628  		    region->type == FW_TYPE_CLC) {
> c948b5da6bbec7 Deren Wu       2023-09-18  629  			clc_base = (u8 *)(fw->data + offset);
> c948b5da6bbec7 Deren Wu       2023-09-18  630  			break;
> c948b5da6bbec7 Deren Wu       2023-09-18  631  		}
> c948b5da6bbec7 Deren Wu       2023-09-18  632  		offset += len;
> c948b5da6bbec7 Deren Wu       2023-09-18  633  	}
> c948b5da6bbec7 Deren Wu       2023-09-18  634
> c948b5da6bbec7 Deren Wu       2023-09-18  635  	if (!clc_base)
> c948b5da6bbec7 Deren Wu       2023-09-18  636  		goto out;
> c948b5da6bbec7 Deren Wu       2023-09-18  637
> c948b5da6bbec7 Deren Wu       2023-09-18  638  	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
> c948b5da6bbec7 Deren Wu       2023-09-18  639  		clc = (const struct mt7925_clc *)(clc_base + offset);
> c948b5da6bbec7 Deren Wu       2023-09-18  640
> 9679ca7326e522 Ming Yen Hsieh 2024-08-19  641  		if (clc->idx > ARRAY_SIZE(phy->clc))
> 
> This should be >= instead of >.
> 
> 9679ca7326e522 Ming Yen Hsieh 2024-08-19  642  			break;
> 9679ca7326e522 Ming Yen Hsieh 2024-08-19  643
> c948b5da6bbec7 Deren Wu       2023-09-18  644  		/* do not init buf again if chip reset triggered */
> c948b5da6bbec7 Deren Wu       2023-09-18 @645  		if (phy->clc[clc->idx])
> c948b5da6bbec7 Deren Wu       2023-09-18  646  			continue;
> c948b5da6bbec7 Deren Wu       2023-09-18  647
> c948b5da6bbec7 Deren Wu       2023-09-18  648  		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
> c948b5da6bbec7 Deren Wu       2023-09-18  649  						  le32_to_cpu(clc->len),
> c948b5da6bbec7 Deren Wu       2023-09-18  650  						  GFP_KERNEL);
> c948b5da6bbec7 Deren Wu       2023-09-18  651
> c948b5da6bbec7 Deren Wu       2023-09-18  652  		if (!phy->clc[clc->idx]) {
> c948b5da6bbec7 Deren Wu       2023-09-18  653  			ret = -ENOMEM;
> c948b5da6bbec7 Deren Wu       2023-09-18  654  			goto out;
> c948b5da6bbec7 Deren Wu       2023-09-18  655  		}
> c948b5da6bbec7 Deren Wu       2023-09-18  656  	}
> c948b5da6bbec7 Deren Wu       2023-09-18  657
> c948b5da6bbec7 Deren Wu       2023-09-18  658  	ret = mt7925_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
> c948b5da6bbec7 Deren Wu       2023-09-18  659  out:
> c948b5da6bbec7 Deren Wu       2023-09-18  660  	release_firmware(fw);
> c948b5da6bbec7 Deren Wu       2023-09-18  661
> c948b5da6bbec7 Deren Wu       2023-09-18  662  	return ret;
> c948b5da6bbec7 Deren Wu       2023-09-18  663  }
> 

Hi, Dan,

The issue is obvious here. Will send a fix soon.

Thanks,
Zekun

