Return-Path: <linux-kernel+bounces-227346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2F914FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284441C21907
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8555175544;
	Mon, 24 Jun 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1nw1ZwBZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9014882F;
	Mon, 24 Jun 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239101; cv=none; b=Wivsj0Eiv3Gm8Y5LYROQJ7Ce1XdkrWq5zMfaNMFAFJXUH8ax5BK+jpPNrt/dhaRfOUd7wXx2BIvl4MFUIBG2VLOCXZb9Sxm4NrxLeESqgHaoirCTpyM0wTEjNyEVJC3S9UbXxdueY9KZn7PJpJAYYlcga7BiLe6Hccjd0Ko7MWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239101; c=relaxed/simple;
	bh=EK+Fi7+C5OPwFD7IS458Gg7eVjvzpeQgfsxONCxGrgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFxh7sg+TDqmzcOPDG4wa4NPsRsjKYH+Lc/ikfgTf6zcyfKgN4w6JoN3/yqQ9hbnkvD8NWjjWtvVnBqv9zFvdeliovdkpwkBz+JF4k+D5GP/RPtIe+GLMR+V853cIQqO++1e8484IODtSC6sWDw58S38cpH9Tp0lLzd91M4xbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1nw1ZwBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CDCC4AF0A;
	Mon, 24 Jun 2024 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719239100;
	bh=EK+Fi7+C5OPwFD7IS458Gg7eVjvzpeQgfsxONCxGrgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1nw1ZwBZRR3NRfv3uvREIcwzG+g7aWxFxCZbqJ32+bK+MuDVrw7g/dclvnpC9juO1
	 T3krYY/CCt5txVJtjaOJatqbMZn2Ga2TVUVeyfogKtCzy3yvgVer4riMx1kT4iFmfS
	 4wV5JctRid46BcyMZ/Y5nYdaFAucm3wuifudk1Rk=
Date: Mon, 24 Jun 2024 16:24:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v8] usb: typec: ucsi: add Lenovo Yoga C630 glue driver
Message-ID: <2024062411-neutron-striving-f16c@gregkh>
References: <20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org>

On Fri, Jun 21, 2024 at 01:21:26AM +0300, Dmitry Baryshkov wrote:
> The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
> the onboard EC. Add glue driver to interface the platform's UCSI
> implementation.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Add driver for the UCSI on the Lenovo Yoga C630 laptop, as implemented
> by the Embedded Controlller of the laptop.
> 
> Support for this EC was implemented by Bjorn, who later could not work
> on this driver. I've picked this patchset up and updated it following
> the pending review comments.
> 
> NOTE: the patch depends on the header from the platform driver. Ilpo
> Järvinen has created an immutable branch based on v6.10-rc1, please pull
> it before merging the patches:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11
> 
>   platform: arm64: add Lenovo Yoga C630 WOS EC driver (2024-06-14 12:51:30 +0300)

I have that branch, yet when building this driver as a module I get the
following errors:
ERROR: modpost: "yoga_c630_ec_unregister_notify" [drivers/usb/typec/ucsi/ucsi_yoga_c630.ko] undefined!
ERROR: modpost: "yoga_c630_ec_ucsi_get_version" [drivers/usb/typec/ucsi/ucsi_yoga_c630.ko] undefined!
ERROR: modpost: "yoga_c630_ec_register_notify" [drivers/usb/typec/ucsi/ucsi_yoga_c630.ko] undefined!
ERROR: modpost: "yoga_c630_ec_ucsi_write" [drivers/usb/typec/ucsi/ucsi_yoga_c630.ko] undefined!
ERROR: modpost: "yoga_c630_ec_ucsi_read" [drivers/usb/typec/ucsi/ucsi_yoga_c630.ko] undefined!

So something went wrong :(

I'll unwind that branch pull now as well and wait for a fixed up version
to be sent.

thanks,

greg k-h

