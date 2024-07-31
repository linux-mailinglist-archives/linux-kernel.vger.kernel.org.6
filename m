Return-Path: <linux-kernel+bounces-269164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03CC942EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CAB1F25D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C61AED36;
	Wed, 31 Jul 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX2yAiTI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5361A8BED;
	Wed, 31 Jul 2024 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429402; cv=none; b=Rml+RHzQVb1g7p3fcq0z3yO10T0O09/2B+IzqVr+qnZXu5ltNZdT5Vt5gbPpSHFZJ35h5Ma9fjSCnc2E4rdX+vtZFucdkNYIK8piFEcMWNeqxNUGTjKBt02QUGLPCNEyIaTxYNS6VKOJy07QUUyOfOebZpYaf8AXd6KDQVWBI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429402; c=relaxed/simple;
	bh=SEcUI8JtPnuzuLd77dWkUBzPD+0GWOA3rL4w76reUP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggXggtb3Lt/6ev4iSur0ajGT2272d64Cd3zOHIobE0/P352UD8BAB0SI/j9aFQaoHIhyfV6CD5mVzBBR1Xb71SfnBrssOfDpy57uHuBcxOYEnhlGRmSmHY1IDEcdaC30ikBaFLGft8vGChsbzU915xZN5Wg9Jcvi6allZJ8fo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX2yAiTI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722429401; x=1753965401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SEcUI8JtPnuzuLd77dWkUBzPD+0GWOA3rL4w76reUP8=;
  b=mX2yAiTIKibjuBafOG4U3vkWgzOT7mZ31piZMNBrxx0kDB3rUEw8UZui
   CnCa5ceIdn3jUoMRiC6Ml5yETttBbIynMqmIlVDYDPJCmYaWE9WwE7bDV
   ELCSSbOxjYPKsvvHYwLrESA78yeT4StL4j+1SjzoKChdsoGN1gqCc9Q1Z
   FZwJSNQWcV1uD/gnxylAj/giG6RHEeRiOxceYY+YXNeyGuTm5peKPnS39
   K14VjwQLUq/wmgs6ZdEWlpXDji/oS+Z4NFD99yxQqYY+yMO0UfgwX3sHq
   seUtxVP6fkZWyGJJRQ9DJMSDQkS9mDVrgRtuYh7YDEwOzkRQe+uC3xgRE
   A==;
X-CSE-ConnectionGUID: jCp2djKnT5ysOW062iaH8Q==
X-CSE-MsgGUID: HAOtlO2xRhmpQoc810hRNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="42834911"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="42834911"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:36:40 -0700
X-CSE-ConnectionGUID: sacR2TFbQO6bYV3DL124zg==
X-CSE-MsgGUID: YUfOL5iFQy2akmg+OycpUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55471318"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa008.jf.intel.com with SMTP; 31 Jul 2024 05:36:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 15:36:35 +0300
Date: Wed, 31 Jul 2024 15:36:35 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] usb: typec: tcpm/tcpci_maxim: use GENMASK() for
 TCPC_VENDOR_CC_CTRL2 register
Message-ID: <Zqov06zsAQOiy4Zt@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-11-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-11-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:18AM +0100, André Draszik wrote:
> Convert register TCPC_VENDOR_CC_CTRL2 to using GENMASK() and
> FIELD_PREP() so as to keep using a similar approach throughout the code
> base and make it arguably easier to read.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 18 +++++++++++-------
>  drivers/usb/typec/tcpm/tcpci_maxim.h       |  6 +++---
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index 8ac8eeade277..f7acaa42329f 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -116,13 +116,14 @@ static int max_contaminant_read_resistance_kohm(struct max_tcpci_chip *chip,
>  	if (channel == CC1_SCALE1 || channel == CC2_SCALE1 || channel == CC1_SCALE2 ||
>  	    channel == CC2_SCALE2) {
>  		/* Enable 1uA current source */
> -		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL_MASK,
> -					 ULTRA_LOW_POWER_MODE);
> +		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
> +					 FIELD_PREP(CCLPMODESEL, ULTRA_LOW_POWER_MODE));
>  		if (ret < 0)
>  			return ret;
>  
>  		/* Enable 1uA current source */
> -		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, UA_1_SRC);
> +		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL,
> +					 FIELD_PREP(CCRPCTRL, UA_1_SRC));
>  		if (ret < 0)
>  			return ret;
>  
> @@ -176,7 +177,8 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
>  	int ret;
>  
>  	/* Enable 80uA source */
> -	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, UA_80_SRC);
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL,
> +				 FIELD_PREP(CCRPCTRL, UA_80_SRC));
>  	if (ret < 0)
>  		return ret;
>  
> @@ -209,7 +211,8 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, 0);
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL,
> +				 FIELD_PREP(CCRPCTRL, 0));
>  	if (ret < 0)
>  		return ret;
>  
> @@ -298,8 +301,9 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL_MASK,
> -				 ULTRA_LOW_POWER_MODE);
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
> +				 FIELD_PREP(CCLPMODESEL,
> +					    ULTRA_LOW_POWER_MODE));
>  	if (ret < 0)
>  		return ret;
>  	ret = max_tcpci_read8(chip, TCPC_VENDOR_CC_CTRL2, &temp);
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
> index 78ff3b73ee7e..92c9a628ebe1 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -20,9 +20,9 @@
>  #define SBUOVPDIS                               BIT(7)
>  #define CCOVPDIS                                BIT(6)
>  #define SBURPCTRL                               BIT(5)
> -#define CCLPMODESEL_MASK                        GENMASK(4, 3)
> -#define ULTRA_LOW_POWER_MODE                    BIT(3)
> -#define CCRPCTRL_MASK                           GENMASK(2, 0)
> +#define CCLPMODESEL                             GENMASK(4, 3)
> +#define ULTRA_LOW_POWER_MODE                    1
> +#define CCRPCTRL                                GENMASK(2, 0)
>  #define UA_1_SRC                                1
>  #define UA_80_SRC                               3
>  
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

