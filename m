Return-Path: <linux-kernel+bounces-189609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CE8CF2D7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1FB2812C3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA38F54;
	Sun, 26 May 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="hI0HwYKw"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8C8C09
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716712078; cv=none; b=l9fpOJNd6Y+/cwjUqme8el1zog/+vhIdLhzrjbUJwezNQK3uMMT9Lw0rCiiQuRwl35AVMbLnjYIAaU1C8iiuFPsFIFszZ4sHMI3VL5iKfKR2Ha6Yd6FDCPBv1PZIHrk1ubOwiqdGrhotsXXkFjuVjFXdGPGbRh9dtp1yWsJ0KsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716712078; c=relaxed/simple;
	bh=1ftbCLkqW7AMyjcnNHoKh6QwQpSGftI1ij6SRmtVCgk=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouAQ9Isu/Ue1wJPuizTInMWgd9cggJSiYdhlicq9qYxdw25r/+8YOZt8yBgqxf7k37Mp62QCgzW/Ak7rTdwSBscJkso3M83FZWa416uFBUEEx1JxRWL0S9k89ImN8r6Y6rj/FFAWwRgqT4pnie0L/LhlCQnKYt+diNTpFlr1Bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=hI0HwYKw; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: adrian.larumbe@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716712074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ftbCLkqW7AMyjcnNHoKh6QwQpSGftI1ij6SRmtVCgk=;
	b=hI0HwYKwTJUFfDagcVlZ87VmI020G1BxLoXinI44qXQVk5x0mgOgYtc9/pRw/xjuRzO3zP
	qrPKOenSZTCON/ChEHf2CsgJPwxoUKjs47Ch80iABLmJdARtF5ZVbK/2+1O9gaa3Hw+4hW
	WP8Emfgy1TiBTKLBVc00jS0oFlXDUNeZvqdUWdsqCb/Ws0gjbNLLOp5uELnZXk4Onzvs5d
	M+HFyCFw/TAasYAuxmn2jYVr64A7frO/2Gro1xxEm4YjAWuBrWTnS+DdEYoYF/k3Bq36+U
	QvOh8ZonbYkAHQTo8vTPKqObz1uU27R+HqvF1dl1iDOwB/dLuIsE0SimvPHUAg==
X-Envelope-To: boris.brezillon@collabora.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: steven.price@arm.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: sumit.semwal@linaro.org
X-Envelope-To: christian.koenig@amd.com
X-Envelope-To: dmitry.osipenko@collabora.com
X-Envelope-To: zack.rusin@broadcom.com
X-Envelope-To: kernel@collabora.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-media@vger.kernel.org
X-Envelope-To: linaro-mm-sig@lists.linaro.org
Date: Sun, 26 May 2024 05:27:29 -0300
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
Subject: Re: [PATCH v4 2/3] drm/lima: Fix dma_resv deadlock at drm object pin
 time
To: =?iso-8859-1?q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring
	<robh@kernel.org>, Steven Price <steven.price@arm.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Zack Rusin
	<zack.rusin@broadcom.com>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Message-Id: <TH33ES.VQFJ1AUXO5N81@packett.cool>
In-Reply-To: <20240523113236.432585-3-adrian.larumbe@collabora.com>
References: <20240523113236.432585-1-adrian.larumbe@collabora.com>
	<20240523113236.432585-3-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT



On Thu, May 23 2024 at 12:32:18 +01:00:00, Adri=E1n Larumbe=20
<adrian.larumbe@collabora.com> wrote:
> Commit a78027847226 ("drm/gem: Acquire reservation lock in
> drm_gem_{pin/unpin}()") moved locking the DRM object's dma=20
> reservation to
> drm_gem_pin(), but Lima's pin callback kept calling drm_gem_shmem_pin,
> which also tries to lock the same dma_resv, leading to a double lock
> situation.
>=20
> As was already done for Panfrost in the previous commit, fix it by
> replacing drm_gem_shmem_pin() with its locked variant.

Hi, just found this while dealing with compositor lockups upon=20
launching a GL client on an old Rockchip RK3066 tablet, and it did fix=20
the problem :) Thank you.

Tested-by: Val Packett <val@packett.cool>



