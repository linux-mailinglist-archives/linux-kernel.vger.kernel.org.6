Return-Path: <linux-kernel+bounces-186780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189EF8CC915
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845391F21A26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C891487C5;
	Wed, 22 May 2024 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csza3GX8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252AA80BFC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716417093; cv=none; b=FMP6DlpyLz30lsI2MNF+ZvZ92xo3i3wkON3jQmzcn9YNs4CxqYe13BlLOh1zrmHsdmoFkOGqdzm88S/K7+FTe1wVNLel7ORrEZh5Ro+fiPi8vb6ZQlYHVMfhH291mFXyMRqgUPGhKijOFHv3uNhFGNi7FD4ymj9gwEz5YKNa/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716417093; c=relaxed/simple;
	bh=1W1L7acCospm0rUX5FWxQM3phzR8QfqYtWmsjzBV1iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJnRxon8S4h9tIUTvzo3uKrXXSQOMYFp9r1ToW02uspdlERz/JL4obp9mv9qmYwXEtvpkTuu4ppBfBgZNaSKQXV3R7hA1W2wyJZs2xhXek/vU/E2Uvz8sXozyVzGICIPZqFXYxvuaVyEPPe8Bzgn0yYpfSFN1dZH35QrErIhlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csza3GX8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716417091; x=1747953091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1W1L7acCospm0rUX5FWxQM3phzR8QfqYtWmsjzBV1iY=;
  b=csza3GX8bCowH1UrEnMB0wWr1+An1RiLgY74pGUap0b6muKfe3HPoVoq
   heiaghKVJDvhuWbLZ/2Qx+6nrxLcN6jAJwA8J3F828GoEZt6721U1lJ4q
   iLKPp0yELkz9u7xgiO1DznQQhSTrAArZP8CbSEp9HssS2aoGm5vppy3+u
   wddFvI+AlO/JFYlubiCL36i16HTd8Ydu0MycHqtLI81vkY7OWzgdrVrdg
   KqPBtsQnSPWvZEBiJgNfdXpjqn74lWRfRi1gzdBnYO0Z84dLhyXYxzyXv
   rb0BOOudID23gMbEGZGAvxbb8U0BG+Iqw4RBjMyhmnw86F33LNWUpB2rK
   Q==;
X-CSE-ConnectionGUID: wxRzx78YRyqj52PGb/B27A==
X-CSE-MsgGUID: n+w1ggRVR7ClWaDqikSWiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23270778"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23270778"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:31:30 -0700
X-CSE-ConnectionGUID: G5irdcCXSgyxecri599MIA==
X-CSE-MsgGUID: iwX5NZClT4C7gT1HWu2k8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33550283"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 May 2024 15:31:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9uUS-0002BN-35;
	Wed, 22 May 2024 22:31:20 +0000
Date: Thu, 23 May 2024 06:30:29 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andriy.shevchenko@linux.intel.com,
	lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	judyhsiao@google.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, kevin-lu@ti.com,
	yuhsuan@google.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, navada@ti.com, cujomalainey@google.com,
	aanya@ti.com, nayeem.mahmud@ti.com,
	Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: tas2781: Add Calibration Kcontrols and tas2563
 digtial gain for Chromebook
Message-ID: <202405230633.Vq1CHD6e-lkp@intel.com>
References: <20240522112942.994-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522112942.994-1-shenghao-ding@ti.com>

