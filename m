Return-Path: <linux-kernel+bounces-433450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BD9E5888
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64FE16AE4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A176C218EA1;
	Thu,  5 Dec 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS8wJqJx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA7149C64
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409196; cv=none; b=OX8FRbVUfzdp6oW2OD0o19InvHa3tbsrZICGgyuHhJrld9sa4eTBJjJkiG9bi/uwVXTl+Fiwb8hNCSLWFIDVpHWMuLc6ISnHzUlgQLmeLPIvyDuq+nMpM9XE6wKJ7GR+zgm9/yTts9zLFkM4e9VlBoDgeUAvwHyRrmEDvYzcmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409196; c=relaxed/simple;
	bh=udsK/NXo03cqE0THHxdmSiUCLh2tIPbDao/AdhDKz/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5jKOHW6QMEe94zefw4YEebr6jS1BgmQB++NC8kt3EgKi+gi46ZAfoCwKS+ApXW1kH3gtTiOMkoRWdcxxBZYv0BrskT7vYv/D+kA3ztEGmkgnMXlvQGQ2NiGYgzFF7sHafaxZf8/PkyR356McJ/OYBUAI1iMY8NEBcWDRHJcm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS8wJqJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAB1C4CED1;
	Thu,  5 Dec 2024 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409195;
	bh=udsK/NXo03cqE0THHxdmSiUCLh2tIPbDao/AdhDKz/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KS8wJqJxe2i6CmkGiraT/fZWdQh0HSRdIFhToMu6N0p5dETN1rGQaE+ELzNYyfl8Z
	 J+nOyIcmUmULOlftEtf2+QiXxum1U3R+Ao1/yKucGMrJu1A1hYGIlwT0DXyAJzRFBg
	 aAXJY7E2pKMJClYMMjoEECClf0cGQbodZz3UYPERhEBZ4kd879cxPH9uVydJ6t+D3U
	 6vgXj92h2DTaEIF4P1VIQUo3+bdZuW7lzdjFXoXqxrYJ02lERkx+is5bTN3M12d1n+
	 0y3xRuoUpzgGzFghDKrekYwhwnSY3j+BQCS/7seXvT59ZJWzQbobAlIiryLNCBiWzn
	 CMP4RRJJdZhwQ==
Date: Thu, 5 Dec 2024 15:33:10 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 13/16] acpi/ghes: better name the offset of the
 hardware error firmware
Message-ID: <20241205153310.2e73a5bf@foz.lan>
In-Reply-To: <20241205102219.274e3d27@imammedo.users.ipa.redhat.com>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
	<20b003136d8c008fd54e8d40c806f13867336e13.1733297707.git.mchehab+huawei@kernel.org>
	<20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
	<20241205085959.2223d079@foz.lan>
	<20241205102219.274e3d27@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 5 Dec 2024 10:22:19 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 5 Dec 2024 08:59:59 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Wed, 4 Dec 2024 17:37:59 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Wed,  4 Dec 2024 08:41:21 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > The hardware error firmware is where HEST error structures are      
> > >       ^^^^^^^^^^^^^^^^^^^^^^^ I can't parse this, suspect you've meant something else here
> > >     
> > > > stored. Those can be GHESv2, but they can also be other types.
> > > > 
> > > > Better name the location of the hardware error.
> > > > 
> > > > No functional changes.    
> > 
> > I meant this fw_cfg file:
> > #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> > #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> > 
> > What about changing description to:
> > 
> > 	The etc/hardware_errors fw_cfg file is where the HEST error
> > 	source structures are stored. Those can be GHESv2, but they can also
> > 	be other types.  
> 
> As I understand it, etc/hardware_errors is a blob
> for '18.3.2.7.1. Generic Error Data' with some extra fields
> to accommodate GHESv2 handling (i.e. err addr indirection and ack reg).
> 
> While error sources are described in HEST (and only GHES ones would
> reference  etc/hardware_errors via error status addr/read ack register addr)

Yeah, what it is stored there is not the error source structures
themselves, but the additional address data they contain. For GHESv2,
such data is the Error Status Address (where CPER data is stored) and 
the Read Ack Register.

Currently, only GHES (type 9) and GHESv2 (type 10) have those
Generic Address Structure stored there.

What about then:

	The etc/hardware_errors fw_cfg file is where the HEST error
	source structures store registers pointed by Generic Address
	Structures, as defined at:

		https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-error-data-entry

	and
		
		https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-structure

	As the name of the firmware file is hardware_errors, better
	name the variable where the offset pointing to it will be stored
	from ghes_error_le to hw_error_le.

	No functional changes.

Regards,
Mauro

> 
> > 
> > 	For more details about error source structure, see:
> > 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source
> > 
> > 	Better name the address variable from ghes_error_le to hw_error_le
> > 	to better reflect that.
> > 
> > 	No functional changes.
> >   
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  hw/acpi/generic_event_device.c | 4 ++--
> > > >  hw/acpi/ghes.c                 | 4 ++--
> > > >  include/hw/acpi/ghes.h         | 2 +-
> > > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > > index 663d9cb09380..17baf36132a8 100644
> > > > --- a/hw/acpi/generic_event_device.c
> > > > +++ b/hw/acpi/generic_event_device.c
> > > > @@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
> > > >      .version_id = 1,
> > > >      .minimum_version_id = 1,
> > > >      .fields = (const VMStateField[]) {
> > > > -        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > > > +        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
> > > >          VMSTATE_END_OF_LIST()
> > > >      },
> > > >  };
> > > > @@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
> > > >  static bool ghes_needed(void *opaque)
> > > >  {
> > > >      AcpiGedState *s = opaque;
> > > > -    return s->ghes_state.ghes_addr_le;
> > > > +    return s->ghes_state.hw_error_le;
> > > >  }
> > > >  
> > > >  static const VMStateDescription vmstate_ghes_state = {
> > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > index 52c2b69d3664..90d76b9c2d8c 100644
> > > > --- a/hw/acpi/ghes.c
> > > > +++ b/hw/acpi/ghes.c
> > > > @@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > > >  
> > > >      /* Create a read-write fw_cfg file for Address */
> > > >      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> > > > -        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> > > > +        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> > > >  
> > > >      ags->present = true;
> > > >  }
> > > > @@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > > >      }
> > > >      ags = &acpi_ged_state->ghes_state;
> > > >  
> > > > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > > > +    start_addr = le64_to_cpu(ags->hw_error_le);
> > > >  
> > > >      start_addr += source_id * sizeof(uint64_t);
> > > >  
> > > > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > > > index 21666a4bcc8b..39619a2457cb 100644
> > > > --- a/include/hw/acpi/ghes.h
> > > > +++ b/include/hw/acpi/ghes.h
> > > > @@ -65,7 +65,7 @@ enum {
> > > >  };
> > > >  
> > > >  typedef struct AcpiGhesState {
> > > > -    uint64_t ghes_addr_le;
> > > > +    uint64_t hw_error_le;
> > > >      bool present; /* True if GHES is present at all on this board */
> > > >  } AcpiGhesState;
> > > >        
> > >     
> > 
> > 
> > 
> > Thanks,
> > Mauro
> >   
> 



Thanks,
Mauro

