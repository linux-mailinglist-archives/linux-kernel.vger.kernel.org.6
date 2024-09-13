Return-Path: <linux-kernel+bounces-327614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71673977859
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6B1F25CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC71A4E86;
	Fri, 13 Sep 2024 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpksQqTz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28B17D377;
	Fri, 13 Sep 2024 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205380; cv=none; b=ofhxlScYoxF10EyWHAmUebivxEXSbsOkOJ/bmf7lK/L1sCdIqlaakpaW/Z0W5DxHS/xfEQpEXKbXCIEZhjFk9tRwdT8CzKtHldIuV218C7R+DUmlJVRPUnzmZrNDnVFqDlFtKrefkEfLgbDYQ49FCershsBIWB3KrsG/eaA8f04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205380; c=relaxed/simple;
	bh=5R5XaxTZbPrsH411hnN/29R+a8+Lk8LpNL0Ge4qRBwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFk5sRSotXqNrpu7Z2fsujhLQDzjp1oa5R0wavCdYGqurQQ15P0Rgg9LY1I0fO53BThEWnvL5XxDOLVUPqpQmCf+iKkkc6pap6uYUmF2Oav6mVSB5isTs3+O1qEH27el8hzfaErrTiazZLBPgmzbmUC8ek5BsFemYJHrmZ6/sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpksQqTz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726205378; x=1757741378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5R5XaxTZbPrsH411hnN/29R+a8+Lk8LpNL0Ge4qRBwQ=;
  b=bpksQqTzZerHPYIwdraqgFRXeac9rohYkiLRczHm4zaUq+F9rB7y99jU
   ld22K6Yoihl9oTEfOi+FFMppHwjbs1pN0sqo8OMpvknUrnQTKJRItuZfs
   kLMLtUSgX8E2PXXwR8eDatkP9j+5NMZ9PDMFM/e2mhuu+SK1FsKh1dq3q
   D4jFaBrnpbJR0b5hOk+TwOWwB+csVKsk4h3it/gGUAZmUc1K4unHaxWdU
   q6GKItwMzy8rVsudLq9BfXJ/tBa2VPJ9M4LnL+teyEOOP3EXa9M09R81l
   q5xHHDeJfUxaEkqh8FtVCQDj+5wJ/YSlWDT7Qs4ekccbBMr01yfY4o9Eb
   A==;
X-CSE-ConnectionGUID: RHr3juOMSPmNY5RUUSDlRg==
X-CSE-MsgGUID: IBMuq5uZRj6SweLBcQNHqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25190253"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25190253"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:29:36 -0700
X-CSE-ConnectionGUID: SFWThGLxT8uu6phGmNFlIw==
X-CSE-MsgGUID: o02l+adqSz+fVPIA//19Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72047678"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Sep 2024 22:29:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soys8-00062m-2g;
	Fri, 13 Sep 2024 05:29:32 +0000
Date: Fri, 13 Sep 2024 13:29:20 +0800
From: kernel test robot <lkp@intel.com>
To: Wenliang <wenliang202407@163.com>, linux@roeck-us.net
Cc: oe-kbuild-all@lists.linux.dev, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wenliang <wenliang202407@163.com>
Subject: Re: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
Message-ID: <202409131320.Ne0lQtTj-lkp@intel.com>
References: <20240822074426.7241-1-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822074426.7241-1-wenliang202407@163.com>

Hi Wenliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenliang/hwmon-add-new-hwmon-driver-sq52205/20240912-002906
base:   linux/master
patch link:    https://lore.kernel.org/r/20240822074426.7241-1-wenliang202407%40163.com
patch subject: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
config: openrisc-randconfig-r072-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131320.Ne0lQtTj-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131320.Ne0lQtTj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131320.Ne0lQtTj-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/sq52205.c: In function 'sq522xx_probe':
>> drivers/hwmon/sq52205.c:493:44: error: assignment of member 'max_register' in read-only object
     493 |         sq522xx_regmap_config.max_register = data->config->registers;
         |                                            ^


vim +/max_register +493 drivers/hwmon/sq52205.c

   460	
   461	static int sq522xx_probe(struct i2c_client *client)
   462	{
   463		struct device *dev = &client->dev;
   464		struct sq522xx_data *data;
   465		struct device *hwmon_dev;
   466		u32 val;
   467		int ret, group = 0;
   468		enum sq522xx_ids chip;
   469	
   470		if (client->dev.of_node)
   471			chip = (uintptr_t)of_device_get_match_data(&client->dev);
   472		else
   473			chip = i2c_match_id(sq522xx_id, client)->driver_data;
   474	
   475		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
   476		if (!data)
   477			return -ENOMEM;
   478	
   479		/* set the device type */
   480		data->client = client;
   481		data->config = &sq522xx_config[chip];
   482		mutex_init(&data->config_lock);
   483	
   484		if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0)
   485			val = SQ522XX_RSHUNT_DEFAULT;
   486	
   487	
   488		if (val <= 0 || val > data->config->calibration_factor)
   489			return -ENODEV;
   490	
   491		data->rshunt = val;
   492	
 > 493		sq522xx_regmap_config.max_register = data->config->registers;
   494	
   495		data->regmap = devm_regmap_init_i2c(client, &sq522xx_regmap_config);
   496		if (IS_ERR(data->regmap)) {
   497			dev_err(dev, "failed to allocate register map\n");
   498			return PTR_ERR(data->regmap);
   499		}
   500	
   501	
   502		ret = sq522xx_init(data);
   503		if (ret < 0) {
   504			dev_err(dev, "error configuring the device: %d\n", ret);
   505			return -ENODEV;
   506		}
   507		if (chip == sq52205) {
   508			ret = sq52205_init(data);
   509			if (ret < 0) {
   510				dev_err(dev, "error configuring the device cal: %d\n", ret);
   511				return -ENODEV;
   512			}
   513		}
   514	
   515		data->groups[group++] = &sq522xx_group;
   516		if (chip == sq52205)
   517			data->groups[group++] = &sq52205_group;
   518	
   519		hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
   520									data, data->groups);
   521		if (IS_ERR(hwmon_dev))
   522			return PTR_ERR(hwmon_dev);
   523	
   524		dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
   525			 client->name, data->rshunt);
   526	
   527		return 0;
   528	}
   529	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

