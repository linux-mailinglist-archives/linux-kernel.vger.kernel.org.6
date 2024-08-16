Return-Path: <linux-kernel+bounces-289507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3E9546DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4053B1F23626
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E3C1917FC;
	Fri, 16 Aug 2024 10:42:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEF18FC83
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804961; cv=none; b=JvtSuoPJ5w1X5XGjHI0vqqfDCVvw9lMtQGXXzZJJMJe3GM0wiYOtscOpJ7wXmS9VToK+KEyX9Ntd2iXjwKHihkWIYBZsnbydDCR6p4PYdI3c2LYwEu0YTE9TONNsjcO8FN6F+TiY5EcptErL86jm/1nBryugem2HAtiQcPN2NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804961; c=relaxed/simple;
	bh=2gQUb4xpYueo47eiH779suL6H3eFVak5XnEmjinlyBs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrO3gNWniK0b7TOdKKat6KWUGQ1BVY9YyZiQIer8RgBxXUWzZwmSyxlYA/FjsEzEoiexSHxhItE/oSCdHXXFYozpsQn00GrqRiBWXzK/Kkt4WSITiy4vzGiBUe5VMiOXGKz9l5mn7AYOV5uHOl+/mie6Zsrbphg4trfPUw9xdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wldm80kfqz67pJF;
	Fri, 16 Aug 2024 18:39:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B247F140119;
	Fri, 16 Aug 2024 18:42:35 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 16 Aug
 2024 11:42:35 +0100
Date: Fri, 16 Aug 2024 11:42:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 01/10] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20240816114233.00003805@Huawei.com>
In-Reply-To: <20240816075324.19d13670@foz.lan>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
	<0be6db8d06b3abab551f24dcc645d46d72d3f668.1723591201.git.mchehab+huawei@kernel.org>
	<20240814133321.00006401@Huawei.com>
	<20240816075324.19d13670@foz.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 07:53:24 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 14 Aug 2024 13:33:21 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
> 
> > On Wed, 14 Aug 2024 01:23:23 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Adds a generic error device to handle generic hardware error
> > > events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> > > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> > > using HID PNP0C33.
> > > 
> > > The PNP0C33 device is used to report hardware errors to
> > > the guest via ACPI APEI Generic Hardware Error Source (GHES).
> > > 
> > > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/acpi/aml-build.c                    | 10 ++++++++++
> > >  hw/acpi/generic_event_device.c         |  8 ++++++++
> > >  include/hw/acpi/acpi_dev_interface.h   |  1 +
> > >  include/hw/acpi/aml-build.h            |  2 ++
> > >  include/hw/acpi/generic_event_device.h |  1 +
> > >  5 files changed, 22 insertions(+)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 6d4517cfbe3d..cb167523859f 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -2520,3 +2520,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
> > >  
> > >      return var;
> > >  }
> > > +
> > > +/* ACPI 5.0: 18.3.2.6.2 Event Notification For Generic Error Sources */    
> > 
> > Given this section got a rename maybe the comment should mention old
> > name and current name for the section?  
> 
> ACPI 6.5 has the same name for the section:

We did a bit of digging after an offline discussion.
It's only there in Errata B of ACPI 5.0.  So need to update this reference
to be more specific if we want to avoid confusion.

> 
> 	18.3.2.7.2. Event Notification For Generic Error Sources
> 
> 	An event notification is recommended for corrected errors where latency 
> 	in processing error reports is not critical to proper system operation. 
> 	The implementation of Event notification requires the platform to define
> 	a device with PNP ID PNP0C33 in the ACPI namespace, referred to as the
> 	error device. 
> 
> Just section number changed. IMO, it is still good enough to seek for
> it at the docs.
> 
> Btw, in this specific case, the best is to use the search box of
> Sphinx html output and seek for PNP0C33 ;-)
> 
> >   
> > > +Aml *aml_error_device(void)
> > > +{
> > > +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> > > +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> > > +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > > +
> > > +    return dev;
> > > +}
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index 15b4c3ebbf24..1673e9695be3 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
> > >      ACPI_GED_PWR_DOWN_EVT,
> > >      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> > >      ACPI_GED_CPU_HOTPLUG_EVT,
> > > +    ACPI_GED_ERROR_EVT    
> > 
> > trailing comma missing.  
> 
> I'll add.
> 
> Thanks,
> Mauro


