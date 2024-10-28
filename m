Return-Path: <linux-kernel+bounces-385410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACE9B36D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72CC1F21820
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C351DEFCD;
	Mon, 28 Oct 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YDPMWx+V"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67F186E27
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133657; cv=none; b=ihY51g5vMd3x/z+BcLLGpEVhsvnWCHHDRDJ+uy49m48gqn4HHmbNcc26dp9OZN7QRZstTKmp2Hf9yfazZ4HrRUHd2N2ro6OayltyKeLglmw/wYo22YHFZtPy84GealT9JTOWj5tbL8EfsIOwgIyOtqb35bIbkx/bbFnY3kH6RwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133657; c=relaxed/simple;
	bh=YnLp2twzv2TNQbo4aCFZTZoiRr0XaMjJP+UKxGSJsRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=le9ht183HydWXHPuDItU4/3xzmHUvCwD55XOWMpCIXsD9h7cSV3ut/u8ADshZPDCOJ3RngWPWm/HprCZySZ/aNMBmcNsu/gZdTuq2++Qxih8JPOZswhyAfUELeRKVvHujgWYbxgk0mn+CZ5MkIGhxuMMaHG2G+53lCPvv3tjcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YDPMWx+V; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1730133652; x=1730392852;
	bh=YnLp2twzv2TNQbo4aCFZTZoiRr0XaMjJP+UKxGSJsRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YDPMWx+VopN7IYplxBpOGlkFuWwiT0GjcLnCz/I7w3zK8cYhr/x9MRkDkWtFKNbt0
	 GuokZV2xiVMslVNXUso5BClJwe29PB0anTiGBGDxkAH4/4g/0Pdq/ZQYpn1tbsis8d
	 Jh/j1593zuLLkEzL9LtnyXZiyk1dsrdn/4GOXE9o+SzVZclfjLV25zyy4eABWHjZXo
	 ReRwqZJjW7aUN0dQyecLkqMMwEg4saP5paeE4yNMUL+uPOQp2W+WM/cuuDVY7VukL/
	 p2OCHCd9MA/8rzOp1+hz9J9t+5YSuQPGA8qkRUx2Kdddk4PakB/P4Ex23rK+F2UQDU
	 rqdNzkUVc3Qdw==
Date: Mon, 28 Oct 2024 16:40:46 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:Re: [PATCH v6] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <-rVNN65kgfRzFJBJDIwQF3jNMfXIZFP8GibtUgB_p-eWGLBkNZhYFr-BXEas8IjjofHxWQUqNicUSTp5rb9XmuLi35XsDd0PzJPz79j-M-8=@proton.me>
In-Reply-To: <2bb58a1c.6287.192d1dc9b2d.Coremail.andyshrk@163.com>
References: <20241016223558.673145-2-pZ010001011111@proton.me> <DurUfF_0TBHKv4DHKIP3ggQh_85nRY0usYWn_fu_oJ45txO7dGKv-OK5rl6EDEPmX5l8WzrwPCzAvYz0xFPfeKGyx7enu1g-prsWIpilv88=@proton.me> <2bb58a1c.6287.192d1dc9b2d.Coremail.andyshrk@163.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 70c53b22f6b3d3f24ee6b0df1f6f75d1e7f29476
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, October 28th, 2024 at 7:42 AM, Andy Yan <andyshrk@163.com> wrote=
:

> Hi Piotr=EF=BC=8C

Hi Andy

> Tested on top of Linux 6.12-rc5 with rk3566-box-demo in a buildroot + wes=
ton environment:
> weston --backend=3Ddrm-backend.so -i 0 --continue-without-input
> weston-simple-egl

Thank you for testing it!

> simple-egl will draw a triangle on the desktop.
> After the patch applied=EF=BC=8Cthe triangle will flicker again and agian=
=E3=80=82
> So it break some function=E3=80=82

Did you have gamma on? The screen flickered for me when I ran something=20
writing gamma LUT frequently because of disable step I reckon.

> I've been quite busy lately, and it will take some time before I can anal=
yze what the specific reason is.

Np, I will try to reproduce this behavior with weston on Pinetab2 in the
meantime.

Best Regards, Piotr Zalewski


