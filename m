Return-Path: <linux-kernel+bounces-342968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66140989544
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8EAB235E4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD74F16D30B;
	Sun, 29 Sep 2024 12:17:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064C42AB1;
	Sun, 29 Sep 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727612236; cv=none; b=ueH4pEu+7FHjQgjF1lSW+Y8oYvFS7mm+5IBuhULQ+kA7gsxJdQOpAGbhkUB5HtIRpKkn0szSCsxisPHRfeDoX+GA5HBuNh/gGJNykXgD7CYGerJyhglRr5g6YxzqJ8J8fOi7NspFgs6OmmvEqFsX5OlpmTXvmSN/YOPB0H/nQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727612236; c=relaxed/simple;
	bh=/My963PN4JTATzj4wq56r34fE/qUpsLRAXsud6kWkuU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tZcVh1pVnbt334R8x5sr998TtfRnk1MvqIL4EF3TUs8ch0C87KES+5Ie6itudOl14N1n4NbMxupbEf42FjSV67qhRysqARjQHfbplr7XIfQMwWasGGZ6VA6C0YaFchsOx+UzvjvuR61EmONGwoxK2rxKCGSvs+sVfxpnqHtoxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1susrI-000000007Nu-0u24;
	Sun, 29 Sep 2024 12:17:04 +0000
Date: Sun, 29 Sep 2024 12:16:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, John Crispin <john@phrozen.org>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_1/2=5D_dt-bindings=3A_mtd=3A_ubi?=
 =?US-ASCII?Q?-volume=3A_add_=27volume-is-critical=27_property?=
User-Agent: K-9 Mail for Android
In-Reply-To: <3fbc4221-5967-fb9a-3cee-91cd5de2b805@huawei.com>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org> <7a2e8819-ac70-4070-a731-53994c72cd79@kernel.org> <Zvf_84xxhxwpPgee@makrotopia.org> <18e9d774-813b-427e-9938-53853d695e18@kernel.org> <ZvgU0eBEwTJ3sHuN@makrotopia.org> <ad5a3811-c856-4f4b-f569-bb67a0e3f751@huawei.com> <Zvkxi-6J8R1K95PQ@makrotopia.org> <3fbc4221-5967-fb9a-3cee-91cd5de2b805@huawei.com>
Message-ID: <5FEB28F8-BE2B-4C97-848C-914CA760BF7F@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29 September 2024 11:23:12 UTC, Zhihao Cheng <chengzhihao1@huawei=2Ecom=
> wrote:
>=E5=9C=A8 2024/9/29 18:52, Daniel Golle =E5=86=99=E9=81=93:
>> On Sun, Sep 29, 2024 at 12:03:11PM +0800, Zhihao Cheng wrote:
>>> =E5=9C=A8 2024/9/28 22:38, Daniel Golle =E5=86=99=E9=81=93:
>>>> On Sat, Sep 28, 2024 at 03:45:49PM +0200, Krzysztof Kozlowski wrote:
>>>> [=2E=2E=2E]
>>>> The case I want to cover here is the bootloader itself being stored
>>>> inside a UBI volume=2E MediaTek's fork of ARM TrustedFirmware-A bl2 c=
omes
>>>> with support for UBI and loads BL3 (which is TF-A BL31 and U-Boot, an=
d
>>>> maybe OP-TEE as well) from a static UBI volume=2E Removing, renaming =
or
>>>> altering that volume results in the device not being able to boot any
>>>> more and requiring a complicated intervention (at attaching debugging
>>>> UART and using low-level recovery tool) in order to recover=2E
>>>=20
>>> Who removes/renames the 'critical' volume? I suggest to fix it in the =
upper
>>> layer(not in kernel)=2E After looking through the patch 2, it seems a =
hack
>>> solution=2E
>>=20
>> The enemy is the user, the upper layer is between the keyboard and the
>> screen=2E Just like for 'read-only' MTD partitions I'm looking
>> for a similar solution for UBI which prevents the user from accidentall=
y
>> deleting or destroying the bootloader, lets say, when logged in via SSH=
=2E
>> =2E
>>=20
>
>I guess that other partitions(excepts mtd) have the similar situations, u=
sers could delete a rootfs(ext4) partition by operation the raw block devic=
e=2E The kernel has no way to stop user doing this, what if the user just w=
ant to rebuild partions?

True, but as you correctly pointed out the worst-case scenario would be Li=
nux no longer booting=2E You would fix that by using a bootable USB pendriv=
e=2E
However, the user wont easily manage to delete the bootloader or BIOS by a=
ccident, such as a simple typo of the partition number or accidentally dest=
roying GPT=2E If the storage of low-level boot firmware is accissible from =
within Linux then there are always additional safeguards, such as the write=
-protection of mmcblkXbootY hw-partition, or MTD partitons holding bootload=
er components being marked as read-only=2E

>Marking volume as critical(by a stopper in kernel) could prevent user mis=
takenly operating, but I think it is more important that user need to know =
what he/she is doing=2E

I agree that education of users is crucial, yet I think the risk of needin=
g complicated hardware interventions (direct access to NAND flash chip, att=
aching JTAG, =2E=2E=2E) which are required in order to recover from a mista=
ke should also be taken into account=2E

