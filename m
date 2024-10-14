Return-Path: <linux-kernel+bounces-363792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1D99C71A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336F31C2271F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C2D15B972;
	Mon, 14 Oct 2024 10:25:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5415B143
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901512; cv=none; b=AD1ZxnjGehI7U1peGCPJRCno50vyPslrC4aWogQI2+KsjJlA4nbEMy5tPTrK/11SCn0hmxEz5pMmdABiLNj+XC8DVTyHG9Y39UIfTw27iT32TD0UAKGpidw4H7f+mJE1PKvecfs0Q4KCJaetUUAt/LvOzki+ZkDBQWnCJuLxFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901512; c=relaxed/simple;
	bh=CNygW/kkl9Igu70pgOcFfZSUKNxhD6nc465LoHDKeIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG9Df97wWPEnSfju3CCwF6aoYWFCf0TTclmKZ8uabl4y0c08gL6BsMiwUDVM3vNLVT9B/xTtAQP/bo3D7FCO5qWMjIjgtDJJ6Uv2iQILSKgDtBwUINoarG0LAXyl5u8MpVfKL2q97a9NrsDvA951cpK4BdI7NCruiPUdSmHHRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 677C41007;
	Mon, 14 Oct 2024 03:25:38 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC0DD3F51B;
	Mon, 14 Oct 2024 03:25:07 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:24:47 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: drivers/firmware/arm_scmi/raw_mode.c:924:8-24: WARNING:
 scmi_dbg_raw_mode_reset_fops: .write() has stream semantic; safe to change
 nonseekable_open -> stream_open. (fwd)
Message-ID: <Zwzxb9K3FzbqVy9t@pluto>
References: <1bb364cc-d167-4ef8-9d94-29b1774068f8@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb364cc-d167-4ef8-9d94-29b1774068f8@inria.fr>

On Wed, Oct 02, 2024 at 09:36:51AM +0200, Julia Lawall wrote:
> Hello,
> 
> I'm just forwarding this for your consideration. I don't know about this
> issue.
> 

Hi Julia,

thanks for letting me know and sorry for the delay in this answer...
...I'll have a look at this soon(-ish)

Thanks,
Cristian

> julia
> 
> ---------- Forwarded message ----------
> Date: Wed, 2 Oct 2024 05:16:38 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: drivers/firmware/arm_scmi/raw_mode.c:924:8-24: WARNING:
>     scmi_dbg_raw_mode_reset_fops: .write() has stream semantic; safe to change
>     nonseekable_open -> stream_open.
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: linux-kernel@vger.kernel.org
> TO: Cristian Marussi <cristian.marussi@arm.com>
> CC: Sudeep Holla <sudeep.holla@arm.com>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> commit: b70c7996d4ffb2e02895132e8a79a37cee66504f firmware: arm_scmi: Make raw debugfs entries non-seekable
> date:   6 months ago
> :::::: branch date: 25 hours ago
> :::::: commit date: 6 months ago
> config: arm64-randconfig-r053-20241001 (https://download.01.org/0day-ci/archive/20241002/202410020543.MuCto6Eo-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202410020543.MuCto6Eo-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/firmware/arm_scmi/raw_mode.c:924:8-24: WARNING: scmi_dbg_raw_mode_reset_fops: .write() has stream semantic; safe to change nonseekable_open -> stream_open.
> 
> vim +924 drivers/firmware/arm_scmi/raw_mode.c
> 
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  886
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  887  static int scmi_dbg_raw_mode_open(struct inode *inode, struct file *filp)
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  888  {
> 7860701d1e6e6e Cristian Marussi 2023-01-18  889  	u8 id;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  890  	struct scmi_raw_mode_info *raw;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  891  	struct scmi_dbg_raw_data *rd;
> 7860701d1e6e6e Cristian Marussi 2023-01-18  892  	const char *id_str = filp->f_path.dentry->d_parent->d_name.name;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  893
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  894  	if (!inode->i_private)
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  895  		return -ENODEV;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  896
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  897  	raw = inode->i_private;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  898  	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  899  	if (!rd)
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  900  		return -ENOMEM;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  901
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  902  	rd->rx.len = raw->desc->max_msg_size + sizeof(u32);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  903  	rd->rx.buf = kzalloc(rd->rx.len, GFP_KERNEL);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  904  	if (!rd->rx.buf) {
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  905  		kfree(rd);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  906  		return -ENOMEM;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  907  	}
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  908
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  909  	rd->tx.len = raw->desc->max_msg_size + sizeof(u32);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  910  	rd->tx.buf = kzalloc(rd->tx.len, GFP_KERNEL);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  911  	if (!rd->tx.buf) {
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  912  		kfree(rd->rx.buf);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  913  		kfree(rd);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  914  		return -ENOMEM;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  915  	}
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  916
> 7860701d1e6e6e Cristian Marussi 2023-01-18  917  	/* Grab channel ID from debugfs entry naming if any */
> 7860701d1e6e6e Cristian Marussi 2023-01-18  918  	if (!kstrtou8(id_str, 16, &id))
> 7860701d1e6e6e Cristian Marussi 2023-01-18  919  		rd->chan_id = id;
> 7860701d1e6e6e Cristian Marussi 2023-01-18  920
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  921  	rd->raw = raw;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  922  	filp->private_data = rd;
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  923
> b70c7996d4ffb2 Cristian Marussi 2024-03-15 @924  	return nonseekable_open(inode, filp);
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  925  }
> 3c3d818a9317a5 Cristian Marussi 2023-01-18  926
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

