Return-Path: <linux-kernel+bounces-263439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A790493D5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AA8284518
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCE178CC8;
	Fri, 26 Jul 2024 15:19:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114B21103;
	Fri, 26 Jul 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007145; cv=none; b=EqQ6kVBNd1oXCnzQMuoa3nCns2d8OGkcISLZP9vwaXDtbQ9TKVAOCAy5w2XonVZNG6V2S98uwjFvTACAiq2iutAWkFx3PwxgPZBMiVOQuMBX8YTF4ZTnFZL7SXdF1CP5j3ejVjWLUiUNww7EOWSNxzYDcanc7x6jwKvVoHgEjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007145; c=relaxed/simple;
	bh=jhyqHZ9A0JXwf8Jkr9SULQxpLu3Omt2PfY0yXjOJdAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKdL5ycBwQI2mI6ISj+wkTGh7jHZI2kU5K2oIZP4gdYQ2q8tB6m3kmzO6hNArsJV7ztH2f+J9jk0K/b9DUjrGV1Ww4OHsefcsAyX2LHEkLzaxKz/2aK7fDN0OVFp6Lvopwev3NzLdgyckg1+9C5t+vW83vZs3ztWenHMO9mgppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02EB11007;
	Fri, 26 Jul 2024 08:19:29 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35A53F73F;
	Fri, 26 Jul 2024 08:19:00 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:18:58 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, quic_nkela@quicinc.com, ptosi@google.com,
	dan.carpenter@linaro.org, souvik.chakravarty@arm.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
Message-ID: <ZqO-Yhemgp-nsnGu@pluto>
References: <20240710173153.4060457-2-cristian.marussi@arm.com>
 <202407130355.IWguWKJm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407130355.IWguWKJm-lkp@intel.com>

On Sat, Jul 13, 2024 at 03:44:38AM +0800, kernel test robot wrote:
> Hi Cristian,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on soc/for-next]
> [also build test WARNING on next-20240712]
> [cannot apply to linus/master v6.10-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Introduce-setup_shmem_iomap/20240711-062033
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20240710173153.4060457-2-cristian.marussi%40arm.com
> patch subject: [PATCH v2 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
> config: arm64-randconfig-r132-20240712 (https://download.01.org/0day-ci/archive/20240713/202407130355.IWguWKJm-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce: (https://download.01.org/0day-ci/archive/20240713/202407130355.IWguWKJm-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407130355.IWguWKJm-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/firmware/arm_scmi/shmem.c:153:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>    drivers/firmware/arm_scmi/shmem.c:153:31: sparse:     expected void [noderef] __iomem *
>    drivers/firmware/arm_scmi/shmem.c:153:31: sparse:     got void *
>    drivers/firmware/arm_scmi/shmem.c:156:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>    drivers/firmware/arm_scmi/shmem.c:156:31: sparse:     expected void [noderef] __iomem *
>    drivers/firmware/arm_scmi/shmem.c:156:31: sparse:     got void *
>    drivers/firmware/arm_scmi/shmem.c:165:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>    drivers/firmware/arm_scmi/shmem.c:165:31: sparse:     expected void [noderef] __iomem *
>    drivers/firmware/arm_scmi/shmem.c:165:31: sparse:     got void *
>    drivers/firmware/arm_scmi/shmem.c:172:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>    drivers/firmware/arm_scmi/shmem.c:172:31: sparse:     expected void [noderef] __iomem *
>    drivers/firmware/arm_scmi/shmem.c:172:31: sparse:     got void *
> 
> vim +153 drivers/firmware/arm_scmi/shmem.c
> 
>    138	
>    139	void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo,
>    140					struct device *dev, bool tx,
>    141					struct resource *res)
>    142	{
>    143		struct device_node *shmem __free(device_node);
>    144		const char *desc = tx ? "Tx" : "Rx";
>    145		int ret, idx = tx ? 0 : 1;
>    146		struct device *cdev = cinfo->dev;
>    147		struct resource lres = {};
>    148		resource_size_t size;
>    149		void __iomem *addr;
>    150	
>    151		shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
>    152		if (!shmem)
>  > 153			return ERR_PTR(-ENODEV);
> 

Will be fixed in V3 using IOMEM_ERR_PTR()

Thanks,
Cristian