Hi Shenghao,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on next-20240522]
[cannot apply to tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ASoc-tas2781-Add-Calibration-Kcontrols-and-tas2563-digtial-gain-for-Chromebook/20240522-193315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240522112942.994-1-shenghao-ding%40ti.com
patch subject: [PATCH v1] ASoc: tas2781: Add Calibration Kcontrols and tas2563 digtial gain for Chromebook
config: x86_64-buildonly-randconfig-002-20240523 (https://download.01.org/0day-ci/archive/20240523/202405230633.Vq1CHD6e-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405230633.Vq1CHD6e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405230633.Vq1CHD6e-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/codecs/tas2781-i2c.c: In function 'tas2563_digital_gain_get':
>> sound/soc/codecs/tas2781-i2c.c:696:31: error: 'tas2563_dvc_table' undeclared (first use in this function); did you mean 'tasklet_disable'?
      ar_mid = get_unaligned_be32(tas2563_dvc_table[mid]);
                                  ^~~~~~~~~~~~~~~~~
                                  tasklet_disable
   sound/soc/codecs/tas2781-i2c.c:696:31: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/codecs/tas2781-i2c.c: In function 'tas2563_digital_gain_put':
   sound/soc/codecs/tas2781-i2c.c:737:29: error: 'tas2563_dvc_table' undeclared (first use in this function); did you mean 'tasklet_disable'?
     volwr = get_unaligned_be32(tas2563_dvc_table[vol]);
                                ^~~~~~~~~~~~~~~~~
                                tasklet_disable
   In file included from sound/soc/codecs/tas2781-i2c.c:30:
   sound/soc/codecs/tas2781-i2c.c: At top level:
>> sound/soc/codecs/tas2781-i2c.c:790:3: error: 'tas2563_dvc_tlv' undeclared here (not in a function); did you mean 'tas2563_snd_controls'?
      tas2563_dvc_tlv),
      ^~~~~~~~~~~~~~~
   include/sound/soc.h:293:12: note: in definition of macro 'SOC_SINGLE_RANGE_EXT_TLV'
     .tlv.p = (tlv_array), \
               ^~~~~~~~~
>> sound/soc/codecs/tas2781-i2c.c:788:17: error: 'tas2563_dvc_table' undeclared here (not in a function); did you mean 'tas2563_snd_controls'?
      0, ARRAY_SIZE(tas2563_dvc_table) - 1, 0,
                    ^~~~~~~~~~~~~~~~~
   include/sound/soc.h:298:42: note: in definition of macro 'SOC_SINGLE_RANGE_EXT_TLV'
       .rshift = xshift, .min = xmin, .max = xmax, \
                                             ^~~~
   sound/soc/codecs/tas2781-i2c.c:788:6: note: in expansion of macro 'ARRAY_SIZE'
      0, ARRAY_SIZE(tas2563_dvc_table) - 1, 0,
         ^~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
    #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                      ^
   include/sound/soc.h:298:42: note: in definition of macro 'SOC_SINGLE_RANGE_EXT_TLV'
       .rshift = xshift, .min = xmin, .max = xmax, \
                                             ^~~~
   include/linux/compiler.h:237:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-i2c.c:788:6: note: in expansion of macro 'ARRAY_SIZE'
      0, ARRAY_SIZE(tas2563_dvc_table) - 1, 0,
         ^~~~~~~~~~


vim +696 sound/soc/codecs/tas2781-i2c.c

   669	
   670	static int tas2563_digital_gain_get(
   671		struct snd_kcontrol *kcontrol,
   672		struct snd_ctl_elem_value *ucontrol)
   673	{
   674		struct soc_mixer_control *mc =
   675			(struct soc_mixer_control *)kcontrol->private_value;
   676		struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
   677		struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
   678		unsigned int l = 0, r = mc->max;
   679		unsigned int target, ar_mid, mid, ar_l, ar_r;
   680		unsigned int reg = mc->reg;
   681		unsigned char data[4];
   682		int ret;
   683	
   684		mutex_lock(&tas_dev->codec_lock);
   685		/* Read the primary device */
   686		ret =  tasdevice_dev_bulk_read(tas_dev, 0, reg, data, 4);
   687		if (ret) {
   688			dev_err(tas_dev->dev, "%s, get AMP vol error\n", __func__);
   689			goto out;
   690		}
   691	
   692		target = get_unaligned_be32(&data[0]);
   693	
   694		while (r > 1 + l) {
   695			mid = (l + r) / 2;
 > 696			ar_mid = get_unaligned_be32(tas2563_dvc_table[mid]);
   697			if (target < ar_mid)
   698				r = mid;
   699			else
   700				l = mid;
   701		}
   702	
   703		ar_l = get_unaligned_be32(tas2563_dvc_table[l]);
   704		ar_r = get_unaligned_be32(tas2563_dvc_table[r]);
   705	
   706		ucontrol->value.integer.value[0] =
   707			abs(target - ar_l) <= abs(target - ar_r) ? l : r;
   708	out:
   709		mutex_unlock(&tas_dev->codec_lock);
   710		return 0;
   711	}
   712	
   713	static int tas2563_digital_gain_put(
   714		struct snd_kcontrol *kcontrol,
   715		struct snd_ctl_elem_value *ucontrol)
   716	{
   717		struct soc_mixer_control *mc =
   718			(struct soc_mixer_control *)kcontrol->private_value;
   719		struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
   720		struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
   721		unsigned int reg = mc->reg;
   722		unsigned int volrd, volwr;
   723		int vol = ucontrol->value.integer.value[0];
   724		int max = mc->max, i, ret = 1;
   725		unsigned char data[4];
   726	
   727		vol = clamp(vol, 0, max);
   728		mutex_lock(&tas_dev->codec_lock);
   729		/* Read the primary device */
   730		ret =  tasdevice_dev_bulk_read(tas_dev, 0, reg, data, 4);
   731		if (ret) {
   732			dev_err(tas_dev->dev, "%s, get AMP vol error\n", __func__);
   733			goto out;
   734		}
   735	
   736		volrd = get_unaligned_be32(&data[0]);
   737		volwr = get_unaligned_be32(tas2563_dvc_table[vol]);
   738	
   739		if (volrd == volwr) {
   740			ret = 0;
   741			goto out;
   742		}
   743	
   744		for (i = 0; i < tas_dev->ndev; i++) {
   745			ret = tasdevice_dev_bulk_write(tas_dev, i, reg,
   746				(unsigned char *)tas2563_dvc_table[vol], 4);
   747			if (ret)
   748				dev_err(tas_dev->dev,
   749					"%s, set digital vol error in device %d\n",
   750					__func__, i);
   751		}
   752	
   753	out:
   754		mutex_unlock(&tas_dev->codec_lock);
   755		return ret;
   756	}
   757	
   758	static const struct snd_kcontrol_new tasdevice_snd_controls[] = {
   759		SOC_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
   760			tasdev_force_fwload_get, tasdev_force_fwload_put),
   761	};
   762	
   763	static const struct snd_kcontrol_new tasdevice_cali_controls[] = {
   764		SOC_SINGLE_EXT("Calibration Stop", SND_SOC_NOPM, 0, 1, 0,
   765			tasdev_nop_get, tasdev_calib_stop_put),
   766		SND_SOC_BYTES_EXT("Amp TF Data", 5, tasdev_tf_data_get, NULL),
   767		SND_SOC_BYTES_EXT("Amp RE Data", 5, tasdev_re_data_get, NULL),
   768		SND_SOC_BYTES_EXT("Amp R0 Data", 5, tasdev_r0_data_get, NULL),
   769		SND_SOC_BYTES_EXT("Amp XMA1 Data", 5, tasdev_XMA1_data_get, NULL),
   770		SND_SOC_BYTES_EXT("Amp XMA2 Data", 5, tasdev_XMA2_data_get, NULL),
   771	};
   772	
   773	static const struct snd_kcontrol_new tas2781_snd_controls[] = {
   774		SOC_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
   775			1, 0, 20, 0, tas2781_amp_getvol,
   776			tas2781_amp_putvol, amp_vol_tlv),
   777		SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
   778			0, 0, 200, 1, tas2781_digital_getvol,
   779			tas2781_digital_putvol, dvc_tlv),
   780	};
   781	
   782	static const struct snd_kcontrol_new tas2781_cali_controls[] = {
   783		SND_SOC_BYTES_EXT("Amp Latch Data", 2, tas2781_latch_reg_get, NULL),
   784	};
   785	
   786	static const struct snd_kcontrol_new tas2563_snd_controls[] = {
   787		SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2563_DVC_LVL, 0,
 > 788			0, ARRAY_SIZE(tas2563_dvc_table) - 1, 0,
   789			tas2563_digital_gain_get, tas2563_digital_gain_put,
 > 790			tas2563_dvc_tlv),
   791	};
   792	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

