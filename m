Return-Path: <linux-kernel+bounces-433900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F809E5E88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC42F282D79
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4AD22D4E4;
	Thu,  5 Dec 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UUhEpFNL"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C551225797
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425130; cv=none; b=tiPb9Hj9jMlSe3mI2yQ6NqbfXMqI3t0Pr8BbS9UPhHvtmv9Azd5YkjLVTJgfMheZ5Gi7mAwVE4Q4IvVq8fXk9WuyKWIemwTDgd+oGNqiF2qlfVSmHKztO4cCkJK29VG6x/SHEwmWpthkwCpJTRFYWa6nuSts+FKYiOgdT2/98TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425130; c=relaxed/simple;
	bh=KvD8SgNhV2A1N+le02OtqO9UlfQzw4KsUU1VV8QANVs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlWEmVGfCYwkzeehAOEA3gvKCdoYQx3GYxBI4u/WJpGzrRBfTn4IhqDR/wS0CM2MxUQMfDkOEXO1KtcZ8sgS5fPAdghOlZpkwMHgg8jQstu93RiMO61CtfUcGktzvmMxd2+VbolK6N/9kC7CZ2jzYwclkhBc2nsjrh0/V7efIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UUhEpFNL; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7vsekokjirfajj2zq3c5dsl7le.protonmail; t=1733425119; x=1733684319;
	bh=KvD8SgNhV2A1N+le02OtqO9UlfQzw4KsUU1VV8QANVs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UUhEpFNLZt5XeV4AzqaMBNiVZKq6xP5gHx2JChMQpa+QmXs4gjffKYnMsu04AJ4oG
	 2+3zTGCdIqSOO7bOBI8LEnl/4rjSuesuDsQLRi95ZrohgSNBnY+p0fh5rQKExxzC9O
	 Wu77u5Yp26auxQ+EePdkuECYwPbMTse5VuWlvI5Xs0sVb8IQVw4h4n2XBcfFx9cSOJ
	 oD50A/BFizsS3iZ/ENxCiUkGCvoGim54Rj4D+XStI9nRO9pIyQCUX0cq3hbXin5hTf
	 DoKYNfhO3q4Z6p2gfF3CIx6v1BfKiA6F9mW8GgFCX11cJQT4QXFKd2DL2xv71lSlBE
	 YrPWFzVc0rqPw==
Date: Thu, 05 Dec 2024 18:58:30 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, hjc@rock-chips.com, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:Re: [PATCH v7] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <Kmf2VXiWF77w-brVyLRrswUV3O_7INOquqIpG31ctJB_c9wVFqCY8DeR8rot4jq6Cpz7VeHX7xDl7SXA2JBwXDggAsjKqn__sP9i-be8NI0=@proton.me>
In-Reply-To: <7877dddf.b3b8.19396e1df66.Coremail.andyshrk@163.com>
References: <20241101185545.559090-3-pZ010001011111@proton.me> <9Rp0NJW2QG5qDduowVaialZWN6xTe9KJFciu7Q2LERJZQXsUgFvMGXfcFaNznIEJEBpZeOdZPuL4fxOEFduaSJLuQJ3cIvN-fx2lEzYSBKE=@proton.me> <12938960.VsHLxoZxqI@diego> <7877dddf.b3b8.19396e1df66.Coremail.andyshrk@163.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 535e75224ca1d8abbcd2f8c5ed08abda699b6ea5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, December 5th, 2024 at 1:53 PM, Andy Yan <andyshrk@163.com> wro=
te:


> I guess it returned because crtc_state->color_mgmt_changed is false when =
called from
>=20
> vop2_crtc_atomic_enable from s2r.
>=20

Hi Heiko and Andy,

Yes that was it. Moving the check out of *try_set_gamma
and checking it only in the atomic_flush fixed the issue.

Thanks Andy for pointing that out.

Regards, Piotr Zalewski

