Return-Path: <linux-kernel+bounces-342500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC26988FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF99A1F21854
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCB1B285;
	Sat, 28 Sep 2024 14:38:25 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0EA18E11;
	Sat, 28 Sep 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534305; cv=none; b=GDtyOifNPeWzqI2TA9YBkgPjmqJhdH0LDsl++fitSGapyoXo7D2tispvE6Gt08BZRMG7OcFu1iueHRFXR54yTFQ9ABnwuxtPnhIANirDUUZQGUYbetLqTtxChJYvdylf+GTF4h0QNrBj/e+tlu/mfUm848pMtXRaSf47POlOcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534305; c=relaxed/simple;
	bh=orNYKmAZbrf/C4rgpwI9BuYiqkQCDmytE2oEUIOF6vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGQ9O6+mBVt9wyAbdBweYtu0TMhUr15fcCZkEm3/TuOAzFJ/jc0yzR7005b3fW/mzmH7ztFUgyWyU4Z84gFDFH1oiiVCBcd983zd/Po6sJfsaZlxO2NUOl9DORHCVDPfUAKEVWobu6uUz+tqioOQFZCcgS8yRQHGiizQr8TQtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1suYaL-000000004ig-0ri1;
	Sat, 28 Sep 2024 14:38:13 +0000
Date: Sat, 28 Sep 2024 15:38:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	John Crispin <john@phrozen.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: mtd: ubi-volume: add
 'volume-is-critical' property
Message-ID: <ZvgU0eBEwTJ3sHuN@makrotopia.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
 <7a2e8819-ac70-4070-a731-53994c72cd79@kernel.org>
 <Zvf_84xxhxwpPgee@makrotopia.org>
 <18e9d774-813b-427e-9938-53853d695e18@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e9d774-813b-427e-9938-53853d695e18@kernel.org>

On Sat, Sep 28, 2024 at 03:45:49PM +0200, Krzysztof Kozlowski wrote:
> On 28/09/2024 15:09, Daniel Golle wrote:
> > On Sat, Sep 28, 2024 at 03:02:47PM +0200, Krzysztof Kozlowski wrote:
> >> On 28/09/2024 14:47, Daniel Golle wrote:
> >>> Add the 'volume-is-critical' boolean property which marks a UBI volume
> >>> as critical for the device to boot. If set it prevents the user from
> >>> all kinds of write access to the volume as well as from renaming it or
> >>> detaching the UBI device it is located on.
> >>>
> >>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >>> ---
> >>>  .../devicetree/bindings/mtd/partitions/ubi-volume.yaml   | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> >>> index 19736b26056b..2bd751bb7f9e 100644
> >>> --- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> >>> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> >>> @@ -29,6 +29,15 @@ properties:
> >>>      description:
> >>>        This container may reference an NVMEM layout parser.
> >>>  
> >>> +  volume-is-critical:
> >>> +    description: This parameter, if present, indicates that the UBI volume
> >>> +      contains early-boot firmware images or data which should not be clobbered.
> >>> +      If set, it prevents the user from renaming the volume, writing to it or
> >>> +      making any changes affecting it, as well as detaching the UBI device it is
> >>> +      located on, so direct access to the underlying MTD device is prevented as
> >>> +      well.
> >>> +    type: boolean
> >>
> >> UBI volumes are mapping to partitions 1-to-1, right? So rather I would
> >> propose to use partition.yaml - we already have read-only there with
> >> very similar description.
> > 
> > No, that's not the case.
> > 
> > An MTD partition can be used as UBI device. A UBI device (and hence MTD
> > partition) can host *several* UBI volumes.
> > 
> > Marking the MTD partition as 'read-only' won't work, as UBI needs
> > read-write access to perform bad block relocation, scrubbing, ...
> 
> OK, so not partition but read-only volume.

+1

> 
> > 
> > Also, typically not all UBI volumes on a UBI device are
> > read-only/critical but only a subset of them.
> > 
> > But you are right that the description is inspired by the description
> > of the 'read-only' property in partition.yaml ;)
> > 
> > I initially thought to also name the property 'read-only', just like
> > for MTD partitions. However, as the desired effect goes beyond
> > preventing write access to the volume itself, I thought it'd be
> > better to use a new name.
> 
> Yeah, maybe... critical indeed covers multiple cases but is also
> subjective. For some bootloader is critical, for other bootloader still
> might be fully A/B updateable thus could be modifiable. For others, they
> want to use fw_setenv from user-space so not critical at all.

The case I want to cover here is the bootloader itself being stored
inside a UBI volume. MediaTek's fork of ARM TrustedFirmware-A bl2 comes
with support for UBI and loads BL3 (which is TF-A BL31 and U-Boot, and
maybe OP-TEE as well) from a static UBI volume. Removing, renaming or
altering that volume results in the device not being able to boot any
more and requiring a complicated intervention (at attaching debugging
UART and using low-level recovery tool) in order to recover.

It is true that also in this case a fully A/B updateable strategy could
be implemented, however, typically that would not be done in Linux, but
rather the code carrying out such update would be part of the bootloader
itself.
UEFI update capsules are a good example for that, but in most cases
things are much less complex on simple embedded Linux networking
appliances such as routers, access points, switches, ...

> 
> I am in general not so happy in describing flash layout in DT, because
> it sounds way too policy or one-use-case specific.
> 
> UBI volume is purely SW construct. One OS can partition MTD in multiple
> ways, so maybe I just do not understand why we have in the first place.

Support for attaching UBI from DT and referencing UBI volumes has been
added because they serve as NVMEM providers, ie. UBI volumes are used to
store things such as Ethernet MAC addresses and Wi-Fi calibration data,
similar to how it also works on devices with NOR flash and simple MTD
partitions holding that data.
And we needed the kernel drivers to be able to access that information
directly, also in case eg. nfsroot is being used.

So while it's true that both, MTD partitioning as well as use of UBI
are pure software constructs, their use can go beyond and below the OS
kernel, meaning that early boot firmware usually requires a specific MTD
partition layout, and some require also certain UBI volumes to be present
for the device to be able to even start the bootloader.

It is also true that (just like MTD partitioning as well) it is
questionable whether this should be communicated as a property of the
flash hardware in DT, or rather end up as information filed under the
/chosen node which to me seems more appropriate. Moving all MTD
partitioning away from the node representing the flash chip and into the
/chosen node would have to happen in a way which doesn't break
compatibility with existing DT, which all describe MTD partitions as a
subnode of the storage hardware itself. Obviously that is beyond the
scope (and independent) of being able to mark some UBI volumes as
critical.

