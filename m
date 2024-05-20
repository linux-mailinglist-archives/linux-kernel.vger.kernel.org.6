Return-Path: <linux-kernel+bounces-183564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103F8C9AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEA0281AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CA31758;
	Mon, 20 May 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLC4r0tW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554B10A24;
	Mon, 20 May 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198426; cv=none; b=C8A+XV254v5Dm+rKFrLBWr5Ihq1Clb9EgGTbZqcfTrgWSgqB+/ObYH99Kj9THdshGNJ5f4wssrEQdkT5wKZsf4Wr+13ZTIEtCAqjhFMXMvgPW+SxnyEOIjDaYgkKfUEBVdc5lTBqik/BDdgu35qsLJeCs2vbZnpNy7BpeIDzETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198426; c=relaxed/simple;
	bh=v10n7LWWPZ4WW9t30Xp+EAF2iLYvof73nLcKeQE2e+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMVQGV4G+bsM/P0zZRPI7MxAGel34j7/6eC2KE1PR0DWGHW1WRO+eIl809VIhGzmz37eT/VRnOp3s3tQgMaA9K8hO44yHcjreaPM3pEr4pLjemq/JzHG4kbqzIimMwsoxESGKzlm9vZ/y1M6BJ5RI3RjzNwUbgHXrkgqEz1xnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLC4r0tW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B36C2BD10;
	Mon, 20 May 2024 09:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198426;
	bh=v10n7LWWPZ4WW9t30Xp+EAF2iLYvof73nLcKeQE2e+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLC4r0tWXjZtpd961eJ1gr5oe87pn92ep2KtReCdJcov1zuJSSuLVx95aLxvoGSH8
	 l1lphrYpg4aEGxJm5YwNDHV+Amy7haysV0s2ek5O1Vr7SLddK97pwWsTl6KDiPmy3A
	 xvqM9Js1Q8/C/E2Z6RDdN3vTNpSrPJuJi4QVSyvjWiZ67ZlDCPo9/hULv5Eff6aTzN
	 bXWfG4Yl3YLUo54GPqvvIENitegu9KRIKI0y/IRH6F+5jfl9VGT4zMPde1vwYQgNaC
	 G5YqIpZDaxEkXFc+ljHPre58PSVK6yUCwCA0xM7zuBuOn2gjC28uVd6UPSKIDA2PQD
	 mBuwKHo5GCL2Q==
Date: Mon, 20 May 2024 17:47:02 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for
 Framework Laptop
Message-ID: <ZkscFnmHeWWma7Nb@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515055631.5775-6-ben@jubnut.com>

On Wed, May 15, 2024 at 06:56:30AM +0100, Ben Walsh wrote:
> Framework Laptops' ACPI exposes the EC as name "PNP0C09". Use this to
> find the device. This makes it easy to find the AML mutex via the
> ACPI_COMPANION device.
> 
> The name "PNP0C09" is part of the ACPI standard, not Chrome-specific,
> so only recognise the device if the DMI data is recognised too.

I don't quite understand the statement.  Why it needs DMI data?

> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
[...]
> -/* True if ACPI device is present */
> -static bool cros_ec_lpc_acpi_device_found;
> +/*
> + * Index into cros_ec_lpc_acpi_device_ids of ACPI device,
> + * negative for ACPI device not found.
> + */
> +static int cros_ec_lpc_acpi_device_found;

Rename it to `cros_ec_lpc_acpi_device_index` for clarity?

>  static int __init cros_ec_lpc_init(void)
>  {
>  	int ret;
> -	acpi_status status;
>  	const struct dmi_system_id *dmi_match;
>  
> -	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
> -				  &cros_ec_lpc_acpi_device_found, NULL);
> -	if (ACPI_FAILURE(status))
> -		pr_warn(DRV_NAME ": Looking for %s failed\n", ACPI_DRV_NAME);
> +	cros_ec_lpc_acpi_device_found = cros_ec_lpc_find_acpi_dev(
> +		cros_ec_lpc_driver.driver.acpi_match_table);

Or just use `cros_ec_lpc_acpi_device_ids`.

> -	} else if (!cros_ec_lpc_acpi_device_found) {
> +	} else if (cros_ec_lpc_acpi_device_found <= 0) {
> +		/* Standard EC "PNP0C09" not supported without DMI data */

Asked the same question above, why PNP0C09 needs DMI data?  Also the way is
a bit confusing as "PNP0C09" must be at index 0 in the acpi_device_id.

