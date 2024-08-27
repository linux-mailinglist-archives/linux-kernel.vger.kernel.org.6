Return-Path: <linux-kernel+bounces-302546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47396000F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57D42816D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65E1B977;
	Tue, 27 Aug 2024 03:52:23 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B62E62C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730743; cv=none; b=Zh8yY0MFGRgu4dFZUR0AvHJaMJ+aDNaw4pZ3F7VgkC/0FcSfoDpLPfF/+qmVNkUIKXUuZ33reBTInY072peokpMI6g5O1zmDG7ZOGozjCXOGDCjnfeTP/Q6EZ15lOO/cg70QvujnUvVpAEIl1+67ddpk1prW8XZ6AabhYIGDJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730743; c=relaxed/simple;
	bh=6dLZqVfRHKNUGkoyZ6J9Cx4oIeOYqXbtyGtGQI4VuZo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Odnwu12DmCFPZszmsLFCZfr1pw9pRhnPMZuEoKor4XQAAa5Ll3gSQ9R8051OyDqa8ehsd+bP9MRXOebNG2AhkYedBk1U0v5rOzIPHI6cT1ty7vRop1CCevS6FmNMDy8m8OK7kmuLl/qfP2O2fkitswwomeZ643t3L7i7hpfiTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtD9n2Ptkz13k4s;
	Tue, 27 Aug 2024 11:51:25 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id C68A1180105;
	Tue, 27 Aug 2024 11:52:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 11:52:10 +0800
Subject: Re: [PATCH] mtd: ubi: remove unused parameter 'pnum' from
 add_volume()
To: kernel test robot <lkp@intel.com>, Wang Zhaolong
	<wangzhaolong1@huawei.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
	<vigneshr@ti.com>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
References: <20240825083515.4074081-1-wangzhaolong1@huawei.com>
 <202408271041.ttLMjF8z-lkp@intel.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <8e511b87-f8e2-7e95-f212-5f2dd318c234@huawei.com>
Date: Tue, 27 Aug 2024 11:52:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202408271041.ttLMjF8z-lkp@intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/8/27 11:26, kernel test robot Ð´µÀ:
> Hi Wang,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on rw-ubifs/next]
> [also build test WARNING on rw-ubifs/fixes linus/master v6.11-rc5 next-20240826]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Zhaolong/mtd-ubi-remove-unused-parameter-pnum-from-add_volume/20240826-142424
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git next
> patch link:    https://lore.kernel.org/r/20240825083515.4074081-1-wangzhaolong1%40huawei.com
> patch subject: [PATCH] mtd: ubi: remove unused parameter 'pnum' from add_volume()
> config: i386-buildonly-randconfig-005-20240827 (https://download.01.org/0day-ci/archive/20240827/202408271041.ttLMjF8z-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271041.ttLMjF8z-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408271041.ttLMjF8z-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/mtd/ubi/attach.c:398: warning: Excess function parameter 'pnum' description in 'add_volume'
> 
> 
> vim +398 drivers/mtd/ubi/attach.c
> 
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  382
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  383  /**
> a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  384   * add_volume - add volume to the attaching information.
> a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  385   * @ai: attaching information
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  386   * @vol_id: ID of the volume to add
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  387   * @pnum: physical eraseblock number

Hi ZhaoLong, you need to remove the parameter description from comments too.

> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  388   * @vid_hdr: volume identifier header
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  389   *
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  390   * If the volume corresponding to the @vid_hdr logical eraseblock is already
> a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  391   * present in the attaching information, this function does nothing. Otherwise
> a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  392   * it adds corresponding volume to the attaching information. Returns a pointer
> fbd0107f4d33be0 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  393   * to the allocated "av" object in case of success and a negative error code in
> fbd0107f4d33be0 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  394   * case of failure.
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  395   */
> beba9855702e14c drivers/mtd/ubi/attach.c Wang Zhaolong       2024-08-25  396  static struct ubi_ainf_volume *add_volume(struct ubi_attach_info *ai, int vol_id,
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  397  					  const struct ubi_vid_hdr *vid_hdr)
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27 @398  {
> 517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  399  	struct ubi_ainf_volume *av;
> de4c455b3e9f630 drivers/mtd/ubi/attach.c Boris Brezillon     2016-09-16  400  	bool created;
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  401
> 3261ebd7d4194ff drivers/mtd/ubi/scan.c   Christoph Hellwig   2007-05-21  402  	ubi_assert(vol_id == be32_to_cpu(vid_hdr->vol_id));
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  403
> de4c455b3e9f630 drivers/mtd/ubi/attach.c Boris Brezillon     2016-09-16  404  	av = ubi_find_or_add_av(ai, vol_id, &created);
> de4c455b3e9f630 drivers/mtd/ubi/attach.c Boris Brezillon     2016-09-16  405  	if (IS_ERR(av) || !created)
> 517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  406  		return av;
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  407
> 517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  408  	av->used_ebs = be32_to_cpu(vid_hdr->used_ebs);
> 517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  409  	av->data_pad = be32_to_cpu(vid_hdr->data_pad);
> 517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  410  	av->compat = vid_hdr->compat;
> 517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  411  	av->vol_type = vid_hdr->vol_type == UBI_VID_DYNAMIC ? UBI_DYNAMIC_VOLUME
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  412  							    : UBI_STATIC_VOLUME;
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  413
> 517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  414  	return av;
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  415  }
> 801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  416
> 


