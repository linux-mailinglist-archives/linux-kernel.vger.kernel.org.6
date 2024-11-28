Return-Path: <linux-kernel+bounces-424909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC39DBB12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06E6162DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4341BFE00;
	Thu, 28 Nov 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YJsklB+g"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEC1BD9F2;
	Thu, 28 Nov 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810430; cv=none; b=QwaeeoY6F5XGPe+7s7IQ7rRKM7ubvByC2K5nwpvX1GiR62Bx8h4CAu8+LqddWPsiQb/LOAG3nEqYVq77GEq/TEvu+8Un6tLnn+BeN8EwLMTaOa33jlU+FW0CLJ4S1272TPsC6F55y+xDI3681usfnE+wczLYnPuB7tQSDZo5RlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810430; c=relaxed/simple;
	bh=SMBP/C98M1fAP9PZi1q1IMPdK3JoaP7rXNK3Q1VvYOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka0sONWT+DYINh94EjbMqsnoImcZFILrQmGEsIPrNwh89N3HLCZj+jUDNX7ezxaJsCikhGvpnh103TGtv9QxYKvFfC60u8mQXQZyxwb4fEVeJ5HJ09pjsbzOLgz0Okpsjl0dimbD6OrTI0bJdH3jjm+91LVlsM6nN6cW8mn+ruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YJsklB+g; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Xy/7ieQyoXAcJaE8+oks5XZebS8CPLjn1pLGrh8er0A=; b=YJsklB+gxKF5RKDm
	FOMrUJ8bH7tnnClXIBZBT6LCxqQkgjCu7ZvWnmkCXZOWaoOr6BHS6LZoOaQFCroqdavU+x/KZYFiK
	Q2xF/8fDaYaYHzMbi7ZRNHpkJPxDo4CxgxH5vTGQaOIq4+lELGEHjpbcZh3ZnDhOESvSrtNL1udjU
	WtCda9GTvSlg500Eb1mDffYlH4thy2xpNVFfBlSzYWoR0dddgGxPSLBU7qViGpgxCCPPszpJqBTwB
	wjI9p+hQw3qnAzE+VbEFuVn3orpQQ84i7aN2O65bkU6Ne0rHEK0TetmN4B1ZjH9OprIhV2PHxrQt0
	vI7wFPwRfnCOC7Su7g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tGh9B-002QnV-1n;
	Thu, 28 Nov 2024 16:13:41 +0000
Date: Thu, 28 Nov 2024 16:13:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: devres: Remove unused
 devm_regulator_bulk_register_supply_alias
Message-ID: <Z0iWtV6XQKNHDqf-@gallifrey>
References: <20241028021500.478043-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241028021500.478043-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:13:29 up 204 days,  3:27,  1 user,  load average: 0.02, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> devm_regulator_bulk_register_supply_alias() has been unused since 2014's
> commit d137be00ee01 ("mfd: core: Don't use devres functions before device
> is added")
> 
> Remove it, and the static helpers only it used.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.

Thanks,

Dave

> ---
>  .../driver-api/driver-model/devres.rst        |  1 -
>  drivers/regulator/devres.c                    | 74 -------------------
>  include/linux/regulator/consumer.h            |  6 --
>  3 files changed, 81 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 5f2ee8d717b1..a1995a16febf 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -426,7 +426,6 @@ PWM
>    devm_fwnode_pwm_get()
>  
>  REGULATOR
> -  devm_regulator_bulk_register_supply_alias()
>    devm_regulator_bulk_get()
>    devm_regulator_bulk_get_const()
>    devm_regulator_bulk_get_enable()
> diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
> index 1b893cdd1aad..6d6ddeb62f57 100644
> --- a/drivers/regulator/devres.c
> +++ b/drivers/regulator/devres.c
> @@ -491,15 +491,6 @@ struct regulator_supply_alias_match {
>  	const char *id;
>  };
>  
> -static int devm_regulator_match_supply_alias(struct device *dev, void *res,
> -					     void *data)
> -{
> -	struct regulator_supply_alias_match *match = res;
> -	struct regulator_supply_alias_match *target = data;
> -
> -	return match->dev == target->dev && strcmp(match->id, target->id) == 0;
> -}
> -
>  static void devm_regulator_destroy_supply_alias(struct device *dev, void *res)
>  {
>  	struct regulator_supply_alias_match *match = res;
> @@ -548,71 +539,6 @@ int devm_regulator_register_supply_alias(struct device *dev, const char *id,
>  }
>  EXPORT_SYMBOL_GPL(devm_regulator_register_supply_alias);
>  
> -static void devm_regulator_unregister_supply_alias(struct device *dev,
> -						   const char *id)
> -{
> -	struct regulator_supply_alias_match match;
> -	int rc;
> -
> -	match.dev = dev;
> -	match.id = id;
> -
> -	rc = devres_release(dev, devm_regulator_destroy_supply_alias,
> -			    devm_regulator_match_supply_alias, &match);
> -	if (rc != 0)
> -		WARN_ON(rc);
> -}
> -
> -/**
> - * devm_regulator_bulk_register_supply_alias - Managed register
> - * multiple aliases
> - *
> - * @dev:       device to supply
> - * @id:        list of supply names or regulator IDs
> - * @alias_dev: device that should be used to lookup the supply
> - * @alias_id:  list of supply names or regulator IDs that should be used to
> - *             lookup the supply
> - * @num_id:    number of aliases to register
> - *
> - * @return 0 on success, a negative error number on failure.
> - *
> - * This helper function allows drivers to register several supply
> - * aliases in one operation, the aliases will be automatically
> - * unregisters when the source device is unbound.  If any of the
> - * aliases cannot be registered any aliases that were registered
> - * will be removed before returning to the caller.
> - */
> -int devm_regulator_bulk_register_supply_alias(struct device *dev,
> -					      const char *const *id,
> -					      struct device *alias_dev,
> -					      const char *const *alias_id,
> -					      int num_id)
> -{
> -	int i;
> -	int ret;
> -
> -	for (i = 0; i < num_id; ++i) {
> -		ret = devm_regulator_register_supply_alias(dev, id[i],
> -							   alias_dev,
> -							   alias_id[i]);
> -		if (ret < 0)
> -			goto err;
> -	}
> -
> -	return 0;
> -
> -err:
> -	dev_err(dev,
> -		"Failed to create supply alias %s,%s -> %s,%s\n",
> -		id[i], dev_name(dev), alias_id[i], dev_name(alias_dev));
> -
> -	while (--i >= 0)
> -		devm_regulator_unregister_supply_alias(dev, id[i]);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(devm_regulator_bulk_register_supply_alias);
> -
>  struct regulator_notifier_match {
>  	struct regulator *regulator;
>  	struct notifier_block *nb;
> diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
> index b9ce521910a0..adaacd7676b6 100644
> --- a/include/linux/regulator/consumer.h
> +++ b/include/linux/regulator/consumer.h
> @@ -185,12 +185,6 @@ int devm_regulator_register_supply_alias(struct device *dev, const char *id,
>  					 struct device *alias_dev,
>  					 const char *alias_id);
>  
> -int devm_regulator_bulk_register_supply_alias(struct device *dev,
> -					      const char *const *id,
> -					      struct device *alias_dev,
> -					      const char *const *alias_id,
> -					      int num_id);
> -
>  /* regulator output control and status */
>  int __must_check regulator_enable(struct regulator *regulator);
>  int regulator_disable(struct regulator *regulator);
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

