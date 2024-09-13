Return-Path: <linux-kernel+bounces-329007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D52978BFA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12DC1C24FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640E3185955;
	Fri, 13 Sep 2024 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTfV6vf+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22EB26289;
	Fri, 13 Sep 2024 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271376; cv=none; b=lL2BgvT2N6+RjqGkdqQ43AZZUapRLhiUY/zKag/bqsiLHfnqeXaXHGnvd+kjTu30bZ5bAfvhBQtHRcmqyUfgsDQQN5H1AYrm3MomrXRRWY2F8RiXD+lG7AL01eAll+thHdTlhD5fyf2TDuQ3aGuc1hCoLdXPZ72dOUtDDenxr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271376; c=relaxed/simple;
	bh=NO2v2utJsQdzPh+GQrcc+a4HtuBy0op5OsmeF8R9gWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueIIBLKu9WY+m70GbEeZXYpVfkQoL0nMUSJg9m70VajpwWAaVP76IJhwyAMSgCWmMTUkaeJ+ifx/8+a+exUCGGb865VuC0AHMVjO4wS9H2W5shmfp247ocdJWn6ELtaGNnaW7dVgcJOVrFBO0XLsx1NMa3ir4zon4kTJKDN7NU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTfV6vf+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726271375; x=1757807375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NO2v2utJsQdzPh+GQrcc+a4HtuBy0op5OsmeF8R9gWI=;
  b=PTfV6vf+w5qBs2eIb0t5qg4j/m5ixmDd3XRcuyTzVwnMwZm002iQiTLh
   S0KE6WpVdt2lC24qhLU9Kebu+vCP0ynqZr6d/Qqg0ZHOsPacCiRvvAFS5
   y3jqzfA8cHe5iKhXKfUvT6vBCESTTItWpybJc1bLU0msBI9rJcRjwRSTh
   CI2yJMu+UT4F5DL94xwn7jWGR4lTnQx6Fp0Wrj0SFhNLUDTRBdwGuJBWU
   XEjtQHpyL5AcyGBUxzjbMnnCpaFylextBaHPTcNXL8qOoZtw/CoqExv43
   KjSlSe9Ibowt+nwEjhkI+QZBGLEd7bkQ/TxEC+pIKtp0N1x8AANXr2ZiF
   A==;
X-CSE-ConnectionGUID: lnzP+/eAS02VVDs1KAskNA==
X-CSE-MsgGUID: HxnItlhBSDSI9fMxsIB8EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25311619"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25311619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 16:49:34 -0700
X-CSE-ConnectionGUID: tm56/a9ST0O+NtQ8axKrsg==
X-CSE-MsgGUID: v2Wr+VnwS7uiDWleXfcRHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="105688913"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Sep 2024 16:49:32 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spG2b-00079G-1s;
	Fri, 13 Sep 2024 23:49:29 +0000
Date: Sat, 14 Sep 2024 07:49:14 +0800
From: kernel test robot <lkp@intel.com>
To: Wenliang <wenliang202407@163.com>, linux@roeck-us.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wenliang <wenliang202407@163.com>
Subject: Re: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
Message-ID: <202409140727.4pErU6oc-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240914/202409140727.4pErU6oc-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140727.4pErU6oc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140727.4pErU6oc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hwmon/sq52205.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/hwmon/sq52205.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/hwmon/sq52205.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/hwmon/sq52205.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/hwmon/sq52205.c:493:37: error: cannot assign to variable 'sq522xx_regmap_config' with const-qualified type 'const struct regmap_config'
     493 |         sq522xx_regmap_config.max_register = data->config->registers;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/hwmon/sq52205.c:67:35: note: variable 'sq522xx_regmap_config' declared const here
      67 | static const struct regmap_config sq522xx_regmap_config = {
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
      68 |         .reg_bits = 8,
         |         ~~~~~~~~~~~~~~
      69 |         .val_bits = 16,
         |         ~~~~~~~~~~~~~~~
      70 | };
         | ~
   7 warnings and 1 error generated.


vim +493 drivers/hwmon/sq52205.c

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

