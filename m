Return-Path: <linux-kernel+bounces-538151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D0A4950B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E833E7A321A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E56E25C70E;
	Fri, 28 Feb 2025 09:30:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F94257434
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735006; cv=none; b=FHs0k9zFAIF5Ck6r+OrmivlorbvUVXbKrLiV9UpFAU8snAuWpNIDv0m9m9uANY10Jzsmx9Y0/5EfM7hQDsM20/o22hmcojE5aFpiOc0xQD4SkBWYxcrlQL7k5QG4GDsON6WVsdT+A26RkGP0oWffgo3D4XL1OyJPqp8GjJyRr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735006; c=relaxed/simple;
	bh=24oC386422ePAgsMPWbvUb/aX6+nV/UCDhbtqdyFH7k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIsJYfx4IHBiyWkpXK48WXnMdvaxzi7wW1FAVVPPipSA8LO5twhB8kxKtdKJlIGLiSVKzICyJWxrdQngnb1fIBYJBN9E8iKl558j5U95DT9pb/z+Cbuf78P10gsyHfi4/8jB3ntLJ7OURiR3o1dOdVxzyvEcMJaaeo0sJB4mviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z42tp0HRVz6K5rN;
	Fri, 28 Feb 2025 17:28:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EAD9F1400D4;
	Fri, 28 Feb 2025 17:30:02 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 28 Feb
 2025 10:30:00 +0100
Date: Fri, 28 Feb 2025 17:29:55 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 16/19] acpi/generic_event_device.c: enable
 use_hest_addr for QEMU 10.x
Message-ID: <20250228172955.0000740e@huawei.com>
In-Reply-To: <797c0199ef713241db145baf3860d32e0eb1d03a.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<797c0199ef713241db145baf3860d32e0eb1d03a.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 17:00:54 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that we have everything in place, enable using HEST GPA
> instead of etc/hardware_errors GPA.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Looks good.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/acpi/generic_event_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index f029753ab709..9fe70b74bd42 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -332,7 +332,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
>      DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
> -                     ghes_state.use_hest_addr, false),
> +                     ghes_state.use_hest_addr, true),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {


