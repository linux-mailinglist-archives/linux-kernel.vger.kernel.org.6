Return-Path: <linux-kernel+bounces-217907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7C90B5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388E11C2161E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD6B8480;
	Mon, 17 Jun 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="MlTNJ5yA"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6391D9511
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640612; cv=pass; b=ThUk9JWoACOfTarF7mX+U9X00Q1//RCkxPsSa9M9Hmz+nbRAWAY2ySfg/8SZIAh5uOisg+TCMCPqIOy3fqA7R8DXEhVzYTj5TkYIGCo5EJqO02Gfe68JMGj1E1BsS24ntr9AAzzs3ZleDU0boTfTNybWR7HNGQYqAtTC2EsqQXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640612; c=relaxed/simple;
	bh=qvtQkXAV7hbFm6WNqefq/KR9Y+kAopnxCYfCiEGoiio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sbi2IQB3cr+qXiuEzl07c4FNGgF7IHxszCvcYlp6O6Ov9qgkRxw4JinTudx90xeK6V0Odm/kLicuoNVCcZfyXcfKM/MIyGAjB8lvZAlXUBt3zPbIb6EkwG4xrGO4yHSs+W0/LEexQyHQ3XFaOhQTSEXwpk8KFpXYJghj8XIpHvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=MlTNJ5yA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1718640590; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T6VNZZTKWK98m6wccXRvPpXuMDfzjfZN4jNQRp06Zj4knWM00LZC1ppA1GIo5o8q1A0aJIAhw0N2w1jDDWYV9Q1ZPAfiL13j9FpBOtYw/kfylpCAJ16qlgkcKplLlus1PJXDEQyaCegwmCHh+uTf6N1+9iAI1iCzYSW1QHYeYfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718640590; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qvtQkXAV7hbFm6WNqefq/KR9Y+kAopnxCYfCiEGoiio=; 
	b=hoF1Que5YDTWB6IUAJpOLqkpo1SUg+oCelLmRs9ZQmYcK/FrODo+jzteJlsfpD4DDNpxbtxztpRV0Wlh4nkfe43RU+pToR3xfDm83FfRoMt+FrZm7BB/MI2TX+HauQIJpGaYZfpgNGe9tjQo5vFH7HqRC0cC14lX9TSdPUiUFKI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718640590;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=qvtQkXAV7hbFm6WNqefq/KR9Y+kAopnxCYfCiEGoiio=;
	b=MlTNJ5yAB+DkFWstBJJdGy6nDxJb7C7QxD+/TBmUDH9UPPHA4ai95ABjzYarajr6
	aBOi4Qz2pQxy2iAAicvGYTvOzOn3uco+SmhTBTvSfLfMj9FOquP8/OnsOUtqhVfstp7
	2OYd82Usu2MSc4rYjTvKRAxmLuH9NhRrYgbabf/NfgjbRAOUayxAa9vok7o+rW5PeRt
	AAKSKbxcpemAubkz7UX+Ps0FdsyeVXFsc2t1QcYSzB4y0EHog/9ajDiAgU8Fn0zJw9V
	JGHtYWrV19Vrg/WXl5SonZ84E6+QvVMdTqKrtON8xB/q2yROBFmJgI/jU3E1gFsS5ea
	+Aal/Gci4g==
Received: by mx.zohomail.com with SMTPS id 1718640587690600.9970315357476;
	Mon, 17 Jun 2024 09:09:47 -0700 (PDT)
Message-ID: <73597116d4f004c5f75cf4f13da1af405ea8da8b.camel@icenowy.me>
Subject: Re: [PATCH 1/2] drm/amdgpu: make duplicated EOP packet for GFX7/8
 have real content
From: Icenowy Zheng <uwu@icenowy.me>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Pierre-Eric
 Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Date: Tue, 18 Jun 2024 00:09:42 +0800
In-Reply-To: <d44651a7-0c07-4b84-8828-f1d405359aeb@amd.com>
References: <20240617105846.1516006-1-uwu@icenowy.me>
	 <20240617105846.1516006-2-uwu@icenowy.me>
	 <88337509-3ad7-47aa-b70f-5294f7f1e486@amd.com>
	 <b4ebdbce2f44c06806a650e72b1b6eb9a16dffe6.camel@icenowy.me>
	 <09fbcd1f-c7b1-47e3-9146-17f8189978a8@amd.com>
	 <e88d4722fa3bbd7104b140debdd85cb212628944.camel@icenowy.me>
	 <d44651a7-0c07-4b84-8828-f1d405359aeb@amd.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-06-17=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 15:59 +0200=EF=BC=
=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> Am 17.06.24 um 15:43 schrieb Icenowy Zheng:
> > =E5=9C=A8 2024-06-17=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 15:09 +0200=EF=
=BC=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> > > Am 17.06.24 um 15:03 schrieb Icenowy Zheng:
> > > > =E5=9C=A8 2024-06-17=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 14:35 +020=
0=EF=BC=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> > > > > Am 17.06.24 um 12:58 schrieb Icenowy Zheng:
> > > > > > The duplication of EOP packets for GFX7/8, with the former
> > > > > > one
> > > > > > have
> > > > > > seq-1 written and the latter one have seq written, seems to
> > > > > > confuse
> > > > > > some
> > > > > > hardware platform (e.g. Loongson 7A series PCIe
> > > > > > controllers).
> > > > > >=20
> > > > > > Make the content of the duplicated EOP packet the same with
> > > > > > the
> > > > > > real
> > > > > > one, only masking any possible interrupts.
> > > > > Well completely NAK to that, exactly that disables the
> > > > > workaround.
> > > > >=20
> > > > > The CPU needs to see two different values written here.
> > > > Why do the CPU need to see two different values here? Only the
> > > > second
> > > > packet will raise an interrupt before and after applying this
> > > > patch,
> > > > and the first packet's result should just be overriden on
> > > > ordinary
> > > > platforms. The CPU won't see the first one, until it's polling
> > > > for
> > > > the
> > > > address for a very short interval, so short that the GPU CP
> > > > couldn't
> > > > execute 2 commands.
> > > Yes exactly that. We need to make two writes, one with the old
> > > value
> > > (seq - 1) and a second with the real value (seq).
> > >=20
> > > Otherwise it is possible that a polling CPU would see the
> > > sequence
> > > before the second EOP is issued with results in incoherent view
> > > of
> > > memory.
> > In this case shouldn't we write seq-1 before any work, and then
> > write
> > seq after work, like what is done in Mesa?
>=20
> No. This hw workaround requires that two consecutive write operations
> happen directly behind each other on the PCIe bus with two different
> values.
>=20
> To make the software logic around that work without any changes we
> use=20
> the values seq - 1 and seq because those are guaranteed to be
> different=20
> and not trigger any unwanted software behavior.
>=20
> Only then we can guarantee that we have a coherent view of system
> memory.

BTW is there any operation that could be taken to examine this specific
workaround?

Is there any case possible to reproduce?

>=20
> > As what I see, Mesa uses another command buffer to emit a
> > EVENT_WRITE_EOP writing 0, and commit this command buffer before
> > the
> > real command buffer.
> >=20
> > > > Or do you mean the GPU needs to see two different values being
> > > > written,
> > > > or they will be merged into only one write request?
> > > >=20
> > > > Please give out more information about this workaround,
> > > > otherwise
> > > > the
> > > > GPU hang problem on Loongson platforms will persist.
> > > Well if Loongson can't handle two consecutive write operations to
> > > the
> > > same address with different values then you have a massive
> > > platform
> > > bug.
> > I think the issue is triggered when two consecutive write
> > operations
> > and one IRQ is present, which is exactly the case of this function.
>=20
> Well then you have a massive platform bug.
>=20
> Two consecutive writes to the same bus address are perfectly legal
> from=20
> the PCIe specification and can happen all the time, even without this
> specific hw workaround.
>=20
> Regards,
> Christian.
>=20
> >=20
> > > That is something which can happen all the time throughout the
> > > operation.
> > >=20
> > > Regards,
> > > Christian.
> > >=20
> > > > > Regards,
> > > > > Christian.
> > > > >=20
> > > > > > Fixes: bf26da927a1c ("drm/amdgpu: add cache flush
> > > > > > workaround to
> > > > > > gfx8 emit_fence")
> > > > > > Fixes: a2e73f56fa62 ("drm/amdgpu: Add support for CIK
> > > > > > parts")
> > > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > > ---
> > > > > > =C2=A0=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 12 +=
++++-------
> > > > > > =C2=A0=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 +=
+++--------
> > > > > > =C2=A0=C2=A0=C2=A0 2 files changed, 9 insertions(+), 15 deletio=
ns(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > index 541dbd70d8c75..778f27f1a34fe 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > @@ -2117,9 +2117,8 @@ static void
> > > > > > gfx_v7_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64
> > > > > > addr,
> > > > > > =C2=A0=C2=A0=C2=A0 {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boo=
l write64bit =3D flags &
> > > > > > AMDGPU_FENCE_FLAG_64BIT;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boo=
l int_sel =3D flags & AMDGPU_FENCE_FLAG_INT;
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Workaround for ca=
che flush problems. First send
> > > > > > a
> > > > > > dummy
> > > > > > EOP
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * event down the pi=
pe with seq one below.
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Workaround for ca=
che flush problems, send EOP
> > > > > > twice.
> > > > > > */
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring,
> > > > > > PACKET3(PACKET3_EVENT_WRITE_EOP,
> > > > > > 4));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOP_TC_A=
CTION_EN |
> > > > > > @@ -2127,11 +2126,10 @@ static void
> > > > > > gfx_v7_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64
> > > > > > addr,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EVENT_IN=
DEX(5)));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, addr & 0xfffffffc);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, (upper_32_bits(addr) &
> > > > > > 0xffff)
> > > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DATA_SEL(1) | INT_SEL(0)=
);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, lower_32_bits(seq - 1));
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, upper_32_bits(seq - 1));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DATA_SEL(write64bit ? 2 =
:
> > > > > > 1) |
> > > > > > INT_SEL(0));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, lower_32_bits(seq));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, upper_32_bits(seq));
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Then send the rea=
l EOP event down the pipe. */
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring,
> > > > > > PACKET3(PACKET3_EVENT_WRITE_EOP,
> > > > > > 4));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOP_TC_A=
CTION_EN |
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > > > > index 2f0e72caee1af..39a7d60f1fd69 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > > > > @@ -6153,9 +6153,7 @@ static void
> > > > > > gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64
> > > > > > addr,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boo=
l write64bit =3D flags &
> > > > > > AMDGPU_FENCE_FLAG_64BIT;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boo=
l int_sel =3D flags & AMDGPU_FENCE_FLAG_INT;
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Workaround for ca=
che flush problems. First send
> > > > > > a
> > > > > > dummy
> > > > > > EOP
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * event down the pi=
pe with seq one below.
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Workaround for ca=
che flush problems, send EOP
> > > > > > twice.
> > > > > > */
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring,
> > > > > > PACKET3(PACKET3_EVENT_WRITE_EOP,
> > > > > > 4));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOP_TC_A=
CTION_EN |
> > > > > > @@ -6164,12 +6162,10 @@ static void
> > > > > > gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64
> > > > > > addr,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EVENT_IN=
DEX(5)));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, addr & 0xfffffffc);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, (upper_32_bits(addr) &
> > > > > > 0xffff)
> > > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DATA_SEL(1) | INT_SEL(0)=
);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, lower_32_bits(seq - 1));
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, upper_32_bits(seq - 1));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 DATA_SEL(write64bit ? 2 : 1) |
> > > > > > INT_SEL(0));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, lower_32_bits(seq));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amdgpu_ring_write(ri=
ng, upper_32_bits(seq));
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Then send the rea=
l EOP event down the pipe:
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * EVENT_WRITE_EOP -=
 flush caches, send int */
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring,
> > > > > > PACKET3(PACKET3_EVENT_WRITE_EOP,
> > > > > > 4));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amd=
gpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOP_TC_A=
CTION_EN |
>=20


