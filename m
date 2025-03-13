Return-Path: <linux-kernel+bounces-559936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99350A5FB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096AC7AD576
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA0926988F;
	Thu, 13 Mar 2025 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MTHih080"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5522690ED;
	Thu, 13 Mar 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882567; cv=none; b=ZlfyVAowN3OK7BEOqw9GRuJtcavRISnRCGNGFV69m+mPyI22cCy5ZEZnkppYthlbufNR+k9kpR3X9IKmyeWCwPJtQ7jJYBmY4dLE6EXh7vkVya9r200Y7snPBjrQHcEMd2Es0alanK2uyyznKAFG/wYa4PAxDfn9hg8r4+o986w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882567; c=relaxed/simple;
	bh=yUmkTzMi123EFNjSyr+Nu88LBaqNtFxixC2H4c1JMQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+WT/nsn6Y0wJQgh5GZNva7BKY6KsVlj243Ud6E3xEwxx9FUksOukhS3A7ogwF1CyW5S8txe65aRGO+EQGKv6zVyySJotKryP4MWNavEExF91+0OVSHKcYV+BN0nQUB0uSxvoHqEMrB+pOnYFH3dhm3SVu6Gd5YvunSnoizvJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MTHih080; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741882563;
	bh=yUmkTzMi123EFNjSyr+Nu88LBaqNtFxixC2H4c1JMQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTHih080InpHqTzHsV6hLWwBbfo4DLUxJeO80hM8KosTXaXTHGQ/j+M6Nb1pA6J2n
	 J1PAbPpcNEp6Lt6ox6/+AM7NfyQkF6gtOB+O23wkXReT0IclsJPcBrSTC0dhPfCPYl
	 USpc5kMAQnBMGETDQF9SMrUg3vFN+Htk91Sky+Lo=
Date: Thu, 13 Mar 2025 17:16:03 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Export the target RPM fan control by ChromeOS EC
 under hwmon
Message-ID: <df6f96a1-66f0-4a83-a543-f71ca8d37eed@t-8ch.de>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>

Hi Sung-Chi,

On 2025-03-13 12:47:41+0800, Sung-Chi Li wrote:
> ChromeOS embedded controller (EC) supports closed-loop fan control. We
> anticipate to have the fan related control from the kernel side, so this
> series register the HWMON_F_TARGET attribute, and implement the read and
> write function for setting/reading the target fan RPM from the EC side.

In general the idea is fine. I'll post some comments for the patches.

The series should be squashed into a single patch. All the new code is
closely related to each other.

> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
> Sung-Chi Li (3):
>       hwmon: (cros_ec) Add setting target fan RPM function
>       hwmon: (cros_ec) Add reading target fan RPM function
>       hwmon: (cros_ec) Register fan target attribute
> 
>  drivers/hwmon/cros_ec_hwmon.c | 69 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 5 deletions(-)
> ---
> base-commit: 9fbcd7b32bf7c0a5bda0f22c25df29d00a872017
> change-id: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3
> 
> Best regards,
> -- 
> Sung-Chi Li <lschyi@chromium.org>

