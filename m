Return-Path: <linux-kernel+bounces-432706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA25A9E4F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4998F18819D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27EF1C303E;
	Thu,  5 Dec 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVlXlbqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C121C3C15
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385606; cv=none; b=PozqLubbK8u5N9FDsoXDX/6AY8D/CLhrdgBTpmUICC6xaO4mXKIjIMjuOBRFwgjfvZVXHCqDa1gCGvQbJjqlfI32a6bNZBacrkUopwOJ+zK0WmIPFn16EfkaiiWQmp72epfjgn6Oyr5F0/r/Plv4WbMHZJz6O6bPMdm09qgACJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385606; c=relaxed/simple;
	bh=q7ysq63iGMnUWGArTOv4L3H5qVOaDhKU0OUZpTni/Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4MXKmxMBtmDU/sk24eFpSLrwwOHx0Nb0laAmkHSIga6ICtQXQwYAUwOTw6mtO4mnO5Sj8/AlPxNuwYXIUqbmJBbFQm+8pUa6BgFoZDXyQnLsCFHj2zVs4I0eF87iNDvuUqhcR9EOFj0xXhBNZ/qZvnOjNQqyqrFwU4hUVDJ0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVlXlbqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820FBC4CED1;
	Thu,  5 Dec 2024 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733385605;
	bh=q7ysq63iGMnUWGArTOv4L3H5qVOaDhKU0OUZpTni/Xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jVlXlbqH6PR+Y396UgJAD97rcUiSCOmuBQtf1jEZvS3SAIn00BDsYr88FpVpPIZHt
	 7mmi0arZ61XfJVSxN9nPdsGuztCxaS9OvLcDEG0ddlTNxf50eNfexvTbBGrvG1QvmM
	 lvi3rO2j0X3iCPj0+Gpbl9iz2wokXZcOD8rg3IL6Im0MgbJdbYgQ5m92RHGwBgNI+E
	 TyJMqg/SlcodLQCcpUziYZB9cYaqNBltsr0SVpunycEDlchCIZLF0WddiMxKcFAV7+
	 oDB5Jmqm6mYDMq7odpIghOm31cR/8XBkh9bhdYXfKvD7/ftn43aQFS2gDNB5C8JJTG
	 IuG6/oD8ktDjQ==
Date: Thu, 5 Dec 2024 08:59:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 13/16] acpi/ghes: better name the offset of the
 hardware error firmware
Message-ID: <20241205085959.2223d079@foz.lan>
In-Reply-To: <20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
	<20b003136d8c008fd54e8d40c806f13867336e13.1733297707.git.mchehab+huawei@kernel.org>
	<20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 4 Dec 2024 17:37:59 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed,  4 Dec 2024 08:41:21 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The hardware error firmware is where HEST error structures are  
>       ^^^^^^^^^^^^^^^^^^^^^^^ I can't parse this, suspect you've meant something else here
> 
> > stored. Those can be GHESv2, but they can also be other types.
> > 
> > Better name the location of the hardware error.
> > 
> > No functional changes.

I meant this fw_cfg file:
#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"

What about changing description to:

	The etc/hardware_errors fw_cfg file is where the HEST error
	source structures are stored. Those can be GHESv2, but they can also
	be other types.

	For more details about error source structure, see:
	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source

	Better name the address variable from ghes_error_le to hw_error_le
	to better reflect that.

	No functional changes.

> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/acpi/generic_event_device.c | 4 ++--
> >  hw/acpi/ghes.c                 | 4 ++--
> >  include/hw/acpi/ghes.h         | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 663d9cb09380..17baf36132a8 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .fields = (const VMStateField[]) {
> > -        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > +        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > @@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
> >  static bool ghes_needed(void *opaque)
> >  {
> >      AcpiGedState *s = opaque;
> > -    return s->ghes_state.ghes_addr_le;
> > +    return s->ghes_state.hw_error_le;
> >  }
> >  
> >  static const VMStateDescription vmstate_ghes_state = {
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 52c2b69d3664..90d76b9c2d8c 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >  
> >      /* Create a read-write fw_cfg file for Address */
> >      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> > -        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> > +        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> >  
> >      ags->present = true;
> >  }
> > @@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> >      }
> >      ags = &acpi_ged_state->ghes_state;
> >  
> > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > +    start_addr = le64_to_cpu(ags->hw_error_le);
> >  
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 21666a4bcc8b..39619a2457cb 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -65,7 +65,7 @@ enum {
> >  };
> >  
> >  typedef struct AcpiGhesState {
> > -    uint64_t ghes_addr_le;
> > +    uint64_t hw_error_le;
> >      bool present; /* True if GHES is present at all on this board */
> >  } AcpiGhesState;
> >    
> 



Thanks,
Mauro

