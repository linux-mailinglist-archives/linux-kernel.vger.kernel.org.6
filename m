Return-Path: <linux-kernel+bounces-334846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28597DD50
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1461C20BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8911714DD;
	Sat, 21 Sep 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7wPDQ+e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BC13AD26;
	Sat, 21 Sep 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726923655; cv=none; b=clSHe1wcZHZ7+JCpPXYri7s+XmwMHO1CLW57axQRu6+AA4WDl7nV6wkjewZwb/gepQtaevhdUp8Fju3pQ5Dug+Jl6ylyEsWw+TEtQ+1YXltZbt+qMn+I2dnDzcyZkonKOjg/FoD2LY2zr/MKZoikb49PfNVO6wWQHVuomDucvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726923655; c=relaxed/simple;
	bh=Qzwnd2JW8YVoqaxd0RoBmQdx5YFfwb7t/+mzl03MbIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+xYfm1LRFlP8G04Mg/hqDsKDkDXTvNcynfOb+Jm1w5PG7BF2jSMu+/IVG7qSvZvNbaJsjYLwwXQqLBVy3EiP/LtOmhgCWhoRqG2SXHxHly/zlZsXIdIiZFJ6xmVUsPEepkLBraFhwDUvkZbjYVZCFgEbrHv9k1evw3YMwyKvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7wPDQ+e; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726923653; x=1758459653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qzwnd2JW8YVoqaxd0RoBmQdx5YFfwb7t/+mzl03MbIE=;
  b=m7wPDQ+eK8mNqMiFDY5F84BeGDz82wU+c6dwn70Vrb0iCSy9tN4jVp2g
   44WxYcQk1EiCxYfMsu1mOGS2EgxrRnmKtiYYZOkzIHnJ3gCx8rzmDMqw7
   fgU4usDYfVLOBFExPhXtKCVYefd32txYXT6VMtLc9ummdBJhcDkJ4qKoE
   D8mo8+Bbzidf76HjW8ZYiQ/WrCQDbQBu6fQLhfV3Qt4i7IwTd9z6a8lPl
   egoLeLCSYyds6MmHoShMdn64n2N6bzXNmcnI04CCJMuYQxZqjs6azF1TW
   XJqT/sG/7I7hj/tUW8I23jpqDtz0rWZn3iP+iNTz+wsh0mu2RV5k99JQZ
   Q==;
X-CSE-ConnectionGUID: HJnJoL0WQPyOnyLAWIbW/Q==
X-CSE-MsgGUID: YKRcVH7pRL2NfkobfAEMGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29818707"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="29818707"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 06:00:52 -0700
X-CSE-ConnectionGUID: AnEOb1GcQUqc0jC32N/gFQ==
X-CSE-MsgGUID: UeIUHx3uQJaI7S4zFIYvVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="74982765"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2024 06:00:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srzjC-000FRb-1v;
	Sat, 21 Sep 2024 13:00:46 +0000
Date: Sat, 21 Sep 2024 20:59:47 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Prusov <ivprusov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@salutedevices.com, prusovigor@gmail.com,
	David Yang <yangxiaohua@everest-semi.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add ES7243E ADC driver
Message-ID: <202409212032.P6kjCapX-lkp@intel.com>
References: <20240920-es7243e-adc-v2-2-0be019735b81@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-es7243e-adc-v2-2-0be019735b81@salutedevices.com>

Hi Igor,

kernel test robot noticed the following build errors:

[auto build test ERROR on baeb9a7d8b60b021d907127509c44507539c15e5]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Prusov/ASoC-dt-bindings-Add-Everest-ES7243E/20240920-235246
base:   baeb9a7d8b60b021d907127509c44507539c15e5
patch link:    https://lore.kernel.org/r/20240920-es7243e-adc-v2-2-0be019735b81%40salutedevices.com
patch subject: [PATCH v2 2/2] ASoC: codecs: add ES7243E ADC driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240921/202409212032.P6kjCapX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409212032.P6kjCapX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409212032.P6kjCapX-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/codecs/es7243e.c: In function 'es7243e_set_dai_fmt':
>> sound/soc/codecs/es7243e.c:252:27: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     252 |                 sdpfmt |= FIELD_PREP(ES7243E_SDP_FMT, 0);
         |                           ^~~~~~~~~~


vim +/FIELD_PREP +252 sound/soc/codecs/es7243e.c

   239	
   240	static int es7243e_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
   241	{
   242		struct snd_soc_component *component = dai->component;
   243		unsigned int sdpfmt = 0;
   244		unsigned int clk2 = 0;
   245		bool is_dsp = false;
   246		bool invert_lrck = false;
   247		int ret;
   248	
   249		/* Set protocol of the serial data port */
   250		switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
   251		case SND_SOC_DAIFMT_I2S:
 > 252			sdpfmt |= FIELD_PREP(ES7243E_SDP_FMT, 0);
   253			break;
   254		case SND_SOC_DAIFMT_LEFT_J:
   255			sdpfmt |= FIELD_PREP(ES7243E_SDP_FMT, 1);
   256			break;
   257		case SND_SOC_DAIFMT_DSP_A:
   258			sdpfmt |= FIELD_PREP(ES7243E_SDP_FMT, 3);
   259			is_dsp = true;
   260			break;
   261		case SND_SOC_DAIFMT_DSP_B:
   262			sdpfmt |= FIELD_PREP(ES7243E_SDP_FMT, 3);
   263			is_dsp = true;
   264			break;
   265		default:
   266			return -EINVAL;
   267		}
   268	
   269		/* Set LR and BCLK polarity */
   270		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
   271		case SND_SOC_DAIFMT_NB_NF:
   272			clk2 |= FIELD_PREP(ES7243E_CLK2_BCLK_INV, 0);
   273			sdpfmt |= FIELD_PREP(ES7243E_SDP_LRP, 0);
   274			break;
   275		case SND_SOC_DAIFMT_IB_IF:
   276			clk2 |= FIELD_PREP(ES7243E_CLK2_BCLK_INV, 1);
   277			sdpfmt |= FIELD_PREP(ES7243E_SDP_LRP, 1);
   278			invert_lrck = true;
   279			break;
   280		case SND_SOC_DAIFMT_IB_NF:
   281			clk2 |= FIELD_PREP(ES7243E_CLK2_BCLK_INV, 1);
   282			sdpfmt |= FIELD_PREP(ES7243E_SDP_LRP, 0);
   283			break;
   284		case SND_SOC_DAIFMT_NB_IF:
   285			clk2 |= FIELD_PREP(ES7243E_CLK2_BCLK_INV, 0);
   286			sdpfmt |= FIELD_PREP(ES7243E_SDP_LRP, 1);
   287			invert_lrck = true;
   288			break;
   289		default:
   290			return -EINVAL;
   291		}
   292	
   293		/* Inverted LRCK is not available in DSP mode. */
   294		if (is_dsp && invert_lrck)
   295			return -EINVAL;
   296	
   297		ret = snd_soc_component_update_bits(component, ES7243E_CLK2,
   298						    ES7243E_CLK2_BCLK_INV, clk2);
   299		if (ret < 0)
   300			return ret;
   301	
   302		return snd_soc_component_update_bits(component, ES7243E_SDP,
   303						     ES7243E_SDP_LRP, sdpfmt);
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

