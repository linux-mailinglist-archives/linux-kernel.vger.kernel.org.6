Return-Path: <linux-kernel+bounces-391186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F59B8398
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1631C20B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FF1CB534;
	Thu, 31 Oct 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RC2i6KEI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242913C3C2;
	Thu, 31 Oct 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403829; cv=none; b=lDx1AF0r/MVQWSedbhALJnJAuEY5mSxdAjDRHDMhpo/BWiqbz18RJG24Slum+mc+Kq1qXAbjr3Zectoxba1FHKPuO+wng2Qit5bB9pFBpJbmcQbsKD8yujSpPjAnodNoZtsxPSz3YGp2doS1EEi8rBavipPnsrI3Mgwn6xQvPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403829; c=relaxed/simple;
	bh=ly4lPOYA+PSGoXJ63VL7vdkuz896T0ptLb6YSldETAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXxQzO7oY/tz9WTB7hN2LSv4OCywqHg1j+JZZMm4NkLKDXTU2WQN4ywr04sy09Ka5Mc/zDrnDXxNaLZMZDa76u4ijWQ3iSBtWI62poxiRoqX0Nq332Z3NU0fd2mlJbhPoTZKIDY2GgACuvq54bmMLKTDkzMON7RAYs/mxsCqfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RC2i6KEI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730403827; x=1761939827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ly4lPOYA+PSGoXJ63VL7vdkuz896T0ptLb6YSldETAE=;
  b=RC2i6KEIC+NGoFaBlijIXMaSECCGjS9l3DiTqD1NtW5c9+ATcLmULXyx
   uzR3BOuDaLsp1sV4hH5dOWDbKRPm1KbsyutXWtBlFk6ZCABok7du1Kxfi
   dW0uMgtguQg2lEDc0uPwqyDjxJ8ErdF/bqXvveoKhYfFHnnOgARTM3Ozj
   p5O5rwYiR8/z+dsBfrmoPU13spBjbZGISqafgiWwYfcS8jIwsNKupxH4a
   IDjjQOiBHYWBpRxFMSwchQFKO2mlBSJUmNxRD57e7bhZOtfFN1xr+kzg7
   mIS4TLskBn0Sk5s1LQYZZIgbI4ahkQdUo97gw8dy6ep//r1DUO9ldXN8X
   w==;
X-CSE-ConnectionGUID: oc5nlO2zRquwZV0+V1JWVQ==
X-CSE-MsgGUID: Q10zooVJTeG8Un3sPZYOGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="17802603"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="17802603"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 12:43:46 -0700
X-CSE-ConnectionGUID: qP5abqGVRQecFYLY8iBVqg==
X-CSE-MsgGUID: g/wG1IUIQZS4TS/glnu1RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82835579"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Oct 2024 12:43:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6b53-000gec-1G;
	Thu, 31 Oct 2024 19:43:41 +0000
Date: Fri, 1 Nov 2024 03:43:36 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] platform/chrome: cros_ec_typec: Displayport
 support
Message-ID: <202411010346.AqbfMqLc-lkp@intel.com>
References: <20241030142833.v2.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030142833.v2.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>

