Return-Path: <linux-kernel+bounces-367688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D89A0565
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB831F26851
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668A205E23;
	Wed, 16 Oct 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="G6UOLutS"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582521C07E7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070673; cv=none; b=XECZRecIVBHIqfa0jmsy0iHQdFZ5O7lyDwJGcdi4ba5SaYHV6VKYrIHLwVd84buGPMpd/0RyT80Ed7hRSRZ+C3Ca+wRmkBB1LvoxdZjYemtJ91yfJmYQE++R2HowWfyzOiniFX4OzDl5kaf0HzlOvpbNpijlXDIs4SFRvlb9DSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070673; c=relaxed/simple;
	bh=1hC389bUY1zoJGbXCZyplZ6rSSoOY8vZaU70geZtI5E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAbXAn0aQXsU1iZWC4eZKTMRRAlcQBCfBLtpbbN4/wKCB/NaeUTCQUA+mnO3L6tDxNVkDZgX70bfNC1QlHuspEaKcGO7Xu50V0eyGcghzJEwMRv/7hvRrDqxXclJ0fRmQfW2/zrUuHi2kHfT4bGOvksX0C/1jdEEE3OYBVg8alg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=G6UOLutS; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729070670; x=1729329870;
	bh=1hC389bUY1zoJGbXCZyplZ6rSSoOY8vZaU70geZtI5E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G6UOLutSrDKqnGdNsoLaiXdsF4OkKPTcXhxvKoGpCceWHV3n2yUPvT8Axmez6STra
	 fJUbwP/J8j5zEwRIc0pDDpsDyHpfD64BgPB29D14Cg+LnZshdSaOPteeJzEB1nkiW8
	 ffD1m1N+uD55hR8UQh99vB6+fMm7eOzsorFacjGJekBTvhwVjCzOy7IWJAUOQ8fuJj
	 v3X04SWmc6A/QwyBOABQRWTGZ9YqRx5dotvwVzaRafNWHuconc634u/WhxRBVhg+yr
	 zHaPuMqQU6XXx2MyJidx+1UB0t6pUTb+t3EvHz4ymzhTd5e1le8i4ZOLy7CynkjFLO
	 dfOam5eHGQM1Q==
Date: Wed, 16 Oct 2024 09:24:24 +0000
To: Diederik de Haas <didi.debian@cknow.org>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Andy Yan <andyshrk@163.com>, hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v5] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <BeXoC3pECSSWt03s_nNVohvTHHdML_K2_kGtlaGpyWHOyHiC-7rmdkADP1eN-PH01n7e29wVcMhEtW4MT50OL2dXEZzdCKdeZw3NPhQZx_A=@proton.me>
In-Reply-To: <D4X4BE9PTJ1Q.2TDYBLWRFYMYA@cknow.org>
References: <20241014222022.571819-4-pZ010001011111@proton.me> <7b45f190.452f.1928e41b746.Coremail.andyshrk@163.com> <o_Cyz_ARcHj4zNlovv75MBwslIRhn3YWlscoNrlpLVobh7eWIMEQR5bNv0yhHx2KEx_gbYi_gH-8Y-CdvRZs9lZscz3-lhAbM50GXUdtSKY=@proton.me> <30940542.b36d.19290215124.Coremail.andyshrk@163.com> <1974DYrs9gLrQrZ5VwCglFgKDDK686iyqnS_g6uPB-s9wZ_4CqfZXPjmYWihLgrkRu7ptNjpkFeqB0uTt73RFId6cL8FowQ8LFltPmaKCoI=@proton.me> <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com> <QvjHFQ4xeCu-8Isrm_jtNRWLowVNFzC8qnHJ6LUGI2iFTTJoEK8fBrXjG9LUrn5Wt9fJ9F04ukEf-koifwCR0uH9nr0AelyiWI85KASNkOQ=@proton.me> <D4X4BE9PTJ1Q.2TDYBLWRFYMYA@cknow.org>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 0f9ab51e7de25b031eaa1a4bf04c70848cb633ff
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Diederik

On Wednesday, October 16th, 2024 at 11:20 AM, Diederik de Haas <didi.debian=
@cknow.org> wrote:

> On Wed Oct 16, 2024 at 11:16 AM CEST, Piotr Zalewski wrote:
>=20
> > I will rework it to[1] and test it. (Have to check if hdmi out on pt2 w=
orks).
>=20
>=20
> Last time I tried it, hdmi out did work.

Nice, thanks for the info :)

