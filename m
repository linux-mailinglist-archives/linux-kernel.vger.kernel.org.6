Return-Path: <linux-kernel+bounces-386903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F59B4964
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B079B23EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA61DF985;
	Tue, 29 Oct 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVVzt42m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5388BEA;
	Tue, 29 Oct 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204112; cv=none; b=EwExPKyUUvCGm4SNHu4a07QAASiysG0KAullYsPyCocjzgBtgxd21ZHMOghyHObxOW42wO9H907XYNkb1GgqFXOgl0err79kzDdLgkzr57g2XDp9Rtc3ipDWq6nm02Q5AVUCczKqTOD7Szo7c1yfTCgXszIo9IRy+LfsZJmQ4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204112; c=relaxed/simple;
	bh=kdB8WIOxwO2C53M0y4AcDu0X0yqW/XkaMCc2OZPGO2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuoiDyp4KVH0Tfc5B9Fi3OWNmueni/ETo14ZpxiFCoRensIo+05TItDYDdBLpJQIDfFmyY3nB6opeovaCb+YzpRq+owGg+lg6KluyPVIBozYiUdhpPT+ggE2u7tYFVwtvHmcaxF+h4VfjcKlm77qcSnZoD8jnIp8V2m1fr+8f2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVVzt42m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF42C4CECD;
	Tue, 29 Oct 2024 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730204111;
	bh=kdB8WIOxwO2C53M0y4AcDu0X0yqW/XkaMCc2OZPGO2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVVzt42mgTPSaeawjxkz5xwhVUK3ZDWBAF8guGKwGQsTORdU4QBcP+dCCaLofkfcx
	 hqaE4tzHiRv03XeUwle9YGh8klwlBlW1R3sTE6GAdJ7Xp8F+YTJa4/hC2UWWnHTY45
	 mvl/eDaY8Ew2jdZ3xAXbZxhMIfwwLKg5LV9a+xc/WL3Ix3au46esLZ4q7VLQzNyqeV
	 B1X9Cw7YHwLxYhs8fYJWGNGC1RPPByfcosKqsVTSF3AUPnL0xfJM8lKlX1VX500POT
	 wQug9JbM+ZZsPG8CmtDjQq65Zmd/zqdqLswiz0jxKyJ9VT3+OZAA+9/AEcRhUEmVQ2
	 EtV/ANU5APoLQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5l8F-0000000034K-2UT4;
	Tue, 29 Oct 2024 13:15:31 +0100
Date: Tue, 29 Oct 2024 13:15:31 +0100
From: Johan Hovold <johan@kernel.org>
To: wojackbb@gmail.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: qcserial: add support for Sierra Wireless
 EM86xx
Message-ID: <ZyDR4_CY_nyiTx0K@hovoldconsulting.com>
References: <20241028081949.699921-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028081949.699921-1-wojackbb@gmail.com>

On Mon, Oct 28, 2024 at 04:19:49PM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Add support for Sierra Wireless EM86xx with 
> USB-id 0x1199:0x90e5 & 0x1199:0x90e4.

> Signed-off-by: Jack Wu <wojackbb@gmail.com>
> ---

I had another patch in my inbox from you adding these ids so this is a
v2. This should be indicated in the patch summary (e.g. "[PATCH v2] USB:
serial: ...) and by adding a short changelog here describing what
changed from the previous versions.

>  drivers/usb/serial/qcserial.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
> index c7de9585feb2..933589ba5869 100644
> --- a/drivers/usb/serial/qcserial.c
> +++ b/drivers/usb/serial/qcserial.c
> @@ -168,6 +168,8 @@ static const struct usb_device_id id_table[] = {
>  	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
>  	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
>  	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
> +	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
> +	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */

Also try to keep the entries sorted by PID.

>  	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
>  	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
>  	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */

Please fix this up in a v3.

Johan