Hi Abhishek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chrome-platform/for-next]
[also build test WARNING on chrome-platform/for-firmware-next usb/usb-testing usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.12-rc5 next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Pandit-Subedi/usb-typec-Add-driver-for-Thunderbolt-3-Alternate-Mode/20241031-053304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20241030142833.v2.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800%40changeid
patch subject: [PATCH v2 5/7] platform/chrome: cros_ec_typec: Displayport support
config: arm-multi_v7_defconfig (https://download.01.org/0day-ci/archive/20241101/202411010346.AqbfMqLc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411010346.AqbfMqLc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411010346.AqbfMqLc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/cros_typec_altmode.c:212:39: warning: 'cros_typec_altmode_ops' defined but not used [-Wunused-const-variable=]
     212 | static const struct typec_altmode_ops cros_typec_altmode_ops = {
         |                                       ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/chrome/cros_typec_altmode.c:40:13: warning: 'cros_typec_altmode_work' defined but not used [-Wunused-function]
      40 | static void cros_typec_altmode_work(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/cros_typec_altmode_ops +212 drivers/platform/chrome/cros_typec_altmode.c

    39	
  > 40	static void cros_typec_altmode_work(struct work_struct *work)
    41	{
    42		struct cros_typec_altmode_data *data =
    43			container_of(work, struct cros_typec_altmode_data, work);
    44	
    45		if (typec_altmode_vdm(data->alt, data->header, data->vdo_data,
    46				      data->vdo_size))
    47			dev_err(&data->alt->dev, "VDM 0x%x failed", data->header);
    48	
    49		data->header = 0;
    50		data->vdo_data = NULL;
    51		data->vdo_size = 0;
    52	}
    53	
    54	static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
    55	{
    56		struct cros_typec_altmode_data *data = typec_altmode_get_drvdata(alt);
    57		struct ec_params_typec_control req = {
    58			.port = data->port->port_num,
    59			.command = TYPEC_CONTROL_COMMAND_ENTER_MODE,
    60		};
    61		int svdm_version;
    62		int ret;
    63	
    64		if (!data->ap_mode_entry) {
    65			const struct typec_altmode *partner =
    66				typec_altmode_get_partner(alt);
    67			dev_warn(&partner->dev,
    68				 "EC does not support ap driven mode entry\n");
    69			return -EOPNOTSUPP;
    70		}
    71	
    72		if (data->sid == USB_TYPEC_DP_SID)
    73			req.mode_to_enter = CROS_EC_ALTMODE_DP;
    74		else
    75			return -EOPNOTSUPP;
    76	
    77		ret = cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
    78				  &req, sizeof(req), NULL, 0);
    79		if (ret < 0)
    80			return ret;
    81	
    82		svdm_version = typec_altmode_get_svdm_version(alt);
    83		if (svdm_version < 0)
    84			return svdm_version;
    85	
    86		data->header = VDO(data->sid, 1, svdm_version, CMD_ENTER_MODE);
    87		data->header |= VDO_OPOS(data->mode);
    88		data->header |= VDO_CMDT(CMDT_RSP_ACK);
    89	
    90		data->vdo_data = NULL;
    91		data->vdo_size = 1;
    92	
    93		schedule_work(&data->work);
    94	
    95		return ret;
    96	}
    97	
    98	static int cros_typec_altmode_exit(struct typec_altmode *alt)
    99	{
   100		struct cros_typec_altmode_data *data = typec_altmode_get_drvdata(alt);
   101		struct ec_params_typec_control req = {
   102			.port = data->port->port_num,
   103			.command = TYPEC_CONTROL_COMMAND_EXIT_MODES,
   104		};
   105		int svdm_version;
   106		int ret;
   107	
   108		if (!data->ap_mode_entry) {
   109			const struct typec_altmode *partner =
   110				typec_altmode_get_partner(alt);
   111			dev_warn(&partner->dev,
   112				 "EC does not support ap driven mode entry\n");
   113			return -EOPNOTSUPP;
   114		}
   115	
   116		ret = cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
   117				  &req, sizeof(req), NULL, 0);
   118	
   119		if (ret < 0)
   120			return ret;
   121	
   122		svdm_version = typec_altmode_get_svdm_version(alt);
   123		if (svdm_version < 0)
   124			return svdm_version;
   125	
   126		data->header = VDO(data->sid, 1, svdm_version, CMD_EXIT_MODE);
   127		data->header |= VDO_OPOS(data->mode);
   128		data->header |= VDO_CMDT(CMDT_RSP_ACK);
   129	
   130		data->vdo_data = NULL;
   131		data->vdo_size = 1;
   132	
   133		schedule_work(&data->work);
   134	
   135		return ret;
   136	}
   137	
   138	static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
   139					      const u32 *data, int count)
   140	{
   141		struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
   142	
   143		int cmd_type = PD_VDO_CMDT(header);
   144		int cmd = PD_VDO_CMD(header);
   145		int svdm_version;
   146	
   147		if (!adata->ap_mode_entry) {
   148			const struct typec_altmode *partner =
   149				typec_altmode_get_partner(alt);
   150			dev_warn(&partner->dev,
   151				 "EC does not support ap driven mode entry\n");
   152			return -EOPNOTSUPP;
   153		}
   154	
   155		svdm_version = typec_altmode_get_svdm_version(alt);
   156		if (svdm_version < 0)
   157			return svdm_version;
   158	
   159		switch (cmd_type) {
   160		case CMDT_INIT:
   161			if (PD_VDO_SVDM_VER(header) < svdm_version) {
   162				typec_partner_set_svdm_version(adata->port->partner,
   163							       PD_VDO_SVDM_VER(header));
   164				svdm_version = PD_VDO_SVDM_VER(header);
   165			}
   166	
   167			adata->header = VDO(adata->sid, 1, svdm_version, cmd);
   168			adata->header |= VDO_OPOS(adata->mode);
   169	
   170			/*
   171			 * DP_CMD_CONFIGURE: We can't actually do anything with the
   172			 * provided VDO yet so just send back an ACK.
   173			 *
   174			 * DP_CMD_STATUS_UPDATE: We wait for Mux changes to send
   175			 * DPStatus Acks.
   176			 */
   177			switch (cmd) {
   178			case DP_CMD_CONFIGURE:
   179				adata->am_data.dp.data.conf = *data;
   180				adata->header |= VDO_CMDT(CMDT_RSP_ACK);
   181				adata->am_data.dp.configured = true;
   182				schedule_work(&adata->work);
   183				break;
   184			case DP_CMD_STATUS_UPDATE:
   185				adata->am_data.dp.pending_status_update = true;
   186				break;
   187			default:
   188				adata->header |= VDO_CMDT(CMDT_RSP_ACK);
   189				schedule_work(&adata->work);
   190				break;
   191			}
   192	
   193			break;
   194		default:
   195			break;
   196		}
   197	
   198		return 0;
   199	}
   200	
   201	static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
   202					      const u32 *data, int count)
   203	{
   204		struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
   205	
   206		if (adata->sid == USB_TYPEC_DP_SID)
   207			return cros_typec_displayport_vdm(alt, header, data, count);
   208	
   209		return -EINVAL;
   210	}
   211	
 > 212	static const struct typec_altmode_ops cros_typec_altmode_ops = {
   213		.enter = cros_typec_altmode_enter,
   214		.exit = cros_typec_altmode_exit,
   215		.vdm = cros_typec_altmode_vdm,
   216	};
   217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

