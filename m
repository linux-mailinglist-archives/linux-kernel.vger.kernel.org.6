Return-Path: <linux-kernel+bounces-342928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F79894E9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54B7283F26
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082D15C150;
	Sun, 29 Sep 2024 10:53:19 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE1152E1C;
	Sun, 29 Sep 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727607199; cv=none; b=qsPV5UuClOwtUe8KRvt/N6ejL9UEhihHQvuYXKMkXxzJEdvV4iMlo8rlNHWviqSGhwsXni2LDjrVqH0fOoeJLQ6xi9O3/n7BCQ4+KExg6ZT4PwEb3G5H8EP2XTesPMCAVw6g2APCR4g+yjBamYQOCl7TUa/l6f/nUUH+q9++4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727607199; c=relaxed/simple;
	bh=cPqISAcZ4H8167b3x7BdNIv2c5BtODWuLOlPU3TW730=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVhT1/1aINwAZnAIPotz4RmYE9N1uRqSYjVevyL6WEREDZxWsar+Llp1pBrJ7J/+JTs9xmHhSva15yx8kneIMPOdyvzQ+EEqV7VMU54L7DfSaQNf40oR27Z17x9+6bK3K8QsuBTQ2FbnbfIE0hi4JkEtICTYII6/9siW5grU2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1surY2-000000007Ck-3WVz;
	Sun, 29 Sep 2024 10:53:06 +0000
Date: Sun, 29 Sep 2024 11:52:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, John Crispin <john@phrozen.org>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: mtd: ubi-volume: add
 'volume-is-critical' property
Message-ID: <Zvkxi-6J8R1K95PQ@makrotopia.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
 <7a2e8819-ac70-4070-a731-53994c72cd79@kernel.org>
 <Zvf_84xxhxwpPgee@makrotopia.org>
 <18e9d774-813b-427e-9938-53853d695e18@kernel.org>
 <ZvgU0eBEwTJ3sHuN@makrotopia.org>
 <ad5a3811-c856-4f4b-f569-bb67a0e3f751@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad5a3811-c856-4f4b-f569-bb67a0e3f751@huawei.com>

On Sun, Sep 29, 2024 at 12:03:11PM +0800, Zhihao Cheng wrote:
> 在 2024/9/28 22:38, Daniel Golle 写道:
> > On Sat, Sep 28, 2024 at 03:45:49PM +0200, Krzysztof Kozlowski wrote:
> > > On 28/09/2024 15:09, Daniel Golle wrote:
> > > > On Sat, Sep 28, 2024 at 03:02:47PM +0200, Krzysztof Kozlowski wrote:
> > > > > On 28/09/2024 14:47, Daniel Golle wrote:
> > > > > > Add the 'volume-is-critical' boolean property which marks a UBI volume
> > > > > > as critical for the device to boot. If set it prevents the user from
> > > > > > all kinds of write access to the volume as well as from renaming it or
> > > > > > detaching the UBI device it is located on.
> > > > > > 
> > > > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > > > ---
> > > > > >   .../devicetree/bindings/mtd/partitions/ubi-volume.yaml   | 9 +++++++++
> > > > > >   1 file changed, 9 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> > > > > > index 19736b26056b..2bd751bb7f9e 100644
> > > > > > --- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> > > > > > @@ -29,6 +29,15 @@ properties:
> > > > > >       description:
> > > > > >         This container may reference an NVMEM layout parser.
> > > > > > +  volume-is-critical:
> > > > > > +    description: This parameter, if present, indicates that the UBI volume
> > > > > > +      contains early-boot firmware images or data which should not be clobbered.
> > > > > > +      If set, it prevents the user from renaming the volume, writing to it or
> > > > > > +      making any changes affecting it, as well as detaching the UBI device it is
> > > > > > +      located on, so direct access to the underlying MTD device is prevented as
> > > > > > +      well.
> > > > > > +    type: boolean
> > > > > 
> > > > > UBI volumes are mapping to partitions 1-to-1, right? So rather I would
> > > > > propose to use partition.yaml - we already have read-only there with
> > > > > very similar description.
> > > > 
> > > > No, that's not the case.
> > > > 
> > > > An MTD partition can be used as UBI device. A UBI device (and hence MTD
> > > > partition) can host *several* UBI volumes.
> > > > 
> > > > Marking the MTD partition as 'read-only' won't work, as UBI needs
> > > > read-write access to perform bad block relocation, scrubbing, ...
> > > 
> > > OK, so not partition but read-only volume.
> > 
> > +1
> > 
> > > 
> > > > 
> > > > Also, typically not all UBI volumes on a UBI device are
> > > > read-only/critical but only a subset of them.
> > > > 
> > > > But you are right that the description is inspired by the description
> > > > of the 'read-only' property in partition.yaml ;)
> > > > 
> > > > I initially thought to also name the property 'read-only', just like
> > > > for MTD partitions. However, as the desired effect goes beyond
> > > > preventing write access to the volume itself, I thought it'd be
> > > > better to use a new name.
> > > 
> > > Yeah, maybe... critical indeed covers multiple cases but is also
> > > subjective. For some bootloader is critical, for other bootloader still
> > > might be fully A/B updateable thus could be modifiable. For others, they
> > > want to use fw_setenv from user-space so not critical at all.
> > 
> > The case I want to cover here is the bootloader itself being stored
> > inside a UBI volume. MediaTek's fork of ARM TrustedFirmware-A bl2 comes
> > with support for UBI and loads BL3 (which is TF-A BL31 and U-Boot, and
> > maybe OP-TEE as well) from a static UBI volume. Removing, renaming or
> > altering that volume results in the device not being able to boot any
> > more and requiring a complicated intervention (at attaching debugging
> > UART and using low-level recovery tool) in order to recover.
> 
> Who removes/renames the 'critical' volume? I suggest to fix it in the upper
> layer(not in kernel). After looking through the patch 2, it seems a hack
> solution.

The enemy is the user, the upper layer is between the keyboard and the
screen. Just like for 'read-only' MTD partitions I'm looking
for a similar solution for UBI which prevents the user from accidentally
deleting or destroying the bootloader, lets say, when logged in via SSH.

